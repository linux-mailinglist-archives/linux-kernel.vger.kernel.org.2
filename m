Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77C24334CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhJSLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:39:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDF6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bGnPWyU/ex0mrojfpq5huP+5pTxB1pC0VCVQxTYOlA0=; b=I505kGwju3lVF61pmKpyMc9oQa
        COXPFFb60sFt9MGVA+svsUr/TKzQpby/KimIrqtIDehXpLOiQ1wQK7EQ8pTYCUGpv6n3Db3e6Q7Ti
        7EcmWwH128bDCpZcvnOu1wk1AZbYgUbazD/I1YnZ4mJtnrmeBGNoioKSh+tT9UzzP0F0O9FtFD8Km
        ft3udazfQ7zzviRdFyA3nzHvRsHoYYCaeMztUqT613bHjdYU7i35xIpycsR3VTzK7I8+3Jf2RfrR+
        Z05dMybAC0sNWyIoSg+SPoy6otTDL5Na7cdJQ+cdwaaLmvkMsggFIEWGuOWSrbFKGanPmhTdiTLcA
        zzs8MfcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcnQc-00AlUX-5h; Tue, 19 Oct 2021 11:37:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42A6030024D;
        Tue, 19 Oct 2021 13:37:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 231ED21BE687A; Tue, 19 Oct 2021 13:37:09 +0200 (CEST)
Date:   Tue, 19 Oct 2021 13:37:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YW6t5catO1mx+eCZ@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013205259.44cvvaxiexiff5w5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013205259.44cvvaxiexiff5w5@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:52:59PM -0700, Josh Poimboeuf wrote:

> BTW, CALL_NOSPEC results in a retpoline site in .altinstr_replacement:
> 
> Relocation section [40] '.rela.retpoline_sites' for section [39] '.retpoline_sites' at offset 0x8d28 contains 1 entry:
>   Offset              Type            Value               Addend Name
>   000000000000000000  X86_64_PC32     000000000000000000     +10 .altinstr_replacement
> 
> Which I assume we don't want.

(I missed this initially, and just independently rediscovered it)

In principle this problem affects static_call_list, the __sanitizer_cov_
and __fentry__ and now retpoline_sites.

Granted, it seems really unlikely to find __fentry__ or __sanitizer_cov_
references in alternatives, but it should be trivial to manually create
one.

I'm thinking we want to exclude all those when found in
.altinstr_replacement, right? It just doesn't make sense to rewrite
replacement text.

How is something like the below? (I'm not completely happy with it, but
I couldn't think of something better either).

---
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1039,14 +1039,39 @@ static void remove_insn_ops(struct instr
 	}
 }
 
+#define DEST_RETPOLINE	((void *)-1L)
+
 static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 			  struct symbol *dest, bool sibling)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
 
-	insn->call_dest = dest;
-	if (!dest)
+	if (dest != DEST_RETPOLINE) {
+		insn->call_dest = dest;
+		if (!dest )
+			return;
+	}
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+
+	/*
+	 * Whatever we do, do not rewrite replacement text.
+	 */
+	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
+		return;
+
+	if (dest == DEST_RETPOLINE) {
+		list_add_tail(&insn->call_node,
+			      &file->retpoline_call_list);
 		return;
+	}
 
 	if (insn->call_dest->static_call_tramp) {
 		list_add_tail(&insn->call_node,
@@ -1091,15 +1116,6 @@ static void add_call_dest(struct objtool
 		list_add_tail(&insn->mcount_loc_node,
 			      &file->mcount_loc_list);
 	}
-
-	/*
-	 * Whatever stack impact regular CALLs have, should be undone
-	 * by the RETURN of the called function.
-	 *
-	 * Annotated intra-function calls retain the stack_ops but
-	 * are converted to JUMP, see read_intra_function_calls().
-	 */
-	remove_insn_ops(insn);
 }
 
 /*
@@ -1133,10 +1149,9 @@ static int add_jump_destinations(struct
 			else
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
 			insn->retpoline_safe = true;
+
+			add_call_dest(file, insn, DEST_RETPOLINE, true);
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
@@ -1272,12 +1287,7 @@ static int add_call_destinations(struct
 			insn->type = INSN_CALL_DYNAMIC;
 			insn->retpoline_safe = true;
 
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
-			remove_insn_ops(insn);
-			continue;
-
+			add_call_dest(file, insn, DEST_RETPOLINE, false);
 		} else
 			add_call_dest(file, insn, reloc->sym, false);
 	}
