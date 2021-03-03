Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A511932BFE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580404AbhCCSd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234234AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zv5HOMrhubR0YcgJnUAQ4Osz1DtNoEt7fRCHOq83pYE=;
        b=F6XGnbqMq3724h48qRMXpTaqgQGFU+zwsNKJWlUXB0uFZndjUL1vY9p3ijIWW2lbWt31Nq
        SavmgJYadpCraMATqXa9hzwMAWSzYZhYWQInA1ab0o60rtwHT8bBBmX3t4SwWkoR/1f+Ma
        l2wM+i0jRMRXfBArFW4yKO4P3dYLCFI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-X561zFl7NTKA2l7ScSN2Cw-1; Wed, 03 Mar 2021 12:09:45 -0500
X-MC-Unique: X561zFl7NTKA2l7ScSN2Cw-1
Received: by mail-wm1-f71.google.com with SMTP id w20so2038788wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zv5HOMrhubR0YcgJnUAQ4Osz1DtNoEt7fRCHOq83pYE=;
        b=CWIzPY3qgqKJtWR7xc/3Ik7XYuTwu1h67CXmw/tAwMJ9FeWt/dGG8Fwlrk8PWqjAw8
         yvDdUx9PKyrBJFnvXP3VkSMCTeRO3M2Q02FxiXbQsoQiLbOTdqaa/5dkWhug4SqhmvAN
         6goJ8iFLmvl3eetT4QoDUoB/7WtoCFucPPWWaqUqGpa04lxJENpZUPJ+nxWy4SHg2s25
         G9/gqxU7Dm424haM/K0JguFZsxQPgm/y8IslvwXE/NFppJB0kSkgF4kaQQ9XP1ASciFv
         oaQ9k0nTLGzzXRxjZLXdkJvHt4qZ5W3+biepI7iLrdiRmTWQi+kSCG/lcPpAUAmLmEiW
         K4ZA==
X-Gm-Message-State: AOAM531eASDphxD5cwNcuUh1ZwgjTbsfl5EZ3dRMQOR9lP8X8B/JCi4x
        bDTFp+SkR9iiKqK08u2suc9A06Aff5wSkxaf/54UD0kBY5PmCNBwydEaao2O/x6Kiqz4yEO4+M2
        2Km8XNTETgujyEHizgu5rP4hlUlziz+B8q8K9m5NoE1ThWc1XKpCdjXlOsn77RKnXaRzu9+SS3B
        48
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr48866wma.94.1614791383051;
        Wed, 03 Mar 2021 09:09:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgq3POhiFwRYXCjRkBsxtxaQb759WEgS+VfCdHCCXPb7mQ7fIa7A8FcAWrVJljpA33CN4ZHg==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr48845wma.94.1614791382829;
        Wed, 03 Mar 2021 09:09:42 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:42 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 04/13] objtool: arm64: Add base definition for arm64 backend
Date:   Wed,  3 Mar 2021 18:09:23 +0100
Message-Id: <20210303170932.1838634-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide needed definitions for a new architecture instruction decoder.
No proper decoding is done yet.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile                        |   5 +
 tools/objtool/arch/arm64/Build                |   8 ++
 tools/objtool/arch/arm64/decode.c             | 130 ++++++++++++++++++
 .../arch/arm64/include/arch/cfi_regs.h        |  14 ++
 tools/objtool/arch/arm64/include/arch/elf.h   |   6 +
 .../arch/arm64/include/arch/endianness.h      |   9 ++
 .../objtool/arch/arm64/include/arch/special.h |  21 +++
 tools/objtool/arch/arm64/special.c            |  21 +++
 tools/objtool/sync-check.sh                   |   5 +
 9 files changed, 219 insertions(+)
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 92ce4fce7bc7..d5cfbec87c02 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -47,6 +47,11 @@ ifeq ($(SRCARCH),x86)
 	SUBCMD_ORC := y
 endif
 
+ifeq ($(SRCARCH),arm64)
+	SUBCMD_CHECK := y
+	CFLAGS  += -Wno-nested-externs
+endif
+
 export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
