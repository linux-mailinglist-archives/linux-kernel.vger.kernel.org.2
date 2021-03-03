Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56F32BFE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580356AbhCCSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236120AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmyQ1vLXbs33D+zQRSzuHol0axjSVg3bJx9Qi1M7Zos=;
        b=U8Ycl2g36K+0gBFMmkN3HW1h8fV/46/CvWuAbZSYkKsPLN8Br7cE18xgGco/lVsj+LVV6r
        kNeXIt/BM4qFa+Oi9ETO8pzitOibWeo3vkKk2ihHfW6Ju6+5eN83CJIDK3mfIhJ6MVNjsW
        TgneK/eeUOnYdO6SyWHH/zz1AV00cpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-72TiEZ1ANdWH4Bxj-by73Q-1; Wed, 03 Mar 2021 12:09:51 -0500
X-MC-Unique: 72TiEZ1ANdWH4Bxj-by73Q-1
Received: by mail-wr1-f72.google.com with SMTP id r12so8945834wro.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmyQ1vLXbs33D+zQRSzuHol0axjSVg3bJx9Qi1M7Zos=;
        b=uT6fvwTvCRAT+AAupKxDZVRyCrq4WRray1rdUrW9S4Z4QDn93uwnTNyEzBcYv7GyM5
         SLcw8lpYoFwAKwH9eT1TuzhPIp/egXnVMMQY+plF32vLx8cszgcD2C4wVl0O0Rs0xcx6
         WFnfatrNRNNS94lVlIyjzlSssE/DhDN2G1fcQgT3quTeDyNEUi8lamf459ffRN0fco+T
         qmXrM9pT84jI4lC/pHXGZ3iafA2ppYb0mh9+TlvsXcIMKgpFw6/jtkHyErAkrx1UDqYt
         BxdTWDf04P6gpgSRxy0kjHXpAmR8dPFaisiK0fcIB9xy6UwbEa4WGyKrmoI9R4vXbHew
         2NKw==
X-Gm-Message-State: AOAM533LnD2qvKJW1pEM7/Y2vKPS4h4sYHRJJLxuFVnevObJU5FkfiA8
        kXux/rny4f+MxoTwR2aLf+J4/ItoWdwD/ZBuj7n+SvS7/7my6W685BAe+Z1ieQu6UQ0jnItB+ns
        3E/9KZa8ZAf2gon/njEHYm7m3FlQo2Sl8EU7rynNMzQ1eZVURjJqXEngirfRKNcoQZF51Xb5uwi
        nF
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr27277360wrw.415.1614791389750;
        Wed, 03 Mar 2021 09:09:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0XDBrMZxSsxp5+DNQ1w7VD9AfdFpKfYS/ZFMG6AdajjxP67bBEHBhvze93dzry0E16Kwh7A==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr27277334wrw.415.1614791389562;
        Wed, 03 Mar 2021 09:09:49 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:49 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 08/13] objtool: arm64: Decode load/store instructions
Date:   Wed,  3 Mar 2021 18:09:27 +0100
Message-Id: <20210303170932.1838634-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store operations and create corresponding stack_ops for
operations targetting SP or FP.

Operations storing/loading multiple registers are split into separate
stack_ops storing single registers.

Operations modifying the base register get an additional stack_op
for the register update. Since the atomic register(s) load/store + base
register update gets split into multiple operations, to make sure
objtool always sees a valid stack, consider store instruction to perform
stack allocations (i.e. modifying the base pointer before the storing)
and loads de-allocations (i.e. modifying the base pointer after the
load).

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 148 ++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 3008dcbb5e64..4e086d2251f5 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -105,6 +105,48 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 	return -1;
 }
 
+static struct stack_op *arm_make_store_op(enum aarch64_insn_register base,
+					  enum aarch64_insn_register reg,
+					  int offset)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	if (!op) {
+		WARN("calloc failed");
+		return NULL;
+	}
+	op->dest.type = OP_DEST_REG_INDIRECT;
+	op->dest.reg = base;
+	op->dest.offset = offset;
+	op->src.type = OP_SRC_REG;
+	op->src.reg = reg;
+	op->src.offset = 0;
+
+	return op;
+}
+
+static struct stack_op *arm_make_load_op(enum aarch64_insn_register base,
+					 enum aarch64_insn_register reg,
+					 int offset)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	if (!op) {
+		WARN("calloc failed");
+		return NULL;
+	}
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = reg;
+	op->dest.offset = 0;
+	op->src.type = OP_SRC_REG_INDIRECT;
+	op->src.reg = base;
+	op->src.offset = offset;
+
+	return op;
+}
+
 static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
 					enum aarch64_insn_register src,
 					int val)
