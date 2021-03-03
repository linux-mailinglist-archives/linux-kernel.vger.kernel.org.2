Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158C432BFDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580316AbhCCSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234874AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRmeHncs6ezc68w5bwY/D71XAF3BdqJ0pJWy8Obs2Tk=;
        b=dxVmZ+k8tUIGPyP5iihTUIQ+niANrQpgSZaP2O4HJLYWpFiUmjmgVf80oO/SiqyuwqAHn7
        mi2lPokoLVv/mZ0pkVgVEF7vrCRcxHm24byfpU2Pm5YED99rIq2HMRF6h5hiMWM+QmzoF/
        KjWNaNS+Ot1XRnVZxMmpSMsBcsWg0+Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-8G198FyGP3K5oKuo1ZHq1g-1; Wed, 03 Mar 2021 12:09:46 -0500
X-MC-Unique: 8G198FyGP3K5oKuo1ZHq1g-1
Received: by mail-wr1-f72.google.com with SMTP id v1so2494140wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRmeHncs6ezc68w5bwY/D71XAF3BdqJ0pJWy8Obs2Tk=;
        b=p4qdKIW1J495vTI6bDhSgrVdEUy7NH4+9Vea0GJX8L4y4LjC5e7jPMCuxRIDsN8W7t
         AwijZfRSk1K+u1bYz5uBK+ZgxtVWy9rLKl95Nt4n+v0Vf5JKbll978VaWU5hzhRg0j+O
         RZm/wQ0pFuX/R1YA9kyJ7LM7WufUzNDMm6v9tKph6zlVi2mOQ9dcPzLnl4dxvW+wq2gH
         Nx8l+IAgGrTDOUlEopdGbemrIffLbf+TkelgsBSbVIfdiIh4JhNB3pGFVWmhWPgTtu7B
         iymDxb3FHgwQnldYKfiGvfZTaoNM9P3X0YLdYGdF7fdfUXO1bQAU7xXNg1HsJ3ngx6RZ
         ji4Q==
X-Gm-Message-State: AOAM531nUEYWI82IeUyxx3UY817H6uRK5khS4gXxdO5Yb0mdFPSPxZin
        MPSLyT4fFfbQexj8DxWmmsjsAs1F6G6ukyXRSn43ztDxbTLC4Z2hgwr2u3iNK0uNyKXH3UmyWRL
        YWq+s7yWfyBOsELG4px2sFvjsxOEL66wYaKMRzmS3ji3HhtvCjkT/JiJ7CCbc0IKgsiTaH3ZKVb
        wY
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr27521899wra.272.1614791385190;
        Wed, 03 Mar 2021 09:09:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLBLB5Lk8aQF0Nglz5/ZrWHAG0QUBwpg2ce/LTsqYabu/2WEp5jEOMEVwBmr4Dtzgc6p+Ixg==
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr27521875wra.272.1614791384974;
        Wed, 03 Mar 2021 09:09:44 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:44 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 05/13] objtool: arm64: Decode add/sub instructions
Date:   Wed,  3 Mar 2021 18:09:24 +0100
Message-Id: <20210303170932.1838634-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode aarch64 additions and substractions and create stack_ops for
instructions interacting with SP or FP.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 94 +++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 3ec0254f7306..54eeb8704a42 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -23,6 +23,13 @@
 
 #include "../../../arch/arm64/lib/insn.c"
 
+static unsigned long sign_extend(unsigned long x, int nbits)
+{
+	unsigned long sign_bit = (x >> (nbits - 1)) & 1;
+
+	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -98,6 +105,61 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 	return -1;
 }
 
+static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
+					enum aarch64_insn_register src,
+					int val)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	if (!op) {
+		WARN("calloc failed");
+		return NULL;
+	}
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = dest;
+	op->src.reg = src;
+	op->src.type = val != 0 ? OP_SRC_ADD : OP_SRC_REG;
+	op->src.offset = val;
+
+	return op;
+}
+
+static int arm_decode_add_sub_imm(u32 instr, bool set_flags,
+				  enum insn_type *type,
+				  unsigned long *immediate,
+				  struct list_head *ops_list)
+{
+	u32 rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, instr);
+	u32 rn = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, instr);
+
+	*type = INSN_OTHER;
+	*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, instr);
+
+	if (instr & AARCH64_INSN_LSL_12)
+		*immediate <<= 12;
+
+	if ((!set_flags && rd == AARCH64_INSN_REG_SP) ||
+	    rd == AARCH64_INSN_REG_FP ||
+	    rn == AARCH64_INSN_REG_FP ||
+	    rn == AARCH64_INSN_REG_SP) {
+		struct stack_op *op;
+		int value;
+
+		if (aarch64_insn_is_subs_imm(instr) || aarch64_insn_is_sub_imm(instr))
+			value = -*immediate;
+		else
+			value = *immediate;
+
+		op = arm_make_add_op(rd, rn, value);
+		if (!op)
+			return -1;
+		list_add_tail(&op->list, ops_list);
+	}
+
+	return 0;
+}
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -121,6 +183,38 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case AARCH64_INSN_CLS_UNKNOWN:
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
+	case AARCH64_INSN_CLS_DP_IMM:
+		/* Mov register to and from SP are aliases of add_imm */
+		if (aarch64_insn_is_add_imm(insn) ||
+		    aarch64_insn_is_sub_imm(insn))
+			return arm_decode_add_sub_imm(insn, false, type, immediate,
+						      ops_list);
+		else if (aarch64_insn_is_adds_imm(insn) ||
+			 aarch64_insn_is_subs_imm(insn))
+			return arm_decode_add_sub_imm(insn, true, type, immediate,
+						      ops_list);
+		else
+			*type = INSN_OTHER;
+		break;
+	case AARCH64_INSN_CLS_DP_REG:
+		if (aarch64_insn_is_mov_reg(insn)) {
+			enum aarch64_insn_register rd;
+			enum aarch64_insn_register rm;
+
+			rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
+			rm = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RM, insn);
+			if (rd == AARCH64_INSN_REG_FP || rm == AARCH64_INSN_REG_FP) {
+				struct stack_op *op;
+
+				op = arm_make_add_op(rd, rm, 0);
+				if (!op)
+					return -1;
+				list_add_tail(&op->list, ops_list);
+				break;
+			}
+		}
+		*type = INSN_OTHER;
+		break;
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

