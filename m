Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39240BC74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhIOAHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOAHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:07:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E96C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:05:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f21so504322plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Yx8N9l/bGE2LoTHp+yhv2lg4BxImxyhH5zoxFhp2MbU=;
        b=ILN2qFAm6tcbOkMGoJePG+t3hm7RfyuSbFBewqtEML3aG+fQV94v3p0gf+7q/1zpYC
         BNYcVLkoUdEt/Fy484iPpu6Cvvc+6l7G8C1EYjVu/7vMrfLipZwzDPI35VX+9dS+WvUu
         lS6oYoPdl+SmtlQIEWYzevjpOjU3aMj2TfSRN7h1LToEYLRkEzZsTwPTcnd4iVEzLm3f
         S8A+UKGr6iE4pPpaZxHjTlQ7LvHiZVAzmXlVw30lGBcKrDqsMaxN2y4S9BYZmQncqWcv
         WRb0/3IkpmmVEEqMVPKjB5HM5DlpeRYAyXEbvyWgyNi98uP+bzoXBFEkAjTECD0IeiID
         d6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Yx8N9l/bGE2LoTHp+yhv2lg4BxImxyhH5zoxFhp2MbU=;
        b=s58pIL6eySwxDc3YkbX5O66prFrW7E2+kJvVRTE83eHsW0huIn6KXBqjj1WmI0kWj5
         LbNfjRe1kVN8rCSHRBhhOeAfraHiKFyJa3gHSVrip2rlJ2Q4S9PT7/+2HQHrKAWMOgLz
         FlV38rbdu/tgwzxwxi3Zp6/EO1UYuyxfxdBk+jEezHnpPfSItYVybzjt+RG1j5igcCCp
         vAxq5tgIEHLEnK4u4HyQT0IgWxtKixIKJ+OzBmL5yRK7DnPP4k5t27AU+PpYHd0eshqc
         7o0JyyqaHBAvMrbqHY7sQV2UnQeBNosROV08TicWGcjhBJDot4Sc2a3opJRKJGx1PMwt
         ksmg==
X-Gm-Message-State: AOAM533ogNhTb0HYo7YHhW7/XF01Srja9O9GtOf98AWDjnAmCETvOrFp
        lqm1hjt5ktqILckosWFA1uxnEs01izc5Cw==
X-Google-Smtp-Source: ABdhPJz4aQvhnAAFUyLhYIDVfflZvKUr0+AFXK9uT7PMExp7NArB0wn+v1KZ87ZtBYrZTHuWyvUusQ==
X-Received: by 2002:a17:90a:19db:: with SMTP id 27mr5037425pjj.57.1631664353605;
        Tue, 14 Sep 2021 17:05:53 -0700 (PDT)
Received: from [2620:15c:17:3:22e5:69e1:debc:7973] ([2620:15c:17:3:22e5:69e1:debc:7973])
        by smtp.gmail.com with ESMTPSA id w142sm8535938pfc.47.2021.09.14.17.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:05:52 -0700 (PDT)
Date:   Tue, 14 Sep 2021 17:05:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.13.14 page allocation failure
In-Reply-To: <9166a3d3-bb22-bf23-453f-8507cc3dc500@xs4all.nl>
Message-ID: <1546b93d-2e78-e9e6-5d17-cbeea135dca@google.com>
References: <9166a3d3-bb22-bf23-453f-8507cc3dc500@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021, Udo van den Heuvel wrote:

> Hello,
> 
> Ever since I recently migrated from AMD Ryzen 3400g to 5700g and went from
> 16GB to 32GB we get these:
> 
> Sep  8 16:40:44 knalp3 kernel: chrome: page allocation failure: order:7,
> mode:0x40a20(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
> Sep  8 16:40:44 knalp3 kernel: CPU: 0 PID: 156918 Comm: chrome Not tainted
> 5.13.14 #5
> Sep  8 16:40:44 knalp3 kernel: Hardware name: Gigabyte Technology Co., Ltd.
> X570 AORUS PRO/X570 AORUS PRO, BIOS F34 07/08/2021
> Sep  8 16:40:44 knalp3 kernel: Call Trace:
> Sep  8 16:40:44 knalp3 kernel: dump_stack+0x64/0x7c
> Sep  8 16:40:44 knalp3 kernel: warn_alloc.cold+0x6f/0xd3
> Sep  8 16:40:44 knalp3 kernel: __alloc_pages_slowpath.constprop.0+0x6c3/0xa80
> Sep  8 16:40:44 knalp3 kernel: ? get_page_from_freelist+0x223/0x9d0
> Sep  8 16:40:44 knalp3 kernel: __alloc_pages+0x169/0x1d0
> Sep  8 16:40:44 knalp3 kernel: cache_alloc_refill+0x58f/0x810
> Sep  8 16:40:44 knalp3 kernel: ? _raw_spin_unlock+0xd/0x20
> Sep  8 16:40:44 knalp3 kernel: kmem_cache_alloc+0x109/0x120
> Sep  8 16:40:44 knalp3 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
> Sep  8 16:40:44 knalp3 kernel: p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]

I'm not sure of the Linux Kernel Runtiem Guard being used here, but 
allocating order-7 memory with GFP_ATOMIC is not at all expected to 
succeed.  The page allocator does not have the ability to do reclaim or to 
defragment memory using memory compaction in this context.

Suggest opening a bug for this with Openwall.

