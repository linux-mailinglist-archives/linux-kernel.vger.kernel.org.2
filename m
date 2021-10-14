Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90C42D343
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNHLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhJNHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634195334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHUkpl/ZAVHt5/5vUXcZgFhHnix+Qpic85kyWSV9RY8=;
        b=SEeLSf4e1LbBoP3MVRLXOIMSJP4ri/IZWApWyP+UFk3qyCIbX4FoFiRDlI27evk2mCYuDL
        1iWc3vttWIGbd3D9lhwnVvxecubMmdL7orHeI9sAEiFbIpUKtTXHuebguOzbZqLFRlvIE7
        Q5XzLVsPNgyynWS4yooBVO0Rz4Fdv8Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-9vMoQDZQN-Wr2BxaOP59pQ-1; Thu, 14 Oct 2021 03:08:53 -0400
X-MC-Unique: 9vMoQDZQN-Wr2BxaOP59pQ-1
Received: by mail-wr1-f71.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso3767106wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yHUkpl/ZAVHt5/5vUXcZgFhHnix+Qpic85kyWSV9RY8=;
        b=sMkj6L4umb9yTCwAQA6EacglI0pCJ/ZhXCwBK2ENXvSR12k1+3CiiXl1j5tqPZgXLo
         v5LZNvZBhyuNX1PS84+Z5k39tcq2yFsDVjn/jGjhd3KuB/0/jbu9hNgjpmKqFvA0x0pI
         AksleopjkAxVmJ15EPxzSkJ7AtG6pOpXT4+d08/OhkFNRI52Hod00gadvW2XaT4YiBHL
         CEoQk3E8uxYASJiqPNo+03uDpPyLuetUdj4HPjy0sEmhnx4qO6/gsZ96WxQgaa+sJ+c+
         R9LmjrPu9G+P6zdSo5XKxCx0BRVXozsjSzMH1My+HXu/HDanluDfNr+44I5pMordDEut
         zkAw==
X-Gm-Message-State: AOAM533WWEqFfeeMnbBxC3NFGoX6Cv24RuGT2lbQ+lhSOz6xrzGNinO1
        bJzs/R0OqiEYmvU9Z1CyZ5c5Iw5j/LwZOnqaOTdWurIrrF6ev8Q+f12OlT4nX5whXMDjBVJtJKc
        W2aC1NmIxdSvAN1suLdmjIADb
X-Received: by 2002:a05:600c:35d4:: with SMTP id r20mr4183453wmq.76.1634195332516;
        Thu, 14 Oct 2021 00:08:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKXpfZss+zb/o1WdVupKiRz0sH2zAIcjZtr09k3FEtY75Mtk/BCXaTGY1T9oSwoTebKGf52A==
X-Received: by 2002:a05:600c:35d4:: with SMTP id r20mr4183437wmq.76.1634195332260;
        Thu, 14 Oct 2021 00:08:52 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id r9sm1554409wrn.95.2021.10.14.00.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 00:08:51 -0700 (PDT)
Message-ID: <11ca4abc-efb7-6304-df36-98951915b2e3@redhat.com>
Date:   Thu, 14 Oct 2021 09:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/migrate: rework hotplug_memory_notifier() stub
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211013144029.2154629-1-arnd@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211013144029.2154629-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.21 16:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous change added a compile time warning for the
> CONFIG_MEMORY_HOTPLUG=n case:
> 
> mm/migrate.c:3216:22: error: 'migrate_on_reclaim_callback' defined but not used [-Werror=unused-function]
>  3216 | static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/migrate.c:3197:13: error: 'set_migration_target_nodes' defined but not used [-Werror=unused-function]
>  3197 | static void set_migration_target_nodes(void)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Rework the hotplug_memory_notifier() stub implementation into
> an inline function so it always references its argument but
> ignores it, leading the compiler to silently drop the hotplug
> memory notifier function and further code referenced from it.
> 
> To do this, the #ifdef around those functions need to be removed
> as well, but this tends to help with readability and build coverage.
> 
> Fixes: dd3e24b84bc1 ("mm/migrate: add CPU hotplug to demotion #ifdef")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/memory.h | 5 ++++-
>  mm/migrate.c           | 6 +-----
>  mm/page_ext.c          | 4 +---
>  mm/slab.c              | 4 ++--
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index a216829df280..95af54f585a1 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -125,7 +125,10 @@ static inline int memory_notify(unsigned long val, void *v)
>  {
>  	return 0;
>  }
> -#define hotplug_memory_notifier(fn, pri)	({ 0; })
> +static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
> +{
> +	return 0;
> +}
>  /* These aren't inline functions due to a GCC bug. */
>  #define register_hotmemory_notifier(nb)    ({ (void)(nb); 0; })
>  #define unregister_hotmemory_notifier(nb)  ({ (void)(nb); })
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7769abac8aad..32303d517e10 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3059,7 +3059,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
>  EXPORT_SYMBOL(migrate_vma_finalize);
>  #endif /* CONFIG_DEVICE_PRIVATE */
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_HOTPLUG_CPU)
> +#if defined(CONFIG_HOTPLUG_CPU)
>  /* Disable reclaim-based migration. */
>  static void __disable_all_migrate_targets(void)
>  {
> @@ -3201,7 +3201,6 @@ static void set_migration_target_nodes(void)
>  	put_online_mems();
>  }
>  
> -#if defined(CONFIG_MEMORY_HOTPLUG)
>  /*
>   * This leaves migrate-on-reclaim transiently disabled between
>   * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
> @@ -3258,9 +3257,7 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>  
>  	return notifier_from_errno(0);
>  }
> -#endif /* CONFIG_MEMORY_HOTPLUG */
>  
> -#ifdef CONFIG_HOTPLUG_CPU
>  /*
>   * React to hotplug events that might affect the migration targets
>   * like events that online or offline NUMA nodes.
> @@ -3302,4 +3299,3 @@ static int __init migrate_on_reclaim_init(void)
>  }
>  late_initcall(migrate_on_reclaim_init);
>  #endif /* CONFIG_HOTPLUG_CPU */
> -#endif /* CONFIG_MEMORY_HOTPLUG || CONFIG_HOTPLUG_CPU */
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 106079e67c2e..6242afb24d84 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -269,7 +269,7 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
>  	total_usage += table_size;
>  	return 0;
>  }
> -#ifdef CONFIG_MEMORY_HOTPLUG
> +
>  static void free_page_ext(void *addr)
>  {
>  	if (is_vmalloc_addr(addr)) {
> @@ -374,8 +374,6 @@ static int __meminit page_ext_callback(struct notifier_block *self,
>  	return notifier_from_errno(ret);
>  }
>  
> -#endif
> -
>  void __init page_ext_init(void)
>  {
>  	unsigned long pfn;
> diff --git a/mm/slab.c b/mm/slab.c
> index 01775fe0e002..da132a9ae6f8 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1095,7 +1095,7 @@ static int slab_offline_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
> +#if defined(CONFIG_NUMA)
>  /*
>   * Drains freelist for a node on each slab cache, used for memory hot-remove.
>   * Returns -EBUSY if all objects cannot be drained so that the node is not
> @@ -1157,7 +1157,7 @@ static int __meminit slab_memory_callback(struct notifier_block *self,
>  out:
>  	return notifier_from_errno(ret);
>  }
> -#endif /* CONFIG_NUMA && CONFIG_MEMORY_HOTPLUG */
> +#endif /* CONFIG_NUMA */
>  
>  /*
>   * swap the static kmem_cache_node with kmalloced memory
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

