Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4175632D90E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCDRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbhCDRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:44:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF264C0613DB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:43:05 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B1F41EC052A;
        Thu,  4 Mar 2021 18:43:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Trimukt++lls65mUIiMtgU/FJWQyOz/Ier0/+iBUxic=;
        b=YNuGiT2ppMAUKqBdTr+Av5YssphGWV+s/Gl6lYAgz5VRVG+rUlVN1pCX9WyMdjrqQmU7E6
        XkPR2dwnT4sRV3kbR/P2BEAVgSu/qW1dvoYf/1O2dYc1ftq2g6IENaGqq5a9t5v8VJQCun
        be3Il4kzjXOREAa9QIJPwFEkbbv4KeQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 21/21] x86/insn: Make insn_complete() static
Date:   Thu,  4 Mar 2021 18:42:37 +0100
Message-Id: <20210304174237.31945-22-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
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
index 5eb3753dce33..f03b6ca7dec6 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -178,13 +178,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
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
index bb58004497f8..058f19b20465 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -714,6 +714,13 @@ int insn_get_length(struct insn *insn)
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
index 5aae785003dc..c9f3eeebb53b 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -178,13 +178,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
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
index be2b057f91d4..cd4dedde3265 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -714,6 +714,13 @@ int insn_get_length(struct insn *insn)
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

