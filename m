Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C332517D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBYO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhBYO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:29:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EA964F06;
        Thu, 25 Feb 2021 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614263327;
        bh=fJYqFwIRHGlreUVkfYXKyb+tmjaO3r5LfkE0zDLtShw=;
        h=From:To:Cc:Subject:Date:From;
        b=QapUi3vDOX6GbM8N/k8tu5C8IWi8SUi4iiGdijaCv0zvZrt31Bm89NyerENo6HN69
         ZuotayIM5jmAlYpdQk/5a1a1XdAJiS3AReEVzneyswQjV9kWbFl+of/XJSpcIUSnzh
         NLLtWGz5t7yk7t5nwGVYikXkgqrakuSfeVzljvhz5seRduMiTjxAioDnbpUj4ClcQ8
         2ivbHQQ8itvG5/SzFMTP/xR4RCIzR7HSqQkYIhyb13KA/5qsXIZ5dCI2m5CCVhlKpM
         k7mkpiEom32oIrnfUS4kYYzK9as4t5Sb9PuDC9PHr7hdo7OERvgxIutlqZahXmL9r+
         Uj1XxaORpJknQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: features: remove c6x references
Date:   Thu, 25 Feb 2021 15:27:17 +0100
Message-Id: <20210225142841.3385428-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The references to arch/c6x are obsolete now that the architecture
is gone. Remove them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/features/core/cBPF-JIT/arch-support.txt            | 1 -
 Documentation/features/core/eBPF-JIT/arch-support.txt            | 1 -
 Documentation/features/core/generic-idle-thread/arch-support.txt | 1 -
 Documentation/features/core/jump-labels/arch-support.txt         | 1 -
 Documentation/features/core/tracehook/arch-support.txt           | 1 -
 Documentation/features/debug/KASAN/arch-support.txt              | 1 -
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt   | 1 -
 Documentation/features/debug/gcov-profile-all/arch-support.txt   | 1 -
 Documentation/features/debug/kcov/arch-support.txt               | 1 -
 Documentation/features/debug/kgdb/arch-support.txt               | 1 -
 Documentation/features/debug/kmemleak/arch-support.txt           | 1 -
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt  | 1 -
 Documentation/features/debug/kprobes/arch-support.txt            | 1 -
 Documentation/features/debug/kretprobes/arch-support.txt         | 1 -
 Documentation/features/debug/optprobes/arch-support.txt          | 1 -
 Documentation/features/debug/stackprotector/arch-support.txt     | 1 -
 Documentation/features/debug/uprobes/arch-support.txt            | 1 -
 Documentation/features/debug/user-ret-profiler/arch-support.txt  | 1 -
 Documentation/features/io/dma-contiguous/arch-support.txt        | 1 -
 Documentation/features/locking/cmpxchg-local/arch-support.txt    | 1 -
 Documentation/features/locking/lockdep/arch-support.txt          | 1 -
 Documentation/features/locking/queued-rwlocks/arch-support.txt   | 1 -
 Documentation/features/locking/queued-spinlocks/arch-support.txt | 1 -
 Documentation/features/perf/kprobes-event/arch-support.txt       | 1 -
 Documentation/features/perf/perf-regs/arch-support.txt           | 1 -
 Documentation/features/perf/perf-stackdump/arch-support.txt      | 1 -
 .../features/sched/membarrier-sync-core/arch-support.txt         | 1 -
 Documentation/features/sched/numa-balancing/arch-support.txt     | 1 -
 Documentation/features/seccomp/seccomp-filter/arch-support.txt   | 1 -
 Documentation/features/time/arch-tick-broadcast/arch-support.txt | 1 -
 Documentation/features/time/clockevents/arch-support.txt         | 1 -
 Documentation/features/time/context-tracking/arch-support.txt    | 1 -
 Documentation/features/time/irq-time-acct/arch-support.txt       | 1 -
 Documentation/features/time/virt-cpuacct/arch-support.txt        | 1 -
 Documentation/features/vm/ELF-ASLR/arch-support.txt              | 1 -
 Documentation/features/vm/PG_uncached/arch-support.txt           | 1 -
 Documentation/features/vm/THP/arch-support.txt                   | 1 -
 Documentation/features/vm/TLB/arch-support.txt                   | 1 -
 Documentation/features/vm/huge-vmap/arch-support.txt             | 1 -
 Documentation/features/vm/ioremap_prot/arch-support.txt          | 1 -
 Documentation/features/vm/pte_special/arch-support.txt           | 1 -
 41 files changed, 41 deletions(-)

diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 399935616813..e59b5215402d 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 79409bfe0263..dcbd8679f514 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 9ea60e416efd..4efcba7b5239 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 894d9693b380..0c801d1bd2da 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index cd3510e2eedb..af34308fce7f 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: |  ok  |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index b2288dc14b72..c244ac7eee26 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 1c49723e7534..7aff505af706 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 7563a494ddb8..416c70345946 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/kcov/arch-support.txt b/Documentation/features/debug/kcov/arch-support.txt
index ab0ee1c933c2..7e44013cc320 100644
--- a/Documentation/features/debug/kcov/arch-support.txt
+++ b/Documentation/features/debug/kcov/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index bc45bac20442..2cb0576f9180 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
index 2db76807ec6f..915185634611 100644
--- a/Documentation/features/debug/kmemleak/arch-support.txt
+++ b/Documentation/features/debug/kmemleak/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 6225cfe0c5bf..aade7816cb87 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 371f0ac488f5..4b663c124d1c 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 38e95251deed..5449bb808442 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 7f4a20e6a12b..d6ff141a6122 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 3329559c8207..ad4de22a71ab 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 43cac6ee0c68..2820177787e1 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index d636ed0e679f..2a3fe812a5fa 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index dfc93d074e3d..bece89586efa 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 1815c7fed06d..52bdda004f5c 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index 940b0bd02957..a8cd163c8b7e 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 4dd5e554873f..8c85949752b3 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index b16d4f71e5ce..5f4e1b3841af 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 04c17c2106a4..75739a0007e0 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index e7450fbb8253..ea8b6d96633a 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 98e79d128d9b..87165861037e 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 47e6903f47a5..883d33b265d6 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -33,7 +33,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 964457ad26c1..bfcfaff67a1b 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ok  |
-    |         c6x: |  ..  |
     |        csky: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index eb3d74092c61..26eec58ab819 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 4d11cbb3c09b..8639fe8315f5 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 6863a3fbddad..9a81cb03b1fd 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |         c6x: |  ok  |
     |        csky: |  ok  |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 52aea275aab7..4ed116c2ec39 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 6fc03deb1c38..bc30c15557c7 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index e51f3af38e31..050de43bbbb9 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index eccda0732474..99cb6d7f5005 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index c74e3f8040e1..6cde38458596 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 1c0b95f2b40d..e8238cb2a4da 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: |  ..  |
     |        csky: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 30f75a79ce01..48a5ca548399 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |         c6x: |  ..  |
     |        csky: | TODO |
     |       h8300: |  ..  |
     |     hexagon: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index c5ff3a427722..439fd9069b8b 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index b5fb37c28cc6..9a0c8783b84d 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 13d0e1e17001..40b969f3a6bb 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -10,7 +10,6 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
-- 
2.29.2

