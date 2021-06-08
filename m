Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4858039F98D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhFHOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhFHOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:21 -0400
Message-Id: <20210608144345.758116583@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hImjpb4qpunvlOerRhGYfsE9Wx1+k0vr4WQRlSr6QkY=;
        b=pulNH0zE+3QRbLd0EoY9zBzK9eda6GJHKBxqEeKRrJ0kf38RuyISU4YBrHoIQ7SVYyr236
        MToTzLPFR4QTJgdcitk4UJYtAcaGochUlwYpFER35nYgZhklxIq14lPXawR49nsssZw2Y0
        WlxPh++wQ5mnLFgkHMcCcrNUKcNB04XyUbAi9MuFmtsi32qWpy89Xd1NnmDA2+brWmJMay
        zDDdgBdzlvmx5jDVQ+R2bYoYeEkQc91b+0ss8Ke27EnDpf1p3AgVz7KW86Qrcrg4PgmgAs
        k6ler4lbyTGeE/KxRXcPaM8E1bhc5C7/MBIKd1sCyDGFQXhH9RMydwud97yj+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hImjpb4qpunvlOerRhGYfsE9Wx1+k0vr4WQRlSr6QkY=;
        b=C5odH8kkd8CIE7l1pJki0ZlMXATDCITyPQo2BOTbVMvgiB9YaPsvWXFqiaBePtb9Nk5zwt
        U7EuHmabOVvISzCQ==
Date:   Tue, 08 Jun 2021 16:36:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>
Subject: [patch V3 2/6] x86/fpu: Invalidate FPU state after a failed XRSTOR
 from a user buffer
References: <20210608143617.565868844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Both Intel and AMD consider it to be architecturally valid for XRSTOR to
fail with #PF but nonetheless change the register state.  The actual
conditions under which this might occur are unclear [1], but it seems
plausible that this might be triggered if one sibling thread unmaps a page
and invalidates the shared TLB while another sibling thread is executing
XRSTOR on the page in question.

__fpu__restore_sig() can execute XRSTOR while the hardware registers are
preserved on behalf of a different victim task (using the
fpu_fpregs_owner_ctx mechanism), and, in theory, XRSTOR could fail but
modify the registers.  If this happens, then there is a window in which
__fpu__restore_sig() could schedule out and the victim task could schedule
back in without reloading its own FPU registers.  This would result in part
of the FPU state that __fpu__restore_sig() was attempting to load leaking
into the victim task's user-visible state.

Invalidate preserved FPU registers on XRSTOR failure to prevent this
situation from corrupting any state.

[1] Frequent readers of the errata lists might imagine "complex
    microarchitectural conditions"

Fixes: 1d731e731c4c ("x86/fpu: Add a fastpath to __fpu__restore_sig()")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
V3: Rework comment - Borislav
V2: Amend changelog - Borislav
---
 arch/x86/kernel/fpu/signal.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -369,6 +369,25 @@ static int __fpu__restore_sig(void __use
 			fpregs_unlock();
 			return 0;
 		}
+
+		/*
+		 * The above did an FPU restore operation, restricted to
+		 * the user portion of the registers, and failed, but the
+		 * microcode might have modified the FPU registers
+		 * nevertheless.
+		 *
+		 * If the FPU registers do not belong to current, then
+		 * invalidate the FPU register state otherwise the task might
+		 * preempt current and return to user space with corrupted
+		 * FPU registers.
+		 *
+		 * In case current owns the FPU registers then no further
+		 * action is required. The fixup below will handle it
+		 * correctly.
+		 */
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			__cpu_invalidate_fpregs_state();
+
 		fpregs_unlock();
 	} else {
 		/*

