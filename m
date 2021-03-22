Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97334345205
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCVVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhCVVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:48:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DFC9619A8;
        Mon, 22 Mar 2021 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616449708;
        bh=fxOmvQzfscGlkTrVh1T1r4rTQjeuugoZbSwqU6liY+4=;
        h=From:To:Cc:Subject:Date:From;
        b=RYBd2GhpAt1WNKgwP+iz/VwnCbd4IjKy9taVj5rn8aiNnijCDkByNcsKwHnma5O8Z
         w74UeNEuCNJn2CKF5j0FDyORMDLlgo85/hH4ufwDmfl3E5wJIxewdImtICHEyxa8GW
         MRltBKmtpXJ+UU/ceouBoyz8ZDyYWkisAi6fNwpcxPu1Km5/YH2FDwGINTHYxUag1p
         cvEoR9uLr4hNcKF1MFa1IXbBoG7zYXUyCuXV97RrR6McDUdumfIEjNS/yUy6Hcz5sV
         2gY62/8oVg804Ba8wJNJYKnJqFhxR+fEkOde1hVkvFpiLa582bXk1H6XcTohWGiXOK
         uA/7A12CcDZlQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] x86: math-emu: Fix function cast warning
Date:   Mon, 22 Mar 2021 22:48:19 +0100
Message-Id: <20210322214824.974323-1-arnd@kernel.org>
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
v2: use consistent naming for the function types, as
    pointed out by Ingo Molnar
---
 arch/x86/math-emu/fpu_trig.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 4a9887851ad8..990d847ae902 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -547,7 +547,7 @@ static void frndint_(FPU_REG *st0_ptr, u_char st0_tag)
 		single_arg_error(st0_ptr, st0_tag);
 }
 
-static int fsin(FPU_REG *st0_ptr, u_char tag)
+static int f_sin(FPU_REG *st0_ptr, u_char tag)
 {
 	u_char arg_sign = getsign(st0_ptr);
 
@@ -608,6 +608,11 @@ static int fsin(FPU_REG *st0_ptr, u_char tag)
 	}
 }
 
+static void fsin(FPU_REG *st0_ptr, u_char tag)
+{
+	f_sin(st0_ptr, tag);
+}
+
 static int f_cos(FPU_REG *st0_ptr, u_char tag)
 {
 	u_char st0_sign;
@@ -724,7 +729,7 @@ static void fsincos(FPU_REG *st0_ptr, u_char st0_tag)
 	}
 
 	reg_copy(st0_ptr, &arg);
-	if (!fsin(st0_ptr, st0_tag)) {
+	if (!f_sin(st0_ptr, st0_tag)) {
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

