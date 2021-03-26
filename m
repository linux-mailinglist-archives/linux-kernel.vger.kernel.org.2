Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120634AB46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCZPQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhCZPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:15:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DC1C0613B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mlawxaQEjlVFjkh/0c2ZF+dfrWW3ULJVtwgo4t1sgqU=; b=r/+7vPCL/HFz7EFvFP1yzRKmMA
        +Qx/AkPi92+A/L2ORIxHZt7wT1DRtHE67rEDSrQiW/MrM94Vyhc6qryq+sTl/6V3YOiIKAyklETgj
        p8BbVgm9Oe37FnytYjkx7QGL7Eoq/Dgju4So5sfRRPwGmI7MX6SGPvcKDXGMVNthejqmRw3B586ZW
        7j1tS+lK8QZtXacwWb/bj+X7M+DNfCwuI+om8enm24PlnC38NBPaRydebYe69JDpTV36SchodCufp
        O0p78qWCnR6LYbreJ8kJzV6Mv/PNsAcMSjSoCvvQpQh00lSLohdzjPUjuVWUFbJnkHoDZqQOBK4wX
        cC9m43WA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPo9Y-00F0oY-Eu; Fri, 26 Mar 2021 15:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6592307976;
        Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5834C2BD73399; Fri, 26 Mar 2021 16:13:34 +0100 (CET)
Message-ID: <20210326151259.880174448@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 16:12:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3 09/16] objtool: Implicitly create reloc sections
References: <20210326151159.128534163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have elf_add_reloc() create the relocation section implicity.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |    6 ------
 tools/objtool/elf.c                 |    9 ++++++++-
 tools/objtool/include/objtool/elf.h |    1 -
 tools/objtool/orc_gen.c             |    2 --
 4 files changed, 8 insertions(+), 10 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -459,9 +459,6 @@ static int create_static_call_sections(s
 	if (!sec)
 		return -1;
 
-	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
-		return -1;
-
 	idx = 0;
 	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
 
@@ -547,9 +544,6 @@ static int create_mcount_loc_sections(st
 	if (!sec)
 		return -1;
 
-	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
-		return -1;
-
 	idx = 0;
 	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
 
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -447,11 +447,18 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
+static struct section *elf_create_reloc_section(struct elf *elf,
+						struct section *base,
+						int reltype);
+
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, int addend)
 {
 	struct reloc *reloc;
 
+	if (!sec->reloc && !elf_create_reloc_section(elf, sec, SHT_RELA))
+		return -1;
+
 	reloc = malloc(sizeof(*reloc));
 	if (!reloc) {
 		perror("malloc");
@@ -829,7 +836,7 @@ static struct section *elf_create_rela_r
 	return sec;
 }
 
-struct section *elf_create_reloc_section(struct elf *elf,
+static struct section *elf_create_reloc_section(struct elf *elf,
 					 struct section *base,
 					 int reltype)
 {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -122,7 +122,6 @@ static inline u32 reloc_hash(struct relo
 
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
-struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, int addend);
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -225,8 +225,6 @@ int orc_create(struct objtool_file *file
 	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
 	if (!sec)
 		return -1;
-	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
-		return -1;
 
 	/* Write ORC entries to sections: */
 	list_for_each_entry(entry, &orc_list, list) {


