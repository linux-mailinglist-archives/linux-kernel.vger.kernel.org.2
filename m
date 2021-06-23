Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B05A3B19D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFWM0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhFWMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:25:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220C2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:23:39 -0700 (PDT)
Message-Id: <20210623121451.451391598@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zYkzV8UeqyB/dvy5j/y7BuRa/gLRdSj7ldd4sclZAZI=;
        b=woleddf2Cm7Zq+TcN0LINPyT+iH4XC4GGt1MkXpJnRv8lgtcQshSjR639XIn9fBldgBrwc
        PF14dcYsvFQ9BEuUBJ2a/+neVlV7MuaIJnlvq9pPpRFC0i0mQnqO94UH3Jz4zhvzifD9ZX
        7rQMR4zJQZDlU9cBV97S9HBqi7UNpYnnTJEvVyNq0kmsg4X3oBe0589l2Q5PYh80BjhZbV
        r5zoKJh+k24HmsRkl6vNCc1b5orOmVT4KF6sR3d8QcBaXXb1JB47l50rsfLOLdRc89IgYt
        ta3iI5Gs9s8Grzq+cuuARXqjr7HPwrPJl/9KcPLYK1rQC50wyMaTqUeNIoDWgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zYkzV8UeqyB/dvy5j/y7BuRa/gLRdSj7ldd4sclZAZI=;
        b=tnKG1AJe1z+5Ilx6h06PyaU+QbTBvjb0lawQaEHxTVxim1egaZp84ueWLK5F3zq1Pbs2XI
        Z95qVyB7e8FrZYBQ==
Date:   Wed, 23 Jun 2021 14:01:29 +0200
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
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 02/65] x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add PKRU
 value to init_fpstate")
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
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
 

