import Foundation
import CoreData

open class CDKeyValueDatedEntityStore<DBEntity, Model>
        : CDKeyValueEntityStore<DBEntity, Model>, KVDatedEntityStore
        where DBEntity: CDKeyValueDatedEntity, Model: Codable & KVIdentifiable & KVDated {

    public typealias KVEntity = Model

    public func readAll(sortDescriptors: [CDSortDescriptor]) throws -> [KVEntity] {
        try internalReadAll(context: viewContext, predicate: .none, fetchOptions: nil, sortDescriptions: sortDescriptors)
    }

    public func read(predicate: CDFPredicate, sortDescriptors: [CDSortDescriptor]) throws -> [KVEntity] {
        try internalReadAll(context: viewContext, predicate: predicate, fetchOptions: .none, sortDescriptions: sortDescriptors)
    }

    public func read(fetchOptions: CDFetchOptions, sortDescriptors: [CDSortDescriptor]) throws -> [KVEntity] {
        try internalReadAll(context: viewContext, predicate: .none, fetchOptions: fetchOptions, sortDescriptions: sortDescriptors)
    }

    public func read(predicate: CDFPredicate, fetchOptions: CDFetchOptions, sortDescriptors: [CDSortDescriptor]) throws -> [KVEntity] {
        try internalReadAll(context: viewContext, predicate: predicate, fetchOptions: fetchOptions, sortDescriptions: sortDescriptors)
    }

    public final override func createDbEntity(entity: KVEntity, context: NSManagedObjectContext) throws {
        guard let data = encodeEntity(entity: entity) else {
            throw CDError.failedToEncodeEntity
        }

        let newItem = DBEntity(context: context)
        newItem.key = entity.key
        newItem.createdAt = entity.createdAt
        newItem.value = data
    }
}