new file mode 100644
index 000000000000..f3de3a50d541
--- /dev/null
+++ b/tools/objtool/arch/arm64/Build
@@ -0,0 +1,8 @@
+objtool-y += special.o
+objtool-y += decode.o
+
+objtool-y += libhweight.o
+
+$(OUTPUT)arch/arm64/libhweight.o: ../lib/hweight.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
new file mode 100644
index 000000000000..3ec0254f7306
--- /dev/null
+++ b/tools/objtool/arch/arm64/decode.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+#include <asm/insn.h>
+
+#include <objtool/check.h>
+#include <objtool/arch.h>
+#include <objtool/elf.h>
+#include <objtool/warn.h>
+
+#include <arch/cfi_regs.h>
+
+/* Hack needed to avoid depending on debug-monitors.h */
+#define AARCH64_BREAK_FAULT	0xBAD
+
+/* Hack needed to avoid depending on kprobes.h */
+#ifndef __kprobes
+#define __kprobes
+#endif
+
+#include "../../../arch/arm64/lib/insn.c"
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case AARCH64_INSN_REG_19:
+	case AARCH64_INSN_REG_20:
+	case AARCH64_INSN_REG_21:
+	case AARCH64_INSN_REG_22:
+	case AARCH64_INSN_REG_23:
+	case AARCH64_INSN_REG_24:
+	case AARCH64_INSN_REG_25:
+	case AARCH64_INSN_REG_26:
+	case AARCH64_INSN_REG_27:
+	case AARCH64_INSN_REG_28:
+	case AARCH64_INSN_REG_FP:
+	case AARCH64_INSN_REG_LR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+}
+
+unsigned long arch_dest_reloc_offset(int addend)
+{
+	return addend;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->immediate;
+}
+
+const char *arch_nop_insn(int len)
+{
+	static u32 nop = 0;
+
+	if (len != AARCH64_INSN_SIZE)
+		WARN("invalid NOP size: %d\n", len);
+
+	if (!nop)
+		nop = aarch64_insn_gen_nop();
+
+	return (const char*)&nop;
+}
+
+static int is_arm64(const struct elf *elf)
+{
+	switch (elf->ehdr.e_machine) {
+	case EM_AARCH64: //0xB7
+		return 1;
+	default:
+		WARN("unexpected ELF machine type %x",
+		     elf->ehdr.e_machine);
+		return 0;
+	}
+}
+
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
+{
+	return -1;
+}
+
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    unsigned int *len, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	u32 insn;
+
+	if (!is_arm64(elf))
+		return -1;
+
+	if (maxlen < AARCH64_INSN_SIZE)
+		return 0;
+
+	*len = AARCH64_INSN_SIZE;
+	*immediate = 0;
+
+	insn = *(u32 *)(sec->data->d_buf + offset);
+
+	switch (aarch64_get_insn_class(insn)) {
+	case AARCH64_INSN_CLS_UNKNOWN:
+		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
+		return -1;
+	default:
+		*type = INSN_OTHER;
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/arch/cfi_regs.h b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
new file mode 100644
index 000000000000..a5185649686b
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#include <asm/insn.h>
+
+#define CFI_BP			AARCH64_INSN_REG_FP
+#define CFI_RA			AARCH64_INSN_REG_LR
+#define CFI_SP			AARCH64_INSN_REG_SP
+
+#define CFI_NUM_REGS		32
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/arm64/include/arch/elf.h b/tools/objtool/arch/arm64/include/arch/elf.h
new file mode 100644
index 000000000000..a31a29b1a386
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/elf.h
@@ -0,0 +1,6 @@
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NONE R_AARCH64_NONE
+
+#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/arm64/include/arch/endianness.h b/tools/objtool/arch/arm64/include/arch/endianness.h
new file mode 100644
index 000000000000..7c362527da20
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/arm64/include/arch/special.h b/tools/objtool/arch/arm64/include/arch/special.h
new file mode 100644
index 000000000000..a82a9b3e51df
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/special.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ARM64_ARCH_SPECIAL_H
+#define _ARM64_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		8
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		12
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _ARM64_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
new file mode 100644
index 000000000000..45f283283091
--- /dev/null
+++ b/tools/objtool/arch/arm64/special.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <objtool/special.h>
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+}
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	return false;
+}
+
+
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				     struct instruction *insn)
+{
+	return NULL;
+}
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 606a4b5e929f..04dcffd04937 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -21,6 +21,11 @@ arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
 arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
 arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+elif [ "$SRCARCH" = "arm64" ]; then
+FILES="$FILES
+arch/arm64/include/asm/insn.h
+arch/arm64/lib/insn.c         -I '^#include [\"<]\(asm/\)*kprobes.h[\">]' -I '^#include [\"<]\(asm/\)*debug-monitors.h[\">]'
+"
 fi
 
 check_2 () {
-- 
2.25.4

