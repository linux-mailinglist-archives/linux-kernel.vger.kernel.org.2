Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38C3A46BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhFKQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:45:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284DC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:43:59 -0700 (PDT)
Message-Id: <20210611163110.987044144@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n8ULFqKVJVwxGPdaLk6GuiVnc7zJ2BkL1GJ5YatZBPg=;
        b=4OoEkfPkZ2ye2y+gC8YNtjlBxEnr/OOQ/cMB1cm+sRjS4VxKotSEmthsecvg7E8Hee0qfr
        QbZNfj+zqKonO+56PDKEZkJozDJdEjq7e1aZnW5NqtLRYlT1t/3I+Yy09lvY8RIDxp0g3W
        ctrmXm9clLPS3raFyyi7535fEmpfdbg+X8aDYT2nUXPY04zFb9ABtOoR35PXJAhLRrH2/H
        P0d8GR9eXFaNEjsf+vnr3V7DlChHLYeOGwJwRIABQXUUkxW47PHljm8IqdqgpiWxlWXPc8
        J8bvQdfrBcg9AwODmKoNx36A9kgiAx8N9KvA/OVRGToRBPVKsSRen6B1WNZMWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n8ULFqKVJVwxGPdaLk6GuiVnc7zJ2BkL1GJ5YatZBPg=;
        b=dYTu+bdXIhZzt+ljYW6KG5t2ynaAm1Jr8NT2cVQfi2SGddMD48+oPdlrgQuG1Us/4qoO0V
        8oZBJnhd0Y/HAvCQ==
Date:   Fri, 11 Jun 2021 18:15:24 +0200
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
Subject: [patch 01/41] Revert a5eff7259790 ("x86/pkeys: Add PKRU value to
 init_fpstate")
References: <20210611161523.508908024@linutronix.de>
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
 

