Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61C231EFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBRTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:30:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhBRSr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:47:29 -0500
Received: from zn.tnic (p200300ec2f0c6200329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:6200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 766E11EC036C;
        Thu, 18 Feb 2021 19:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613674001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bG2ukGdeaJBUIyVoPz3j2HXqZkZj71tMc/X8YRCOFZ8=;
        b=fSVWz3hJi+/MX62NWM5YVdrVGtnVvHJnJ/02FtGSq8GX9i1OT8Lx7f7TEHDJHCTgZJ4Esf
        E3LlD2KvJaq0MaOJPbwNoL5kWHa/5hdAoCHCUAUernNayItFmXvRyBO4lhqsTTgihy7B0D
        GxzTdKARCtZeV+r4yTIoWxpdY87wTtw=
Date:   Thu, 18 Feb 2021 19:46:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tony.luck@intel.com, pjt@google.com,
        linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [RFC PATCH] x86/retpolines: Prevent speculation after RET
Message-ID: <20210218184639.GF4214@zn.tnic>
References: <20210218165938.213678824@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218165938.213678824@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:59:38PM +0100, Peter Zijlstra wrote:
> Hi!
> 
> The first patch rearranges the implementation and consolidates unused bytes.
> The second patch uses INT3 over LFENCE to shrink the retpoline to 15 bytes, by
> which 4 can live in a cacheline.
> 
> Patches have been boot tested on my IVB.

And here's the patch that prompted all this:

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 18 Feb 2021 17:21:24 +0100

Both vendors speculate after a near RET in some way:

Intel:

"Unlike near indirect CALL and near indirect JMP, the processor will not
speculatively execute the next sequential instruction after a near RET
unless that instruction is also the target of a jump or is a target in a
branch predictor."

AMD:

"Some AMD processors when they first encounter a branch do not stall
dispatch and use the branches dynamic execution to determine the target.
Therefore, they will speculatively dispatch the sequential instructions
after the branch. This happens for near return instructions where it is
not clear what code may exist sequentially after the return instruction.
This behavior also occurs with jmp/call instructions with indirect
targets. Software should place a LFENCE or another dispatch serializing
instruction after the return or jmp/call indirect instruction to prevent
this sequential speculation."

The AMD side doesn't really need the LFENCE because it'll do LFENCE;
JMP/CALL <target> due to X86_FEATURE_RETPOLINE_AMD, before it reaches
the RET.

Objtool bits provided by Peter Zijlstra (Intel) <peterz@infradead.org>

Reported-by: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S             | 1 +
 tools/objtool/arch/x86/decode.c      | 5 +++++
 tools/objtool/check.c                | 6 ++++++
 tools/objtool/include/objtool/arch.h | 1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 397d408e8244..3f8652aaf84d 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -31,6 +31,7 @@ SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
 	mov	%\reg, (%_ASM_SP)
 	UNWIND_HINT_FUNC
 	ret
+	lfence
 SYM_FUNC_END(__x86_retpoline_\reg)
 
 .endm
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 549813cff8ab..84a5e3cfa72d 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -464,6 +464,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->src.type = OP_SRC_POP;
 				op->dest.type = OP_DEST_MEM;
 			}
+
+		} else if (op2 == 0xae && modrm == 0xe8) {
+
+			/* lfence */
+			*type = INSN_NOSPEC;
 		}
 
 		break;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 331a763d8775..9ab84f0c4032 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2868,6 +2868,12 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
 		return true;
 
+	/*
+	 * We allow speculation traps after RETURN instructions.
+	 */
+	if (prev_insn->type == INSN_RETURN && insn->type == INSN_NOSPEC)
+		return true;
+
 	/*
 	 * Check if this (or a subsequent) instruction is related to
 	 * CONFIG_UBSAN or CONFIG_KASAN.
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 6ff0685f5cc5..faf0c0afd938 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -26,6 +26,7 @@ enum insn_type {
 	INSN_CLAC,
 	INSN_STD,
 	INSN_CLD,
+	INSN_NOSPEC,
 	INSN_OTHER,
 };
 
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
