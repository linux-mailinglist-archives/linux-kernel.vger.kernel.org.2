Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF80A39836B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhFBHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232045AbhFBHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622619883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLGpkDE1IQ5Z6ghLy17vYVsC5JFNhgBxA3y2/XyFEdA=;
        b=LaCaxxaHFwrDMEmTyCrHVZqKTXdk5TkuZijBYME3yWVvu7yG1WNivC9Q+S/FUgB8+cZYLK
        ooLKEb9wbGTyvfALUShPz8v+Oi1EyPTl7nXaV6t7JMEIDZjLIwpIyZ36NZuinXeEGsaF21
        MEEvUBF146JLNLtD8BlPijoCtD62DZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-FdH4VYz_NVOw6H7WnQV1Og-1; Wed, 02 Jun 2021 03:44:39 -0400
X-MC-Unique: FdH4VYz_NVOw6H7WnQV1Og-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so659871wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DLGpkDE1IQ5Z6ghLy17vYVsC5JFNhgBxA3y2/XyFEdA=;
        b=phCXJ+1mUk0EM42M6yPQVBa0aahdhn6jP0xU3svNnIsfQ2MRP3izl2oQwMDiQefGul
         3ndsk2KAP9P6IQTwT+a4w7qFoqeyS9vrHEYdLbJjCaMMKquryM4y/rjZJzpcXAQBDc1i
         GI2keiVLSU82t1TJHAuB9gX6+tsEcM9VT21DjgFUTiFSxewz21Hl9El86DJ/QJ9taOcT
         ObOptsJ/jeaWpR5Fc3LxJsEvS/BKStYL4c0Xz23is5gMdxWO8MDkvZu02MM/Ed5yJK5y
         haxd0J3xQeP+cmXm4T90+XMSJHi4FASSzLjUuqTYFTlgGvoM4NOgmBvHf2evF+kVJn2h
         UgXg==
X-Gm-Message-State: AOAM531fJee8tcIHAOS742nvuYzbnZ0eDuI/mH2K6jlitwFNhHMlv720
        CNLEPTeWSgW7UpA2RLFxAl3S0aNmQiBWCTKLLLfm7KDzuyKltDH2NDqou6h8s1s95WYuN66q2Z4
        jwf0Y82ckltx6DMAqlkGyrdK9
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr1386665wry.4.1622619878315;
        Wed, 02 Jun 2021 00:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI3CiFMzRRi7muHGRTn1JgPXeq0ijBTSXMaKWHp06UrdyFomSIUI6/+cnQbSdUADSp0rrJTQ==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr1386639wry.4.1622619877932;
        Wed, 02 Jun 2021 00:44:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id z12sm5549022wrv.68.2021.06.02.00.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:44:37 -0700 (PDT)
To:     yong w <yongw.pur@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org
References: <CAOH5QeCiBF8AYsF853YRFw=kKq+7ps_a30qOFwYOwbinYLbUEw@mail.gmail.com>
 <13c28e69-cfd9-bcf6-ab77-445c6fa4cc6e@redhat.com>
 <CAOH5QeDapb6zsUZK3QA66PNfWJovqR4gWMODnckVdfbvte0Vqg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH V1] zram:calculate available memory when zram is used
Message-ID: <4350ee16-15d0-1d37-6074-cea5185aac51@redhat.com>
Date:   Wed, 2 Jun 2021 09:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOH5QeDapb6zsUZK3QA66PNfWJovqR4gWMODnckVdfbvte0Vqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 02:06, yong w wrote:
> Thanks for your reply!
> 
> Indeed, when zram is not triggered, MemAvalible will be greater than Memtotal.
> As you said, this modification will have program compatibility issues,
>   when there
> are some user space scripts use MemAvailable for calculation.
> 
> How about providing another proc interface?
> Such as /proc/xxx, When execute “cat /proc/xxx”, it returns "available
> + swapfree - swapfree * compress ratio" value.

Good question. What would be an appropriate name and description for 
this entry?

We do have in /proc/meminfo already:

MemTotal:
MemAvailable:
SwapTotal:
SwapFree:

I wonder if we could add an entry either for "swapfree - swapfree * 
compress" or "swapfree * compress". But even then, I struggle to find a 
fitting name. We could either define something like

"SwapAvailable:" An estimate of how much swap space is available for 
starting new applications. Note that SwapAvailable is different to 
SwapFree when swap compression, as implemented by zram, is being performed.

So a user can compute

"TotalAvailable = MemAvailable + SwapAvailable".

or if that doesn't make any sense:

"TotalAvailable:" An estimate of how much memory and swap space is 
available for starting new applications. Usually, the value corresponds 
to "MemAvailable + SwapFree", however, swap compression, as implemented 
by zram, might allow for making more efficient use of free swap space.


I'd prefer the first -- if it makes any sense.

You should CC linux-api on follow up patches.

