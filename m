Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6B3A6EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhFNTax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:30:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhFNTav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:30:51 -0400
Received: from zn.tnic (p200300ec2f09b9000b7fffe760596043.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:b7f:ffe7:6059:6043])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83FDA1EC036C;
        Mon, 14 Jun 2021 21:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623698927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FIka5To9W4/GsHlLGI1tXPlvrk8dk7xf2smdG4yTjhs=;
        b=hY+uEg6WFa1M186e5fxvPTdXJ7KErqxhWM6njt+OIEgtLFAL34teXQJphajQ4yuFNoDLOq
        pnEiPBP/2q/Kw8tioWMGiiuuNZ0PR4YdttdPv/4cPJ/w5AjthdsUBDAeqlJkIjPNqKUQsO
        J12+cqG+rTgx97zZ+89zeM0+sfxNqT8=
Date:   Mon, 14 Jun 2021 21:28:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <YMet7RTthIBL8oeO@zn.tnic>
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com>
 <20210614162018.GD68749@worktop.programming.kicks-ass.net>
 <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com>
 <YMeeBJKJhddzReGe@zn.tnic>
 <CAKwvOdkV8DLKJb7h_=6mUb_V=qdmBaCqNMU8scaBhpqF7yeeMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkV8DLKJb7h_=6mUb_V=qdmBaCqNMU8scaBhpqF7yeeMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:03:15PM -0700, Nick Desaulniers wrote:
> Yes, I will file a bug (or two) against GCC and then post the links on
> the other thread (re: pgo) since that already has the toolchains
> mailing list cc'ed.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
