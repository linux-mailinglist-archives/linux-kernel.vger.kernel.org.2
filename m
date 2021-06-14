Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8F3A6C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhFNQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhFNQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F816C0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:23 -0700 (PDT)
Message-Id: <20210614155356.760453090@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gpsUrwul8/waQPlS0/GNa8sTrq4H85o+PFcvmWPCTfM=;
        b=mljztUCvgZq+60MqEwGxIWvLGujCapiAl+eVCfBQ91uVgkzKtE+ANgZuh1Pw0YODIMiWQG
        sRNM1FnfHk4mxA6uVHfsORwBvkoHNG84uIwuGutwNk9YPgqI93EDwKimJjFsEKBlaFSOSY
        uzDZv6lcbHeABSxww1htH/ieDBcwfFhhBH3E5sBWcDMnpVC7IUdUha7o2z9+d3e9S40ySv
        P1IUUym1XFGySC9Kik66voz9RuEdrg55DhKDSDoN+t0obHNk3rCKllvrXgSDHMKWtK4J5W
        uPjPhw5uHA1hx1BOXnYSzK8K72eEv5nH/XJvEMggdvcrHWrkWKw6hlERqG+yew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gpsUrwul8/waQPlS0/GNa8sTrq4H85o+PFcvmWPCTfM=;
        b=+6yStcq/RByE5gUS8pVdQYpmZW9c3Kocwark33M5ZHIQZpbDAxr1K+Ps9jQeLIOWDusJ3P
        +3VH7inMuIxT98DQ==
Date:   Mon, 14 Jun 2021 17:44:38 +0200
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
Subject: [patch V2 30/52] x86/fpu: Rename initstate copy functions
References: <20210614154408.673478623@linutronix.de>
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
@@ -355,7 +355,7 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from the init fpstate.
  * Caller must do fpregs_[un]lock() around it.
  */
-static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
+static inline void load_fpregs_from_init_fpstate(u64 features_mask)
 {
 	if (use_xsave())
 		xrstor_from_kernel(&init_fpstate.xsave, features_mask);
@@ -391,9 +391,9 @@ static void fpu__clear(struct fpu *fpu,
 		    xfeatures_mask_supervisor())
 			xrstor_from_kernel(&fpu->state.xsave,
 					     xfeatures_mask_supervisor());
-		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+		load_fpregs_from_init_fpstate(xfeatures_mask_user());
 	} else {
-		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+		load_fpregs_from_init_fpstate(xfeatures_mask_all);
 	}
 
 	fpregs_mark_activate();

