Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD432C013
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580791AbhCCSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236154AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWFc5LkINmQGNoqDpICyJHLZ4ydJLXuT0gd8wTx9egU=;
        b=YeBpMTKQ2Z2G7LxeKZqzrygRoisXfMOseoy6U34xXqJ/B8UxKUfPIhigIAkRJYC1uaEFK3
        TUh39L+gODnjiZjiXlfXCOAUU+kY3XNzTHqLuCU7rD87TtDYdMrmeG8D6xvkrIGyUJ4tUF
        vQIZCtbncjTgBMDqoUu68ZPrG0EXFDM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-foDOB-7-MQGqzYs6S5jHUQ-1; Wed, 03 Mar 2021 12:09:52 -0500
X-MC-Unique: foDOB-7-MQGqzYs6S5jHUQ-1
Received: by mail-wr1-f69.google.com with SMTP id z6so4297742wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWFc5LkINmQGNoqDpICyJHLZ4ydJLXuT0gd8wTx9egU=;
        b=CSOkH6KfroOYa079B4Kn1woLhnbh9Va8QvBFRmQra8WsGu1t/KgSQJtb3xIcMDKisR
         QkIIbAQ45MJ2baqgRXpBsQ7o3aC1YyWhX+OlRWeLML8jA6V4TLLcQZp0JeD5E2AVPXNL
         L99SiDitQDEnBJ2gmzdbS3PnIg7l2k7nIRH5WZpHuYyAmJM1FZOxRJVvJfv2Sb6CEvgv
         1OCdKsmRCHAEAKpvisJsruCZXkOcjFd9p1qVbKK3GjEnVtYgJkwKtoMCZCXt8HD3eKZp
         EMt4gA8tnDdi2o7jDbMfThrIHDJEk47vYirPEB1GCxfhwZV2tcHr5lvsEDEuIy/NL3gc
         y1vg==
X-Gm-Message-State: AOAM530OMxc1LS/xBDPhitdyv9r5D4+2SOQxOn1breaah8PvB1kcoDQ1
        9ar1du/25YIHYPrJy6i/R7f+RkeuGLbboN/2/0r8xTj9qilJm3PZxxglRDHlZfH/uiZAfa6FZ9L
        NCt6ix9baSHl9KWJRDXA91PuVN1ChmEkqhLX5c0TyklxfWrDN1Y+/XieY8iEMSySHdzS0QwWBLi
        AS
X-Received: by 2002:adf:f841:: with SMTP id d1mr27888726wrq.36.1614791391446;
        Wed, 03 Mar 2021 09:09:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDCUZUG8mSoLXRPqSl8I/V8alKK6lYNpH2msZdC3D2Z/G3uqkfDbJx/aOBofOeSHgeyAmuew==
X-Received: by 2002:adf:f841:: with SMTP id d1mr27888704wrq.36.1614791391241;
        Wed, 03 Mar 2021 09:09:51 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:50 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 09/13] objtool: arm64: Decode LDR instructions
Date:   Wed,  3 Mar 2021 18:09:28 +0100
Message-Id: <20210303170932.1838634-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load literal instructions can generate constants inside code sections.
Record the locations of the constants in order to be able to remove
their corresponding "struct instruction".

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c    | 86 ++++++++++++++++++++++++++++
 tools/objtool/arch/x86/decode.c      |  5 ++
 tools/objtool/check.c                |  3 +
 tools/objtool/include/objtool/arch.h |  3 +
 4 files changed, 97 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 4e086d2251f5..b4631d79f13f 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -30,6 +30,73 @@ static unsigned long sign_extend(unsigned long x, int nbits)
 	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
 }
 
+struct insn_loc {
+	const struct section *sec;
+	unsigned long offset;
+	struct hlist_node hnode;
+	bool ignorable;
+};
+
+DEFINE_HASHTABLE(invalid_insns, 16);
+
+static int record_invalid_insn(const struct section *sec,
+			       unsigned long offset,
+			       bool ignore)
+{
+	struct insn_loc *loc;
+	struct hlist_head *l;
+
+	l = &invalid_insns[hash_min(offset, HASH_BITS(invalid_insns))];
+	if (!hlist_empty(l)) {
+		loc = hlist_entry(l->first, struct insn_loc, hnode);
+		loc->ignorable |= ignore;
+		return 0;
+	}
+
+	loc = malloc(sizeof(*loc));
+	if (!loc) {
+		WARN("malloc failed");
+		return -1;
+	}
+
+	loc->sec = sec;
+	loc->offset = offset;
+	loc->ignorable = ignore;
+
+	hash_add(invalid_insns, &loc->hnode, loc->offset);
+
+	return 0;
+}
+
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	struct hlist_node *tmp;
+	struct insn_loc *loc;
+	unsigned int bkt;
+	int res = 0;
+
+	hash_for_each_safe(invalid_insns, bkt, tmp, loc, hnode) {
+		struct instruction *insn;
+
+		insn = find_insn(file, (struct section *) loc->sec, loc->offset);
+		if (insn) {
+			if (loc->ignorable) {
+				list_del(&insn->list);
+				hash_del(&insn->hash);
+				free(insn);
+			} else {
+				WARN_FUNC("can't decode instruction", insn->sec, insn->offset);
+				return -1;
+			}
+		}
+
+		hash_del(&loc->hnode);
+		free(loc);
+	}
+
+	return res;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -389,6 +456,25 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (ret <= 0)
 			return ret;
 
+		if (aarch64_insn_is_ldr_lit(insn)) {
+			long pc_offset;
+
+			pc_offset = insn & GENMASK(23, 5);
+			/* Sign extend and multiply by 4 */
+			pc_offset = (pc_offset << (64 - 23));
+			pc_offset = ((pc_offset >> (64 - 23)) >> 5) << 2;
+
+			if (record_invalid_insn(sec, offset + pc_offset, true))
+				return -1;
+
+			/* 64-bit literal */
+			if (insn & BIT(30)) {
+				if (record_invalid_insn(sec,
+							offset + pc_offset + 4,
+							true))
+					return -1;
+			}
+		}
 		*type = INSN_OTHER;
 		break;
 	}
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 431bafb881d4..54f57bfd6f8f 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -619,6 +619,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	return 0;
 }
 
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	return 0;
+}
+
 void arch_initial_func_cfi_state(struct cfi_init_state *state)
 {
 	int i;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a0f762a15ad5..7750f6342855 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -325,6 +325,9 @@ static int decode_instructions(struct objtool_file *file)
 	if (stats)
 		printf("nr_insns: %lu\n", nr_insns);
 
+	if (arch_post_process_instructions(file))
+		return -1;
+
 	return 0;
 
 err:
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index ff21f387712d..6c61fc96ff00 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -65,6 +65,7 @@ struct stack_op {
 	struct list_head list;
 };
 
+struct objtool_file;
 struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
@@ -75,6 +76,8 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
 
+int arch_post_process_instructions(struct objtool_file *file);
+
 bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
-- 
2.25.4

