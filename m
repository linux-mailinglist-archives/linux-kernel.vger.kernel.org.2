Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD03956BE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhEaISq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhEaISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622449021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/b/Emsa0FSUIKJI9wt8rcErU7Yt1S2VQUQdM8XMLLr8=;
        b=FtIBSR0WnOwgTQK2ECH7g/o8oYWQhoRVU6mMZ2yXk3Dppq79kz3T/blaZOT9p9XNfWPiPV
        hLAYBo/DKbMNiL22NA3YdlzgUMlXFIU5gwQabnJz34WOcQaD7f1+nkt2goVEg3Tl/W2GSH
        Pcu/zXdspuAcnUcGnw/Q2ETkmphOq1s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-gic4SyCWNAuuHu62X0XWCg-1; Mon, 31 May 2021 04:17:00 -0400
X-MC-Unique: gic4SyCWNAuuHu62X0XWCg-1
Received: by mail-wr1-f72.google.com with SMTP id z4-20020adfe5440000b0290114f89c9931so1457480wrm.17
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/b/Emsa0FSUIKJI9wt8rcErU7Yt1S2VQUQdM8XMLLr8=;
        b=glFose/8E2G1h3VKiMb7nKG1EMWoDbSxjIe2KyRHiR8raGhgZXz+NRANm7vXAzDrE3
         KNFVO/FiB+HZOmo0PjExqWUsH+cwl8f852NVkmEsRaFRDU4fFFW7aFQI6+ULJfKLsMYg
         DLnbf+gUafJo1/722sEJoe8J6h9i1DWVRHPkIdeoqucEE5z2UoZHbztgL4NYoS7Yu2ER
         eGY2B1eVwluLsAlBGiWOqkl/I3HcHWKz3+fmh79yrGtF+uTtT4W1aGc97dFrxhGWfHpA
         sk85U2znRDtJCtDiOOiF6o1qNyeVuec8I4mC8rm0c19NqkYjFW+kWu15ZxwW2aP7K04C
         UVIg==
X-Gm-Message-State: AOAM530MOgK7/oZIAbkx3oP6KjUsXo9y6vLeNs18nC2GRegST5boCa2b
        t5hkTK6YtULXuDb66/UGOgEUrU6IVx2F8SuVuKh5Lljaxk5oUiInMaoZaXWUZOznOVCLS/rFTT1
        YcnLcYmls4QdUBjqMTKTCly+Z
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr21500253wrr.159.1622449019186;
        Mon, 31 May 2021 01:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7pluG996V9OgV48SQDr0K4XGMV3gSLo1HKUqb8uwGV2U4T467X/HHsy1/cUVIv8bfWoGVFQ==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr21500232wrr.159.1622449018922;
        Mon, 31 May 2021 01:16:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a6f.dip0.t-ipconnect.de. [91.12.106.111])
        by smtp.gmail.com with ESMTPSA id j10sm16077664wrt.32.2021.05.31.01.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 01:16:58 -0700 (PDT)
To:     yong w <yongw.pur@gmail.com>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
References: <CAOH5QeCiBF8AYsF853YRFw=kKq+7ps_a30qOFwYOwbinYLbUEw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH V1] zram:calculate available memory when zram is used
Message-ID: <13c28e69-cfd9-bcf6-ab77-445c6fa4cc6e@redhat.com>
Date:   Mon, 31 May 2021 10:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOH5QeCiBF8AYsF853YRFw=kKq+7ps_a30qOFwYOwbinYLbUEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.21 19:18, yong w wrote:
> When zram is used, available+Swap free memory is obviously bigger than
> I actually can use, because zram can compress memory by compression
> algorithm and zram compressed data will occupy memory too.
> 
> So, I count the compression rate of zram in the kernel. The available
> memory  is calculated as follows:
> available + swapfree - swapfree * compress ratio
> MemAvailable in /proc/meminfo returns available + zram will save space
> 

This will mean that we can easily have MemAvailable > MemTotal, right? 
I'm not sure if there are some user space scripts that will be a little 
disrupted by that. Like calculating "MemUnavailable = MemTotal - 
MemAvailable".

MemAvailable: "An estimate of how much memory is available for starting 
new applications, without swapping"

Although zram isn't "traditional swapping", there is still a performance 
impact when having to go to zram because it adds an indirection and 
requires (de)compression. Similar to having very fast swap space (like 
PMEM). Let's not call something "memory" that doesn't have the same 
semantics as real memory as in "MemTotal".

This doesn't feel right.

