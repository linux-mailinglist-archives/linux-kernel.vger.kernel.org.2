Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA9456102
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhKRRBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhKRRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:01:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8DBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:58:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so303121wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9arlHwl5sZGxwLKNSnBvdvuO00k17CUi2kFQug5ePuY=;
        b=CKD46qr7Sg+TPo1m8pW/IrMNRcZwSMk4Q+j0//oWTGqapkhdrfkagj8u/xyNrklTF0
         Dq7tUrRFWyDmGOGdJlVyDnyHPF4+PCZXoUetNa6GXFRaWvk6AxOoZm8soN9FkkfsI+Ad
         1c5EGKTo2jhXOCKXuAJfDQQ3EktfU/Z5VKymRiiKNiAPrrAw++Ktd0mD72fsqJJRpYoZ
         1dw4t+zYtInPvLMZ8kCmsl2qdGh0wXG6hG8n4RscyTHJrdecAVgvFbqCRiN+iK7BgzJ5
         1Zi9S/NU0HNdou1UX1BSmidPyoab5tkcDrHurrNJawNU/h/Ri1JeyKBw0XFMANbqZrTB
         bueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9arlHwl5sZGxwLKNSnBvdvuO00k17CUi2kFQug5ePuY=;
        b=qAOtXpfZUc3FA8+migYFaRw8667ovCCIJexl1tokuAkRU7UG8t2cwKVjNA8VuVH9Ht
         GyvI82+qhs1gopCpwPqkIIj9rPlngkyw/zJfJliWY6YKym30ePusUK4rx8wscUgNhrUQ
         U2TJqvwLYLtUucnRAJgTRp3xpVKjpojcITugPOxpnYdp6Isq2YCPK8qp6sMNI/1H3DUt
         S4fWWQDeS8VniFBDtiBADmEMi3hG6P/mWWzlUkT3cyGQkOZzRRcTcDA5C8AbNggYGCh7
         jio2GSInceiMqHVCJX9y4tTd0D4r6bfioyp9P2SNMYu03/IKpRGx9JeJv2qDpqsy9y2d
         60Og==
X-Gm-Message-State: AOAM530Nz2HJaDDmt6ufRHk+QnjuyqtXqA5QDl9Mdj0+174V8PLXzOtH
        5X5xGN36NpdYc+hJXg6g2KKxc3DFkTn1jZLMSsGAjA==
X-Google-Smtp-Source: ABdhPJyr2/8JOviY3rktdWWJ0aiWPWp9RipiVd+D7Yt9YzTvXSrRm/RyjepwpwEAmm93YgD+HnlOenTiBSp9KKQM7X8=
X-Received: by 2002:a05:600c:1f13:: with SMTP id bd19mr11662489wmb.9.1637254681545;
 Thu, 18 Nov 2021 08:58:01 -0800 (PST)
MIME-Version: 1.0
References: <202111180219.YkyoBMpf-lkp@intel.com> <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net> <21f86e2bc817b6ec0c7a9194a4fefb1d55e3040b.camel@sipsolutions.net>
In-Reply-To: <21f86e2bc817b6ec0c7a9194a4fefb1d55e3040b.camel@sipsolutions.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 18 Nov 2021 08:57:49 -0800
Message-ID: <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 8:27 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2021-11-18 at 17:00 +0100, Peter Zijlstra wrote:
> > On Wed, Nov 17, 2021 at 11:40:35AM -0800, Eric Dumazet wrote:
> > > On Wed, Nov 17, 2021 at 10:55 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Wed, Nov 17, 2021 at 10:46 AM kernel test robot <lkp@intel.com> wrote:
> > > > >
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > > > > head:   d31c3c683ee668ba5d87c0730610442fd672525f
> > > > > commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
> > > > > config: um-x86_64_defconfig (attached as .config)
> > > > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > > > reproduce (this is a W=1 build):
> > > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
> > > > >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > > > >         git fetch --no-tags tip x86/core
> > > > >         git checkout d31c3c683ee668ba5d87c0730610442fd672525f
> > > > >         # save the attached .config to linux build tree
> > > > >         make W=1 ARCH=um SUBARCH=x86_64
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All errors (new ones prefixed by >>):
> > > > >
> > > > >    arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
> > > > > > > arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
> > > > >       98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> > > > >          |            ^~~~~~~~~~~~~~~~~~~~~~
> > > > >    cc1: some warnings being treated as errors
> > > > >
> > > > >
> > > >
> > > > Hmmm... it seems we need to guard this with CONFIG_DCACHE_WORD_ACCESS ?
> > >
> > > Perhaps something like the following ?
> >
> > Dear um folks, is this indeed the best solution? It's a bit sad to have
> > to add this to x86_64, but if that's the way it is...
> >
>
> I guess we can add load_unaligned_zeropad() or even just somehow add the
> include with it (asm/word-at-a-time.h) from x86?

Unless fixups can be handled, the signature of the function needs to
be different.

In UM, we would need to provide a number of bytes that can be read.
