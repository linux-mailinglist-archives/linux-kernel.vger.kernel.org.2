Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637C3C7FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhGNIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbhGNIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:25:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99247C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:22:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k63-20020a37a1420000b02903b4fb67f606so702504qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KdvbL+Jep13ELIaiRdmi7CMJ1jwkrxNTodiW13l5s0s=;
        b=K/k4GmUtF3yG+w1ubwAcV1h/regNH6rxNsQDK1IiTmkob5+8KiyU/5NsdDEb33mUrB
         u+kAZmc08dVEF5i3UPNh8PjNea1NIBEnV3hjZGqy46SaL1Aqt0BN10BGhnG8bIX9zEUx
         1Shh5HDaSNOtXoRDcU6xdl2m+J0ys/HTsBuVHCUiO5+ZcXvToVvr7z6qmm2VjJ3OcSay
         2avA9ObCQUrLTsvJE3vkUrdA9pR8ODxTOFF+lMiZZaHbp99jYgmSWepbEV1B2diduMc5
         ntCLG8IAfAWOXxjAxKCRVwXskOqDnzek6p4mFchJuR+kYL9yAnGKA+/BN88s8+OSEJ8B
         iXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KdvbL+Jep13ELIaiRdmi7CMJ1jwkrxNTodiW13l5s0s=;
        b=Outf9Ev/kd0Xxj06lvz08jdJKKPIGdwelb2uRlxKeY4X5ZEeasYq9zYGbYaCw9V3jh
         GmvdMbwt+ZXdJ6cniwdC+81jAwDDPbMsLKn8gpY/L7nibhwo1g87uXayVyl/P5MS6vE2
         EYnd7Rlpuf7K7Sp+uuW/bXmIiTCTQv6Mh2Ue8dfhWU+hTm/TOJf5X9PU5Vl1CSrjdbGA
         iI3x8ebGKDe17lplZyo+nhANSu5DFvEKIlDgqsi24LbjYLCEFp79Rc46D2NTtbCbWXF5
         LTmsNIpnmM/WcdnVnOWwCnwXxK4ke7tgk4LCP4t8XYoLJhJZvt6ttmdmMkASV0YdE0EW
         N/1w==
X-Gm-Message-State: AOAM531DpXujE2Pvo98yNebrmHOmLntPwu7Im2LOxIKHry+eZBYQaXwN
        ETHAa9D1opWbqvkO/t2FhgWZ3m3q5g==
X-Google-Smtp-Source: ABdhPJw0UfQRHiH2QXYvw4stNcyWMxZNVdQpGwjEyO8n+8qr2clzt1G3vMBRhJkqIIyuoJ/8Y7jyj6DQBA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:16e4:4f77:5c18:936])
 (user=elver job=sendgmr) by 2002:a05:6214:6a1:: with SMTP id
 s1mr9343148qvz.54.1626250927652; Wed, 14 Jul 2021 01:22:07 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:21:45 +0200
Message-Id: <20210714082145.2709233-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH mm v2] kfence: show cpu and timestamp in alloc/free info
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, Joern Engel <joern@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record cpu and timestamp on allocations and frees, and show them in
reports. Upon an error, this can help correlate earlier messages in the
kernel log via allocation and free timestamps.

Suggested-by: Joern Engel <joern@purestorage.com>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
Acked-by: Joern Engel <joern@purestorage.com>
---
v2:
* Rebase to v5.14-rc1 and pick up Acks.
---
 Documentation/dev-tools/kfence.rst | 98 ++++++++++++++++--------------
 mm/kfence/core.c                   |  3 +
 mm/kfence/kfence.h                 |  2 +
 mm/kfence/report.c                 | 19 ++++--
 4 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index fdf04e741ea5..0fbe3308bf37 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -65,25 +65,27 @@ Error reports
 A typical out-of-bounds access looks like this::
 
     ==================================================================
-    BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0xa3/0x22b
+    BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0xa6/0x234
 
