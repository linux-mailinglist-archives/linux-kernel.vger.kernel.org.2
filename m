Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D77341713
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhCSIHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhCSIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:06:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A787C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkHBYHfoCsDHRy+l3G4x3jQeUIpsZUBDXt4bxONprtE=; b=M5OuWWtY5YElEdzEV3icSTsKN4
        RBqjuGOohreB/5OCbBiLDaPfcxuBx1mnwTgJrcN0CHrJvk39PAgH4K+LV2UQknJBBoYngXcW1W8aZ
        t75Cke9TDp1X5kShy/7A+bNpsCfC7TL2i2hwt4QCWl7f+yKlO+ESb5rwaX0Dk6k7tWKUOrL53Rycr
        kbvUY1+gN2yBs0mL2rtAEeRyhDg2Mg1ZXJ3VdqtA8njAYBLUN4gmlp9xH6alBI97lvUJuyWwzukUd
        ZUXEg/wWIWz9nlTgCQDVEEvgAOfsrwsQPLKljsciOkfDCN7yC3v9+UJWv+mrMTsYckd4XTS4RrNpc
        NEmO6yZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNA9d-006qyk-8B; Fri, 19 Mar 2021 08:06:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D66F73006E0;
        Fri, 19 Mar 2021 09:06:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9CF7213C0F22; Fri, 19 Mar 2021 09:06:44 +0100 (CET)
Date:   Fri, 19 Mar 2021 09:06:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YFRblERAnQu2KtZG@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.253147364@infradead.org>
 <20210319032955.zdx6ihhprem5owbc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319032955.zdx6ihhprem5owbc@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:29:55PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:17PM +0100, Peter Zijlstra wrote:
> > When the compiler emits: "CALL __x86_indirect_thunk_\reg" for an
> > indirect call, have objtool rewrite it to:
> > 
> > 	ALTERNATIVE "call __x86_indirect_thunk_\reg",
> > 		    "call *%reg", ALT_NOT(X86_FEATURE_RETPOLINE)
> > 
> > Additionally, in order to not emit endless identical
> > .altinst_replacement chunks, use a global symbol for them, see
> > __x86_indirect_alt_*.
> > 
> > This also avoids objtool from having to do code generation.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> This is better than I expected.  Nice workaround for not generating
> code.

Thanks :-)

> > +.macro ALT_THUNK reg
> > +
> > +	.align 1
> > +
> > +SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
> > +	ANNOTATE_RETPOLINE_SAFE
> > +1:	call	*%\reg
> > +2:	.skip	5-(2b-1b), 0x90
> > +SYM_FUNC_END(__x86_indirect_alt_call_\reg)
> > +
> > +SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
> > +	ANNOTATE_RETPOLINE_SAFE
> > +1:	jmp	*%\reg
> > +2:	.skip	5-(2b-1b), 0x90
> > +SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
> 
> This mysterious code needs a comment.  Shouldn't it be in
> .altinstr_replacement or something?

Comment, yes, I suppose so. And no, if we stick it in
.altinstr_replacement we'll throw them away with initmem and module
alternative patching (which will also refer to these symbols) will go
side-ways.

> Also doesn't the alternative code already insert nops?

Problem is that the {call,jmp} *%\reg thing is not fixed length. They're
2 or 3 bytes depending on which register is picked.

We could make them all 3 long and insert 0,1 nop I suppose.

Initially alternatives wouldn't re-optimize nops on patched things, it
would simply add nops on. And I had the above be:

1:	INSN	*%\reg
2:	.nops	5-(2b-1b)

and we'd get a single right sized nop. But the .nops directive it too
new, we support binutils that don't have it :/

Hence, it now reads:

2:	.skip	5-(2b-1b), 0x90

End result is that alternative NOP optimizer patch at the start of the
series that now also optimizes a bunch of cases that are unrelated and
were previously missed -- but crucially, it covers this case too :-)

Anyway, yes I could make it 3 long.

> > +int arch_rewrite_retpoline(struct objtool_file *file,
> > +			   struct instruction *insn,
> > +			   struct reloc *reloc)
> > +{
> > +	struct symbol *sym;
> > +	char name[32] = "";
> > +
> > +	if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
> > +		return 0;
> > +
> > +	sprintf(name, "__x86_indirect_alt_%s_%s",
> > +		insn->type == INSN_JUMP_DYNAMIC ? "jmp" : "call",
> > +		reloc->sym->name + 21);
> > +
> > +	sym = find_symbol_by_name(file->elf, name);
> > +	if (!sym) {
> > +		sym = elf_create_undef_symbol(file->elf, name);
> > +		if (!sym) {
> > +			WARN("elf_create_undef_symbol");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	elf_add_alternative(file->elf, insn, sym,
> > +			    ALT_NOT(X86_FEATURE_RETPOLINE), 5, 5);
> > +
> > +	return 0;
> > +}
> 
> Need to propagate the error.

Oh, indeed so.