@@ -125,6 +167,101 @@ static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
 	return op;
 }
 
+static int arm_decode_load_store(u32 insn, enum insn_type *type,
+				 unsigned long *immediate,
+				 struct list_head *ops_list)
+{
+	enum aarch64_insn_register base;
+	enum aarch64_insn_register rt;
+	struct stack_op *op;
+	int size;
+	int offset;
+
+	*type = INSN_OTHER;
+
+	if (aarch64_insn_is_store_single(insn) ||
+	    aarch64_insn_is_load_single(insn))
+		size = 1 << ((insn & GENMASK(31, 30)) >> 30);
+	else
+		size = 4 << ((insn >> 31) & 1);
+
+	if (aarch64_insn_is_store_imm(insn) || aarch64_insn_is_load_imm(insn))
+		*immediate = size * aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12,
+								  insn);
+	else if (aarch64_insn_is_store_pre(insn) ||
+		 aarch64_insn_is_load_pre(insn) ||
+		 aarch64_insn_is_store_post(insn) ||
+		 aarch64_insn_is_load_post(insn))
+		*immediate = sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_9,
+								       insn),
+					 9);
+	else if (aarch64_insn_is_stp(insn) || aarch64_insn_is_ldp(insn) ||
+		 aarch64_insn_is_stp_pre(insn) ||
+		 aarch64_insn_is_ldp_pre(insn) ||
+		 aarch64_insn_is_stp_post(insn) ||
+		 aarch64_insn_is_ldp_post(insn))
+		*immediate = size * sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7,
+									      insn),
+						7);
+	else
+		return 1;
+
+	base = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
+	if (base != AARCH64_INSN_REG_FP && base != AARCH64_INSN_REG_SP)
+		return 0;
+
+	offset = *immediate;
+
+	if (aarch64_insn_is_store_pre(insn) || aarch64_insn_is_stp_pre(insn) ||
+	    aarch64_insn_is_store_post(insn) || aarch64_insn_is_stp_post(insn)) {
+		op = arm_make_add_op(base, base, *immediate);
+		list_add_tail(&op->list, ops_list);
+
+		if (aarch64_insn_is_store_post(insn) || aarch64_insn_is_stp_post(insn))
+			offset = -*immediate;
+		else
+			offset = 0;
+	} else if (aarch64_insn_is_load_post(insn) || aarch64_insn_is_ldp_post(insn)) {
+		offset = 0;
+	}
+
+	/* First register */
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	if (aarch64_insn_is_store_single(insn) ||
+	    aarch64_insn_is_store_pair(insn))
+		op = arm_make_store_op(base, rt, offset);
+	else
+		op = arm_make_load_op(base, rt, offset);
+
+	if (!op)
+		return -1;
+	list_add_tail(&op->list, ops_list);
+
+	/* Second register (if present) */
+	if (aarch64_insn_is_store_pair(insn) ||
+	    aarch64_insn_is_load_pair(insn)) {
+		rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT2,
+						  insn);
+		if (aarch64_insn_is_store_pair(insn))
+			op = arm_make_store_op(base, rt, offset + size);
+		else
+			op = arm_make_load_op(base, rt, offset + size);
+		if (!op)
+			return -1;
+		list_add_tail(&op->list, ops_list);
+	}
+
+	if (aarch64_insn_is_load_pre(insn) || aarch64_insn_is_ldp_pre(insn) ||
+	    aarch64_insn_is_load_post(insn) || aarch64_insn_is_ldp_post(insn)) {
+		op = arm_make_add_op(base, base, *immediate);
+		if (!op)
+			return -1;
+		list_add_tail(&op->list, ops_list);
+	}
+
+	return 0;
+}
+
 static int arm_decode_add_sub_imm(u32 instr, bool set_flags,
 				  enum insn_type *type,
 				  unsigned long *immediate,
@@ -244,6 +381,17 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			*type = INSN_OTHER;
 		}
 		break;
+	case AARCH64_INSN_CLS_LDST:
+	{
+		int ret;
+
+		ret = arm_decode_load_store(insn, type, immediate, ops_list);
+		if (ret <= 0)
+			return ret;
+
+		*type = INSN_OTHER;
+		break;
+	}
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

