Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63E41F729
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355715AbhJAV6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhJAV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:58:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B7FC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 14:56:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g14so9140955pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0HYkhZW+UnFaJxDdjyTcTV7bE6XCnU8G/h+aF91cys=;
        b=G52OGId37JvuenFKWC82JJOBf3Ros45azAwPvTEEuGTUO0z/uqct0FVHC07Vry10Os
         DceFEfAIlTY9Iibk9gMbm5P9nksmmIcX7en1g9eZJ5vg8XYvj1bzrXEnpSWU+FoaF3Dx
         kl3+efNw2+qTKtYv92szcOmCimEl3tlbTojE6zWNbK5V//hl4hNcE8v0GncMjIv9SqjW
         qpIijxOZejNAa9ix7GYfQ6OiKSBdg3m2dqK3mfPVO7FC62qklCUbLRhezpq7DaeLstnx
         6Lh9H0jlmigBoSjAl/rUkBmbEiOGo5bWzIEjAJevybVhQhLjKucxs8mam2ccqyK7FCIS
         IqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0HYkhZW+UnFaJxDdjyTcTV7bE6XCnU8G/h+aF91cys=;
        b=nMhsKDU5EZGsK9NXaPhOXCabuf3dddUTpgbpFVDw8VzhSzBC4RvServ8eV0NeKlTJd
         f042mntlQN4JXNHj6vWn7KZjtFTvNpdifVuYnJzpv8HZSNZbMJpym7pLZble3Y/ZhqUF
         zxAzeocTMHFqdVC0newMJL8B6D8I14PHv5kX6p1if1Axc8l+Vs7hWZUnutQy4dwiwBsk
         cGf2phIRt/Z7u8hBD8Udvhfo07TeYeqoiNJGQo57zEWMAy6EWcjtrfeoZJZkN2RxQbIs
         UI7xh2fACvGfANQd+BTbPHaDzX/L0PcAA+XI5HEPKFwQ/qzi31OSaalj7c7IbrMynVjK
         tyQQ==
X-Gm-Message-State: AOAM531Iqj/W0Sj3pi0HSxuqK2HNtHRou1GjFOrsU7KCKNqhtBsdiZxs
        gxKSJkJCZDGriYexGcmFb64=
X-Google-Smtp-Source: ABdhPJwSjplbrAiB8YX+59gmbtocYp84ljQvPvMBs3dspkRb5dUdv845u5h8qQaj6bL/25kmH8b4DA==
X-Received: by 2002:a63:4003:: with SMTP id n3mr274013pga.413.1633125393800;
        Fri, 01 Oct 2021 14:56:33 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:63c:b112:55c:f7f4])
        by smtp.gmail.com with ESMTPSA id 26sm8142954pgx.72.2021.10.01.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 14:56:33 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH v2] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()
Date:   Fri,  1 Oct 2021 14:56:30 -0700
Message-Id: <20211001215630.810592-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

syzbot reported access to unitialized memory in mbind() [1]

Issue came with commit bda420b98505 ("numa balancing: migrate on
fault among multiple bound nodes")

This commit added a new bit in MPOL_MODE_FLAGS, but only checked
valid combination (MPOL_F_NUMA_BALANCING can only be used with MPOL_BIND)
in do_set_mempolicy()

This patch moves the check in sanitize_mpol_flags() so that it
is also used by mbind()

[1]
BUG: KMSAN: uninit-value in __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
 __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
 mpol_equal include/linux/mempolicy.h:105 [inline]
 vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
 mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
 do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
 kernel_mbind mm/mempolicy.c:1483 [inline]
 __do_sys_mbind mm/mempolicy.c:1490 [inline]
 __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
 __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was created at:
 slab_alloc_node mm/slub.c:3221 [inline]
 slab_alloc mm/slub.c:3230 [inline]
 kmem_cache_alloc+0x751/0xff0 mm/slub.c:3235
 mpol_new mm/mempolicy.c:293 [inline]
 do_mbind+0x912/0x15f0 mm/mempolicy.c:1289
 kernel_mbind mm/mempolicy.c:1483 [inline]
 __do_sys_mbind mm/mempolicy.c:1490 [inline]
 __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
 __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
=====================================================
Kernel panic - not syncing: panic_on_kmsan set ...
CPU: 0 PID: 15049 Comm: syz-executor.0 Tainted: G    B             5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ff/0x28e lib/dump_stack.c:106
 dump_stack+0x25/0x28 lib/dump_stack.c:113
 panic+0x44f/0xdeb kernel/panic.c:232
 kmsan_report+0x2ee/0x300 mm/kmsan/report.c:186
 __msan_warning+0xd7/0x150 mm/kmsan/instrumentation.c:208
 __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
 mpol_equal include/linux/mempolicy.h:105 [inline]
 vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
 mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
 do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
 kernel_mbind mm/mempolicy.c:1483 [inline]
 __do_sys_mbind mm/mempolicy.c:1490 [inline]
 __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
 __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4a41b2c709
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a3f0a3188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f4a41c30f60 RCX: 00007f4a41b2c709
RDX: 0000000000002001 RSI: 0000000000c00007 RDI: 0000000020012000
RBP: 00007f4a41b86cb4 R08: 0000000000000000 R09: 0000010000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4a42164b2f R14: 00007f4a3f0a3300 R15: 0000000000022000

Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
---
v2: fix compiler warning reported by kernel test robot <lkp@intel.com>

 mm/mempolicy.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1592b081c58ef6dd63c6f075ad24722f2be7cb5d..d12e0608fced235dc9137d0628437046299c7cfc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -856,16 +856,6 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
-	if (flags & MPOL_F_NUMA_BALANCING) {
-		if (new && new->mode == MPOL_BIND) {
-			new->flags |= (MPOL_F_MOF | MPOL_F_MORON);
-		} else {
-			ret = -EINVAL;
-			mpol_put(new);
-			goto out;
-		}
-	}
-
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		mpol_put(new);
@@ -1458,7 +1448,11 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
-
+	if (*flags & MPOL_F_NUMA_BALANCING) {
+		if (*mode != MPOL_BIND)
+			return -EINVAL;
+		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
+	}
 	return 0;
 }
 
-- 
2.33.0.800.g4c38ced690-goog

