Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0471B433CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhJSQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhJSQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634662024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lzv/d7dwj9b7gfvOyidWoFUoke+ufBy0z3ny1vSzmxI=;
        b=NjCCZZ1jmiWEaeUg6JlotYMh4lgmMz5D4NMLur4JLX2GbE9rmTPLW2oapSZMP8gej1NYJs
        fG6Ic/X+Tw4c/P+VrhLUdErFhYDngmEc2fmtpndXKU6+G8yM8Ek6payPvg7992U7Hnnk1q
        m2qdLX1PRcTy5t/K7R7l2xvxTg0tBrY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-BVeI1bh9NRCWMy26B9yM1A-1; Tue, 19 Oct 2021 12:47:03 -0400
X-MC-Unique: BVeI1bh9NRCWMy26B9yM1A-1
Received: by mail-qv1-f69.google.com with SMTP id t12-20020a05621421ac00b00382ea49a7cbso499367qvc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lzv/d7dwj9b7gfvOyidWoFUoke+ufBy0z3ny1vSzmxI=;
        b=DCsdj3mZL6/zEXKdpvKxZkLrUAo2pZjls5W+G4CZ7Gm9BL4YcWh+dQyAr851vjZYVA
         6Ih8jCBSAYMY1nAWqntoDSpXord5DKXsopKpdJQ989pxwukRZQUIdlTIcT7zHFbfuluz
         OvgpI0bbJ2DIiWo5iqicFtPWbQUuq7SQt7/h0No5mtQ63uvd7osk9ayvgCavQ/Z8+CXV
         1P8jeaPvqwd2GCQRdGaJgL3OGnnReKcri6dz7UAHp39JyXnFG4s1UUfaVu6EWXacTAQn
         0p+qaSQshHCdJN8lO3Yra7BsBvcXDddL4LcCvJOQt6gU45UhBjIGnQdxDsZY0CvJLUYm
         Frlg==
X-Gm-Message-State: AOAM531IKGgfb3yLwtDqhFve3kH4G27TexuVu0Ler4a93FomVEMLGKeb
        ZI0KzRn0DXl9vxWCb/P0t5Jz3NfaUQ1sfQ1Tsue1ZE3C3PQK9z01Wui0VfGf9B2G9Me1mi1GzaX
        CKN5VsB7IHEJeQOgneYFgTPQ4
X-Received: by 2002:a37:54a:: with SMTP id 71mr929481qkf.230.1634662022391;
        Tue, 19 Oct 2021 09:47:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPHoM5Dd54iWKJQ89J0WWJhCy6bGWCJQe0q4CWyYS5eBiH+Y1OVQkRx3+XvnOOhY7QICFI/Q==
X-Received: by 2002:a37:54a:: with SMTP id 71mr929454qkf.230.1634662022099;
        Tue, 19 Oct 2021 09:47:02 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 201sm8443871qkh.43.2021.10.19.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:47:01 -0700 (PDT)
Date:   Tue, 19 Oct 2021 09:46:59 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211019164659.dybir4wgfmdt4r47@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013205259.44cvvaxiexiff5w5@treble>
 <YW6t5catO1mx+eCZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW6t5catO1mx+eCZ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 01:37:09PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 01:52:59PM -0700, Josh Poimboeuf wrote:
> 
> > BTW, CALL_NOSPEC results in a retpoline site in .altinstr_replacement:
> > 
> > Relocation section [40] '.rela.retpoline_sites' for section [39] '.retpoline_sites' at offset 0x8d28 contains 1 entry:
> >   Offset              Type            Value               Addend Name
> >   000000000000000000  X86_64_PC32     000000000000000000     +10 .altinstr_replacement
> > 
> > Which I assume we don't want.
> 
> (I missed this initially, and just independently rediscovered it)
> 
> In principle this problem affects static_call_list, the __sanitizer_cov_
> and __fentry__ and now retpoline_sites.
> 
> Granted, it seems really unlikely to find __fentry__ or __sanitizer_cov_
> references in alternatives, but it should be trivial to manually create
> one.
> 
> I'm thinking we want to exclude all those when found in
> .altinstr_replacement, right? It just doesn't make sense to rewrite
> replacement text.

Right.

(Someday, if it made sense to do so, objtool could put the annotation at
the original replaced instruction.  Then the kernel self-patching code
could run after alternatives patching and could then decide whether the
annotation is relevant or not.  But right now I can't think of any
scenario where that would be remotely sane.)

> How is something like the below? (I'm not completely happy with it, but
> I couldn't think of something better either).

How about something like this?

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c865a10372a..90d51c294034 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -993,18 +993,31 @@ static void remove_insn_ops(struct instruction *insn)
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
+	if (!insn->call_dest)
+		return;
+
+	/*
+	 * Alternative replacement code is just template code which is
+	 * sometimes copied to the original instruction.  For now, don't
+	 * annotate it.  (In the future we might consider annotating the
+	 * original instruction if/when it ever makes sense to do so.)
+	 */
+	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
+		return;
+
+	if (insn->call_dest->retpoline) {
+		list_add_tail(&insn->call_node, &file->retpoline_call_list);
 		return;
+	}
 
 	if (insn->call_dest->static_call_tramp) {
-		list_add_tail(&insn->call_node,
-			      &file->static_call_list);
+		list_add_tail(&insn->call_node, &file->static_call_list);
+		return;
 	}
 
 	/*
@@ -1025,6 +1038,7 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 			               : arch_nop_insn(insn->len));
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+		return;
 	}
 
 	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
@@ -1042,9 +1056,17 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 
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
+
+	annotate_call_site(file, insn, sibling);
 
 	/*
 	 * Whatever stack impact regular CALLs have, should be undone
@@ -1053,7 +1075,9 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	 * Annotated intra-function calls retain the stack_ops but
 	 * are converted to JUMP, see read_intra_function_calls().
 	 */
-	remove_insn_ops(insn);
+	if (dest)
+		remove_insn_ops(insn);
+
 }
 
 /*
@@ -1077,7 +1101,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1087,9 +1111,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			else
 				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
 
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
+			add_call_dest(file, insn, reloc->sym, true);
 			insn->retpoline_safe = true;
 			continue;
 		} else if (insn->func) {
@@ -1218,20 +1240,14 @@ static int add_call_destinations(struct objtool_file *file)
 
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
@@ -1916,8 +1932,25 @@ static int read_static_call_tramps(struct objtool_file *file)
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
 
@@ -1980,13 +2013,16 @@ static int decode_sections(struct objtool_file *file)
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
 

