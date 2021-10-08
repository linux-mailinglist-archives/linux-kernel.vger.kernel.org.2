Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD8426810
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhJHKiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbhJHKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:38:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EAC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fOOXVLIjroz589bA9nEOA6Z/1zKHGta3sTBFeCArqKg=; b=qnErXajf+Tz1Aty0jWPJLkxZTL
        MRuyWm5kxdepoPJdv25zbmkIZ+M7goLOs+vxWx5yM6+GlNQDnuaK0fn8lcteA6tRPfBHfm7Pi5wNm
        yhm3exzOlkMLWh5wjEUzyXMXkrPZidQeIrUNK440bEzCx2BjcH1tb55B1sxpjfPEW0IOJk/mz6vXl
        6DIlpm0d5wG0waakYPoY5GkJcooP41mfJaQIALmhAm4oZpY6JGIOcq20jz/Mltn6nI8WNRgwwSjgb
        CWYQlpS8Pq3CsRWT3uF10wj/Lftj13SeKci0hmD7To0lW7Is6/jUDGqhnMc4W3Rf3QDRQ7hMKbUfA
        OQMZfhGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnDp-003022-OT; Fri, 08 Oct 2021 10:35:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFAB1300094;
        Fri,  8 Oct 2021 12:35:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C0362CFD3AED; Fri,  8 Oct 2021 12:35:25 +0200 (CEST)
Date:   Fri, 8 Oct 2021 12:35:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] objtool: Optimize/fix retpoline alternative
 generation
Message-ID: <YWAe7RSvYqdpbABf@hirez.programming.kicks-ass.net>
References: <20211007212211.366874577@infradead.org>
 <20211007212627.008917519@infradead.org>
 <20211008072325.4qujedsjtjqbvzrd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008072325.4qujedsjtjqbvzrd@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:23:25AM -0700, Josh Poimboeuf wrote:
> On Thu, Oct 07, 2021 at 11:22:13PM +0200, Peter Zijlstra wrote:
> > When re-running objtool it will generate alterantives for all
> 
> "alternatives"
> 
> > retpoline hunks, even if they are already present.
> > 
> > Discard the retpoline alternatives later so we can mark the
> 
> Discard? or mark as ignored?

I used 'discard' since we don't actually generate insn->alts entries.

> > +++ b/tools/objtool/check.c
> > @@ -1468,6 +1468,14 @@ static int add_special_section_alts(stru
> >  				ret = -1;
> >  				goto out;
> >  			}
> > +			/*
> > +			 * Skip (but mark) the retpoline alternatives so that we
> > +			 * don't generate them again.
> > +			 */
> 
> I'm having a lot of trouble following this comment.  In my half-sleeping
> state I'm theorizing this serves two purposes:
> 
>   1) skip validating the alt (because why?)
> 
>      and
> 
>   2) if re-running objtool on the object, don't generate a duplicate
>      alternative?  or maybe it also avoids duplicates for retpoline
>      alternatives which were created in asm code?
> 
> Not sure if I'm right but either way the comment needs more content.
> 
> Also not sure about $SUBJECT, maybe it can be more specific.

Below better?

> BTW, this "re-running objtool" thing is probably a bigger problem that
> can be handled more broadly.  When writing an object, we could write a
> dummy discard section ".discard.objtool_wuz_here" which tells it not to
> touch it a second time as weird things could happen.

Section can't work, since we run the first pass on individual
translations units, so if we get the wuz_here tag from one TU we can't
tell if we perhaps forgot to run on another.

Better detecting if there's actual work to do seems safer to me.

What I actually did yesterday was hack up --noinstr to WARN if there was
an elf modification done, I could turn that into a --ro flag or
something, which we can set on vmlinux if it's supposed to be a pure
validation pass.

---
Subject: objtool: Optimize retpoline alternative generation
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Oct 7 23:15:34 CEST 2021

When re-running objtool it will generate alternatives for all
retpoline hunks, even if they are already present.

Instead of early discarding the retpoline alterantives, hang onto them
a little longer such that the instructions can be marked as already
having an alternative, which then in turn enables avoiding generating
another one.

Having multiple alternatives for a single site is harmless, provided
they're identical, however it does waste time and space.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |    3 +++
 tools/objtool/check.c           |   11 +++++++++++
 tools/objtool/special.c         |    8 --------
 3 files changed, 14 insertions(+), 8 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -806,6 +806,9 @@ int arch_rewrite_retpolines(struct objto
 		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
 			continue;
 
+		if (insn->ignore_alts)
+			continue;
+
 		reloc = insn->reloc;
 
 		sprintf(name, "__x86_indirect_alt_%s_%s",
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1477,6 +1477,17 @@ static int add_special_section_alts(stru
 				ret = -1;
 				goto out;
 			}
+
+			/*
+			 * Don't generate alternative instruction streams
+			 * (insn->alts) but instead mark the retpoline call as
+			 * already having an alternative, so that we can avoid
+			 * generating another instance.
+			 */
+			if (new_insn->func && arch_is_retpoline(new_insn->func)) {
+				orig_insn->ignore_alts = true;
+				continue;
+			}
 		}
 
 		if (special_alt->group) {
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -109,14 +109,6 @@ static int get_alt_entry(struct elf *elf
 			return -1;
 		}
 
-		/*
-		 * Skip retpoline .altinstr_replacement... we already rewrite the
-		 * instructions for retpolines anyway, see arch_is_retpoline()
-		 * usage in add_{call,jump}_destinations().
-		 */
-		if (arch_is_retpoline(new_reloc->sym))
-			return 1;
-
 		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
 
 		/* _ASM_EXTABLE_EX hack */