> Sep  8 16:40:44 knalp3 kernel: pre_handler_kretprobe+0x8a/0x160
> Sep  8 16:40:44 knalp3 kernel: opt_pre_handler+0x4a/0x80
> Sep  8 16:40:44 knalp3 kernel: optimized_callback+0xbe/0xf0
> Sep  8 16:40:44 knalp3 kernel: 0xffffffffc0076294
> Sep  8 16:40:44 knalp3 kernel: ? wake_up_new_task+0x1/0x280
> Sep  8 16:40:44 knalp3 kernel: ? kernel_clone+0xd6/0x380
> Sep  8 16:40:44 knalp3 kernel: ? __do_sys_clone+0x60/0x80
> Sep  8 16:40:44 knalp3 kernel: ? do_syscall_64+0x61/0x80
> Sep  8 16:40:44 knalp3 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> Sep  8 16:40:44 knalp3 kernel: Mem-Info:
> Sep  8 16:40:44 knalp3 kernel: active_anon:5244 inactive_anon:1494070
> isolated_anon:0#012 active_file:1098885 inactive_file:4703460
> isolated_file:0#012 unevictable:639 dirty:948 writeback:0#012
> slab_reclaimable:74606 slab_unreclaimable:245109#012 mapped:347626
> shmem:160084 pagetables:16000 bounce:0#012 free:98085 free_pcp:4475 free_cma:0
> Sep  8 16:40:44 knalp3 kernel: Node 0 active_anon:20976kB
> inactive_anon:5976280kB active_file:4395540kB inactive_file:18813840kB
> unevictable:2556kB isolated(anon):0kB isolated(file):0kB mapped:1390504kB
> dirty:3792kB writeback:0kB shmem:640336kB shmem_thp: 0kB shmem_pmdmapped: 0kB
> anon_thp: 1681408kB writeback_tmp:0kB kernel_stack:31376kB pagetables:64000kB
> all_unreclaimable? no
> Sep  8 16:40:44 knalp3 kernel: DMA free:11264kB min:32kB low:44kB high:56kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB
> inactive_file:0kB unevictable:0kB writepending:0kB present:15984kB
> managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 2357 31506 31506
> Sep  8 16:40:44 knalp3 kernel: DMA32 free:118968kB min:5052kB low:7464kB
> high:9876kB reserved_highatomic:16384KB active_anon:124kB
> inactive_anon:772432kB active_file:166476kB inactive_file:1282188kB
> unevictable:16kB writepending:368kB present:2521312kB managed:2455776kB
> mlocked:16kB bounce:0kB free_pcp:3528kB local_pcp:0kB free_cma:0kB
> Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 0 29148 29148
> Sep  8 16:40:44 knalp3 kernel: Normal free:262612kB min:64544kB low:94388kB
> high:124232kB reserved_highatomic:0KB active_anon:20488kB
> inactive_anon:5202876kB active_file:4228640kB inactive_file:17532192kB
> unevictable:2540kB writepending:3424kB present:30379008kB managed:29854648kB
> mlocked:68kB bounce:0kB free_pcp:14248kB local_pcp:64kB free_cma:0kB
> Sep  8 16:40:44 knalp3 kernel: lowmem_reserve[]: 0 0 0 0
> Sep  8 16:40:44 knalp3 kernel: DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB
> 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11264kB
> Sep  8 16:40:44 knalp3 kernel: DMA32: 494*4kB (UM) 132*8kB (UM) 194*16kB (M)
> 710*32kB (M) 224*64kB (UM) 24*128kB (UM) 18*256kB (UM) 13*512kB (M) 6*1024kB
> (M) 9*2048kB (M) 9*4096kB (M) = 118968kB
> Sep  8 16:40:44 knalp3 kernel: Normal: 570*4kB (UME) 2546*8kB (UME) 2503*16kB
> (UME) 1391*32kB (UME) 848*64kB (UME) 549*128kB (UME) 114*256kB (U) 1*512kB (M)
> 0*1024kB 0*2048kB 0*4096kB = 261448kB
> Sep  8 16:40:44 knalp3 kernel: Node 0 hugepages_total=0 hugepages_free=0
> hugepages_surp=0 hugepages_size=2048kB
> Sep  8 16:40:44 knalp3 kernel: 5963328 total pagecache pages
> Sep  8 16:40:44 knalp3 kernel: 0 pages in swap cache
> Sep  8 16:40:44 knalp3 kernel: Swap cache stats: add 170, delete 169, find
> 61/83
> Sep  8 16:40:44 knalp3 kernel: Free swap  = 18873848kB
> Sep  8 16:40:44 knalp3 kernel: Total swap = 18874360kB
> Sep  8 16:40:44 knalp3 kernel: 8229076 pages RAM
> Sep  8 16:40:44 knalp3 kernel: 0 pages HighMem/MovableOnly
> Sep  8 16:40:44 knalp3 kernel: 147630 pages reserved
> Sep  8 16:40:44 knalp3 kernel: [p_lkrg] p_alloc_ed_pids() returned NULL for
> pid 156929 :(
> 
> This did not happen (unless there really was an OOM) when using 16GB of RAM.
> 
> The RAM is from AMD's HCL for AMD Ryzen 3000+. The RAM was tested with
> memtest86 with no errors. (only a night, but still)
> 
> How can I find out what is going on?
> Did I misconfigure my kernel?
> Do I make to configure something to use the 'immense' amount of 32GB with no
> issues?
> 
> Please let me know.
> 
> 
> Kind regards,
> Udo
> 
