Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4D323B19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhBXLMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:12:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234959AbhBXLEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:04:11 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B017A1EC05BF;
        Wed, 24 Feb 2021 12:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Jl0nejyEMZKxT+cf2MYH1RmdqoQSmDm/wdrxfNnPUM=;
        b=Q476rfIZGDL2cv0S+l9sTljoUJ02oZ+qqlXYgoR9wlpnL6SYoEFTyule74Ha/tnpI5kIUn
        juw3+uDdoYu+2nulkr7D6UhTdX3rwyQDyKwvRMhk4oYPKa/ym1Xk+XoDy25jwhYEVpFf55
        H3YY+hgJOwnSKWfvc/RJ9iRorBdWgZk=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 17/21] tools/objtool: Convert to insn_decode()
Date:   Wed, 24 Feb 2021 12:02:29 +0100
Message-Id: <20210224110233.19715-18-bp@alien8.de>
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
 tools/objtool/arch/x86/decode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cde9c36e40ae..67ee8d2a9e5c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -90,7 +90,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    struct list_head *ops_list)
 {
 	struct insn insn;
-	int x86_64, sign;
+	int x86_64, sign, ret;
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
@@ -101,10 +101,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	if (x86_64 == -1)
 		return -1;
 
-	insn_init(&insn, sec->data->d_buf + offset, maxlen, x86_64);
-	insn_get_length(&insn);
-
-	if (!insn_complete(&insn)) {
+	ret = insn_decode(&insn, sec->data->d_buf + offset, maxlen,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0) {
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
-- 
2.29.2

