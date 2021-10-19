Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86B6433CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJSQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232355AbhJSQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634662159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugUw7NsAv0YfUcAT0Sk5/LXb2GdlYXRM+aaTlkyR4sM=;
        b=h4kY83wQ2fqgHLT8BqU4G0thBmkB9KNqmHq09nJUtyvxXMMLQzUhhi4bXnre6d/WfWZnE7
        fqc76hc7IjXwX/N8mhL2XwDJuYKxFqygXiMJEWZuVHrFVUYympDBOrScpT0l/0cOU2K5Eg
        Ng00dy6JVI3GbD932TKO+Q41RyHMvgw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-lhwwvq8VOwW0P839LDtEQQ-1; Tue, 19 Oct 2021 12:49:17 -0400
X-MC-Unique: lhwwvq8VOwW0P839LDtEQQ-1
Received: by mail-qk1-f197.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so390702qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugUw7NsAv0YfUcAT0Sk5/LXb2GdlYXRM+aaTlkyR4sM=;
        b=W3YEwwgZliZCoamdbY4BWUE6kKBQAHIPsxruHhE+l3saEwxzHKxvCi+dZVb8kWXoWR
         +WyGxzHiRSWmEOiagd3cMyXXMp/oV0KB4JbxN5Y2umt4QyA7FoEGqj5HzgOWwue86/3g
         UmAvJ7s8UR+AKQrC0/AQb+83fSI4J9JCF19xC01qAcG7h97OamcoWlrDzxf/KkWW7TKB
         ig6sQosEyuL+2dUlegrDh9+abnGloYijzE78y4xEsK3WR705bzSC8CEikMewTogu3c1Q
         AG/VpMRXte1tRFN8SBYcgcOau8BFWCUsvla3ZzgH7Lg3cc78LcjQ49yjVrMUwdqT1uPJ
         adFA==
X-Gm-Message-State: AOAM532/TDhTWQjielTLTKVOjVoPG3e1/J0Z/NVETVKD3zZ3+k/Z4YhP
        n4Ld0sh9+CoFZpdV8oRIonFWJCIDwnpi8qW+fAL1tHCT2p90aB9IStcc5eQOlimF8gSlCQoelix
        32/KsXQB967hz4cjRafdyltuz
X-Received: by 2002:a05:622a:60d:: with SMTP id z13mr1159968qta.37.1634662157224;
        Tue, 19 Oct 2021 09:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjwcryOdnVEZWlyZQvaraaUsm0A6UmRp1D8DrlMtaafpYAxKmebRga+vlKlVHhIgp+10j8rw==
X-Received: by 2002:a05:622a:60d:: with SMTP id z13mr1159946qta.37.1634662156952;
        Tue, 19 Oct 2021 09:49:16 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id v7sm8104656qkd.41.2021.10.19.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:49:16 -0700 (PDT)
Date:   Tue, 19 Oct 2021 09:49:13 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211019164913.2dsyyethdeblqjlq@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013205259.44cvvaxiexiff5w5@treble>
 <YW6t5catO1mx+eCZ@hirez.programming.kicks-ass.net>
 <20211019164659.dybir4wgfmdt4r47@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019164659.dybir4wgfmdt4r47@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 09:47:02AM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 19, 2021 at 01:37:09PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 13, 2021 at 01:52:59PM -0700, Josh Poimboeuf wrote:
> > 
> > > BTW, CALL_NOSPEC results in a retpoline site in .altinstr_replacement:
> > > 
> > > Relocation section [40] '.rela.retpoline_sites' for section [39] '.retpoline_sites' at offset 0x8d28 contains 1 entry:
> > >   Offset              Type            Value               Addend Name
> > >   000000000000000000  X86_64_PC32     000000000000000000     +10 .altinstr_replacement
> > > 
> > > Which I assume we don't want.
> > 
> > (I missed this initially, and just independently rediscovered it)
> > 
> > In principle this problem affects static_call_list, the __sanitizer_cov_
> > and __fentry__ and now retpoline_sites.
> > 
> > Granted, it seems really unlikely to find __fentry__ or __sanitizer_cov_
> > references in alternatives, but it should be trivial to manually create
> > one.
> > 
> > I'm thinking we want to exclude all those when found in
> > .altinstr_replacement, right? It just doesn't make sense to rewrite
> > replacement text.
> 
> Right.
> 
> (Someday, if it made sense to do so, objtool could put the annotation at
> the original replaced instruction.  Then the kernel self-patching code
> could run after alternatives patching and could then decide whether the
> annotation is relevant or not.  But right now I can't think of any
> scenario where that would be remotely sane.)
> 
> > How is something like the below? (I'm not completely happy with it, but
> > I couldn't think of something better either).
> 
> How about something like this?

Slightly improved version:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c865a10372a..e0892632ef4a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -993,18 +993,28 @@ static void remove_insn_ops(struct instruction *insn)
 	}
 }
 
