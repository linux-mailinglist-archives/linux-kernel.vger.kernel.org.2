Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE53ACEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhFRPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbhFRPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F9C0611FB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:20:04 -0700 (PDT)
Message-Id: <20210618143448.485859910@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YVU0FZ2XwhZNoMB9DmVeQ+jEob2xNRLvQxwIAI8+IzY=;
        b=SIxyMDFAjFtMHYeSemtHX8B8xU9LXXd3J1QihvzQ5alu+wDB3vXRaUgHYNthQZip05z8Sr
        Nu/M2IooAXFqpoEFaXsRULC6rMsNj9TlV3iY6FJxyMKQqTmm3F5dRJC43ldRcxPA3292Xv
        ieRFErydH9/MHOETAOedBL0MYLNDVK1YHlOcrCbtyZ/rDuxfaTIilcoK08PfdvIQUilxu3
        4Fjrlr+O1apWAa1s2Jukmfb5fQUPsEV9HkgLwfUJ6Nimc70nHGQnT2MswjMZQCbF7tn9v2
        SKFWRr+OHG2KxdILMW9VZX1tz2aU7IYfp08Sxrwb5YtDCpl/w+eKS1n1V7ublQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YVU0FZ2XwhZNoMB9DmVeQ+jEob2xNRLvQxwIAI8+IzY=;
        b=HUvOGVFcpIL149y2/ASTFw34JZLgLO+uQsC+CxjI3LaFwWEWakrexw1rfr4qwNEpfjLlM+
        74CyU6kx9bOZ1uAQ==
Date:   Fri, 18 Jun 2021 16:18:59 +0200
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
Subject: [patch V3 36/66] x86/fpu: Rename initstate copy functions
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again this not a copy. It's loading register state.

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
+static inline void load_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
 		os_xrstor(&init_fpstate.xsave, features_mask);
@@ -338,9 +338,9 @@ static void fpu__clear(struct fpu *fpu,
 		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
 		    xfeatures_mask_supervisor())
 			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+		load_fpregs_from_init_fpstate(xfeatures_mask_user());
 	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+		load_fpregs_from_init_fpstate(xfeatures_mask_all);
 	}
 
 	fpregs_mark_activate();

