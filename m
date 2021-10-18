Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF26432451
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhJRQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhJRQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:58:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8115AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u21so1087671lff.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Av2yU1eH/+KVUhWiYq4bjMFQGpgX8uwkDZTA6ABYzWY=;
        b=ZQYlUkUhykf3kLY8BWKFRAPVroexGsixF5RO31L4XWCUbcmaFWjtjbemBdQfOOr0JD
         cZh/UO41cVqXmXZL8zJJjHuQDgntGNoreyegMn8jzYmN0upt/E+k6RaymlpHDXXjnHpr
         XbcAhmuFs9E5mP96xElxs5PImroPZuLgX/5SbkCw0FIobXuK3yO1XEIvITYduiJyKrVM
         UKIkodApRn85ra/6Aea8VKHUD5xKCuQAVcc8mHsbh6sgGtmAOIVxV3ozDKWX8t/nCE5m
         HqSjrAKbM/oVXbIAjFfEJl99Fgsc8Kdlu8TQTljGI4K8CYGQ6o7nk/C5dnaiVfTXk27L
         2DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av2yU1eH/+KVUhWiYq4bjMFQGpgX8uwkDZTA6ABYzWY=;
        b=lkDcTdI+yQnzfBA9D0Nlb5NjC/MEzfLCeWLpeeUJJcnTmvuqSfkMRW2JrG/MLs9ond
         VZmt6IUTmH6RovtIyJr1LH1yQ84YuKHE31iEH/t4j89AQdSUROtY6zoZ5aXysRgY99D1
         /8gymouDjkVDeWLDWoD6QbEgatfKlEOpw8dAnZup1esgbb2Onwm++J8tefyXLz+64Hke
         u5vaSZOZvDT0EjffqiCcRV+BbxpXKW1J2PAvyUzkk5tw8kBc0zknRuEdDxWzQWQgJYla
         zi7BoSK1j2/OSCekG45WcioCOUdodJ2RMtDOiEEMvJdSoZLkCE2wXId+WEIr86aTGPqH
         ar7g==
X-Gm-Message-State: AOAM532/SHZyZpZLQH+tNCM5zLmpox9Xo+H4AeeBI3joEs7wyFtwB4KZ
        IW1DtowQ11eoVbNtdmIwYTcHIbagb9kHmA==
X-Google-Smtp-Source: ABdhPJywXDi+aFao3/27N0EumZQ7tbfFo2+e7OhGw0k/ihXkVRjIaqQwUH0dRTWRcCKvNRrwJRydrA==
X-Received: by 2002:a05:6512:3d8a:: with SMTP id k10mr907429lfv.120.1634576178917;
        Mon, 18 Oct 2021 09:56:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i6sm1680539lja.57.2021.10.18.09.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:56:18 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id CC14810309A; Mon, 18 Oct 2021 19:56:21 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCHv2 3/3] x86/sev-es: Use insn_decode_mmio() for MMIO implementation
Date:   Mon, 18 Oct 2021 19:56:14 +0300
Message-Id: <20211018165614.20153-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
References: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch SEV implementation to insn_decode_mmio(). The helper is going
to be used by TDX too.

No functional changes. It is only build-tested.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/sev.c | 171 ++++++++++--------------------------------
 1 file changed, 40 insertions(+), 131 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..8fea7ea67c67 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -807,22 +807,6 @@ static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
 	do_early_exception(ctxt->regs, trapnr);
 }
 
-static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
-{
-	long *reg_array;
-	int offset;
-
-	reg_array = (long *)ctxt->regs;
-	offset    = insn_get_modrm_reg_off(&ctxt->insn, ctxt->regs);
-
-	if (offset < 0)
-		return NULL;
-
-	offset /= sizeof(long);
-
-	return reg_array + offset;
-}
-
 static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
 {
 	long *reg_array;
@@ -870,76 +854,6 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
 }
 
-static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
-						 struct es_em_ctxt *ctxt)
-{
-	struct insn *insn = &ctxt->insn;
-	unsigned int bytes = 0;
-	enum es_result ret;
-	int sign_byte;
-	long *reg_data;
-
-	switch (insn->opcode.bytes[1]) {
-		/* MMIO Read w/ zero-extension */
-	case 0xb6:
-		bytes = 1;
-		fallthrough;
-	case 0xb7:
-		if (!bytes)
-			bytes = 2;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero extend based on operand size */
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		memset(reg_data, 0, insn->opnd_bytes);
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-		/* MMIO Read w/ sign-extension */
-	case 0xbe:
-		bytes = 1;
-		fallthrough;
-	case 0xbf:
-		if (!bytes)
-			bytes = 2;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Sign extend based on operand size */
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		if (bytes == 1) {
-			u8 *val = (u8 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x80) ? 0xff : 0x00;
-		} else {
-			u16 *val = (u16 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
-		}
-		memset(reg_data, sign_byte, insn->opnd_bytes);
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-	default:
-		ret = ES_UNSUPPORTED;
-	}
-
-	return ret;
-}
-
 /*
  * The MOVS instruction has two memory operands, which raises the
  * problem that it is not known whether the access to the source or the
@@ -1007,83 +921,78 @@ static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
 		return ES_RETRY;
 }
 
-static enum es_result vc_handle_mmio(struct ghcb *ghcb,
-				     struct es_em_ctxt *ctxt)
+static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct insn *insn = &ctxt->insn;
 	unsigned int bytes = 0;
+	enum mmio_type mmio;
 	enum es_result ret;
+	u8 sign_byte;
 	long *reg_data;
 
-	switch (insn->opcode.bytes[0]) {
-	/* MMIO Write */
-	case 0x88:
-		bytes = 1;
-		fallthrough;
-	case 0x89:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
+	mmio = insn_decode_mmio(insn, &bytes);
+	if (mmio == MMIO_DECODE_FAILED)
+		return ES_DECODE_FAILED;
 
-		reg_data = vc_insn_get_reg(ctxt);
+	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
 		if (!reg_data)
 			return ES_DECODE_FAILED;
+	}
 
+	switch (mmio) {
+	case MMIO_WRITE:
 		memcpy(ghcb->shared_buffer, reg_data, bytes);
-
 		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
 		break;
-
-	case 0xc6:
-		bytes = 1;
-		fallthrough;
-	case 0xc7:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
+	case MMIO_WRITE_IMM:
 		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
-
 		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
 		break;
-
-		/* MMIO Read */
-	case 0x8a:
-		bytes = 1;
-		fallthrough;
-	case 0x8b:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
+	case MMIO_READ:
 		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
 		if (ret)
 			break;
 
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
 		/* Zero-extend for 32-bit operation */
 		if (bytes == 4)
 			*reg_data = 0;
 
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
+	case MMIO_READ_ZERO_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		memset(reg_data, 0, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case MMIO_READ_SIGN_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
 
-		/* MOVS instruction */
-	case 0xa4:
-		bytes = 1;
-		fallthrough;
-	case 0xa5:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
+		if (bytes == 1) {
+			u8 *val = (u8 *)ghcb->shared_buffer;
 
-		ret = vc_handle_mmio_movs(ctxt, bytes);
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			u16 *val = (u16 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+
+		/* Sign extend based on operand size */
+		memset(reg_data, sign_byte, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
-		/* Two-Byte Opcodes */
-	case 0x0f:
-		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
+	case MMIO_MOVS:
+		ret = vc_handle_mmio_movs(ctxt, bytes);
 		break;
 	default:
 		ret = ES_UNSUPPORTED;
+		break;
 	}
 
 	return ret;
-- 
2.32.0

