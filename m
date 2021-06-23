Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B43B19FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36836 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhFWM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:37 -0400
Message-Id: <20210623121454.816581630@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+G6xD9wXWd7M2o920rwdj6rEQzPEdPKXtNICi00d1cM=;
        b=m4JtwUSI1AS+nSWFVaTjaBQzDsEomN0LOQaiK/G57ytMcA85v7XrQ9AZ8webt62j1duySp
        rYloEdukcHuwPO2xdNAqV0YPqkoMhAUeLAlM7iS/MpJRbhmZAM2vKhFow6TfNx7BnHejCP
        3x1seW7Z7hMeBhyZsaA6M1XtlZT1/Jkc/NNUTcja5vwovf4Of7NgsX1N9LOC9q+WrSvX9C
        5ktF4VLSRP6JKyS8JcGxf1hXpRxAcyGhDRqTXd/1coTlJ2AvIKrIzytM4+wlkW+aaFBENx
        uuJGQVP7soUM/OrZw7vEztmg2AnOzJjGaOONNyC4BcKSxJiaflmq/tu8IOiqRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+G6xD9wXWd7M2o920rwdj6rEQzPEdPKXtNICi00d1cM=;
        b=syCXvfnTwiCkkSamfB9v1SWR6YH872XocxrztdCu7HOfJhDEOXSaBbuk006BXfxCk8NMWy
        ThhQzJpG7Nl+crCQ==
Date:   Wed, 23 Jun 2021 14:02:02 +0200
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
Subject: [patch V4 35/65] x86/fpu: Rename initstate copy functions
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again this not a copy. It's restoring register state from kernel memory.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -303,7 +303,7 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from the init fpstate.
  * Caller must do fpregs_[un]lock() around it.
  */
-static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
+static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
 		os_xrstor(&init_fpstate.xsave, features_mask);
@@ -338,9 +338,9 @@ static void fpu__clear(struct fpu *fpu,
 		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
 		    xfeatures_mask_supervisor())
 			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+		restore_fpregs_from_init_fpstate(xfeatures_mask_user());
 	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+		restore_fpregs_from_init_fpstate(xfeatures_mask_all);
 	}
 
 	fpregs_mark_activate();