> Signed-off-by: wangyong <yongw.pur@gmail.com <mailto:yongw.pur@gmail.com>>
> ---
>   drivers/block/zram/zcomp.h    |  1 +
>   drivers/block/zram/zram_drv.c |  4 ++
>   drivers/block/zram/zram_drv.h |  1 +
>   fs/proc/meminfo.c             |  2 +-
>   include/linux/swap.h          | 10 +++++
>   mm/swapfile.c                 | 95 
> +++++++++++++++++++++++++++++++++++++++++++
>   mm/vmscan.c                   |  1 +
>   7 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> index 40f6420..deb2dbf 100644
> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -40,4 +40,5 @@ int zcomp_decompress(struct zcomp_strm *zstrm,
>    const void *src, unsigned int src_len, void *dst);
> 
>   bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
> +int get_zram_major(void);
>   #endif /* _ZCOMP_H_ */
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cf8deec..1c6cbd4 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -59,6 +59,10 @@ static void zram_free_page(struct zram *zram, size_t 
> index);
>   static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
>    u32 index, int offset, struct bio *bio);
> 
> +int get_zram_major(void)
> +{
> + return zram_major;
> +}
> 
>   static int zram_slot_trylock(struct zram *zram, u32 index)
>   {
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 6e73dc3..5d8701a 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -88,6 +88,7 @@ struct zram_stats {
>    atomic64_t bd_reads; /* no. of reads from backing device */
>    atomic64_t bd_writes; /* no. of writes from backing device */
>   #endif
> + atomic_t min_compr_ratio;
>   };
> 
>   struct zram {
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c..f7bf350 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -57,7 +57,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> 
>    show_val_kb(m, "MemTotal:       ", i.totalram);
>    show_val_kb(m, "MemFree:        ", i.freeram);
> - show_val_kb(m, "MemAvailable:   ", available);
> + show_val_kb(m, "MemAvailable:   ", available + count_avail_swaps());
>    show_val_kb(m, "Buffers:        ", i.bufferram);
>    show_val_kb(m, "Cached:         ", cached);
>    show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 032485e..3225a2f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -514,6 +514,8 @@ extern int init_swap_address_space(unsigned int 
> type, unsigned long nr_pages);
>   extern void exit_swap_address_space(unsigned int type);
>   extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
>   sector_t swap_page_sector(struct page *page);
> +extern void update_zram_zstats(void);
> +extern u64 count_avail_swaps(void);
> 
>   static inline void put_swap_device(struct swap_info_struct *si)
>   {
> @@ -684,6 +686,14 @@ static inline swp_entry_t get_swap_page(struct page 
> *page)
>    return entry;
>   }
> 
> +void update_zram_zstats(void)
> +{
> +}
> +
> +u64 count_avail_swaps(void)
> +{
> +}
> +
>   #endif /* CONFIG_SWAP */
> 
>   #ifdef CONFIG_THP_SWAP
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cbb4c07..93a9dcb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -44,6 +44,7 @@
>   #include <asm/tlbflush.h>
>   #include <linux/swapops.h>
>   #include <linux/swap_cgroup.h>
> +#include "../drivers/block/zram/zram_drv.h"
> 
>   static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>    unsigned char);
> @@ -3408,6 +3409,100 @@ SYSCALL_DEFINE2(swapon, const char __user *, 
> specialfile, int, swap_flags)
>    return error;
>   }
> 
> +u64 count_avail_swap(struct swap_info_struct *si)
> +{
> + u64 result;
> + struct zram *z;
> + unsigned int free;
> + unsigned int ratio;
> +
> + result = 0;
> + if (!si)
> + return 0;
> +
> + //zram calculate available mem
> + if (si->flags & SWP_USED && si->swap_map) {
> + if (si->bdev->bd_disk->major == get_zram_major()) {
> + z = (struct zram *)si->bdev->bd_disk->private_data;
> + down_read(&z->init_lock);
> + ratio = atomic_read(&z->stats.min_compr_ratio);
> + free = (si->pages << (PAGE_SHIFT - 10))
> + - (si->inuse_pages << (PAGE_SHIFT - 10));
> + if (!ratio)
> + result += free / 2;
> + else
> + result = free * (100 - 10000 / ratio) / 100;
> + up_read(&z->init_lock);
> + }
> + } else
> + result += (si->pages << (PAGE_SHIFT - 10))
> + - (si->inuse_pages << (PAGE_SHIFT - 10));
> +
> + return result;
> +}
> +
> +u64 count_avail_swaps(void)
> +{
> + int type;
> + u64 result;
> + struct swap_info_struct *si;
> +
> + result = 0;
> + spin_lock(&swap_lock);
> + for (type = 0; type < nr_swapfiles; type++) {
> + si = swap_info[type];
> + spin_lock(&si->lock);
> + result += count_avail_swap(si);
> + spin_unlock(&si->lock);
> + }
> + spin_unlock(&swap_lock);
> +
> + return result;
> +}
> +
> +void update_zram_zstat(struct swap_info_struct *si)
> +{
> + struct zram *z;
> + struct zram_stats *stat;
> + int ratio;
> + u64 orig_size, compr_data_size;
> +
> + if (!si)
> + return;
> +
> + //update zram min compress ratio
> + if (si->flags & SWP_USED && si->swap_map) {
> + if (si->bdev->bd_disk->major == get_zram_major()) {
> + z = (struct zram *)si->bdev->bd_disk->private_data;
> + down_read(&z->init_lock);
> + stat = &z->stats;
> + ratio = atomic_read(&stat->min_compr_ratio);
> + orig_size = atomic64_read(&stat->pages_stored) << PAGE_SHIFT;
> + compr_data_size = atomic64_read(&stat->compr_data_size);
> + if (compr_data_size && (!ratio
> +     || ((orig_size * 100) / compr_data_size < ratio)))
> + atomic_set(&stat->min_compr_ratio,
> +    (orig_size * 100) / compr_data_size);
> + up_read(&z->init_lock);
> + }
> + }
> +}
> +
> +void update_zram_zstats(void)
> +{
> + int type;
> + struct swap_info_struct *si;
> +
> + spin_lock(&swap_lock);
> + for (type = 0; type < nr_swapfiles; type++) {
> + si = swap_info[type];
> + spin_lock(&si->lock);
> + update_zram_zstat(si);
> + spin_unlock(&si->lock);
> + }
> + spin_unlock(&swap_lock);
> +}
> +
>   void si_swapinfo(struct sysinfo *val)
>   {
>    unsigned int type;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eb31452..ffaf59b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4159,6 +4159,7 @@ static int kswapd(void *p)
>    alloc_order);
>    reclaim_order = balance_pgdat(pgdat, alloc_order,
>    highest_zoneidx);
> + update_zram_zstats();
>    if (reclaim_order < alloc_order)
>    goto kswapd_try_sleep;
>    }
> -- 
> 2.7.4


-- 
Thanks,

David / dhildenb

