Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB7427914
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbhJIKpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhJIKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:45:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688EEC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lVZqnnE4CRum8hThyFK5fkcSOMPzFxtchZIwDLp5bTE=; b=cdh0PHTEX9zzPAy/ykh1C8eQYV
        qcc9qbiQE9QG0iBajpfc/lcJAw4o0/qbvE/JPxi8phKplN42UgGp9fw41j7pBYuUJUf2FYa5H5n25
        RfLxojsxDWwc/yKa5cUx3pmwEmn5KvK7cXcQf7W4ldf4IrpKmEjtp3MOvDPcPaQs5rXGjOkw65nSt
        MMgf2qeN9QfTkChDkrLkSxCu0dUZkKEZWlIeQb7YCQjbbXfnuprXuP5l6vzZcBt/y5dsV4X3ae8iE
        z8J9V1aEOFTaTJkMggm2wfD0V3sirEpsGXBNTEKyxXGLOocwdh2u/YNjTDg82539O06baRRlSxLLs
        wp+e+vyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ9oJ-0044F6-1l; Sat, 09 Oct 2021 10:43:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48B009811D4; Sat,  9 Oct 2021 12:42:35 +0200 (CEST)
Date:   Sat, 9 Oct 2021 12:42:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] objtool: Optimize/fix retpoline alternative
 generation
Message-ID: <20211009104235.GV174703@worktop.programming.kicks-ass.net>
References: <20211007212211.366874577@infradead.org>
 <20211007212627.008917519@infradead.org>
 <20211008072325.4qujedsjtjqbvzrd@treble>
 <YWAe7RSvYqdpbABf@hirez.programming.kicks-ass.net>
 <20211008163906.e5kbzwi2slldk6gh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008163906.e5kbzwi2slldk6gh@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:39:06AM -0700, Josh Poimboeuf wrote:
> On Fri, Oct 08, 2021 at 12:35:25PM +0200, Peter Zijlstra wrote:

> > I used 'discard' since we don't actually generate insn->alts entries.
> 
> I still don't like 'discard', it sounds like you're removing the
> existing ALTERNATIVE from the file.

OK, I'll go word-smith it more then :-)

> > > BTW, this "re-running objtool" thing is probably a bigger problem that
> > > can be handled more broadly.  When writing an object, we could write a
> > > dummy discard section ".discard.objtool_wuz_here" which tells it not to
> > > touch it a second time as weird things could happen.
> > 
> > Section can't work, since we run the first pass on individual
> > translations units, so if we get the wuz_here tag from one TU we can't
> > tell if we perhaps forgot to run on another.
> > 
> > Better detecting if there's actual work to do seems safer to me.
> 
> I *really* don't like writing an ITU and then later writing it again as
> part of bigger a linked object.  It's just going to introduce a lot of
> bugs and a lot of individual "did I do this yet?" checks that we'll
> forget to do half the time.
> 
> If we "perhaps forgot to run on another", and if that's a problem, then
> shouldn't it be a warning when we detect it?
> 
> What specific scenarios were you thinking about?

The obvious scenario (which I actually triggered when I did this
jump_label rewrite thingy) was that a file that uses jump_label wasn't
ran through objtool and stuff came unstuck.

So if we have this double-pass, then all modifications should be done at
the TU level, while the LD level pass should be validation only.

This R/O validation pass at LD level could detect the missed TU level
processing.

> > What I actually did yesterday was hack up --noinstr to WARN if there was
> > an elf modification done, I could turn that into a --ro flag or
> > something, which we can set on vmlinux if it's supposed to be a pure
> > validation pass.
> 
> That might be useful, --dry-run or so.  Also useful for re-running
> objtool with --backtrace to get more details about a warning.

What I had was a little more crude, it simply is a WARN for every elf.c
function that sets ->changed = true. It actually did do the change, but
it warned about it.

Also, --dry-run, to me, doesn't imply warning about the modifications,
simply not committing them, eg. it would skip elf_write(). (which should
still be easy enough to add).

> > Subject: objtool: Optimize retpoline alternative generation
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Oct 7 23:15:34 CEST 2021
> > 
> > When re-running objtool it will generate alternatives for all
> > retpoline hunks, even if they are already present.
> > 
> > Instead of early discarding the retpoline alterantives, hang onto them
> 
> s/alterantives/alternatives/
> 
> > @@ -1477,6 +1477,17 @@ static int add_special_section_alts(stru
> >  				ret = -1;
> >  				goto out;
> >  			}
> > +
> > +			/*
> > +			 * Don't generate alternative instruction streams
> > +			 * (insn->alts) but instead mark the retpoline call as
> > +			 * already having an alternative, so that we can avoid
> > +			 * generating another instance.
> > +			 */
> 
> But this also means that branch validation will get skipped on this alt,
> right?  Can you mention that here, and why it's not a problem?

I can. But I'm >.< close to getting objtool writing
.altinstr_replacement sections which would invalidate this patch.

The only teensy problem is that if objtool creates the
.altinstr_replacement section, it also needs to create a STT_SECTION
symbol for it, which I've also done... *except* STT_SECTION symbols need
to be STB_LOCAL.

And therin lies the rub, ELF wants all STB_LOCAL symbols grouped at the
start of the symbol table (and keeps the number of them in sh_info).
This means that objtool needs to go reshuffle the whole symbol table,
which means updating all references to the symbols :/
