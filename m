Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3FD41F399
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353901AbhJARvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJARvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:51:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CAC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:49:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v19so7065009pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pslx7hBcPPFZ8XrzuCQe14lpG1eQkJuld8AUzwy4jRw=;
        b=mAcVHEGvLboDetHv6iiAcsGZf0VqUVlHTo6zH1sjEm3NG3jF8eUqiy1TI1P229h74A
         c8n8qJS6lvAeF8tvZc9EiEa7HHtIGIR/MM7h7K09e76G02mEnqbyXwQz1S7H2k2x/trh
         RTQqwUbWYdwZDRQun6Okbrdo3FICGBZllOithmC2Y+JttRncj79FjDAvDz6+Q61nQAug
         pqgtgHxrWOPZdImDRNXqN2tXQlwaiaYpio8DzardoikuSc9PCRYRoBqDajomy+2cTwiP
         oc2Of0YP+FHpDky4MYly3XQDfNC3eR5N0S1vJsUHzxPJboZOGlt1lWmdY53K7FetTciI
         gLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pslx7hBcPPFZ8XrzuCQe14lpG1eQkJuld8AUzwy4jRw=;
        b=T7Uirei/4iWYcxdMAiQRn6c9ebzSiIP6ZIcNciNwDsifIFVodivtoEnrY5UVdAyU7B
         OcejlGtU/K1VzhoSWBKK8RcZdR7xD0EBrlg5nMvRELKTa3PrNopQ1awF7PFFDkAiJ9vy
         vufEGYUdCCfX3oJt8gQncSifg6aPAnY/h1sHJ8PJ4nEqXXvjkx9etf3wQilR9Mu9vLQy
         Gwf76fkih34UUQ5KSPRIgrP0o3jIaW4imHD0uWzUD8DoRAQAwUwvBybE+82pGEmlft7S
         N5ZLnEhiqvOkl2vOC1bjQdTevASWbFq5pF1ceH4Ev9K0Pc50GpPe5Xdo6uHLEQkYjXfz
         P75A==
X-Gm-Message-State: AOAM533Sb1ovUKpE+OHvNaZqpN3Nbd9oeyvWMtwVSIovZVKIEtXgxbjF
        w3DqHaFD7THizLcL/JbzRZs=
X-Google-Smtp-Source: ABdhPJzxVklSIIgjRrPqhEEWqrAQZ0plL4gqT9+yCOV47EnKLTo+9SK6to4WztttIYH95dbMlfq2/w==
X-Received: by 2002:a17:90a:c913:: with SMTP id v19mr21774876pjt.169.1633110592486;
        Fri, 01 Oct 2021 10:49:52 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:63c:b112:55c:f7f4])
        by smtp.gmail.com with ESMTPSA id y80sm6856185pfb.196.2021.10.01.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:49:52 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()
Date:   Fri,  1 Oct 2021 10:49:47 -0700
Message-Id: <20211001174947.135123-1-eric.dumazet@gmail.com>
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
 mm/mempolicy.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1592b081c58ef6dd63c6f075ad24722f2be7cb5d..7a7abdbec7af66f88bb68cb4f47e9722d56bfd5b 100644
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
+		if (mode != MPOL_BIND)
+			return -EINVAL;
+		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
+	}
 	return 0;
 }
 
-- 
2.33.0.800.g4c38ced690-goog

