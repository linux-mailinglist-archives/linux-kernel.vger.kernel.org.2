Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E331D3986A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhFBKjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:39:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60724 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232622AbhFBKjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:39:24 -0400
Received: from zn.tnic (p200300ec2f0f0e00cc90e218be681080.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:cc90:e218:be68:1080])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D8B01EC03F0;
        Wed,  2 Jun 2021 12:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622630257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LbZDvfPG9AbfENSDQ9YS4c7v7yt8exIPkE06YZBe5yk=;
        b=KPIRmkHOu14h26zGILDi/ie+4vNy9vGT3CeN1YSMvsYvoQHc6B/6FfRgxKWLWCyzvugbhR
        V39LXyFwtaVGklK2PP7sW5UthltzuQIcVjGvnrNnIdwWjNfXV56c6Wqs2G4nCK0rYLS84P
        PuI4KerQeKNNCCMHUmA4ptTWgl6SNj0=
Date:   Wed, 2 Jun 2021 12:37:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Richard Narron <richard@aaazen.com>
Subject: Re: [PATCH] x86/alternative: Optimize single-byte NOPs at an
 arbitrary position
Message-ID: <YLdfbJBk20HIjfDE@zn.tnic>
References: <20210601212125.17145-1-bp@alien8.de>
 <YLc+AniWgFBdMbX6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLc+AniWgFBdMbX6@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:14:58AM +0200, Peter Zijlstra wrote:
> Who again insisted that wouldn't happen? :-)

Yours truly, ofc. :-P

> That's almost a proper comment, might as well finish it
> 
> /*
>  * optimize_nops_range() - Optimize a sequence of single byte NOPs (0x90)
>  * @instr: instruction byte stream
>  * @instrlen: length of the above
>  * @off: offset within @instr where the first NOP has been detected
>  *
>  * Return: number of NOPs found (and replaced)
>  */

Done.

> 	for (; i < instrlen && instr[i] == 0x90; i++)
> 		;
> 
> perhaps? (possibly too dense, up to you)

Yeah, let's leave it simple so that one can read it at a quick glance.

> > +
> > +	nnops = i - off;
> > +
> > +	if (nnops <= 1)
> > +		return nnops;
> 
> !nnops would be an error, no?

Yeah, just being overly cautious. It should not be 0 since we're being
called for the byte at offset being 0x90. But I have said "should not
be" before and have fallen flat on my face.

> We really needs that extra line?

Zapped.

> Anyway, irrespective of nits:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, all except one incorporated.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
