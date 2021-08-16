Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969243EDD7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhHPTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhHPTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629140553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaPaMTFRwOlalYqY+qpN8Vjkdz1ojm5EFtBdmc0R7Q0=;
        b=f2DaON1Evw/sNa9MLbO3IKITWmjEH5wrScxeGi64G5fRSHE176aUkBgwZ6bxwX0gu9DO3K
        Q6CizofKOnBwv1Y/v8t16hXQdPeb7Oy3Lxbgc3r5uTRi85G0raA3baaClxvK06qccz/BuW
        h0uE1iRiNoIJpSMtCdwr2KKynN9m00I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-SW_94KzhOUqfznLiq5x3Bg-1; Mon, 16 Aug 2021 15:02:32 -0400
X-MC-Unique: SW_94KzhOUqfznLiq5x3Bg-1
Received: by mail-wr1-f70.google.com with SMTP id z10-20020a5d440a0000b0290154e0f00348so5785271wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SaPaMTFRwOlalYqY+qpN8Vjkdz1ojm5EFtBdmc0R7Q0=;
        b=HFMXL1AHaeFHzdddfaz0Ij/70zqisiTXy3MymhfVtPVTMpWll1lf1WogxG5hls84Q1
         3PHmT+Qr7mziVDSeWmIlTuOL1YSMTcDCs+GG21lKC2/a4z1HDEOiQ7QciKiZAZGeeQGt
         pGQ633Ye+DtvTgjRBRHviVjMXIlW7VD3qKn8auAaMa5KXlhiNgKGOwMRgWhbAWKybM+l
         zHTrZuQ9rAYp8hsJ5Zy2rei8pt53mqeONcJMLzHFgA5v1beAq5NuZwCt60sxE5o2K17P
         ZDie/eC0z3jLEBUzxCPq5OWANT+miIzy5mkNHf6uY91pWhU/n0vG4wQCpycqyyyYIhVt
         nA0g==
X-Gm-Message-State: AOAM53183y++/wmwQuB23PCsP9u/tN+TfRYJr9XpMDxqUinh9sAiDQF+
        GuyZkPUe3BEJ5lzbosEXngnUbZWpb5tNf2a3aiPArsBN4c5ZnnYEBLgk5Q3XLQs+fyH3TvLpVod
        cdC9kyieaLfBh9DJVLr/BnDjPiYm6hWrR4zabpd9Oa1QJqAfdoKBQ1/bRJX7KJHSMQ2YHRqx4
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr20481960wrs.125.1629140551051;
        Mon, 16 Aug 2021 12:02:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG10oAFva6f49HTqptclKG4Ju8lf+MYRjJoWcSTGlrxn2tFjSPgamIK2DpHqGd+5SnB5z2qg==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr20481921wrs.125.1629140550753;
        Mon, 16 Aug 2021 12:02:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id h11sm10965wmc.23.2021.08.16.12.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 12:02:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     Yang Shi <shy828301@gmail.com>, naoya.horiguchi@nec.com,
        osalvador@suse.de, tdmackey@twitter.com, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210816180909.3603-1-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2ea04811-a9a3-0fe6-38aa-222e79ded09a@redhat.com>
