Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC83098C8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhA3XSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhA3XSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:18:40 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E9C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:18:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p21so17683514lfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zFgn0TmKFtNNs3cjJkq4u2lwCNPKs6ofIywWaibKc80=;
        b=Xig1rfH9tRAPhK78YlTYa9duURS00/sfQaL74K5th9BCOZ4c60VF1jSvo44gPA+ise
         6tgubmTJG8eCoB7LIJi2SWd838uykd/h6XCXPxkOUqkWZ7N22Nkjd7JjKSaPtyikyPS3
         kGx//2K8721RjSygFZV8yZCc2s7FqkKYEM9saoZYNMtP65JbX1cFk2qYhuNmWXN9HrPE
         Y/TUuXBtaresDTTZittTWdEaEktm+CyOW2EDjqUrjIJ3LqiFwCFCr8yZBF/PLoYOnLU+
         w4rLjQoOoPbHBwL9fmg+s69fSefR1RGtu3RWiKpQ/Njo2ibDjC3EJhkUkXFqUi8w4vws
         WfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zFgn0TmKFtNNs3cjJkq4u2lwCNPKs6ofIywWaibKc80=;
        b=kXHSMljIKTSzycbLOWf/bH3+9gZ5+JQpJbXRkE2ZioEdxqBBd4CqaNeyEoJIVV/26T
         vBQXEoackr2outwGmjYODfMmf61CCG1TN5BbiWqtWMVcTPISw/NRAVlB4x7qZoU1rjIh
         5zsLOnzlidW2I2V7FLVFNgsCgFi5DSX8dKPAmN9T/JsKrO5hbM/ZP3l8wDkXYLzijDqF
         1pDtCtGTNTwZyCslliQNL2cqVXIee285cL+l3OiHWlGdVwckLS8aZUWfEiQi/Gagxt6t
         o+KHzKIrxyUoZ92qv47m+sBU3zrhFeCwPcy0radvLVRYcM0zTAkt/0fr/SvLm+Z9gE5X
         0k7A==
X-Gm-Message-State: AOAM531LM0d6u9YZE4wPGcYpNaCW0O8vPNbvXS4Iart1Q7pIN5J45kse
        FxaUrkdAcrlWZUyMePuB4PhXRZBd091mlmSoewQ=
X-Google-Smtp-Source: ABdhPJzZczXPTbJ/JlIRlD9Bcb3Sr4V6hfGS+lQC2J810q0+K0WcdPP6idY98cUtyzTzprZD+Y9iUhcxuF5on5u9tgg=
X-Received: by 2002:a19:985:: with SMTP id 127mr5545337lfj.66.1612048678702;
 Sat, 30 Jan 2021 15:17:58 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 31 Jan 2021 04:17:46 +0500
Message-ID: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
Subject: [bug] 5.11-rc5 brought page allocation failure issue [ttm][amdgpu]
To:     ckoenig.leichtzumerken@gmail.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5.11-rc5 (git 76c057c84d28) brought a new issue.
Now the kernel log is flooded with the message "page allocation failure".

Trace:
msedge:cs0: page allocation failure: order:10,
mode:0x190cc2(GFP_HIGHUSER|__GFP_NORETRY|__GFP_NOMEMALLOC),
nodemask=(null),cpuset=/,mems_allowed=0
CPU: 18 PID: 4540 Comm: msedge:cs0 Tainted: G        W
--------- ---  5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 3402 01/13/2021
Call Trace:
 dump_stack+0x8b/0xb0
 warn_alloc.cold+0x72/0xd6
 ? _cond_resched+0x16/0x50
 ? __alloc_pages_direct_compact+0x1a1/0x210
 __alloc_pages_slowpath.constprop.0+0xf64/0xf90
 ? kmem_cache_alloc+0x299/0x310
 ? lock_acquire+0x173/0x380
 ? trace_hardirqs_on+0x1b/0xe0
 ? lock_release+0x1e9/0x400
 __alloc_pages_nodemask+0x37d/0x400
 ttm_pool_alloc+0x2a3/0x630 [ttm]
 ttm_tt_populate+0x37/0xe0 [ttm]
 ttm_bo_handle_move_mem+0x142/0x180 [ttm]
 ttm_bo_evict+0x12e/0x1b0 [ttm]
 ? kfree+0xeb/0x660
 ? amdgpu_vram_mgr_new+0x34d/0x3d0 [amdgpu]
 ttm_mem_evict_first+0x101/0x4d0 [ttm]
 ttm_bo_mem_space+0x2c8/0x330 [ttm]
 ttm_bo_validate+0x163/0x1c0 [ttm]
 amdgpu_cs_bo_validate+0x82/0x190 [amdgpu]
 amdgpu_cs_list_validate+0x105/0x150 [amdgpu]
 amdgpu_cs_ioctl+0x803/0x1ef0 [amdgpu]
 ? trace_hardirqs_off_caller+0x41/0xd0
 ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
 drm_ioctl_kernel+0x8c/0xe0 [drm]
 drm_ioctl+0x20f/0x3c0 [drm]
 ? amdgpu_cs_find_mapping+0xe0/0xe0 [amdgpu]
 ? selinux_file_ioctl+0x147/0x200
 ? lock_acquired+0x1fa/0x380
 ? lock_release+0x1e9/0x400
 ? trace_hardirqs_on+0x1b/0xe0
 amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
 __x64_sys_ioctl+0x82/0xb0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f829c36c11b
Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c
c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 25 bd 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f8282c14f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8282c14fa0 RCX: 00007f829c36c11b
RDX: 00007f8282c14fa0 RSI: 00000000c0186444 RDI: 0000000000000018
RBP: 00000000c0186444 R08: 00007f8282c15640 R09: 00007f8282c14f80
R10: 0000000000000000 R11: 0000000000000246 R12: 00001f592c0fe088
R13: 0000000000000018 R14: 0000000000000000 R15: 00000000fffffffd
Mem-Info:
active_anon:24325 inactive_anon:3569299 isolated_anon:0
 active_file:704540 inactive_file:2709725 isolated_file:0
 unevictable:1230 dirty:256317 writeback:7074
 slab_reclaimable:222328 slab_unreclaimable:112852
 mapped:838359 shmem:469422 pagetables:47722 bounce:0
 free:107165 free_pcp:1298 free_cma:0
