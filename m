Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5165B332A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhCIPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:25:29 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56619 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhCIPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:25:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UR8pmsK_1615303512;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UR8pmsK_1615303512)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 23:25:13 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
Date:   Tue,  9 Mar 2021 23:25:08 +0800
Message-Id: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

count_partial() can hold n->list_lock spinlock for quite long, which
makes much trouble to the system. This series eliminate this problem.

v1->v2:
- Improved changelog and variable naming for PATCH 1~2.
- PATCH3 adds per-cpu counter to avoid performance regression
  in concurrent __slab_free().

v2->v3:
- Changed "page->inuse" to the safe "new.inuse", etc.
- Used CONFIG_SLUB_DEBUG and CONFIG_SYSFS condition for new counters.
- atomic_long_t -> unsigned long

[Testing]
There seems might be a little performance impact under extreme
__slab_free() concurrent calls according to my tests.

On my 32-cpu 2-socket physical machine:
Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz

1) perf stat --null --repeat 10 -- hackbench 20 thread 20000

== original, no patched
Performance counter stats for 'hackbench 20 thread 20000' (10 runs):

      24.536050899 seconds time elapsed                                          ( +-  0.24% )


Performance counter stats for 'hackbench 20 thread 20000' (10 runs):

      24.588049142 seconds time elapsed                                          ( +-  0.35% )


== patched with patch1~4
Performance counter stats for 'hackbench 20 thread 20000' (10 runs):

      24.670892273 seconds time elapsed                                          ( +-  0.29% )


Performance counter stats for 'hackbench 20 thread 20000' (10 runs):

      24.746755689 seconds time elapsed                                          ( +-  0.21% )


2) perf stat --null --repeat 10 -- hackbench 32 thread 20000

== original, no patched
 Performance counter stats for 'hackbench 32 thread 20000' (10 runs):

      39.784911855 seconds time elapsed                                          ( +-  0.14% )

 Performance counter stats for 'hackbench 32 thread 20000' (10 runs):

      39.868687608 seconds time elapsed                                          ( +-  0.19% )

== patched with patch1~4
 Performance counter stats for 'hackbench 32 thread 20000' (10 runs):

      39.681273015 seconds time elapsed                                          ( +-  0.21% )

 Performance counter stats for 'hackbench 32 thread 20000' (10 runs):

      39.681238459 seconds time elapsed                                          ( +-  0.09% )


Xunlei Pang (4):
  mm/slub: Introduce two counters for partial objects
  mm/slub: Get rid of count_partial()
  percpu: Export per_cpu_sum()
  mm/slub: Use percpu partial free counter

 include/linux/percpu-defs.h   |  10 ++++
 kernel/locking/percpu-rwsem.c |  10 ----
 mm/slab.h                     |   4 ++
 mm/slub.c                     | 120 +++++++++++++++++++++++++++++-------------
 4 files changed, 97 insertions(+), 47 deletions(-)

-- 
1.8.3.1

