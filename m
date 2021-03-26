Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9674534AB35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhCZPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCZPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:13:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25BC0613B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZvoP37llgnNQa3vTxNbBa+XWHpX3096nmb77EAmORxs=; b=XGWyr+JCbyrmmWAhS78R+vpeqz
        atwMn/Cyp7gnHyAMceRzY/IPO/g7UlNuvrEIKeI+uNhWFvuDJ1pj1OTp4eX4No6PkSGs6ezJ8fDKk
        Nbn8fh0Nv07QLZQmsBsCR3MDRMprQaYa6Us0Vj/lD8szQ8eHl5p89YaTjBRs4c+Sg1JyWfRD5QIh7
        NQwPSHOJvzug8h5uXD9H47wP0mnayBt0C2ZKXP9wNtzvLWaAldn/DyucNyIZkClIly4lphY4BHhf4
        Ur3Ld6glJHSW8SLDe8HY+tSkLi/HoWrVgKd+KiqtX5qxtCXGyjuYiE+XemCXoME9eYbPZdWJ91UYL
        QKX2SdSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Y-003s0T-Fw; Fri, 26 Mar 2021 15:13:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B16583079C2;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7CC6B2BD7339E; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151300.195441549@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 14/16] objtool: Cache instruction relocs
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track the reloc of instructions to avoid having to look them up again
later.

(Technically x86 instructions can have two relocations, but not jumps
and calls, for which we're using this.)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |   28 ++++++++++++++++++++++------
 tools/objtool/include/objtool/check.h |    1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -803,6 +803,25 @@ __weak bool arch_is_retpoline(struct sym
 	return false;
 }
 
+#define NEGATIVE_RELOC	((void *)-1L)
+
+static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
+{
+	if (insn->reloc == NEGATIVE_RELOC)
+		return NULL;
+
+	if (!insn->reloc) {
+		insn->reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+						       insn->offset, insn->len);
+		if (!insn->reloc) {
+			insn->reloc = NEGATIVE_RELOC;
+			return NULL;
+		}
+	}
+
+	return insn->reloc;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -817,8 +836,7 @@ static int add_jump_destinations(struct
 		if (!is_static_jump(insn))
 			continue;
 
-		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-						 insn->offset, insn->len);
+		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_sec = insn->sec;
 			dest_off = arch_jump_destination(insn);
@@ -950,8 +968,7 @@ static int add_call_destinations(struct
 		if (insn->type != INSN_CALL)
 			continue;
 
-		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					       insn->offset, insn->len);
+		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_call_destination(insn->sec, dest_off);
@@ -1151,8 +1168,7 @@ static int handle_group_alt(struct objto
 		 * alternatives code can adjust the relative offsets
 		 * accordingly.
 		 */
-		alt_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-						   insn->offset, insn->len);
+		alt_reloc = insn_reloc(file, insn);
 		if (alt_reloc &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -56,6 +56,7 @@ struct instruction {
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
 	struct reloc *jump_table;
+	struct reloc *reloc;
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;


