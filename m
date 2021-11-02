Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FD54437BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKBVU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:20:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKBVUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:20:54 -0400
Received: from zn.tnic (p200300ec2f1e1e0080adfba3347e3dab.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1e00:80ad:fba3:347e:3dab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C4AD1EC0372;
        Tue,  2 Nov 2021 22:18:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635887898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+/uDq33xUD46XLKdHYR9LMs4FyeNj1wjtbIaLFhaSWU=;
        b=mXz/zjz0JdyUSUexsPc4zLrAmMcEklloNANLpGI8mtCpf6bWFQ0UShVIu+z0cuoZYhLDgT
        gL22/17Lk0ZAOlBLZ+fXQVHtehCZxGGmB+fz/OsOG42ryphNXlXed5gg508eT3iRJDFwNL
        yZK+7ypcGCRAoC0E/YJXQmPkPiY+vbw=
Date:   Tue, 2 Nov 2021 22:18:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
Message-ID: <YYGrFAx17lD/GTul@zn.tnic>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
 <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
 <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
 <CAHk-=wghWC3B6tFpQChL=q+HdUKN6R3OohPt53VsEOcKASKrRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wghWC3B6tFpQChL=q+HdUKN6R3OohPt53VsEOcKASKrRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 10:50:06AM -0700, Linus Torvalds wrote:
> On Tue, Nov 2, 2021 at 3:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Having the plugin gate on section name seems a lot hacky, but given it's
> > already doing that, one more doesn't hurt.
> 
> Looks sane to me.
> 
> Some of the other warnings are just odd.
> 
> Why is mce_setup() 'noinst'? I'm not seeing any reason for it, but
> maybe I'm just blind. That one complains about the memcpy() call.
> 
> Of course, I suspect memcpy/memset might be better off noinstr anyway,
> exactly because they can happen for very regular C code (struct
> assignments etc). But mce_setup() doesn't really seem to have much
> reason to not be instrumented.

That is going away in my local patchset here. The aim is to have the #MC
handler be noinstr, ofc, but that thing calls a bunch of other functions
and even external ones so it needs careful massaging without destroying
the whole house of cards in the process. :-)

I should have something palatable - read: properly split patches - soon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
