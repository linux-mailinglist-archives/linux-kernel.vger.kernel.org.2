Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C03A6C08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhFNQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhFNQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B06C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:01 -0700 (PDT)
Message-Id: <20210614155354.935915316@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QEpaw02U7+Qp+O5kTJbVqJSDsevvpgnJvGsvNmpTKDE=;
        b=elB7lDCTIPMDd8y7sPeY6nk50hVhtfeJr46B0rEZ9lvlWpkPz/8B2CLq02GVfN+Ee17usW
        7trWvXkegZBRzDuntzZlmsx8DkOUOgEuMRZSHCkq1c9n5NERUsI09JXSeg8L5yADnWvEno
        P5dJBIOQga37LjBxVOYdQ2MKqudyECyzKOVuChVc5mVrIDkfaea1T2pIfB0+NA++Wf74go
        qSaAlP9PladA+1B/gfzcvFa217CbMMVM548ehIoYj2YXHk7NlwmW2+vPF41XDaNN0nUw04
        R2C30k2wsWjajOfsQuROR8UabqoIedhFrE/iqwh5IJeYfF9bNDyPZ5NvT2u2KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QEpaw02U7+Qp+O5kTJbVqJSDsevvpgnJvGsvNmpTKDE=;
        b=KxFcBbBZRhnB3H6TRFuPDwSh7oFPz9T8BglpgKIx9xUQtGlcVOuA6A9G4xqJXz3X1XQ7Ps
        GbDwG8qxnEKZVpAg==
Date:   Mon, 14 Jun 2021 17:44:20 +0200
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
Subject: [patch V2 12/52] x86/fpu: Fail ptrace() requests that try to set
 invalid MXCSR values
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

We're not doing anyone any favors by accepting and silently changing an
invalid MXCSR value supplied via ptrace().  Instead, return -EINVAL on
invalid input.

If this breaks something, we can revert it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch. Picked up from Andy.
---
 arch/x86/kernel/fpu/regset.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -65,8 +65,9 @@ int xfpregs_set(struct task_struct *targ
 	if (ret)
 		return ret;
 
-	/* Mask invalid MXCSR bits (for historical reasons). */
-	newstate.mxcsr &= mxcsr_feature_mask;
+	/* Do not allow an invalid MXCSR value. */
+	if (newstate.mxcsr & ~mxcsr_feature_mask)
+		ret = -EINVAL;
 
 	fpu__prepare_write(fpu);
 

