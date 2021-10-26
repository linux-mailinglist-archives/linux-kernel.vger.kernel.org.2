Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE943AD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhJZH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbhJZH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:57:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6BC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x9EV8p+NAc9sje+bBFNf8CFaMsrZWmsIgVDf3QEenKY=; b=fOFRN5nmT5MXiYaUAdPNYehCrR
        08WQkxQen3CJExvxVF2Zqw50RMCzOiUFhHuTpTL/FY1/WWgu1tnMVOQiXUAXCvYhUFfG88QSQu72B
        nJtl9n3qtABmwVbHwM2Eec+Pkk2UkpkwBkod8kIZkyIRDoy/w7z+/X6Iq+s+1abG6Un7ZVfjl/Q6h
        fdkPhE3W8xEsFvp21787SEkwPtzPA6xwNumMzH1fRPbsUH8k9f+FI/AFcbCsycCX/cWFoEsZnFay3
        YNMpZlRWfoHFPYokryq1Eg1jL+s9mnmYANLCbagDyvT/trDvJ0I8/+i3hfhDbvRrpbqXR84aNFnGq
        0Kzc4EZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfHIi-00CJno-Jw; Tue, 26 Oct 2021 07:55:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91D1E3001BF;
        Tue, 26 Oct 2021 09:55:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CB38203C8A8D; Tue, 26 Oct 2021 09:55:15 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:55:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 01/14] objtool: Tag retpoline thunk symbols
Message-ID: <YXe0Yyb6C2TwlqSR@hirez.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.557458476@infradead.org>
 <20211020151714.sf3wq4d7wuya5jbj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020151714.sf3wq4d7wuya5jbj@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:17:14AM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 20, 2021 at 12:44:43PM +0200, Peter Zijlstra wrote:
> > In order to avoid calling arch_is_retpoline() (which does a strcmp)
> > over and over on symbols, tag them once upfront.
> > 
> > XXX do we also want to do __fentry__ ?
> 
> Might as well.
> 
> > XXX do we want an enum instead of a bunch of bools ?
> 
> Maybe, or convert the bools to bit fields.

Like so then...

---
Subject: objtool: Classify symbols
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Oct 20 10:05:55 CEST 2021

In order to avoid calling str*cmp() on symbol names, over and over, do
them all once upfront and store the result.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |   34 ++++++++++++++++++++++------------
 tools/objtool/include/objtool/elf.h |    5 ++++-
 2 files changed, 26 insertions(+), 13 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1012,8 +1012,7 @@ static void add_call_dest(struct objtool
 	 * so they need a little help, NOP out any KCOV calls from noinstr
 	 * text.
 	 */
-	if (insn->sec->noinstr &&
-	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+	if (insn->sec->noinstr && insn->call_dest->kcov) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1027,7 +1026,7 @@ static void add_call_dest(struct objtool
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
 	}
 
-	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+	if (mcount && insn->call_dest->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -1077,7 +1076,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1218,7 +1217,7 @@ static int add_call_destinations(struct
 
 			add_call_dest(file, insn, dest, false);
 
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
@@ -1919,17 +1918,28 @@ static int read_intra_function_calls(str
 	return 0;
 }
 
-static int read_static_call_tramps(struct objtool_file *file)
+static int classify_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->bind == STB_GLOBAL &&
-			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+			if (func->bind != STB_GLOBAL)
+				continue;
+
+			if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
 				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
 				func->static_call_tramp = true;
+
+			if (arch_is_retpoline(func))
+				func->retpoline_thunk = true;
+
+			if (!strcmp(func->name, "__fentry__"))
+				func->fentry = true;
+
+			if (!strncmp(func->name, "__sanitizer_cov_", 16))
+				func->kcov = true;
 		}
 	}
 
@@ -1995,7 +2005,7 @@ static int decode_sections(struct objtoo
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
-	ret = read_static_call_tramps(file);
+	ret = classify_symbols(file);
 	if (ret)
 		return ret;
 
@@ -2053,9 +2063,9 @@ static int decode_sections(struct objtoo
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL && insn->call_dest &&
-	    insn->call_dest->type == STT_NOTYPE &&
-	    !strcmp(insn->call_dest->name, "__fentry__"))
+	if (insn->type == INSN_CALL &&
+	    insn->call_dest &&
+	    insn->call_dest->fentry)
 		return true;
 
 	return false;
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -55,7 +55,10 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
-	bool static_call_tramp;
+	u8 static_call_tramp : 1;
+	u8 retpoline_thunk   : 1;
+	u8 fentry            : 1;
+	u8 kcov              : 1;
 	struct list_head pv_target;
 };
 
