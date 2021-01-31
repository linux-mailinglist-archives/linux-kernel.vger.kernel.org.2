Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68A830998B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhAaBB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhAaBB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:01:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A522C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:01:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so7934927plh.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lodb+ht9BR+Z7IAwV21RAKzFam+8lcDMU8RhLDk/c/I=;
        b=GDyXA6rd2tIUOjVP8BMEixrV10K/0p1Te2ahfCjg4PtIoi9w54+06zGyOCg8UK2PSJ
         YqbXooLG2ERe8atuIfJpKVX6lytKCu7CJU+FVAs1U3sR7rntIAh4bX5GIS/s2sNipYB0
         jxnxOmBVonBbxMYEwoTzHFyG4cWygHOv9XAgUC9n9tU8o22TT6ataZy1Tzd0JvjXCX3o
         eKgna0+G1d9p3fO/KpaF2KwQKG28R2Pp4lEpAkyZSS+yKDDq86N1bn3kXCtdP9XadsPy
         q4JvyV6QaoSzyAobdxb95sAwbSfq9GRCuMBW2Y88G5rloFoFpyFKrotNROWuGe4GqB+k
         cOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lodb+ht9BR+Z7IAwV21RAKzFam+8lcDMU8RhLDk/c/I=;
        b=sg8k7MA8B8iGPF2R87hWqOBquMVrTWOC1MZ8r+ImMjeBQzgKso+QOJpY/Z2DOBqsPz
         8KMf/bR2puu2TGamTOr15F5cKejy3sRF6ZCh2jMGT9DwXdGGGYM6MGWeGbpLrMv1KHLa
         caLPYzkyXyOWlIZoasZBFkcIU9xT7hxMpUXbMLH+FMWIenK2FtgV/FuQW5f/QdIqJq3j
         n/vma7zAjNIrDjmAM4yCMdg7vMlUo1H/88bnfayR98sfsmBuOXLKkI9DfN5hDCU1WayT
         HshA/M4DI9bsaJAjXV62pWV60FOtXriFJ4IbJuryQ7HsNUDpZYz47GxstteLHwZYGvkn
         rUcQ==
X-Gm-Message-State: AOAM5304Osk/MFo5kXG2EQr4rLfvTOESma2OURy3A6JfbN8JieFgcd+j
        H542kda+vUk5nu7EkwaHSCGoww==
X-Google-Smtp-Source: ABdhPJxaYlEuaNa9YFIS6XiaWngEVUvBpS98dh/MIqh6NgLoXG0PdLBvytlpgPVtBc6T9JMdheK4Hw==
X-Received: by 2002:a17:902:9044:b029:df:fa69:1ed1 with SMTP id w4-20020a1709029044b02900dffa691ed1mr11631079plz.11.1612054874676;
        Sat, 30 Jan 2021 17:01:14 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id r9sm3533359pfq.8.2021.01.30.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:01:13 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:01:13 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        ckoenig.leichtzumerken@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue
 [ttm][amdgpu]
In-Reply-To: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
Message-ID: <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-881750204-1612054873=:606041"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-881750204-1612054873=:606041
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 31 Jan 2021, Mikhail Gavrilov wrote:

> The 5.11-rc5 (git 76c057c84d28) brought a new issue.
> Now the kernel log is flooded with the message "page allocation failure".
> 
> Trace:
> msedge:cs0: page allocation failure: order:10,

Order-10, wow!

ttm_pool_alloc() will start at order-10 and back off trying smaller orders 
if necessary.  This is a regression introduced in

commit bf9eee249ac2032521677dd74e31ede5429afbc0
Author: Christian König <christian.koenig@amd.com>
Date:   Wed Jan 13 14:02:04 2021 +0100

    drm/ttm: stop using GFP_TRANSHUGE_LIGHT

Namely, it removed the __GFP_NOWARN that we otherwise require.  I'll send 
a patch in reply.

