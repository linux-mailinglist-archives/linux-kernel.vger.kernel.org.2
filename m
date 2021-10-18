Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9223432450
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhJRQ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhJRQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:58:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D4C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so1070233lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kO0IXbauHLHAa1pjDhs0BWqR5rXDhpyxkrmhc19wT0=;
        b=t2nzo4JU7enSGoqSaYD4jpJfnUsSqsz9UUd490AifLNmYgL1JHUJwaqbMZW0p9oZiV
         vCazc/UXZ7OXpYpKr0ezQWDLf5dhhHVad9KAS4EQpD/j2X29ymzrwFDErWwnbNiL5pFU
         T/2PPu1Jm5INJ74TmFRquGSBKSo9Rxr1q22wS9ncxcPmdAqQTlqZGgHS6Cedfd/MawZU
         fnmx1RmlsdkvS84MsBLQBL9N118SYVEkySenQipK3tUsgoR+RgpFIL32aDFhKsXCjieP
         9+Zy/+3najf2URWTSmgeCYhddBXMIwr+nEPZBpp4OdoJ5UdlLRxVMNctM8uCb/ncs6z6
         GbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kO0IXbauHLHAa1pjDhs0BWqR5rXDhpyxkrmhc19wT0=;
        b=w6su/44Zsn9QddRrTTy2G7oUdPTL3QY+2TRH7yKUJH/ByUhw0LIUqZyCqLexMeDuDi
         0u28uIObbb2NQt/4PHNc/iiQ+m2DFSVMHL4pRScxYl0tVnvJAbuNrWTfVktxQqvGKkZu
         6zl5sTobL2ajOy20qPWVWKIUkiKoPsmHVHXvh7wH0FE2PonLZoko507o6jc9s/zD6Qth
         KS+kP1UBWne5GPdr65vaswoNTW+Xqxy5pXIBhdxY6wdS5F5o7HMfJnDkqM0PNOJJKcXs
         V6T+MnvkXCSKbhoHcuLMt6A7cKUHOmDhSV5G36lqlVElFzBMCZ37NrRLrvZtwFUmZhb1
         E8fg==
X-Gm-Message-State: AOAM533f4/oFkPQzaQkFKiZBj58V+nj3ezdV/HWsYbCSotphvW97vU1Q
        leL5HGzLL5UfK/BVr+H0NmLGLQ==
X-Google-Smtp-Source: ABdhPJzs64luYq0kman9mQJRgnyq6xvbYACwZMokiqrRuNjhYPF0qsXdPjHVz4XFTa3OkzFLLIB6QQ==
X-Received: by 2002:a05:6512:b0a:: with SMTP id w10mr837120lfu.240.1634576178147;
        Mon, 18 Oct 2021 09:56:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u4sm1182431lfs.153.2021.10.18.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:56:17 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id DF87210309C; Mon, 18 Oct 2021 19:56:20 +0300 (+03)
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
Subject: [PATCHv2 2/3] x86/insn-eval: Introduce insn_decode_mmio()
Date:   Mon, 18 Oct 2021 19:56:13 +0300
Message-Id: <20211018165614.20153-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
References: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 64fbab09b966..1714359f48bd 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1559,3 +1559,87 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 
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
+	if (!insn_get_opcode(insn))
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