Node 0 active_anon:97300kB inactive_anon:14277196kB
active_file:2818160kB inactive_file:10838900kB unevictable:4920kB
isolated(anon):0kB isolated(file):0kB mapped:3353436kB dirty:1025268kB
writeback:28296kB shmem:1877688kB shmem_thp: 0kB shmem_pmdmapped: 0kB
anon_thp: 0kB writeback_tmp:0kB kernel_stack:62528kB
pagetables:190888kB all_unreclaimable? no
Node 0 DMA free:11800kB min:32kB low:44kB high:56kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:15992kB managed:15900kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 3056 31787 31787 31787
Node 0 DMA32 free:303044kB min:6492kB low:9620kB high:12748kB
reserved_highatomic:0KB active_anon:20kB inactive_anon:1322808kB
active_file:5136kB inactive_file:483136kB unevictable:0kB
writepending:220876kB present:3314552kB managed:3246620kB mlocked:0kB
bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 28731 28731 28731
Node 0 Normal free:113816kB min:61052kB low:90472kB high:119892kB
reserved_highatomic:0KB active_anon:97280kB inactive_anon:12953852kB
active_file:2812656kB inactive_file:10355000kB unevictable:4920kB
writepending:832688kB present:30133248kB managed:29421044kB
mlocked:4920kB bounce:0kB free_pcp:5180kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 0*32kB 2*64kB (U) 1*128kB (U)
1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11800kB
Node 0 DMA32: 1009*4kB (UME) 724*8kB (UME) 488*16kB (UME) 1111*32kB
(UME) 950*64kB (UME) 620*128kB (UME) 223*256kB (UME) 74*512kB (M)
11*1024kB (M) 2*2048kB (ME) 0*4096kB = 303684kB
Node 0 Normal: 964*4kB (UME) 719*8kB (ME) 379*16kB (UME) 192*32kB
(UME) 127*64kB (UME) 130*128kB (UME) 122*256kB (UME) 18*512kB (UME)
4*1024kB (UM) 11*2048kB (UM) 0*4096kB = 113656kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
3881804 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 67108860kB
Total swap = 67108860kB
8365948 pages RAM
0 pages HighMem/MovableOnly
195057 pages reserved
0 pages cma reserved
0 pages hwpoisoned

Full kernel log: https://pastebin.com/dJEzxzQ7

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname
-r`/kernel/drivers/gpu/drm/ttm/ttm.ko.debug ttm_pool_alloc+0x2a3
ttm_pool_alloc+0x2a3/0x630:
alloc_pages at /usr/src/debug/kernel-20210128git76c057c84d28/linux-5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64/./include/linux/gfp.h:547
(inlined by) ttm_pool_alloc_page at
/usr/src/debug/kernel-20210128git76c057c84d28/linux-5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64/drivers/gpu/drm/ttm/ttm_pool.c:91
(inlined by) ttm_pool_alloc at
/usr/src/debug/kernel-20210128git76c057c84d28/linux-5.11.0-0.rc5.20210128git76c057c84d28.138.fc34.x86_64/drivers/gpu/drm/ttm/ttm_pool.c:383



-- 
Best Regards,
Mike Gavrilov.
