Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762E732F544
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCEVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:23:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27824C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 13:23:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d3so5944118lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SydtHA9ySlkODMySHl2z0gV1PL50P5TP1t2fIowj2ao=;
        b=IiowVuY5H7HwbHt3FsPfra4svFZ+jyUJwevcVWIDYh7E47fIsYZfyfxWEaqkp+Y1Cl
         aM4IJyeHPL8m5C/ULkmtXt/Tk2W67vqLtjpPJix1g5tvliIcOrY+E/aTytf6+TPiYUkB
         XhWp9HZieAf4AnqTMwrfdrBt63JbWcnOu+SvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SydtHA9ySlkODMySHl2z0gV1PL50P5TP1t2fIowj2ao=;
        b=TeepY/vYqWdgRuCSR6vEbobjLXRUkQPDWJx1CdWDSdU10TYFNghEisemn0IC4e0hZd
         fLNyYC96Y2EjX9yHEnvESXWnh4wSK6JwBKpEIeyq2lvz1TLjMgk4wvl7nBpGrurS7kxj
         FwniCnl9OyhPaJkbRfrvlopjkHg0QZQEvlivbzHVCiJdi/F164ueFyMbFFGfEK66ZU2z
         YCva15E97UJqkm/RwuPqLlp4qt4WoRaqw77gxiuqx609PVEw7ovKCvM08Xi34aJuiN5F
         TicR+7En0XEMpX9SPOYg3Jp5+jDU3SckmszWNqv99RHgxmgasEayFqOXrdQAnz+RfNI1
         1sPw==
X-Gm-Message-State: AOAM530s4QPLQzmUkKsdcDn6VkdPY4LE8braJn8kK+tItBLynBbhajjD
        ufJoVPeURvbtIn1NMBV8UthpwRBHMg5pYw==
X-Google-Smtp-Source: ABdhPJx3bHnNJzWYv566vXj3peGNTIS6z0qgaQlhhQSL9FnIJIO94vO5FIJhWLq0rptH9bVtC2gbPw==
X-Received: by 2002:a05:6512:98d:: with SMTP id w13mr6894444lft.100.1614979437332;
        Fri, 05 Mar 2021 13:23:57 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n23sm444747lfq.121.2021.03.05.13.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 13:23:55 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id e2so4566938ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 13:23:55 -0800 (PST)
X-Received: by 2002:a2e:a589:: with SMTP id m9mr151221ljp.220.1614979434841;
 Fri, 05 Mar 2021 13:23:54 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com> <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com> <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
 <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com>
In-Reply-To: <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Mar 2021 13:23:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
Message-ID: <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     David Laight <David.Laight@aculab.com>
Cc:     Tom Tromey <tom@tromey.com>, Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 1:19 AM David Laight <David.Laight@aculab.com> wrote:
>
> The point is that you can skip the unwanted parts of
> #if without having to parse the file at all.
> You just need to detect the line breaks.

That's not actually true AT ALL.

You still need to at the very least parse the preprocessor tokens,
looking for things like #if, #else, and #endif. Because those can -
and do - nest inside the whole thing, so you're not even looking for
the final #endif, you have to be aware that there might be new #if
statements that means that now you now have to increment the nesting
count for the endif.

And to do even just *THAT*, you need to do all the comment parsing,
and all the string parsing, because a #endif means something entirely
different if there was a "/*"  or a string on a previous line that
hasn't been terminated yet (yes, unterminated strings are bad
practice, but ..).

And regardless of even _those_ issues, you still should do all the
other syntactic tokenization stuff (ie all the quoting, the the
character handling: 'a' is a valid C token, but if you see the string
"it's" outside of a comment, that's a syntax error even if it's inside
a disabled region. IOW, this is an incorrect file:

   #if 0
   it's a bug to do this, and the compiler should scream
   #endif

because it's simply not a valid token sequence. The fact that it's
inside a "#if 0" region doesn't change that fact at all.  So you did
need to do all the tokenization logic.

The same goes for all the wide string stuff, the tri-graph horrors, etc etc.

End result: you need to still do basically all of the basic lexing,
and while you can then usually quickly throw the result mostly away
(and you could possibly use a simplified lexer _because_ you throw it
away), you actually didn't really win much. Doing a specialized lexer
just for the disabled regions is probably simply a bad idea: the fact
that you need to still do all the #if nesting etc checking means that
you still do need to do a modicum of tokenization etc.

Really: the whole "trivial" front-end parsing phase of C - and
particularly C++ - is a huge huge deal. It's going to show in the
profiles of the compiler quite decisively, unless you have a compiler
that then spends absolutely insane time on optimization and tries to
do things that basically no sane compiler does (because developers
wouldn't put up with the time sink).

So yes, I've even used things like super-optimizers that chew on small
pieces of code for _days_ because they have insane exponential costs
etc. I've never done it seriously, because it really isn't realistic,
but it can be a fun exercise to try.

Outside of those kinds of super-optimizers, lexing and parsing is a
big big deal.

(And again - this is very much language-specific.  The C/C++ model of
header files is very very flexible, and has a lot of conveniences, but
it's also a big part of why the front end is such a big deal. Other
language models have other trade-offs).

             Linus
