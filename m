Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0143E6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhJ1ROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhJ1ROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:14:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C65C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FKH1k1V2mT7Pmhc/wykH/6Z5s1HhtVEDD4pR3gYAvtY=; b=Ik5uIr6cFDLYyHD7Dh4Ysg+SMl
        lU83Cg+cVQQKcoGKRJYdqtGaQcMhiyPdZm44zUHLIuG1NaqR0XXrDICf+BKUiRqLgVwkz+g/XLr6k
        NueFesA07p6Q0RBJxHBXVtG0OIKucUe8y5AGdnCMZdiHKX76dticLm4o5dJLurG3zesb+/GV0SuLh
        r8vH5fE2ZrQiTNRJbPNA/GX0AYvHS+vBkQDgjWRkyV3t+dTLnjvIg/t3pIrDGjfXJfrAsahSmMGdS
        vB+3S+3jeSB5Av82gXYaUEcenhXhavoVUwP+q+zI0XQRigY+ObzwJJQCTgU7BdxNbRIq4RQGz8JEH
        2B2YL20A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg8w1-00Cqbz-Ej; Thu, 28 Oct 2021 17:11:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D355B30031A;
        Thu, 28 Oct 2021 19:11:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B691020279F24; Thu, 28 Oct 2021 19:11:24 +0200 (CEST)
Date:   Thu, 28 Oct 2021 19:11:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, hjl.tools@gmail.com
Subject: Re: [RFC][PATCH] x86: Add straight-line-speculation mitigation
Message-ID: <YXrZvIMD/5zMs1xF@hirez.programming.kicks-ass.net>
References: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
 <202110280923.341FFA15D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110280923.341FFA15D8@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:51:12AM -0700, Kees Cook wrote:
> On Thu, Oct 28, 2021 at 01:44:00PM +0200, Peter Zijlstra wrote:
> > Hi,
> > 
> > This little patch makes use of an upcomming GCC feature to mitigate
> > straight-line-speculation for x86:
> > 
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
> > 
> > It's built tested on x86_64-allyesconfig using GCC-12+patch and GCC-11.
> > It's also been boot tested on x86_64-defconfig+kvm_guest.config using
> > GCC-12+patch.
> > 
> > Enjoy!
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I'm all for such mitigations. In x86's case, it's small and easy. I do
> note, however, than arm64 maintainers weren't as impressed:
> https://lore.kernel.org/lkml/20210305095256.GA22536@willie-the-truck/

Yeah, I remembered some of that :-)

> What's the image size impact?

My x86_64-defconfig+kvm gives:

   text    data     bss     dec     hex filename
22940902        6964034 1323240 31228176        1dc8110 defconfig-build/vmlinux
22388944        6964034 1880296 31233274        1dc94fa defconfig-build/vmlinux

~538kb, which is quite impressive

> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -179,6 +179,10 @@ ifdef CONFIG_RETPOLINE
> >    endif
> >  endif
> >  
> > +ifdef CONFIG_SLS
> > +  KBUILD_CFLAGS += -mharden-sls=all
> > +endif
> > +
> >  KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
> >  
> >  ifdef CONFIG_LTO_CLANG
> 
> Given the earlier patch for ARM, perhaps the Kconfig and Makefile chunks
> should be at the top level instead, making this feature easier to
> implement in other architectures?

Hence me having Cc'ed some ARM64 people

> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -3084,6 +3084,12 @@ static int validate_branch(struct objtoo
> >  		switch (insn->type) {
> >  
> >  		case INSN_RETURN:
> > +			if (next_insn && next_insn->type == INSN_TRAP) {
> > +				next_insn->ignore = true;
> > +			} else if (sls && !insn->retpoline_safe) {
> > +				WARN_FUNC("missing int3 after ret",
> > +					  insn->sec, insn->offset);
> > +			}
> >  			return validate_return(func, insn, &state);
> >  
> >  		case INSN_CALL:
> > @@ -3127,6 +3133,14 @@ static int validate_branch(struct objtoo
> >  			break;
> >  
> >  		case INSN_JUMP_DYNAMIC:
> > +			if (next_insn && next_insn->type == INSN_TRAP) {
> > +				next_insn->ignore = true;
> > +			} else if (sls && !insn->retpoline_safe) {
> > +				WARN_FUNC("missing int3 after indirect jump",
> > +					  insn->sec, insn->offset);
> > +			}
> > +
> > +			/* fallthrough */
> >  		case INSN_JUMP_DYNAMIC_CONDITIONAL:
> >  			if (is_sibling_call(insn)) {
> >  				ret = validate_sibling_call(file, insn, &state);
> 
> Oh very nice; I was going to ask "how can we make sure no bare 'ret's
> sneak back into .S files" and here it is. Excellent.

Yeah, there was no way I was going to do that without tooling ;-) I'd
not have found half of it.

> Random thought, not for this patch, but can objtool validate the int3
> linker padding too? (i.e. to double-check the behavior of
> 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes"))

Probably. there might be some weird corner cases between GCC alignment
nops and linker fillers I suppose.