> mode:0x190cc2(GFP_HIGHUSER|__GFP_NORETRY|__GFP_NOMEMALLOC),
> nodemask=(null),cpuset=/,mems_allowed=0
> CPU: 18 PID: 4540 Comm: msedge:cs0 Tainted: G        W
> --------- ---  5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64 #1
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 3402 01/13/2021
> Call Trace:
>  dump_stack+0x8b/0xb0
>  warn_alloc.cold+0x72/0xd6
>  ? _cond_resched+0x16/0x50
>  ? __alloc_pages_direct_compact+0x1a1/0x210
>  __alloc_pages_slowpath.constprop.0+0xf64/0xf90
>  ? kmem_cache_alloc+0x299/0x310
>  ? lock_acquire+0x173/0x380
>  ? trace_hardirqs_on+0x1b/0xe0
>  ? lock_release+0x1e9/0x400
>  __alloc_pages_nodemask+0x37d/0x400
>  ttm_pool_alloc+0x2a3/0x630 [ttm]
>  ttm_tt_populate+0x37/0xe0 [ttm]
>  ttm_bo_handle_move_mem+0x142/0x180 [ttm]
>  ttm_bo_evict+0x12e/0x1b0 [ttm]
>  ? kfree+0xeb/0x660
>  ? amdgpu_vram_mgr_new+0x34d/0x3d0 [amdgpu]
>  ttm_mem_evict_first+0x101/0x4d0 [ttm]
>  ttm_bo_mem_space+0x2c8/0x330 [ttm]
>  ttm_bo_validate+0x163/0x1c0 [ttm]
>  amdgpu_cs_bo_validate+0x82/0x190 [amdgpu]
>  amdgpu_cs_list_validate+0x105/0x150 [amdgpu]
>  amdgpu_cs_ioctl+0x803/0x1ef0 [amdgpu]
>  ? trace_hardirqs_off_caller+0x41/0xd0
>  ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
>  drm_ioctl_kernel+0x8c/0xe0 [drm]
>  drm_ioctl+0x20f/0x3c0 [drm]
>  ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
>  ? selinux_file_ioctl+0x147/0x200
>  ? lock_acquired+0x1fa/0x380
>  ? lock_release+0x1e9/0x400
>  ? trace_hardirqs_on+0x1b/0xe0
>  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
>  __x64_sys_ioctl+0x82/0xb0
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f829c36c11b
> Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c
> c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 25 bd 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007f8282c14f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f8282c14fa0 RCX: 00007f829c36c11b
> RDX: 00007f8282c14fa0 RSI: 00000000c0186444 RDI: 0000000000000018
> RBP: 00000000c0186444 R08: 00007f8282c15640 R09: 00007f8282c14f80
> R10: 0000000000000000 R11: 0000000000000246 R12: 00001f592c0fe088
> R13: 0000000000000018 R14: 0000000000000000 R15: 00000000fffffffd
> Mem-Info:
> active_anon:24325 inactive_anon:3569299 isolated_anon:0
>  active_file:704540 inactive_file:2709725 isolated_file:0
>  unevictable:1230 dirty:256317 writeback:7074
>  slab_reclaimable:222328 slab_unreclaimable:112852
>  mapped:838359 shmem:469422 pagetables:47722 bounce:0
>  free:107165 free_pcp:1298 free_cma:0
> Node 0 active_anon:97300kB inactive_anon:14277196kB
> active_file:2818160kB inactive_file:10838900kB unevictable:4920kB
> isolated(anon):0kB isolated(file):0kB mapped:3353436kB dirty:1025268kB
> writeback:28296kB shmem:1877688kB shmem_thp: 0kB shmem_pmdmapped: 0kB
> anon_thp: 0kB writeback_tmp:0kB kernel_stack:62528kB
> pagetables:190888kB all_unreclaimable? no
> Node 0 DMA free:11800kB min:32kB low:44kB high:56kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
> present:15992kB managed:15900kB mlocked:0kB bounce:0kB free_pcp:0kB
> local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 3056 31787 31787 31787
> Node 0 DMA32 free:303044kB min:6492kB low:9620kB high:12748kB
> reserved_highatomic:0KB active_anon:20kB inactive_anon:1322808kB
> active_file:5136kB inactive_file:483136kB unevictable:0kB
> writepending:220876kB present:3314552kB managed:3246620kB mlocked:0kB
> bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 28731 28731 28731
> Node 0 Normal free:113816kB min:61052kB low:90472kB high:119892kB
> reserved_highatomic:0KB active_anon:97280kB inactive_anon:12953852kB
> active_file:2812656kB inactive_file:10355000kB unevictable:4920kB
> writepending:832688kB present:30133248kB managed:29421044kB
> mlocked:4920kB bounce:0kB free_pcp:5180kB local_pcp:4kB free_cma:0kB
> lowmem_reserve[]: 0 0 0 0 0
> Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB (U) 1*128kB (U)
> 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11800kB
> Node 0 DMA32: 1009*4kB (UME) 724*8kB (UME) 488*16kB (UME) 1111*32kB
> (UME) 950*64kB (UME) 620*128kB (UME) 223*256kB (UME) 74*512kB (M)
> 11*1024kB (M) 2*2048kB (ME) 0*4096kB = 303684kB
> Node 0 Normal: 964*4kB (UME) 719*8kB (ME) 379*16kB (UME) 192*32kB
> (UME) 127*64kB (UME) 130*128kB (UME) 122*256kB (UME) 18*512kB (UME)
> 4*1024kB (UM) 11*2048kB (UM) 0*4096kB = 113656kB
> Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0
> hugepages_size=1048576kB
> Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> 3881804 total pagecache pages
> 0 pages in swap cache
> Swap cache stats: add 0, delete 0, find 0/0
> Free swap  = 67108860kB
> Total swap = 67108860kB
> 8365948 pages RAM
> 0 pages HighMem/MovableOnly
> 195057 pages reserved
> 0 pages cma reserved
> 0 pages hwpoisoned
> 
> Full kernel log: https://pastebin.com/dJEzxzQ7
> 
> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname
> -r`/kernel/drivers/gpu/drm/ttm/ttm.ko.debug ttm_pool_alloc+0x2a3
> ttm_pool_alloc+0x2a3/0x630:
> alloc_pages at /usr/src/debug/kernel-20210128git76c057c84d28/linux-5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64/./include/linux/gfp.h:547
> (inlined by) ttm_pool_alloc_page at
> /usr/src/debug/kernel-20210128git76c057c84d28/linux-5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64/drivers/gpu/drm/ttm/ttm_pool.c:91
> (inlined by) ttm_pool_alloc at
> /usr/src/debug/kernel-20210128git76c057c84d28/linux-5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64/drivers/gpu/drm/ttm/ttm_pool.c:383
> 
> 
> 
> -- 
> Best Regards,
> Mike Gavrilov.
> 
--1482994552-881750204-1612054873=:606041--