Date:   Mon, 16 Aug 2021 21:02:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816180909.3603-1-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 20:09, Yang Shi wrote:
> In the current implementation of soft offline, if non-LRU page is met,
> all the slab caches will be dropped to free the page then offline.  But
> if the page is not slab page all the effort is wasted in vain.  Even
> though it is a slab page, it is not guaranteed the page could be freed
> at all.
> 
> However the side effect and cost is quite high.  It does not only drop
> the slab caches, but also may drop a significant amount of page caches
> which are associated with inode caches.  It could make the most
> workingset gone in order to just offline a page.  And the offline is not
> guaranteed to succeed at all, actually I really doubt the success rate
> for real life workload.
> 
> Furthermore the worse consequence is the system may be locked up and
> unusable since the page cache release may incur huge amount of works
> queued for memcg release.
> 
> Actually we ran into such unpleasant case in our production environment.
> Firstly, the workqueue of memory_failure_work_func is locked up as
> below:
> 
> BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 53s!
> Showing busy workqueues and worker pools:
> workqueue events: flags=0x0
>    pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=14/256 refcnt=15
>      in-flight: 409271:memory_failure_work_func
>      pending: kfree_rcu_work, kfree_rcu_monitor, kfree_rcu_work, rht_deferred_worker, rht_deferred_worker, rht_deferred_worker, rht_deferred_worker, kfree_rcu_work, kfree_rcu_work, kfree_rcu_work, kfree_rcu_work, drain_local_stock, kfree_rcu_work
> workqueue mm_percpu_wq: flags=0x8
>    pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>      pending: vmstat_update
> workqueue cgroup_destroy: flags=0x0
>    pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=12072
>      pending: css_release_work_fn
> 
> There were over 12K css_release_work_fn queued, and this caused a few
> lockups due to the contention of worker pool lock with IRQ disabled, for
> example:
> 
> NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
> Modules linked in: amd64_edac_mod edac_mce_amd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel xt_DSCP iptable_mangle kvm_amd bpfilter vfat fat acpi_ipmi i2c_piix4 usb_storage ipmi_si k10temp i2c_core ipmi_devintf ipmi_msghandler acpi_cpufreq sch_fq_codel xfs libcrc32c crc32c_intel mlx5_core mlxfw nvme xhci_pci ptp nvme_core pps_core xhci_hcd
> CPU: 1 PID: 205500 Comm: kworker/1:0 Tainted: G             L    5.10.32-t1.el7.twitter.x86_64 #1
> Hardware name: TYAN F5AMT /z        /S8026GM2NRE-CGN, BIOS V8.030 03/30/2021
> Workqueue: events memory_failure_work_func
> RIP: 0010:queued_spin_lock_slowpath+0x41/0x1a0
> Code: 41 f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 1b 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> RSP: 0018:ffff9b2ac278f900 EFLAGS: 00000002
> RAX: 0000000000480101 RBX: ffff8ce98ce71800 RCX: 0000000000000084
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ce98ce6a140
> RBP: 00000000000284c8 R08: ffffd7248dcb6808 R09: 0000000000000000
> R10: 0000000000000003 R11: ffff9b2ac278f9b0 R12: 0000000000000001
> R13: ffff8cb44dab9c00 R14: ffffffffbd1ce6a0 R15: ffff8cacaa37f068
> FS:  0000000000000000(0000) GS:ffff8ce98ce40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcf6e8cb000 CR3: 0000000a0c60a000 CR4: 0000000000350ee0
> Call Trace:
>   __queue_work+0xd6/0x3c0
>   queue_work_on+0x1c/0x30
>   uncharge_batch+0x10e/0x110
>   mem_cgroup_uncharge_list+0x6d/0x80
>   release_pages+0x37f/0x3f0
>   __pagevec_release+0x1c/0x50
>   __invalidate_mapping_pages+0x348/0x380
>   ? xfs_alloc_buftarg+0xa4/0x120 [xfs]
>   inode_lru_isolate+0x10a/0x160
>   ? iput+0x1d0/0x1d0
>   __list_lru_walk_one+0x7b/0x170
>   ? iput+0x1d0/0x1d0
>   list_lru_walk_one+0x4a/0x60
>   prune_icache_sb+0x37/0x50
>   super_cache_scan+0x123/0x1a0
>   do_shrink_slab+0x10c/0x2c0
>   shrink_slab+0x1f1/0x290
>   drop_slab_node+0x4d/0x70
>   soft_offline_page+0x1ac/0x5b0
>   ? dev_mce_log+0xee/0x110
>   ? notifier_call_chain+0x39/0x90
>   memory_failure_work_func+0x6a/0x90
>   process_one_work+0x19e/0x340
>   ? process_one_work+0x340/0x340
>   worker_thread+0x30/0x360
>   ? process_one_work+0x340/0x340
>   kthread+0x116/0x130

Just curious, who actually ends up calling soft_offline_page() ? I 
cannot really make sense of this, looking at upstream Linux.

I can spot

a) drivers/base/memory.c: /sys/devices/system/memory/soft_offline_page 
seems to be a testing interface

b) MADV_SOFT_OFFLINE seems to be a testing interface as well

c) arch/parisc/kernel/pdt.c doesn't apply to your case I guess?

I'm just wondering who ends up calling soft_offline_page() in a 
production environment and via which call path. I'm most probably 
missing something.

-- 
Thanks,

David / dhildenb