> Thanks in advance！
> 
> 
> David Hildenbrand <david@redhat.com> 于2021年5月31日周一 下午4:17写道：
>>
>> On 30.05.21 19:18, yong w wrote:
>>> When zram is used, available+Swap free memory is obviously bigger than
>>> I actually can use, because zram can compress memory by compression
>>> algorithm and zram compressed data will occupy memory too.
>>>
>>> So, I count the compression rate of zram in the kernel. The available
>>> memory  is calculated as follows:
>>> available + swapfree - swapfree * compress ratio
>>> MemAvailable in /proc/meminfo returns available + zram will save space
>>>
>>
>> This will mean that we can easily have MemAvailable > MemTotal, right?
>> I'm not sure if there are some user space scripts that will be a little
>> disrupted by that. Like calculating "MemUnavailable = MemTotal -
>> MemAvailable".
>>
>> MemAvailable: "An estimate of how much memory is available for starting
>> new applications, without swapping"
>>
>> Although zram isn't "traditional swapping", there is still a performance
>> impact when having to go to zram because it adds an indirection and
>> requires (de)compression. Similar to having very fast swap space (like
>> PMEM). Let's not call something "memory" that doesn't have the same
>> semantics as real memory as in "MemTotal".
>>
>> This doesn't feel right.
>>
>>> Signed-off-by: wangyong <yongw.pur@gmail.com <mailto:yongw.pur@gmail.com>>
>>> ---
>>>    drivers/block/zram/zcomp.h    |  1 +
>>>    drivers/block/zram/zram_drv.c |  4 ++
>>>    drivers/block/zram/zram_drv.h |  1 +
>>>    fs/proc/meminfo.c             |  2 +-
>>>    include/linux/swap.h          | 10 +++++
>>>    mm/swapfile.c                 | 95
>>> +++++++++++++++++++++++++++++++++++++++++++
>>>    mm/vmscan.c                   |  1 +
>>>    7 files changed, 113 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
>>> index 40f6420..deb2dbf 100644
>>> --- a/drivers/block/zram/zcomp.h
>>> +++ b/drivers/block/zram/zcomp.h
>>> @@ -40,4 +40,5 @@ int zcomp_decompress(struct zcomp_strm *zstrm,
>>>     const void *src, unsigned int src_len, void *dst);
>>>
>>>    bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
>>> +int get_zram_major(void);
>>>    #endif /* _ZCOMP_H_ */
>>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>>> index cf8deec..1c6cbd4 100644
>>> --- a/drivers/block/zram/zram_drv.c
>>> +++ b/drivers/block/zram/zram_drv.c
>>> @@ -59,6 +59,10 @@ static void zram_free_page(struct zram *zram, size_t
>>> index);
>>>    static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
>>>     u32 index, int offset, struct bio *bio);
>>>
>>> +int get_zram_major(void)
>>> +{
>>> + return zram_major;
>>> +}
>>>
>>>    static int zram_slot_trylock(struct zram *zram, u32 index)
>>>    {
>>> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
>>> index 6e73dc3..5d8701a 100644
>>> --- a/drivers/block/zram/zram_drv.h
>>> +++ b/drivers/block/zram/zram_drv.h
>>> @@ -88,6 +88,7 @@ struct zram_stats {
>>>     atomic64_t bd_reads; /* no. of reads from backing device */
>>>     atomic64_t bd_writes; /* no. of writes from backing device */
>>>    #endif
>>> + atomic_t min_compr_ratio;
>>>    };
>>>
>>>    struct zram {
>>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>>> index 6fa761c..f7bf350 100644
>>> --- a/fs/proc/meminfo.c
>>> +++ b/fs/proc/meminfo.c
>>> @@ -57,7 +57,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>>
>>>     show_val_kb(m, "MemTotal:       ", i.totalram);
>>>     show_val_kb(m, "MemFree:        ", i.freeram);
>>> - show_val_kb(m, "MemAvailable:   ", available);
>>> + show_val_kb(m, "MemAvailable:   ", available + count_avail_swaps());
>>>     show_val_kb(m, "Buffers:        ", i.bufferram);
>>>     show_val_kb(m, "Cached:         ", cached);
>>>     show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 032485e..3225a2f 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -514,6 +514,8 @@ extern int init_swap_address_space(unsigned int
>>> type, unsigned long nr_pages);
>>>    extern void exit_swap_address_space(unsigned int type);
>>>    extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
>>>    sector_t swap_page_sector(struct page *page);
>>> +extern void update_zram_zstats(void);
>>> +extern u64 count_avail_swaps(void);
>>>
>>>    static inline void put_swap_device(struct swap_info_struct *si)
>>>    {
>>> @@ -684,6 +686,14 @@ static inline swp_entry_t get_swap_page(struct page
>>> *page)
>>>     return entry;
>>>    }
>>>
>>> +void update_zram_zstats(void)
>>> +{
>>> +}
>>> +
>>> +u64 count_avail_swaps(void)
>>> +{
>>> +}
>>> +
>>>    #endif /* CONFIG_SWAP */
>>>
>>>    #ifdef CONFIG_THP_SWAP
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index cbb4c07..93a9dcb 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -44,6 +44,7 @@
>>>    #include <asm/tlbflush.h>
>>>    #include <linux/swapops.h>
>>>    #include <linux/swap_cgroup.h>
>>> +#include "../drivers/block/zram/zram_drv.h"
>>>
>>>    static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>>>     unsigned char);
>>> @@ -3408,6 +3409,100 @@ SYSCALL_DEFINE2(swapon, const char __user *,
>>> specialfile, int, swap_flags)
>>>     return error;
>>>    }
>>>
>>> +u64 count_avail_swap(struct swap_info_struct *si)
>>> +{
>>> + u64 result;
>>> + struct zram *z;
>>> + unsigned int free;
>>> + unsigned int ratio;
>>> +
>>> + result = 0;
>>> + if (!si)
>>> + return 0;
>>> +
>>> + //zram calculate available mem
>>> + if (si->flags & SWP_USED && si->swap_map) {
>>> + if (si->bdev->bd_disk->major == get_zram_major()) {
>>> + z = (struct zram *)si->bdev->bd_disk->private_data;
>>> + down_read(&z->init_lock);
>>> + ratio = atomic_read(&z->stats.min_compr_ratio);
>>> + free = (si->pages << (PAGE_SHIFT - 10))
>>> + - (si->inuse_pages << (PAGE_SHIFT - 10));
>>> + if (!ratio)
>>> + result += free / 2;
>>> + else
>>> + result = free * (100 - 10000 / ratio) / 100;
>>> + up_read(&z->init_lock);
>>> + }
>>> + } else
>>> + result += (si->pages << (PAGE_SHIFT - 10))
>>> + - (si->inuse_pages << (PAGE_SHIFT - 10));
>>> +
>>> + return result;
>>> +}
>>> +
>>> +u64 count_avail_swaps(void)
>>> +{
>>> + int type;
>>> + u64 result;
>>> + struct swap_info_struct *si;
>>> +
>>> + result = 0;
>>> + spin_lock(&swap_lock);
>>> + for (type = 0; type < nr_swapfiles; type++) {
>>> + si = swap_info[type];
>>> + spin_lock(&si->lock);
>>> + result += count_avail_swap(si);
>>> + spin_unlock(&si->lock);
>>> + }
>>> + spin_unlock(&swap_lock);
>>> +
>>> + return result;
>>> +}
>>> +
>>> +void update_zram_zstat(struct swap_info_struct *si)
>>> +{
>>> + struct zram *z;
>>> + struct zram_stats *stat;
>>> + int ratio;
>>> + u64 orig_size, compr_data_size;
>>> +
>>> + if (!si)
>>> + return;
>>> +
>>> + //update zram min compress ratio
>>> + if (si->flags & SWP_USED && si->swap_map) {
>>> + if (si->bdev->bd_disk->major == get_zram_major()) {
>>> + z = (struct zram *)si->bdev->bd_disk->private_data;
>>> + down_read(&z->init_lock);
>>> + stat = &z->stats;
>>> + ratio = atomic_read(&stat->min_compr_ratio);
>>> + orig_size = atomic64_read(&stat->pages_stored) << PAGE_SHIFT;
>>> + compr_data_size = atomic64_read(&stat->compr_data_size);
>>> + if (compr_data_size && (!ratio
>>> +     || ((orig_size * 100) / compr_data_size < ratio)))
>>> + atomic_set(&stat->min_compr_ratio,
>>> +    (orig_size * 100) / compr_data_size);
>>> + up_read(&z->init_lock);
>>> + }
>>> + }
>>> +}
>>> +
>>> +void update_zram_zstats(void)
>>> +{
>>> + int type;
>>> + struct swap_info_struct *si;
>>> +
>>> + spin_lock(&swap_lock);
>>> + for (type = 0; type < nr_swapfiles; type++) {
>>> + si = swap_info[type];
>>> + spin_lock(&si->lock);
>>> + update_zram_zstat(si);
>>> + spin_unlock(&si->lock);
>>> + }
>>> + spin_unlock(&swap_lock);
>>> +}
>>> +
>>>    void si_swapinfo(struct sysinfo *val)
>>>    {
>>>     unsigned int type;
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index eb31452..ffaf59b 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -4159,6 +4159,7 @@ static int kswapd(void *p)
>>>     alloc_order);
>>>     reclaim_order = balance_pgdat(pgdat, alloc_order,
>>>     highest_zoneidx);
>>> + update_zram_zstats();
>>>     if (reclaim_order < alloc_order)
>>>     goto kswapd_try_sleep;
>>>     }
>>> --
>>> 2.7.4
>>
>>
>> --
>> Thanks,
>>
>> David / dhildenb
>>
> 


-- 
Thanks,

David / dhildenb