-static void add_call_dest(struct objtool_file *file, struct instruction *insn,
-			  struct symbol *dest, bool sibling)
+static void annotate_call_site(struct objtool_file *file,
+			       struct instruction *insn, bool sibling)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
 
-	insn->call_dest = dest;
-	if (!dest)
+	/*
+	 * Alternative replacement code is just template code which is
+	 * sometimes copied to the original instruction.  For now, don't
+	 * annotate it.  (In the future we might consider annotating the
+	 * original instruction if/when it ever makes sense to do so.)
+	 */
+	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
 		return;
 
+	if (insn->call_dest->retpoline) {
+		list_add_tail(&insn->call_node, &file->retpoline_call_list);
+		return;
+	}
+
 	if (insn->call_dest->static_call_tramp) {
-		list_add_tail(&insn->call_node,
-			      &file->static_call_list);
+		list_add_tail(&insn->call_node, &file->static_call_list);
+		return;
 	}
 
 	/*
@@ -1025,6 +1035,7 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 			               : arch_nop_insn(insn->len));
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+		return;
 	}
 
 	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
@@ -1042,9 +1053,19 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 
 		insn->type = INSN_NOP;
 
-		list_add_tail(&insn->mcount_loc_node,
-			      &file->mcount_loc_list);
+		list_add_tail(&insn->mcount_loc_node, &file->mcount_loc_list);
+		return;
 	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+			  struct symbol *dest, bool sibling)
+{
+	insn->call_dest = dest;
+	if (!dest)
+		return;
+
+	annotate_call_site(file, insn, sibling);
 
 	/*
 	 * Whatever stack impact regular CALLs have, should be undone
@@ -1054,6 +1075,7 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	 * are converted to JUMP, see read_intra_function_calls().
 	 */
 	remove_insn_ops(insn);
+
 }
 
 /*
@@ -1077,7 +1099,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1087,9 +1109,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			else
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
+			add_call_dest(file, insn, reloc->sym, true);
 			insn->retpoline_safe = true;
 			continue;
 		} else if (insn->func) {
@@ -1218,20 +1238,14 @@ static int add_call_destinations(struct objtool_file *file)
 
 			add_call_dest(file, insn, dest, false);
 
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
 			 */
 			insn->type = INSN_CALL_DYNAMIC;
+			add_call_dest(file, insn, reloc->sym, false);
 			insn->retpoline_safe = true;
-
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
-			remove_insn_ops(insn);
-			continue;
-
 		} else
 			add_call_dest(file, insn, reloc->sym, false);
 	}
@@ -1916,8 +1930,25 @@ static int read_static_call_tramps(struct objtool_file *file)
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->bind == STB_GLOBAL &&
 			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
-				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
+				     strlen(STATIC_CALL_TRAMP_PREFIX_STR))) {
 				func->static_call_tramp = true;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int read_retpoline_thunks(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *func;
+
+	for_each_sec(file, sec) {
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->bind == STB_GLOBAL && arch_is_retpoline(func)) {
+				func->retpoline = true;
+			}
 		}
 	}
 
@@ -1980,13 +2011,16 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	/*
-	 * Must be before add_{jump_call}_destination.
-	 */
+	/* Must be before add_{jump_call}_destination. */
 	ret = read_static_call_tramps(file);
 	if (ret)
 		return ret;
 
+	/* Must be before add_{jump_call}_destination. */
+	ret = read_retpoline_thunks(file);
+	if (ret)
+		return ret;
+
 	/*
 	 * Must be before add_special_section_alts() as that depends on
 	 * jump_dest being set.
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9bdc7c757bf8..b773366dfb52 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -56,6 +56,7 @@ struct symbol {
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
 	bool static_call_tramp;
+	bool retpoline;
 	struct list_head pv_target;
 };
 

