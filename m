Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210E3ACE93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhFRPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56328 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhFRPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:43 -0400
Message-Id: <20210618143445.769616874@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=R2Qjyw6Zc8pt9ekkG6nMwtYrspreGdq8YwOfxKRzMR8=;
        b=t5hUBrY953wh9Qmu4pxMQzh2vBWSNJ900zv2xAQ4Muxhsj8gvybV5xkM6ZJvzDKd9us8uk
        JiBM/QC2LOofMVzsBd1CZ+kYqFoTJNT8fKUSHrYJ99o9FJNqrxPuYEEzgZlzBEveaUA5hD
        lX087OkmIamsibngutejU0yeAsU6xc737s69CPjK7Plw9H/eMTJXJE80cJqXkBHJQjERml
        4s3K6MWvsQJZi8xijUXao6nDHkTxvoaTHJmO2EhWAxN48sUSgRNvpYbNyivvj8p1QsGb9b
        fFMgQJRY1l3M5eJX5AZ2seozb+xi6XDgqp11/GeY4Q5dKVJSxWwlkdj+3sANcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=R2Qjyw6Zc8pt9ekkG6nMwtYrspreGdq8YwOfxKRzMR8=;
        b=Egs+6vbPDdPd4F6300paY4EruL/XO4EVzplrcbI6kOZ1+G3TD0+/2u4JUjPstS4OPajzd7
        KvO+vAMXExbMELBw==
Date:   Fri, 18 Jun 2021 16:18:35 +0200
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
Subject: [patch V3 12/66] x86/fpu: Reject invalid MXCSR values in
 copy_kernel_to_xstate()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of masking out reserved bits, check them and reject the provided
state as invalid if not zero.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Validate MXCSR when FP|SSE|YMM are set. The quirk check is only
    correct for the copy function.
V2: New patch
---
 arch/x86/kernel/fpu/xstate.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1154,6 +1154,19 @@ void copy_xstate_to_kernel(struct membuf
 		membuf_zero(&to, to.left);
 }
 
+static inline bool mxcsr_valid(struct xstate_header *hdr, const u32 *mxcsr)
+{
+	u64 mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
+
+	/* Only check if it is in use */
+	if (hdr->xfeatures & mask) {
+		/* Reserved bits in MXCSR must be zero. */
+		if (*mxcsr & ~mxcsr_feature_mask)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
@@ -1172,6 +1185,9 @@ int copy_kernel_to_xstate(struct xregs_s
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	if (!mxcsr_valid(&hdr, kbuf + offsetof(struct fxregs_state, mxcsr)))
+		return -EINVAL;
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
@@ -1202,9 +1218,6 @@ int copy_kernel_to_xstate(struct xregs_s
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
-	/* mxcsr reserved bits must be masked to zero for historical reasons. */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
 	return 0;
 }
 

