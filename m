Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D7934AB38
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCZPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCZPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5866C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lRJVuN5SNm42ulmHDQq0rFSR4dCPy/OGCrzKirUZcWE=; b=OkX5UXd5ALsR3hkMONhr1bKHXP
        uD0a41yz5lGik3LMA017V1XdhqvmXL0ocFZYLuQuvB8XarqDSfumOyq5p+2BgsR4rigPN7+1jANHL
        FHCLkLlBJEyLybnvFaxtO9S9fjJuzo3x2gJzNuAOuxeBGCb7maYKE4En/Yjeobo2J4kBhH80QDr1l
        aRKi8iUndQrJbnInp4K3209Ab+X5GLVGmoHlPB0FiGDeITHeAQOWZVMPl8zCIox54OC11Myt51Bcp
        FxF4c4jB0gPVre2y2G24/LG2Sbx00DATGw70DsDG8CBx+QT/+JbHNO6HpefK9MfsrW3PZsMcNFO+D
        8rjLEB7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Y-003s0S-Fb; Fri, 26 Mar 2021 15:13:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF2F53079B2;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 733C32BD7339D; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151300.130805730@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 13/16] objtool: Keep track of retpoline call sites
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide infrastructure for architectures to rewrite/augment compiler
generated retpoline calls. Similar to what we do for static_call()s,
keep track of the instructions that are retpoline calls.

Use the same list_head, since a retpoline call cannot also be a
static_call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                   |   34 +++++++++++++++++++++++++++-----
 tools/objtool/include/objtool/arch.h    |    2 +
 tools/objtool/include/objtool/check.h   |    2 -
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 5 files changed, 34 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -451,7 +451,7 @@ static int create_static_call_sections(s
 		return 0;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->static_call_list, static_call_node)
+	list_for_each_entry(insn, &file->static_call_list, call_node)
 		idx++;
 
 	sec = elf_create_section(file->elf, ".static_call_sites", SHF_WRITE,
@@ -460,7 +460,7 @@ static int create_static_call_sections(s
 		return -1;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
+	list_for_each_entry(insn, &file->static_call_list, call_node) {
 
 		site = (struct static_call_site *)sec->data->d_buf + idx;
 		memset(site, 0, sizeof(struct static_call_site));
@@ -829,13 +829,16 @@ static int add_jump_destinations(struct
 			else
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
+			list_add_tail(&insn->call_node,
+				      &file->retpoline_call_list);
+
 			insn->retpoline_safe = true;
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
 			insn->call_dest = reloc->sym;
 			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
+				list_add_tail(&insn->call_node,
 					      &file->static_call_list);
 			}
 			continue;
@@ -897,7 +900,7 @@ static int add_jump_destinations(struct
 				/* internal sibling call (without reloc) */
 				insn->call_dest = insn->jump_dest->func;
 				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->static_call_node,
+					list_add_tail(&insn->call_node,
 						      &file->static_call_list);
 				}
 			}
@@ -981,6 +984,9 @@ static int add_call_destinations(struct
 			insn->type = INSN_CALL_DYNAMIC;
 			insn->retpoline_safe = true;
 
+			list_add_tail(&insn->call_node,
+				      &file->retpoline_call_list);
+
 			remove_insn_ops(insn);
 			continue;
 
@@ -988,7 +994,7 @@ static int add_call_destinations(struct
 			insn->call_dest = reloc->sym;
 
 		if (insn->call_dest && insn->call_dest->static_call_tramp) {
-			list_add_tail(&insn->static_call_node,
+			list_add_tail(&insn->call_node,
 				      &file->static_call_list);
 		}
 
@@ -1714,6 +1720,11 @@ static void mark_rodata(struct objtool_f
 	file->rodata = found;
 }
 
+__weak int arch_rewrite_retpolines(struct objtool_file *file)
+{
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -1742,6 +1753,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_special_section_alts() as that depends on
+	 * jump_dest being set.
+	 */
 	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
@@ -1778,6 +1793,15 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be after add_special_section_alts(), since this will emit
+	 * alternatives. Must be after add_{jump,call}_destination(), since
+	 * those create the call insn lists.
+	 */
+	ret = arch_rewrite_retpolines(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -87,4 +87,6 @@ int arch_decode_hint_reg(struct instruct
 
 bool arch_is_retpoline(struct symbol *sym);
 
+int arch_rewrite_retpolines(struct objtool_file *file);
+
 #endif /* _ARCH_H */
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -39,7 +39,7 @@ struct alt_group {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
-	struct list_head static_call_node;
+	struct list_head call_node;
 	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -18,6 +18,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head retpoline_call_list;
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -125,6 +125,7 @@ struct objtool_file *objtool_open_read(c
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");


