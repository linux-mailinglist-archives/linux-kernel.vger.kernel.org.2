Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE7434998
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJTLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhJTLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:03:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D50C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uAUto2Sxvin+ttUbLDoqoG+FsA166sSIIPmSogsiaNc=; b=NPNKIMsxETeKEALs8Nk+LRh9IK
        5MHXWnshZZSB3ZgcTjIiqgw0uYNN/79p/hSnaGrs3zCnnVgQy8fyHigALLFv1pT55C8uCG+Zuz2gI
        oHeq5u4cL447rPtemf/v1oqi0sibBRW1DSAznMAccfWvL2Af4EDU1DgUoDV65C14CM/uWCK1hMaeG
        IFZSqLTlwooLeQDAhLPMXIgVHTc0HvC9cJGiw+IEWBSGT/K7MEKUAtUTSlQRoO12QU6aYYOrL0Q9M
        6RiENacHDx32qXx3VZASl2/haoVSuW8L10nriqw5jygIahFsopMKF4eVQBVH0N+qoWm3lnVyyIcz+
        35BQNWfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L0-00Aw11-RS; Wed, 20 Oct 2021 11:00:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02DE1300221;
        Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DA2C0201BB3C5; Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Message-ID: <20211020105842.557458476@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 01/14] objtool: Tag retpoline thunk symbols
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid calling arch_is_retpoline() (which does a strcmp)
over and over on symbols, tag them once upfront.

XXX do we also want to do __fentry__ ?
XXX do we want an enum instead of a bunch of bools ?

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |   17 +++++++++++------
 tools/objtool/include/objtool/elf.h |    1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1077,7 +1077,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1218,7 +1218,7 @@ static int add_call_destinations(struct
 
 			add_call_dest(file, insn, dest, false);
 
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
@@ -1907,17 +1907,22 @@ static int read_intra_function_calls(str
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
 		}
 	}
 
@@ -1983,7 +1988,7 @@ static int decode_sections(struct objtoo
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
-	ret = read_static_call_tramps(file);
+	ret = classify_symbols(file);
 	if (ret)
 		return ret;
 
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -56,6 +56,7 @@ struct symbol {
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
 	bool static_call_tramp;
+	bool retpoline_thunk;
 	struct list_head pv_target;
 };
 


