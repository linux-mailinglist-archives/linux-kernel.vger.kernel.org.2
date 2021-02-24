Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5D323B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhBXLMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:12:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234964AbhBXLEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:04:14 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C3A01EC05D1;
        Wed, 24 Feb 2021 12:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXoC1DSBzARFwMOqLNzBju99XRx2tAJWQgP2Hb5eTEo=;
        b=OMl8VA9k/tbVL6P4aSBw8qs1PE/AtT5W2wyULueX40jqrlwnaF3OqrltcyyYdYhBLL9JxD
        Cd3dpchRtquS5OzwARbkCPy7g7cIdD/TlCkU6dMymu1fbygQW+6G7vQ5BwJmt8d6YUgofO
        DKHrRsdXKHsBVCaB0dsbP4SmXCWZPzc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 21/21] x86/insn: Make insn_complete() static
Date:   Wed, 24 Feb 2021 12:02:33 +0100
Message-Id: <20210224110233.19715-22-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... and move it above the only place it is used.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn.h       | 7 -------
 arch/x86/lib/insn.c               | 7 +++++++
 tools/arch/x86/include/asm/insn.h | 7 -------
 tools/arch/x86/lib/insn.c         | 7 +++++++
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index ec260f5a6dd5..6df0d3da0d86 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -133,13 +133,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
 	return !!insn->emulate_prefix_size;
 }
 
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
 static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
 {
 	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 07ee5b14ae38..aa6ee796a987 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -726,6 +726,13 @@ int insn_get_length(struct insn *insn)
 	return 0;
 }
 
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
 /**
  * insn_decode() - Decode an x86 instruction
  * @insn:	&struct insn to be initialized
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index a54b4423b640..4f219e3ae817 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -133,13 +133,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
 	return !!insn->emulate_prefix_size;
 }
 
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
 static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
 {
 	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 6c9c1648eef3..a14e78091c75 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -726,6 +726,13 @@ int insn_get_length(struct insn *insn)
 	return 0;
 }
 
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
 /**
  * insn_decode() - Decode an x86 instruction
  * @insn:	&struct insn to be initialized
-- 
2.29.2

