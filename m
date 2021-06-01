Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253EE397B87
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhFAVGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:06:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E819C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:04:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f11so15083216lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1xBq/yJQb1ctA6qRFIUGU27xyMZ75sBIbNTD9efPBik=;
        b=t0eflJF8UnBowpwoSUwJPkrnNdFFFYx7tvKHGM/SVmXzP1zmhBL45Yc07D0w2k7N4b
         msWGrBeHienj1/NGQWjKz6eX6KGg5xjY0m6mP8FPNSq+LkRqHN6zRuaF/bj7V7Ynac5x
         b2IiLFfuFgnKS/vXDgbyPwb45xMb8tpOyBjvUnH5Zw9f2T0T665G5GkqsXTOJjhRDha5
         bK5sDKlwO05A3cNwdbo/htN/MLrB8V1hBW2MQUkzQmNjz4+Zlby7hqyb52c+IlKp6Q72
         Tqdw1r/T7rBQkIB6FIJiKlGdrnUpEhWKvOrxd+vFRKY37R5c4Xr4gXTUZCrOFC9jDgBg
         gKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1xBq/yJQb1ctA6qRFIUGU27xyMZ75sBIbNTD9efPBik=;
        b=Zyg2p8jKw+AiO5JcIq4FFsTp71fZ+UwziXr/NWge+J3yCLnbKUNgJqZy+42WXnmaiB
         5F5FaKV/yVeGWDbhVd74Bgp7xCaJXHnD8KV6xTMjIgTqskWI//LOSn03v4Taots9e6Ey
         Plpae175rnW+vDaWcHCemaUC/VHJQwRI2+ZkTkghN4crfUG+6sMCl0oulWIQ2e/U7/ps
         msWMFhpAXfWu0fAgd3EkT9RaVu3eXZaBy25JwLhsbr7y5t28zPDk1w982HB9rR+1It4H
         R9aiSdN6VFv1V6A0PuDh3cSabJt50X2KapoOqZmDW2f9yPwvyfQ6v0ASS8pR6pEKnIza
         cgfw==
X-Gm-Message-State: AOAM532doBwZrC+7A6DCnzJ7Vd2o1fzZmF87zLNBu6KtQCEWGAVQf13Y
        Z2XivH/3ig/xLefkhvcxW4SBPtTTMyyW9dMe5mbQxg==
X-Google-Smtp-Source: ABdhPJxQkHCQf9RGRbYb1eURvFXQz0R5PgHRn0MZYtVB7qDIQTNv2ZXq/Cg+zMtKmjEkGy0hxIaIOL5ODDYv7J26Cd8=
X-Received: by 2002:a19:f706:: with SMTP id z6mr5933873lfe.122.1622581495442;
 Tue, 01 Jun 2021 14:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210528200821.459214-1-jarmo.tiitto@gmail.com>
 <2450763.S1xdTQMYLV@hyperiorarchmachine> <CAKwvOdmk34yQQow_kMLeF32OpfcP4O0SrPx3gMO3KQvgE8uZ9Q@mail.gmail.com>
 <3233714.pFP5IgcPq9@hyperiorarchmachine>
In-Reply-To: <3233714.pFP5IgcPq9@hyperiorarchmachine>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 14:04:43 -0700
Message-ID: <CAKwvOdnN+Cv5e1D5O18GkE6hjqaSAOKQHywDnJ7GzjPNMAsy_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] pgo: modules Add module profile data export machinery.
To:     jarmo.tiitto@gmail.com
Cc:     Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 1:46 PM <jarmo.tiitto@gmail.com> wrote:
>
> Kirjoitit tiistaina 1. kes=C3=A4kuuta 2021 20.27.01 EEST:
>
> > Hi Jarmo,
> > Thanks for the series! Would you mind including the above in a cover le=
tter
> > in a v2? (You can use --cover-letter command line arg to `git format-pa=
tch`
> > to generate a stub).  The please explicitly cc
> > Sami Tolvanen <samitolvanen@google.com>
> > Bill Wendling <morbo@google.com>
> > on the series? Finally, please specify the cover letter and all patch f=
iles
> > to git send-email in one command, so that the individual patch files ar=
e
> > linked on lore.kernel.org. This makes it significantly easier to review=
 and
> > test.
> >
>
> Hello,
>
> Yeah, I realized afterwards that I screwed up at the git send-mail/messag=
e
> threading task. Sorry about that. I will correct all of it in my next v2
> patch. Make mistakes, and learn new things.

No worries; best way to learn to swim is to jump in the pool!
(Well...I might not actually recommend that to kids, but you catch the
drift; maybe "sink or swim" is the better expression?).  Also, you
should use text/plain for your email; you're probably getting
automated responses from LKML about that. In gmail, you can click the
vertical ellipses in the bottom right of a reply; make sure to check
"Plain Text."

> I will post new v2 patch once I'm done writing and testing it. Based on t=
he
> feed back here I will try keep it simple and unify the vmlinux + modules =
code
> such that there is no fs_mod.c source any more nor necessary code duplica=
tion.
>
> Basically it will be an rewrite on my part but I'm just excited to do it.

Better to rewrite it now rather than later, I suppose.

> I feel this first attempt was more like of RFC/prototype such that I coul=
d get
> in contact with you guys.

Yep, that's common for v1 of patches.  If you're interested in Clang
Built Linux generally, send me your github account name and I'll add
you to our org on github.
https://github.com/ClangBuiltLinux

> Just one question about copyrights: do I need to add my statement to the
> sources, if yes, then how should I proceed ?

Sure, you can add them to the top level of each source file you touch
(we don't do this for Makefiles I think).  I think the signed-off-by
tag is enough though, which implies agreement with the Developer's
Certificate of Origin:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#devel=
oper-s-certificate-of-origin-1-1.
For instance, I don't think I ever have added my name/copyright to the
top of a file, but that also has to do with my employment agreement I
have with my employer. IANAL
--=20
Thanks,
~Nick Desaulniers
