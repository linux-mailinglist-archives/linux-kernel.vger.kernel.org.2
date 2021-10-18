Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78B430F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJREoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:44:14 -0400
Received: from foss.arm.com ([217.140.110.172]:60490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhJREoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:44:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD31811D4;
        Sun, 17 Oct 2021 21:42:02 -0700 (PDT)
Received: from [10.163.74.6] (unknown [10.163.74.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B181E3F73D;
        Sun, 17 Oct 2021 21:41:58 -0700 (PDT)
Subject: Re: [PATCH] mm/migrate: rework hotplug_memory_notifier() stub
To:     Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211013144029.2154629-1-arnd@kernel.org>
 <YWftfNOTIUmzx3kP@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cc5c9924-e58e-d950-ae10-462e8fdfed85@arm.com>
Date:   Mon, 18 Oct 2021 10:11:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWftfNOTIUmzx3kP@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/21 2:12 PM, Michal Hocko wrote:
> On Wed 13-10-21 16:39:38, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The previous change added a compile time warning for the
>> CONFIG_MEMORY_HOTPLUG=n case:
>>
>> mm/migrate.c:3216:22: error: 'migrate_on_reclaim_callback' defined but not used [-Werror=unused-function]
>>  3216 | static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/migrate.c:3197:13: error: 'set_migration_target_nodes' defined but not used [-Werror=unused-function]
>>  3197 | static void set_migration_target_nodes(void)
>>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Rework the hotplug_memory_notifier() stub implementation into
>> an inline function so it always references its argument but
>> ignores it, leading the compiler to silently drop the hotplug
>> memory notifier function and further code referenced from it.
>>
>> To do this, the #ifdef around those functions need to be removed
>> as well, but this tends to help with readability and build coverage.
>>
>> Fixes: dd3e24b84bc1 ("mm/migrate: add CPU hotplug to demotion #ifdef")
> 
> This is not a sha1 in the Linus tree. I suspect this comes from
> linux-next and akpm patch queue. Those sha1s are not stable so it is
> better to not reference them.

I did not find this SHA on latest linux-next (20211015) as well.

> 
> Can we fold that into patch directly?

+1

> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> The fix looks good to me.
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
> 
>> ---
>>  include/linux/memory.h | 5 ++++-
>>  mm/migrate.c           | 6 +-----
>>  mm/page_ext.c          | 4 +---
>>  mm/slab.c              | 4 ++--
>>  4 files changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>> index a216829df280..95af54f585a1 100644
>> --- a/include/linux/memory.h
>> +++ b/include/linux/memory.h
>> @@ -125,7 +125,10 @@ static inline int memory_notify(unsigned long val, void *v)
>>  {
>>  	return 0;
>>  }
>> -#define hotplug_memory_notifier(fn, pri)	({ 0; })
>> +static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
>> +{
>> +	return 0;
>> +}
>>  /* These aren't inline functions due to a GCC bug. */
>>  #define register_hotmemory_notifier(nb)    ({ (void)(nb); 0; })
>>  #define unregister_hotmemory_notifier(nb)  ({ (void)(nb); })
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 7769abac8aad..32303d517e10 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -3059,7 +3059,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
>>  EXPORT_SYMBOL(migrate_vma_finalize);
>>  #endif /* CONFIG_DEVICE_PRIVATE */
>>  
>> -#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_HOTPLUG_CPU)
>> +#if defined(CONFIG_HOTPLUG_CPU)
>>  /* Disable reclaim-based migration. */
>>  static void __disable_all_migrate_targets(void)
>>  {
>> @@ -3201,7 +3201,6 @@ static void set_migration_target_nodes(void)
>>  	put_online_mems();
>>  }
>>  
>> -#if defined(CONFIG_MEMORY_HOTPLUG)
>>  /*
>>   * This leaves migrate-on-reclaim transiently disabled between
>>   * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
>> @@ -3258,9 +3257,7 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>>  
>>  	return notifier_from_errno(0);
>>  }
>> -#endif /* CONFIG_MEMORY_HOTPLUG */
>>  
>> -#ifdef CONFIG_HOTPLUG_CPU
>>  /*
>>   * React to hotplug events that might affect the migration targets
>>   * like events that online or offline NUMA nodes.
>> @@ -3302,4 +3299,3 @@ static int __init migrate_on_reclaim_init(void)
>>  }
>>  late_initcall(migrate_on_reclaim_init);
>>  #endif /* CONFIG_HOTPLUG_CPU */
>> -#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_HOTPLUG_CPU */
>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>> index 106079e67c2e..6242afb24d84 100644
>> --- a/mm/page_ext.c
>> +++ b/mm/page_ext.c
>> @@ -269,7 +269,7 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
>>  	total_usage += table_size;
>>  	return 0;
>>  }
>> -#ifdef CONFIG_MEMORY_HOTPLUG
>> +
>>  static void free_page_ext(void *addr)
>>  {
>>  	if (is_vmalloc_addr(addr)) {
>> @@ -374,8 +374,6 @@ static int __meminit page_ext_callback(struct notifier_block *self,
>>  	return notifier_from_errno(ret);
>>  }
>>  
>> -#endif
>> -
>>  void __init page_ext_init(void)
>>  {
>>  	unsigned long pfn;
>> diff --git a/mm/slab.c b/mm/slab.c
>> index 01775fe0e002..da132a9ae6f8 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -1095,7 +1095,7 @@ static int slab_offline_cpu(unsigned int cpu)
>>  	return 0;
>>  }
>>  
>> -#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
>> +#if defined(CONFIG_NUMA)
>>  /*
>>   * Drains freelist for a node on each slab cache, used for memory hot-remove.
>>   * Returns -EBUSY if all objects cannot be drained so that the node is not
>> @@ -1157,7 +1157,7 @@ static int __meminit slab_memory_callback(struct notifier_block *self,
>>  out:
>>  	return notifier_from_errno(ret);
>>  }
>> -#endif /* CONFIG_NUMA && CONFIG_MEMORY_HOTPLUG */
>> +#endif /* CONFIG_NUMA */
>>  
>>  /*
>>   * swap the static kmem_cache_node with kmalloced memory
>> -- 
>> 2.29.2
> 
