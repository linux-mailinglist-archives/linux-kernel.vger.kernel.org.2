Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBD3A46C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhFKQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhFKQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:08 -0400
Message-Id: <20210611163112.039431600@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QX1VoycMN9gsrXlDDoDt65mZa5mTaOiskCaBMc3isOA=;
        b=tGdzGBAeUk1rEw6VBE/n0VZlX6Un9i60Wz9g6zX9LTS7YfcHDCVHw8hEpHGlcgHSr/rsEd
        wa5JTLz2N1jf+oH0M4FB3MyDpGOb6rIIrStYNyXltNgv4vOnccC4VdWb4U1UE2ALEsfjKM
        5MgeprkvNO4M6GAIrCqviRGx1rUxehqBmmfL7YT6n3W+lwcJZDM4N2NOE1iDzRcSQu0hpw
        kRzMuKNMw9WFqXPnn7MXaeiPY5FqGpjEOwujlD2K0A0FdLv+/6Z/uWqLGQPASYXLnKBzxF
        stkLfQQEeXQI1JuxrPO161dW78bk+M2iLllEpNv8oph0DIxYwVb8mAnx1aZHYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QX1VoycMN9gsrXlDDoDt65mZa5mTaOiskCaBMc3isOA=;
        b=LnT5pqmz0ua5mmuo9llNAMeTmeSpK84V16QJpuMMDiEmq2ss0dNl/AMNUaxoPoY4Crys9B
        6zs3Stg9RChU5kAQ==
Date:   Fri, 11 Jun 2021 18:15:33 +0200
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
Subject: [patch 10/41] x86/fpu: Cleanup arch_set_user_pkey_access()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is having a sanity check with a WARN_ON_ONCE() but happily
proceeds when the pkey argument is out of range.

Clean it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -887,11 +887,10 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
  * rights for @pkey to @init_val.
  */
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val)
+			      unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 old_pkru, new_pkru_bits = 0;
+	int pkey_shift;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -905,7 +904,8 @@ int arch_set_user_pkey_access(struct tas
 	 * values originating from in-kernel users.  Complain
 	 * if a bad value is observed.
 	 */
-	WARN_ON_ONCE(pkey >= arch_max_pkey());
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
 
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
@@ -914,6 +914,7 @@ int arch_set_user_pkey_access(struct tas
 		new_pkru_bits |= PKRU_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
+	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */

