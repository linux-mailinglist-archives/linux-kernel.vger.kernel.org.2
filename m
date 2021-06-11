Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD773A46D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFKQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhFKQqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14651C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:23 -0700 (PDT)
Message-Id: <20210611163113.082022911@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gpsUrwul8/waQPlS0/GNa8sTrq4H85o+PFcvmWPCTfM=;
        b=Ii/YwsP/4UKS380vzl6gZF05ah64jopvhrik1iKqbmErxnphH0iRx+8iIdT6N3N10zodZg
        TlLYjdkFdl2vhrdxBkBMQfktSSZ1Fcnqi69TRnqSM5h8f/MdVf+AeLgNAFOb6NRJA09mLG
        ja7sKY2M9b8+rQ8g21u+pKAi++CxI2+0EkeYLC4mM7KtwejIEXha9BSYbnDJvpSs7Gmm5E
        ikJUOZuO0hukkNBxNLGXvEajGlIYaAWXPJNZAJIdGnAWAtdzEXtlXd3yxoJsHheavB3Vb+
        D+B24Fqq060NBLyFFhuIJv2P+wA9flUx/OPTTJeHtCLKDGTFBG21iCiopFkWhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gpsUrwul8/waQPlS0/GNa8sTrq4H85o+PFcvmWPCTfM=;
        b=un+lSC78u+hJjaxc27vI/1XgnWuah1qg8Oovrv3oLMTdaEyrnnX5rUgoHr+coEvcEyZ4dm
        GLPdUGa1/cB73ECA==
Date:   Fri, 11 Jun 2021 18:15:43 +0200
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
Subject: [patch 20/41] x86/fpu: Rename initstate copy functions
References: <20210611161523.508908024@linutronix.de>
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

