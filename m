Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB583B100D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFVW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:29980 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhFVW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:27:59 -0400
IronPort-SDR: 5deZf1J3c/kHAsvSL12STRhqmTDMKm/bP+/fn1bhx77SbuuzDBDNyrHqm87bnP6kQUMa97h6BT
 L8JAas7TUQUg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="270998122"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="270998122"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:42 -0700
IronPort-SDR: 3Cv6VAe2Arq0XVuwX4bqp5n3jtAvWgetfg9Z4EvtFqHrEJXY64YqaMxwKlKLDmBrBxGGFASMBi
 Tls65kRwfPbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="406110488"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2021 15:25:42 -0700
Subject: [RFC][PATCH 1/8] x86/pkeys: add PKRU storage outside of task XSAVE buffer
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:24:57 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222457.C16E9CB5@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

PKRU has space in the task XSAVE buffer, but is not context-switched by
XSAVE/XRSTOR.  It is switched more eagerly than other FPU state because
PKRU affects things like copy_to/from_user().  This is because PKRU
affects user *PERMISSION* accesses, not just accesses made from user
*MODE* itself.

Prepare to move PKRU away from being XSAVE-managed.  Allocate space in
the thread_struct for it and save/restore it in the context-switch path
separately from the XSAVE-managed features.

Leave the XSAVE storage in place for now to ensure bisectability.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/include/asm/pkru.h  |    5 +++++
 b/arch/x86/kernel/cpu/common.c |    3 +++
 b/arch/x86/kernel/process_64.c |    9 ++++-----
 b/arch/x86/mm/pkeys.c          |    2 ++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/pkru.h~pkru-stash-thread-value arch/x86/include/asm/pkru.h
--- a/arch/x86/include/asm/pkru.h~pkru-stash-thread-value	2021-06-22 14:49:06.594051763 -0700
+++ b/arch/x86/include/asm/pkru.h	2021-06-22 14:49:06.607051763 -0700
@@ -44,11 +44,16 @@ static inline void write_pkru(u32 pkru)
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 	/*
+	 * Update the actual register.
+	 *
 	 * WRPKRU is relatively expensive compared to RDPKRU.
 	 * Avoid WRPKRU when it would not change the value.
 	 */
 	if (pkru != rdpkru())
 		wrpkru(pkru);
+
+	/* Update the thread-local, context-switched value: */
+	current->thread.pkru = pkru;
 }
 
 static inline void pkru_write_default(void)
diff -puN arch/x86/kernel/cpu/common.c~pkru-stash-thread-value arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~pkru-stash-thread-value	2021-06-22 14:49:06.596051763 -0700
+++ b/arch/x86/kernel/cpu/common.c	2021-06-22 14:49:06.608051763 -0700
@@ -482,6 +482,9 @@ static __always_inline void setup_pku(st
 	cr4_set_bits(X86_CR4_PKE);
 	/* Load the default PKRU value */
 	pkru_write_default();
+
+	/* Establish the default value for future tasks: */
+	init_task.thread.pkru = init_pkru_value;
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff -puN arch/x86/kernel/process_64.c~pkru-stash-thread-value arch/x86/kernel/process_64.c
--- a/arch/x86/kernel/process_64.c~pkru-stash-thread-value	2021-06-22 14:49:06.599051763 -0700
+++ b/arch/x86/kernel/process_64.c	2021-06-22 14:49:06.608051763 -0700
@@ -349,15 +349,14 @@ static __always_inline void load_seg_leg
 static __always_inline void x86_pkru_load(struct thread_struct *prev,
 					  struct thread_struct *next)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
+	u32 pkru = read_pkru();
 
 	/* Stash the prev task's value: */
-	prev->pkru = rdpkru();
+	prev->pkru = pkru;
 
 	/*
-	 * PKRU writes are slightly expensive.  Avoid them when not
-	 * strictly necessary:
+	 * PKRU writes are slightly expensive.  Avoid
+	 * them when not strictly necessary:
 	 */
 	if (prev->pkru != next->pkru)
 		wrpkru(next->pkru);
diff -puN arch/x86/mm/pkeys.c~pkru-stash-thread-value arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~pkru-stash-thread-value	2021-06-22 14:49:06.604051763 -0700
+++ b/arch/x86/mm/pkeys.c	2021-06-22 14:49:06.609051763 -0700
@@ -159,6 +159,8 @@ static ssize_t init_pkru_write_file(stru
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
+	WRITE_ONCE(init_task.thread.pkru, new_init_pkru);
+
 	return count;
 }
 
_
