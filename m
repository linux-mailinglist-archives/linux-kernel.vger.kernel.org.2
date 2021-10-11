Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D59428AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhJKKYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:24:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhJKKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:24:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7CCF22009;
        Mon, 11 Oct 2021 10:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633947732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyQen1Zq8Tl+eNKk+7X6QbIZKCPE6MO8S+wIugEUo/Y=;
        b=potp4nGQcaQHBKM7WWeqOodSSb5zdnY6IobzXyt7Q2XK3u4AdvfJuDBKuQB7fo4dpIUqes
        0fSdKZTs2FPHT5y6cmXCQktlYXBaH9g2XMdicci2uzDrDZ+hjvMWYIQ/XHJxaJ9KdOrolM
        WLL4DAyJhvZt9nY7y1i4CZI5TOdoIJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633947732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyQen1Zq8Tl+eNKk+7X6QbIZKCPE6MO8S+wIugEUo/Y=;
        b=BlvExj7R/7/oeQZZ2IwIPtv2w1J982s6E+hU0B6frUfM7S54czD77QRen7Ev4mCO9VXXNF
        /4MICsoZ1wHC04AA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3418DA3B88;
        Mon, 11 Oct 2021 10:22:12 +0000 (UTC)
Date:   Mon, 11 Oct 2021 11:22:10 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING
 | MPOL_LOCAL in mbind()
Message-ID: <20211011102210.GU3891@suse.de>
References: <20211001174947.135123-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211001174947.135123-1-eric.dumazet@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:49:47AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot reported access to unitialized memory in mbind() [1]
> 
> Issue came with commit bda420b98505 ("numa balancing: migrate on
> fault among multiple bound nodes")
> 
> This commit added a new bit in MPOL_MODE_FLAGS, but only checked
> valid combination (MPOL_F_NUMA_BALANCING can only be used with MPOL_BIND)
> in do_set_mempolicy()
> 
> This patch moves the check in sanitize_mpol_flags() so that it
> is also used by mbind()
> 
> [1]
> BUG: KMSAN: uninit-value in __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
>  __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
>  mpol_equal include/linux/mempolicy.h:105 [inline]
>  vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
>  mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
>  do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
>  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Uninit was created at:
>  slab_alloc_node mm/slub.c:3221 [inline]
>  slab_alloc mm/slub.c:3230 [inline]
>  kmem_cache_alloc+0x751/0xff0 mm/slub.c:3235
>  mpol_new mm/mempolicy.c:293 [inline]
>  do_mbind+0x912/0x15f0 mm/mempolicy.c:1289
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
>  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> =====================================================
> Kernel panic - not syncing: panic_on_kmsan set ...
> CPU: 0 PID: 15049 Comm: syz-executor.0 Tainted: G    B             5.15.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1ff/0x28e lib/dump_stack.c:106
>  dump_stack+0x25/0x28 lib/dump_stack.c:113
>  panic+0x44f/0xdeb kernel/panic.c:232
>  kmsan_report+0x2ee/0x300 mm/kmsan/report.c:186
>  __msan_warning+0xd7/0x150 mm/kmsan/instrumentation.c:208
>  __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
>  mpol_equal include/linux/mempolicy.h:105 [inline]
>  vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
>  mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
>  do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
>  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f4a41b2c709
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4a3f0a3188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f4a41c30f60 RCX: 00007f4a41b2c709
> RDX: 0000000000002001 RSI: 0000000000c00007 RDI: 0000000020012000
> RBP: 00007f4a41b86cb4 R08: 0000000000000000 R09: 0000010000000002
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4a42164b2f R14: 00007f4a3f0a3300 R15: 0000000000022000
> 
> Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
