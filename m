Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCF323B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhBXLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:09:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234976AbhBXLDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:24 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D3EF1EC05B9;
        Wed, 24 Feb 2021 12:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ix60NK+RvNT/efEphcHH454wcnN7BlhPfTRO0HpPn0M=;
        b=sBY+/XC/Rr0HJBGzcV5VQaGbLYYDCWt1gVxgSRnv8VtoLe1Lc03e9RKfJu9xTVjoUwFx1Q
        PtTweCibVIarUenBxxuYP4lWLsMQOs5Op0FsVsWUU6E8WGbO54rj/rpKQszMVRTbDmK09S
        Wu/dmtk1CdfNyX8H1ILP9O5+xgDsBqA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/21] x86/mce: Convert to insn_decode()
Date:   Wed, 24 Feb 2021 12:02:22 +0100
Message-Id: <20210224110233.19715-11-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/severity.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991314c5..a2136ced9d73 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -218,15 +218,15 @@ static struct severity {
 static bool is_copy_from_user(struct pt_regs *regs)
 {
 	u8 insn_buf[MAX_INSN_SIZE];
-	struct insn insn;
 	unsigned long addr;
+	struct insn insn;
+	int ret;
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
 		return false;
 
 	switch (insn.opcode.value) {
@@ -234,10 +234,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	case 0x8A: case 0x8B:
 	/* MOVZ mem,reg */
 	case 0xB60F: case 0xB70F:
-		insn_get_modrm(&insn);
-		insn_get_sib(&insn);
-		if (!insn.modrm.got || !insn.sib.got)
-			return false;
 		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 		break;
 	/* REP MOVS */
-- 
2.29.2

