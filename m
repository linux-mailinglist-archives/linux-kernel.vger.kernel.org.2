Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB984444DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhKCPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhKCPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:48:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A082C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:46:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so6043840lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nB+vocTTi+ffXwAW5PnidSrxiNJSRlWMr43KKlhuIo=;
        b=7wq/aT2vGZamcE6NnoNWuV/FiPvSSHOkyVsH5s/EdsbIH5cLfJ6Qz0/r+XDjjv/p4o
         eep402n8qmDpPj6gXwaWzqyrXgE0fq8EphgDG95JhdGTDA+sMSz8939ASLnLQabGoLFO
         l3t8i/sdTsBK1AM2islWIrNw1UzBfXbjnYdMQtsBQkXKmEcPCxiXggPsVWxQwwyrDnM0
         5AX2QLLruIXABk9tR4MmfhiQr0k2rIDMNBV0D9ZsyS3VyahmS9ZrtUTPtiblsNyEjUw9
         0DG8ZqUm7jBRj7263tmN4i3Sunpqzbv+UrlbZX5i4oaix2SpD+4hIrCWAQrRJNES5Z+Z
         3PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nB+vocTTi+ffXwAW5PnidSrxiNJSRlWMr43KKlhuIo=;
        b=xsV2egcny0Cm7h/rwIQjNQUI+8mNpBingwhD5CedXA96E2bUAcVaTQhpmmAyDDBDmK
         PEjsFwWygvHXkJHrAayM1ml6HdaOMZRVoQpIXSsJzdIOo0S8yyEq5BfBt7nur/hVAH1A
         94icnOvF2zOHElymnCpDBvJ+yZT/x4nsSQgsW7ugLx2td2bKAZFZB7cWVbjaasiWIhsC
         wplmWi0CtxUXR/Yox9ouqLRd0T+hobgD37zshIvyj7kpFIVYVgK5n/dypJfK3j833GVj
         yyt2zFmdkgC8UuFJGiu7epfoqgSzMVZKmMEejI4wtIuMYKTXMHV9XLDkoJZlr89J6f4r
         ipHg==
X-Gm-Message-State: AOAM530Pz0D2aFHiM12PB1cHJNeU3+NEEnIpGX/Iag4TU94OGFsf/IgX
        NghketBvaYNAd8T7CnY8UP9vaQ==
X-Google-Smtp-Source: ABdhPJyYuF8gJbNKuxifi1aJzNzvtc6FiC0tvnfE5AmZfCe+MTPGlVDK/e+h1Tti+tkLXJvTRoaczQ==
X-Received: by 2002:a05:6512:1102:: with SMTP id l2mr41096551lfg.181.1635954380645;
        Wed, 03 Nov 2021 08:46:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f8sm210444lfu.5.2021.11.03.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:46:19 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id A2D0D1033EE; Wed,  3 Nov 2021 18:46:18 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCHv3 3/4] x86/insn-eval: Introduce insn_decode_mmio()
Date:   Wed,  3 Nov 2021 18:45:54 +0300
Message-Id: <20211103154555.23729-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
References: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

In preparation for sharing MMIO instruction decode between SEV-ES and
TDX, factor out the common decode into a new insn_decode_mmio() helper.

For regular virtual machine, MMIO is handled by the VMM and KVM
emulates instructions that caused MMIO. But, this model doesn't work
for a secure VMs (like SEV or TDX) as VMM doesn't have access to the
guest memory and register state. So, for TDX or SEV VMM needs
assistance in handling MMIO. It induces exception in the guest. Guest
has to decode the instruction and handle it on its own.

The code is based on the current SEV MMIO implementation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/insn-eval.h | 12 +++++
 arch/x86/lib/insn-eval.c         | 84 ++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 5c6869565fb3..010d31726d06 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -29,4 +29,16 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
 bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
+enum mmio_type {
+	MMIO_DECODE_FAILED,
+	MMIO_WRITE,
+	MMIO_WRITE_IMM,
+	MMIO_READ,
+	MMIO_READ_ZERO_EXTEND,
+	MMIO_READ_SIGN_EXTEND,
+	MMIO_MOVS,
+};
+
+enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 385232a67281..ffd040c1c97b 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1560,3 +1560,87 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 
 	return true;
 }
+
+/**
+ * insn_decode_mmio() - Decode a MMIO instruction
+ * @insn:	Structure to store decoded instruction
+ * @bytes:	Returns size of memory operand
+ *
+ * Decodes instruction that used for Memory-mapped I/O.
+ *
+ * Returns:
+ *
+ * Type of the instruction. Size of the memory operand is stored in
+ * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
+ */
+enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
+{
+	int type = MMIO_DECODE_FAILED;
+
+	*bytes = 0;
+
+	if (insn_get_opcode(insn))
+		return MMIO_DECODE_FAILED;
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x88: /* MOV m8,r8 */
+		*bytes = 1;
+		fallthrough;
+	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_WRITE;
+		break;
+
+	case 0xc6: /* MOV m8, imm8 */
+		*bytes = 1;
+		fallthrough;
+	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_WRITE_IMM;
+		break;
+
+	case 0x8a: /* MOV r8, m8 */
+		*bytes = 1;
+		fallthrough;
+	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_READ;
+		break;
+
+	case 0xa4: /* MOVS m8, m8 */
+		*bytes = 1;
+		fallthrough;
+	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_MOVS;
+		break;
+
+	case 0x0f: /* Two-byte instruction */
+		switch (insn->opcode.bytes[1]) {
+		case 0xb6: /* MOVZX r16/r32/r64, m8 */
+			*bytes = 1;
+			fallthrough;
+		case 0xb7: /* MOVZX r32/r64, m16 */
+			if (!*bytes)
+				*bytes = 2;
+			type = MMIO_READ_ZERO_EXTEND;
+			break;
+
+		case 0xbe: /* MOVSX r16/r32/r64, m8 */
+			*bytes = 1;
+			fallthrough;
+		case 0xbf: /* MOVSX r32/r64, m16 */
+			if (!*bytes)
+				*bytes = 2;
+			type = MMIO_READ_SIGN_EXTEND;
+			break;
+		}
+		break;
+	}
+
+	return type;
+}
-- 
2.32.0

