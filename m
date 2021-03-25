Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67973489C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:02:04 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:27216 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:01:30 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 12P71Eji000576;
        Thu, 25 Mar 2021 16:01:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 12P71Eji000576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1616655675;
        bh=35qK+TDUWH89XFuOlT4Ceqr1ByyKjN1HXv9JJtPoq+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oV0ah/M8nbV4SL9InNpQBg3Kj8vCLpbHUESpOD5H3E9hNDIHqTlfhOlJFuzQw6ZwE
         06p8an8PfpN6K5Y1GVTiEK95Zt9EdO3D1kQNDzrrW9UClGaugyGMbieWQEyNKffr5n
         iFFz8PBtq0MMFruArb+Z1PX7zhmy411gG/D0Mvb2YSaAJpZdFHnVU1ZPDyPbyWNBF7
         N7R9NQqGERe5wP9SQmf0p//hkopXNtnzoqHYQDYUyB0LY/4ng9RWmGVHp+HCl2neME
         ttdvdnBaOcGxY/KU57Zxcoion88GVwp4xctsVQW+Z0QT4na165Wqll5NAuG0xMoA32
         4H1U+/G6pJb7w==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id y200so1067160pfb.5;
        Thu, 25 Mar 2021 00:01:15 -0700 (PDT)
X-Gm-Message-State: AOAM533E0MultMW8Axb7uUd79JuqnvwXIObq8kHQJ5FTZLFp/DZCvEWL
        2JE+m/E378g1coAOQ/IKZvCJcguxk+oF9pVTNv8=
X-Google-Smtp-Source: ABdhPJyDnD+j2Knq2ABvomoL1uB8X0ToT40elNI9VXKPYbw3O2SGfqeNYXYsoFTSEcMGScs3+88x3bO1ccVarpfmYKU=
X-Received: by 2002:a65:41c6:: with SMTP id b6mr6182669pgq.7.1616655674402;
 Thu, 25 Mar 2021 00:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <16043769.gqpzGLO8mG@pinwheel> <20200703073143.423557-1-danny@kdrag0n.dev>
 <20200703062950.5e8c1785@lwn.net> <9486d1ab-580a-0819-10c9-a62354a255e1@rasmusvillemoes.dk>
In-Reply-To: <9486d1ab-580a-0819-10c9-a62354a255e1@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Mar 2021 16:00:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+M5Cn84tkEAiLDoyaKmrG-cFOyUjPgFC2+ksDGHn3vQ@mail.gmail.com>
Message-ID: <CAK7LNAQ+M5Cn84tkEAiLDoyaKmrG-cFOyUjPgFC2+ksDGHn3vQ@mail.gmail.com>
Subject: Re: [PATCH v2] editorconfig: Add automatic editor configuration file
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>, Danny Lin <danny@kdrag0n.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:01 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 03/07/2020 14.29, Jonathan Corbet wrote:
>
> [doing a bit of necromancy here]
>
> > On Fri,  3 Jul 2020 00:31:43 -0700
> > Danny Lin <danny@kdrag0n.dev> wrote:
> >
> >> EditorConfig is a standard for defining basic editor configuration in
> >> projects. There is support available for 47 code editors as of writing,
> >> including both built-in and extension support. Many notable projects
> >> have adopted the standard already, including zsh, htop, and qemu.
> >>
> >> While this isn't a full-fledged C code style specifier, it does set some
> >> basic ground rules that make it more convenient for contributors to use
> >> any editor of their choice and not have to worry about indentation, line
> >> endings, encoding, final newlines, etc. This should make it
> >> significantly easier to conform to the kernel's general code style when
> >> used in combination with clang-format.
> >>
> >> For more information, check the official EditorConfig website:
> >> https://editorconfig.org/
> >>
> >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> >> ---
> >
> > So I worry a bit that not everybody will welcome the addition of a dotfile
> > that may be magically interpreted by their editor.
>
> I would suppose that one would have to enable editorconfig support
> explicitly in one's editor, so this would have no effect for people that
> haven't done so (though there are almost certainly exceptions).
>
> > I also worry that the
> > file itself could become a battleground for people wanting to argue about
> > style issues.
>
> I don't think so, not any more than the coding-style document is, and
> that seems to be pretty solid (but as doc maintainer, you'd know better).
>
> >
> > Perhaps I worry a bit too much...?
>
> As someone who regularly needs to submit patches to random upstream
> projects to fix bugs or implement minor features, I for one would really
> welcome more widespread use of editorconfig. While I mostly work with
> the linux kernel (and other projects using the same C style), so my
> default C style setting is "linux", even for the kernel this would be
> helpful to me when I poke around in none-C files (shell scripts, for
> example).
>
> Rasmus


Just from my curiosity, I just checked the behavior
when the language is specified by a shebang line.

For example, scripts/diffconfig has no file suffix,
but specifies '#!/usr/bin/env python3'
at the very top line.
This is sensible for tools that interface to users.
Users have no interest in which language is used
internally.


As far as I test this patch on Emacs, it follows the rule
of [*] rather than [*.{pl,pm,py,tc,json,tc}].

This is the correct behavior but not what we want in general.

I do not mean I am negative to this patch.
Rather, I very much like this patch, but I just
wondered how this case could be handled.

I found this:
https://github.com/editorconfig/editorconfig/issues/404
I did not read through it, though.


--
Best Regards
Masahiro Yamada
