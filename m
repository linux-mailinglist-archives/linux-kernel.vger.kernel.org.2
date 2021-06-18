Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857E33ACE95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhFRPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhFRPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:47 -0400
Message-Id: <20210618143446.088319013@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QtQUP889ciSZ+4gS9iHLmpPHEl8XQW1YfEDlvnA0EGI=;
        b=iY9vD7vJWCE9W8jN21QD6fT2K9YK1wi4qoC/JsINRIGUjApTl9yfOavXyCdKSC+t/8HuF8
        20E+66pyRcAr7SMKY92I2aLWCayWqPCIA9NlvL4t/d9Kag041UezSZE7idRh+gDxP/Rmv7
        L9Ulh1HxK2+UlyQs1NVE95Pum6Ied4RqQfDQIhyeNnzbrLkP9OJoQ1pQkno826jdzm/3Lz
        /hWNSfT26Fgkly3W6AbEc0MlFph30VE7KxsAI3gD6k8YhJC5GTGr0CT7FzAi80irbzlaOJ
        mXIhZ3Hd5Nea5YVXWQ/TBP9xtoREOIqJYNoASYJ6oCztPe+CFbtkojpMo31CGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QtQUP889ciSZ+4gS9iHLmpPHEl8XQW1YfEDlvnA0EGI=;
        b=68h1rt6Bqw9/eio/WJnBEzVg/wehv8kafloFHDDJL8reRSL3fc7Y+XJtWGh6GG8O6LNm1s
        JVfpXTsRN/RphsBg==
Date:   Fri, 18 Jun 2021 16:18:38 +0200
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
Subject: [patch V3 15/66] x86/fpu: Fail ptrace() requests that try to set
 invalid MXCSR values
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

There is no benefit from accepting and silently changing an invalid MXCSR
value supplied via ptrace().  Instead, return -EINVAL on invalid input.

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
@@ -64,8 +64,9 @@ int xfpregs_set(struct task_struct *targ
 	if (ret)
 		return ret;
 
-	/* Mask invalid MXCSR bits (for historical reasons). */
-	newstate.mxcsr &= mxcsr_feature_mask;
+	/* Do not allow an invalid MXCSR value. */
+	if (newstate.mxcsr & ~mxcsr_feature_mask)
+		ret = -EINVAL;
 
 	fpu__prepare_write(fpu);
 

