Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD28639F98F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhFHOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhFHOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C2C061787
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:49:30 -0700 (PDT)
Message-Id: <20210608144345.912645927@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4LgZtohgq2ySESHc02//du52iwoTx7HELfTV7M2CNOk=;
        b=DrBNLsLASRQA1MXui6Wz8ql7fIb+Xn7iAIE2pgTvQZR+Tkxo7VjttWsbyNOdUfrf2VIVxY
        t06nRKO0xpNG4I7W894ucQE5WB31QIEavEJF5eMPlIscT4N1/r0u2xJOR1ubeY/RgP/kdV
        mOZW9Xn4uJmuGtfGRoBvz8SDAIxy2sZxeEp2T1DnkO9maWdZ53VhTfnTNVcvgzWfeo7S1Q
        BpbEJeybhIwMFlQK0RD0DPTMbaVQKImtPHiMK2zcdKpb5Q9cv+XFwjryEetEy5bLQT5qxC
        t1SOuM+aNASTQENnSPaOr6AgLtaiaPoWjzjtUAsoA3pc1i3djXw2pCzM/6R+yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4LgZtohgq2ySESHc02//du52iwoTx7HELfTV7M2CNOk=;
        b=R7AjCCNpSzRzMAYzkaVkBCKWz2MaLTk1KEAP5csC1RK6euycc4RmCJpULajQHi8+NQ3LKO
        2WrHt5S+bbFdwHCA==
Date:   Tue, 08 Jun 2021 16:36:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@suse.de>
Subject: [patch V3 3/6] x86/process: Check PF_KTHREAD and not current->mm for
 kernel threads
References: <20210608143617.565868844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

switch_fpu_finish() checks current->mm as indicator for kernel threads.
That's wrong because kernel threads can temporarily use a mm of a user
process via kthread_use_mm().

Check the task flags for PF_KTHREAD instead.

Fixes: 0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/fpu/internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -578,7 +578,7 @@ static inline void switch_fpu_finish(str
 	 * PKRU state is switched eagerly because it needs to be valid before we
 	 * return to userland e.g. for a copy_to_user() operation.
 	 */
-	if (current->mm) {
+	if (!(current->flags & PF_KTHREAD)) {
 		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
 		if (pk)
 			pkru_val = pk->pkru;

