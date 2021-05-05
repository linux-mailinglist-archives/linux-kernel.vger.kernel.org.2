Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F733733F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEEDjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:39:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:52495 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhEEDjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:39:39 -0400
IronPort-SDR: /HLzpGGbF72kfhaJEi0rK0WetM+Nw33vMOmngSAmzn/Y6GVeSXTyficseVABLaXfq0c8O+sHrl
 e07fRFWTXpQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196080593"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196080593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 20:38:43 -0700
IronPort-SDR: x9khEdArgVdtl18Y+8naJXPBOcGrztaLXVNZmdMVXxzpMAYU2k+Oz32Mo1ux/ettRdNapeCMhN
 uri3EDiHTxNg==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="531511854"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 20:38:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     jpoimboe@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] objtool: Allocate CFI state lazily
Date:   Tue,  4 May 2021 20:38:35 -0700
Message-Id: <20210505033835.1282751-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

objtool create a struct instruction for every instruction in the
objfile. This contains a full CFI state with space for all the
registers. On an allyesconfig build it uses roughly ~25GB altogether,
significantly more than gcc.

Not every instructions needs CFI state, it's only needed for
instructions that modify the stack. Allocate the CFI state lazily.

This shrinks the objtool peak from ~25GB to ~16GB or so. Still
too much, but somewhat of an improvement.

Cc: peterz@infradead.org
Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 tools/objtool/arch/x86/decode.c       |  7 +++++-
 tools/objtool/check.c                 | 34 ++++++++++++++++++---------
 tools/objtool/include/objtool/check.h |  4 +++-
 tools/objtool/orc_gen.c               | 15 ++++++++----
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 549813cff8ab..bcc92ca70dc9 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -613,7 +613,12 @@ const char *arch_nop_insn(int len)
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
-	struct cfi_reg *cfa = &insn->cfi.cfa;
+	struct cfi_reg *cfa;
+
+	if (sp_reg == ORC_REG_UNDEFINED && !insn->cfip)
+		return 0;
+
+	cfa = &insn_get_cfi(insn)->cfa;
 
 	switch (sp_reg) {
 	case ORC_REG_UNDEFINED:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5e5388a38e2a..cf292aafd2a4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -253,6 +253,20 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 		state->noinstr = sec->noinstr;
 }
 
+struct cfi_state *insn_get_cfi(struct instruction *insn)
+{
+	if (!insn->cfip) {
+		struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
+		if (!cfi) {
+			WARN("calloc failed");
+			exit(1);
+		}
+		init_cfi_state(cfi);
+		insn->cfip = cfi;
+	}
+	return insn->cfip;
+}
+
 /*
  * Call the arch-specific instruction decoder for all the instructions and add
  * them to the global instruction list.
@@ -289,7 +303,6 @@ static int decode_instructions(struct objtool_file *file)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1138,7 +1151,6 @@ static int handle_group_alt(struct objtool_file *file,
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
 		INIT_LIST_HEAD(&nop->stack_ops);
-		init_cfi_state(&nop->cfi);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -1557,7 +1569,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		insn->hint = true;
 
 		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
-			set_func_state(&insn->cfi);
+			set_func_state(insn_get_cfi(insn));
 			continue;
 		}
 
@@ -1567,9 +1579,9 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		insn->cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
-		insn->cfi.type = hint->type;
-		insn->cfi.end = hint->end;
+		insn_get_cfi(insn)->cfa.offset = bswap_if_needed(hint->sp_offset);
+		insn_get_cfi(insn)->type = hint->type;
+		insn_get_cfi(insn)->end = hint->end;
 	}
 
 	return 0;
@@ -2421,9 +2433,9 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
 	group_off = insn->offset - insn->alt_group->first_insn->offset;
 
 	if (!alt_cfi[group_off]) {
-		alt_cfi[group_off] = &insn->cfi;
+		alt_cfi[group_off] = insn_get_cfi(insn);
 	} else {
-		if (memcmp(alt_cfi[group_off], &insn->cfi, sizeof(struct cfi_state))) {
+		if (memcmp(alt_cfi[group_off], insn_get_cfi(insn), sizeof(struct cfi_state))) {
 			WARN_FUNC("stack layout conflict in alternatives",
 				  insn->sec, insn->offset);
 			return -1;
@@ -2472,7 +2484,7 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 
 static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 {
-	struct cfi_state *cfi1 = &insn->cfi;
+	struct cfi_state *cfi1 = insn_get_cfi(insn);
 	int i;
 
 	if (memcmp(&cfi1->cfa, &cfi2->cfa, sizeof(cfi1->cfa))) {
@@ -2694,9 +2706,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			state.instr += insn->instr;
 
 		if (insn->hint)
-			state.cfi = insn->cfi;
+			state.cfi = *insn_get_cfi(insn);
 		else
-			insn->cfi = state.cfi;
+			*insn_get_cfi(insn) = state.cfi;
 
 		insn->visited |= visited;
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index f5be798107bc..01b4a65c6fb1 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -59,9 +59,11 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
-	struct cfi_state cfi;
+	struct cfi_state *cfip;
 };
 
+extern struct cfi_state *insn_get_cfi(struct instruction *);
+
 static inline bool is_static_jump(struct instruction *insn)
 {
 	return insn->type == INSN_JUMP_CONDITIONAL ||
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 738aa5021bc4..7530a24ea179 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -13,13 +13,19 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
+static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
+			  struct instruction *insn)
 {
-	struct instruction *insn = container_of(cfi, struct instruction, cfi);
 	struct cfi_reg *bp = &cfi->regs[CFI_BP];
 
 	memset(orc, 0, sizeof(*orc));
 
+	if (!cfi) {
+		orc->end = 0;
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
+
 	orc->end = cfi->end;
 
 	if (cfi->cfa.base == CFI_UNDEFINED) {
@@ -179,7 +185,7 @@ int orc_create(struct objtool_file *file)
 			int i;
 
 			if (!alt_group) {
-				if (init_orc_entry(&orc, &insn->cfi))
+				if (init_orc_entry(&orc, insn->cfip, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
@@ -203,7 +209,8 @@ int orc_create(struct objtool_file *file)
 				struct cfi_state *cfi = alt_group->cfi[i];
 				if (!cfi)
 					continue;
-				if (init_orc_entry(&orc, cfi))
+				/* errors are reported on the original insn */
+				if (init_orc_entry(&orc, cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
-- 
2.25.4

