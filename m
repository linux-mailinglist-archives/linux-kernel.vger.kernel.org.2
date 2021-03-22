Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A563344CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCVRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232070AbhCVRGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:06:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 289136146D;
        Mon, 22 Mar 2021 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616432774;
        bh=XAkPgjgZ2QDBE+oZCfm0SfAf6AMlPXHZkmi1dip4ApQ=;
        h=From:To:Cc:Subject:Date:From;
        b=q1/eBxL/X/8YUjH4nRXPdv+Znw2q1MepW9PkHERmPay3Q2DA8VEF8mPbbcQ+rs2Yi
         pTsFR1g/qKPDoBndPFkiKTrv+xemKrOZxyY0hfmNEQP8FkI0wyiS+/ZS/toERp3E0z
         7Ugho/hbPAbJYd8H+WF6B92uTk8S/cNsxaLsj7j+qKgdbgzz5iglayv86FIs47THWq
         cT85NRwSeMSBokVdz1jLS+Og3WcQygjPb0N/n44epdjd1VoXf7SeILdsUrsH/TDril
         fF4Rv6jbtzWIkWRSc86MHRWem+dZhozAjON7/qLHLez1yJz0J0BM5ufpgKxZZ9wO/g
         Sakv/4N15AHzw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: math-emu: Fix function cast warning
Date:   Mon, 22 Mar 2021 18:06:05 +0100
Message-Id: <20210322170610.1823153-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1', gcc points out that casting between
incompatible function types can be dangerous:

arch/x86/math-emu/fpu_trig.c:1638:60: error: cast between incompatible function types from ‘int (*)(FPU_REG *, u_char)’ {aka ‘int (*)(struct fpu__reg *, unsigned char)’} to ‘void (*)(FPU_REG *, u_char)’ {aka ‘void (*)(struct fpu__reg *, unsigned char)’} [-Werror=cast-function-type]
 1638 |         fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, (FUNC_ST0) fsin, fcos
      |                                                            ^

This one seems harmless, but it is easy enough to work around it by
adding an intermediate function that adjusts the return type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/math-emu/fpu_trig.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 4a9887851ad8..aebfdb244cb4 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -547,7 +547,7 @@ static void frndint_(FPU_REG *st0_ptr, u_char st0_tag)
 		single_arg_error(st0_ptr, st0_tag);
 }
 
-static int fsin(FPU_REG *st0_ptr, u_char tag)
+static int do_fsin(FPU_REG *st0_ptr, u_char tag)
 {
 	u_char arg_sign = getsign(st0_ptr);
 
@@ -608,6 +608,11 @@ static int fsin(FPU_REG *st0_ptr, u_char tag)
 	}
 }
 
+static void fsin(FPU_REG *st0_ptr, u_char tag)
+{
+	fsin(st0_ptr, tag);
+}
+
 static int f_cos(FPU_REG *st0_ptr, u_char tag)
 {
 	u_char st0_sign;
@@ -724,7 +729,7 @@ static void fsincos(FPU_REG *st0_ptr, u_char st0_tag)
 	}
 
 	reg_copy(st0_ptr, &arg);
-	if (!fsin(st0_ptr, st0_tag)) {
+	if (!do_fsin(st0_ptr, st0_tag)) {
 		push();
 		FPU_copy_to_reg0(&arg, st0_tag);
 		f_cos(&st(0), st0_tag);
@@ -1635,7 +1640,7 @@ void FPU_triga(void)
 }
 
 static FUNC_ST0 const trig_table_b[] = {
-	fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, (FUNC_ST0) fsin, fcos
+	fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, fsin, fcos
 };
 
 void FPU_trigb(void)
-- 
2.29.2