-    Out-of-bounds read at 0xffffffffb672efff (1B left of kfence-#17):
-     test_out_of_bounds_read+0xa3/0x22b
-     kunit_try_run_case+0x51/0x85
+    Out-of-bounds read at 0xffff8c3f2e291fff (1B left of kfence-#72):
+     test_out_of_bounds_read+0xa6/0x234
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    kfence-#17 [0xffffffffb672f000-0xffffffffb672f01f, size=32, cache=kmalloc-32] allocated by task 507:
-     test_alloc+0xf3/0x25b
-     test_out_of_bounds_read+0x98/0x22b
-     kunit_try_run_case+0x51/0x85
+    kfence-#72: 0xffff8c3f2e292000-0xffff8c3f2e29201f, size=32, cache=kmalloc-32
+
+    allocated by task 484 on cpu 0 at 32.919330s:
+     test_alloc+0xfe/0x738
+     test_out_of_bounds_read+0x9b/0x234
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    CPU: 4 PID: 107 Comm: kunit_try_catch Not tainted 5.8.0-rc6+ #7
-    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
+    CPU: 0 PID: 484 Comm: kunit_try_catch Not tainted 5.13.0-rc3+ #7
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
     ==================================================================
 
 The header of the report provides a short summary of the function involved in
@@ -96,30 +98,32 @@ Use-after-free accesses are reported as::
     ==================================================================
     BUG: KFENCE: use-after-free read in test_use_after_free_read+0xb3/0x143
 
-    Use-after-free read at 0xffffffffb673dfe0 (in kfence-#24):
+    Use-after-free read at 0xffff8c3f2e2a0000 (in kfence-#79):
      test_use_after_free_read+0xb3/0x143
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    kfence-#24 [0xffffffffb673dfe0-0xffffffffb673dfff, size=32, cache=kmalloc-32] allocated by task 507:
-     test_alloc+0xf3/0x25b
+    kfence-#79: 0xffff8c3f2e2a0000-0xffff8c3f2e2a001f, size=32, cache=kmalloc-32
+
+    allocated by task 488 on cpu 2 at 33.871326s:
+     test_alloc+0xfe/0x738
      test_use_after_free_read+0x76/0x143
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    freed by task 507:
+    freed by task 488 on cpu 2 at 33.871358s:
      test_use_after_free_read+0xa8/0x143
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    CPU: 4 PID: 109 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
-    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
+    CPU: 2 PID: 488 Comm: kunit_try_catch Tainted: G    B             5.13.0-rc3+ #7
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
     ==================================================================
 
 KFENCE also reports on invalid frees, such as double-frees::
@@ -127,30 +131,32 @@ KFENCE also reports on invalid frees, such as double-frees::
     ==================================================================
     BUG: KFENCE: invalid free in test_double_free+0xdc/0x171
 
-    Invalid free of 0xffffffffb6741000:
+    Invalid free of 0xffff8c3f2e2a4000 (in kfence-#81):
      test_double_free+0xdc/0x171
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    kfence-#26 [0xffffffffb6741000-0xffffffffb674101f, size=32, cache=kmalloc-32] allocated by task 507:
-     test_alloc+0xf3/0x25b
+    kfence-#81: 0xffff8c3f2e2a4000-0xffff8c3f2e2a401f, size=32, cache=kmalloc-32
+
+    allocated by task 490 on cpu 1 at 34.175321s:
+     test_alloc+0xfe/0x738
      test_double_free+0x76/0x171
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    freed by task 507:
+    freed by task 490 on cpu 1 at 34.175348s:
      test_double_free+0xa8/0x171
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    CPU: 4 PID: 111 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
-    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
+    CPU: 1 PID: 490 Comm: kunit_try_catch Tainted: G    B             5.13.0-rc3+ #7
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
     ==================================================================
 
 KFENCE also uses pattern-based redzones on the other side of an object's guard
@@ -160,23 +166,25 @@ These are reported on frees::
     ==================================================================
     BUG: KFENCE: memory corruption in test_kmalloc_aligned_oob_write+0xef/0x184
 
-    Corrupted memory at 0xffffffffb6797ff9 [ 0xac . . . . . . ] (in kfence-#69):
+    Corrupted memory at 0xffff8c3f2e33aff9 [ 0xac . . . . . . ] (in kfence-#156):
      test_kmalloc_aligned_oob_write+0xef/0x184
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    kfence-#69 [0xffffffffb6797fb0-0xffffffffb6797ff8, size=73, cache=kmalloc-96] allocated by task 507:
-     test_alloc+0xf3/0x25b
+    kfence-#156: 0xffff8c3f2e33afb0-0xffff8c3f2e33aff8, size=73, cache=kmalloc-96
+
+    allocated by task 502 on cpu 7 at 42.159302s:
+     test_alloc+0xfe/0x738
      test_kmalloc_aligned_oob_write+0x57/0x184
-     kunit_try_run_case+0x51/0x85
+     kunit_try_run_case+0x61/0xa0
      kunit_generic_run_threadfn_adapter+0x16/0x30
-     kthread+0x137/0x160
+     kthread+0x176/0x1b0
      ret_from_fork+0x22/0x30
 
-    CPU: 4 PID: 120 Comm: kunit_try_catch Tainted: G        W         5.8.0-rc6+ #7
-    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
+    CPU: 7 PID: 502 Comm: kunit_try_catch Tainted: G    B             5.13.0-rc3+ #7
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
     ==================================================================
 
 For such errors, the address where the corruption occurred as well as the
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index d7666ace9d2e..0fd7a122e1a1 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -20,6 +20,7 @@
 #include <linux/moduleparam.h>
 #include <linux/random.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/sysctl.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -196,6 +197,8 @@ static noinline void metadata_update_state(struct kfence_metadata *meta,
 	 */
 	track->num_stack_entries = stack_trace_save(track->stack_entries, KFENCE_STACK_DEPTH, 1);
 	track->pid = task_pid_nr(current);
+	track->cpu = raw_smp_processor_id();
+	track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
 
 	/*
 	 * Pairs with READ_ONCE() in
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 24065321ff8a..c1f23c61e5f9 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -36,6 +36,8 @@ enum kfence_object_state {
 /* Alloc/free tracking information. */
 struct kfence_track {
 	pid_t pid;
+	int cpu;
+	u64 ts_nsec;
 	int num_stack_entries;
 	unsigned long stack_entries[KFENCE_STACK_DEPTH];
 };
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 2a319c21c939..d1daabdc9188 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
+#include <linux/math.h>
 #include <linux/printk.h>
 #include <linux/sched/debug.h>
 #include <linux/seq_file.h>
@@ -100,6 +101,13 @@ static void kfence_print_stack(struct seq_file *seq, const struct kfence_metadat
 			       bool show_alloc)
 {
 	const struct kfence_track *track = show_alloc ? &meta->alloc_track : &meta->free_track;
+	u64 ts_sec = track->ts_nsec;
+	unsigned long rem_nsec = do_div(ts_sec, NSEC_PER_SEC);
+
+	/* Timestamp matches printk timestamp format. */
+	seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus:\n",
+		       show_alloc ? "allocated" : "freed", meta->alloc_track.pid,
+		       meta->alloc_track.cpu, (unsigned long)ts_sec, rem_nsec / 1000);
 
 	if (track->num_stack_entries) {
 		/* Skip allocation/free internals stack. */
@@ -126,15 +134,14 @@ void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *met
 		return;
 	}
 
-	seq_con_printf(seq,
-		       "kfence-#%td [0x%p-0x%p"
-		       ", size=%d, cache=%s] allocated by task %d:\n",
-		       meta - kfence_metadata, (void *)start, (void *)(start + size - 1), size,
-		       (cache && cache->name) ? cache->name : "<destroyed>", meta->alloc_track.pid);
+	seq_con_printf(seq, "kfence-#%td: 0x%p-0x%p, size=%d, cache=%s\n\n",
+		       meta - kfence_metadata, (void *)start, (void *)(start + size - 1),
+		       size, (cache && cache->name) ? cache->name : "<destroyed>");
+
 	kfence_print_stack(seq, meta, true);
 
 	if (meta->state == KFENCE_OBJECT_FREED) {
-		seq_con_printf(seq, "\nfreed by task %d:\n", meta->free_track.pid);
+		seq_con_printf(seq, "\n");
 		kfence_print_stack(seq, meta, false);
 	}
 }
-- 
2.32.0.93.g670b81a890-goog

