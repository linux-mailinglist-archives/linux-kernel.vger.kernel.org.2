Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14B432067E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBTRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 12:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBTRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:41:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F5C061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 09:41:06 -0800 (PST)
Received: from zn.tnic (p200300ec2f14bd002490444ce9b57ac6.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:bd00:2490:444c:e9b5:7ac6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C07901EC01DF;
        Sat, 20 Feb 2021 18:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613842863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lfXXQdZUDmQdTpAha8096XlXO/gL9eYwC0kOdnYXm8c=;
        b=fVUdRZHdhbo8jcxoIWlXeuNXzw0MeHUyqJ2+3XiKHQmFMy5iKH35Om0qO2QaW0bMpL9VZZ
        9txg58C9nqznNdq8B+UCDX3B66JlU/Uk6APWiVJUwDvFANm+b8Dm3zFP2YyVwbLVExP85v
        E+rUQSaNktzmz5wgs/cMfKMeDo43y0o=
Date:   Sat, 20 Feb 2021 18:41:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210220174101.GA29905@zn.tnic>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
 <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:48:46PM +0100, Peter Zijlstra wrote:
>  - straight line execution is always better than a round-trip to
>    somewhere else, no matter how trivial.

Sure, but not at that price. Especially not if it is waaay down in perf
profiles.

>  - supposely EIBRS (yeah, I know, there's a paper out there) should
>    result in no longer using retpolines.

Yap, supposedly both vendors have stuff like that in the works. When
that happens, we can finally use ALTERNATIVE_3 in the ratpolines. :-)

>  - I really, as in _REALLY_ don't want to do a CET enabled retpoline

WTF is that? Can we deal with one atrocity at a time pls...

>  - IOW, retpolines should be on their way out (knock on wood)

Yap, my hope too.

>  - doing this was fun :-)

I know.

>  - this stuff was mostly trivial make work stuff I could do with a head
>    full of snot and a headache.

I don't want to imagine what you'd come up with when you're all healthy
and rested. :-P

>  - if we had negative alternatives objtool doesn't need to actually
>    rewrite code in this case. It could simply emit alternative entries
>    and call it a day.

I don't mind the negative alt per se - I mind the implementation I saw.
I'm sure we can come up with something nicer, like, for example, struct
alt_instr.flags to denote that this feature is a NOT feature. IOW, I'd
like for the fact that a feature is a NOT feature or patching needs to
happen in the NOT case, to be explicitly stated with a flag. I.e.,

	if (!boot_cpu_has(a->cpuid) && !(a->flags & PATCH_WHEN_X86_FEATURE_FLAG_NOT_SET))
		continue;

Something like that.
			
>  - objtool already rewrites code

Sure, as long as one can reconstruct from looking at the asm, what
objdool has changed. I fear that'll get out of control if not done with
restraint and proper documentation.

>  - I have more cases for objtool to rewrite code (I'll see if I can
>    rebase and post that this weekend -- no promises).

Oh noes.

>  - also https://lkml.kernel.org/r/20200625200235.GQ4781@hirez.programming.kicks-ass.net

Oh well, I guess you can simply make objtool compile the kernel and be
done with it.

:)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
