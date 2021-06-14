Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16B93A6BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhFNQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhFNQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:39:53 -0400
Message-Id: <20210614155353.984120664@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OxziZc4Tj4SRAuxrciou8wAkOhY6kml5MAK8bosSTdw=;
        b=Wpd3279xswIsq6IZJ3SuM5ZZFGRfBUfL0RcpfSyVDR6Lk9lQuoQXOyiMm3r6TwW6P4rJyT
        /vCB5fwuv0aPhsZZr8ower6WZTeg5PatSnwToNHDqMNJjkpeLce2WFzWMhQb4ipTTIS+MO
        ERfZP56VZ0iNTWjSHYeSxo30W5DdTWosC2e6SzXv9ZzrDNc4mvXZfrkAVCFQgVJVhkI9re
        K+N53cWMNhVu3QrXE6Lq3tMR2VAd0TU8z41q/5UVMoeUHgnANRsaJk/Om8Be6J5MOV6Xiv
        QUJPiHnuKVNzBfKk4nQ0Il6otQ69/MRFhGhN57z2ZY9brIW6bkHFZfSUhfU5fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OxziZc4Tj4SRAuxrciou8wAkOhY6kml5MAK8bosSTdw=;
        b=NqAhYbwrYhN+2LtnvT4iKgBx+5lQrCm8ozsStKlKEwT5s7DAo3j820bCRI9/lk1JUUqH3k
        WP95cLq7wyeY15Aw==
Date:   Mon, 14 Jun 2021 17:44:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 03/52] x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add PKRU
 value to init_fpstate")
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cannot work and it's unclear how that ever made a difference.

init_fpstate.xsave.header.xfeatures is always 0 so get_xsave_addr() will
always return a NULL pointer, which will prevent storing the default PKRU
value in initfp_state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix subject
---
 arch/x86/kernel/cpu/common.c |    5 -----
 arch/x86/mm/pkeys.c          |    6 ------
 2 files changed, 11 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -466,8 +466,6 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
-	struct pkru_state *pk;
-
 	/* check the boot processor, plus compile options for PKU: */
 	if (!cpu_feature_enabled(X86_FEATURE_PKU))
 		return;
@@ -478,9 +476,6 @@ static __always_inline void setup_pku(st
 		return;
 
 	cr4_set_bits(X86_CR4_PKE);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (pk)
-		pk->pkru = init_pkru_value;
 	/*
 	 * Setting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
 	 * cpuid bit to be set.  We need to ensure that we
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,7 +10,6 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
-#include <asm/fpu/internal.h>		/* init_fpstate			*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -154,7 +153,6 @@ static ssize_t init_pkru_read_file(struc
 static ssize_t init_pkru_write_file(struct file *file,
 		 const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	struct pkru_state *pk;
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
@@ -177,10 +175,6 @@ static ssize_t init_pkru_write_file(stru
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
-	if (!pk)
-		return -EINVAL;
-	pk->pkru = new_init_pkru;
 	return count;
 }
 

