Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F973BC271
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhGESC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhGESC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:02:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4741BC061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 10:59:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s129so30318224ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJsboDNld2P6AbWlug6aDXd7eLnwEy72n526BJjJ3p4=;
        b=EXqSe5LBsLsLCtQiC8U/5Swb48WLpeSqS53eK2HIJRAVgtZeLSLS8A1wZ6eHgnCvc7
         yYyGiLzAg5kHHmj95ZJwzrQ8+jiI4dQIXuPBYD7eArDwyslmw/KUjaqixVz80HIs95cr
         opGbcBdxR62OF1sDMSjE7x1ZLMoRMQmzc5qtxYCbwHFwtgMrkbYWcghfWg40xwCrlesM
         l5YSUUfyLiwe1VQhV0mf7mEohw9ZYV21sksVI7UpkbYqM2FiLK+3tG2Pw1EIEEqlsF1Q
         IijD4D61dFjQycgonxf9i5m6dzoYTs+ATalj6Gb5PIhriSMhzPu03lgiYC8BLJMqiJJX
         EuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJsboDNld2P6AbWlug6aDXd7eLnwEy72n526BJjJ3p4=;
        b=ikdx8lLwniRpwVYP1tJ7cT2RbZlt0cHXFNpwO9M+biaYxi7JtGleAR3a3x84oa2qO6
         E4MwRFYRy4dNPl3ENIWncIt51/jspIJBaHNBJ2KOuQVepLiNE9CwSO/AxznaEgPskfpr
         lgLm/5O3V1jnPyolpkvlWKMooiwDG41g7WfEoSwxEMfbtcOL5GsgnVsPECGNcJOJuPiS
         +xz2vi+X3EBZy0UiVHtrL7ZY21sP8JnwBZPAhuonKyq5Q4ma7j7VQ7UY8jttt276+fSI
         Qdq3CD4cxdXBeYv3wIlTHr2iMUzhnW1jr/QPottwY7VAFPYmSCDoy8g8BrNPADYyqRZi
         RHug==
X-Gm-Message-State: AOAM531b21JjmSy1Yhe/PcOICm4K94gTu/ZsxNeetpcX6fvtmoSfpxW5
        GkpbwcQdZMXOG2yKvq6+jk8RVHEcuayWbR+2TPsdZQ==
X-Google-Smtp-Source: ABdhPJyvaS7gUP6HUAzHKKgtRP4C9Mp35iZpjbSbMDDM8Y8tIigQktn8iFhCJSpMTQY4LzKuFxygyboKlXkIdveVT8U=
X-Received: by 2002:a25:7b86:: with SMTP id w128mr20063583ybc.273.1625507990140;
 Mon, 05 Jul 2021 10:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210702032943.7865-1-lecopzer.chen@mediatek.com>
 <20210702032943.7865-2-lecopzer.chen@mediatek.com> <CAK7LNATqZdZy9mH2qbFJPGs81a0fEFGPutqmvrdz1U51zOvH3Q@mail.gmail.com>
In-Reply-To: <CAK7LNATqZdZy9mH2qbFJPGs81a0fEFGPutqmvrdz1U51zOvH3Q@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 5 Jul 2021 10:59:39 -0700
Message-ID: <CABCJKudYQV6Nt=Qq+zY=9JF1WmLVLnx+--3mJA9dkhLMhMvuFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Kbuild: lto: add CONFIG_MAKE_VERSION
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yj.chiang@mediatek.com, Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 7:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jul 2, 2021 at 12:29 PM Lecopzer Chen
> <lecopzer.chen@mediatek.com> wrote:
> >
> > To check the GNU make version. Used by the LTO Kconfig.
> >
> > LTO with MODVERSIONS will fail in generating correct CRC because
> > the makefile rule doesn't work for make with version 3.8X.[1]
> >
> > Thus we need to check make version during selecting on LTO Kconfig.
> > Add CONFIG_MAKE_VERSION which means MAKE_VERSION in canonical digits
> > for arithmetic comparisons.
> >
> > [1] https://lore.kernel.org/lkml/20210616080252.32046-1-lecopzer.chen@mediatek.com/
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
>
>
> NACK.
>
> "Let's add MAKE_VERSION >= 40200 restriction
> just because I cannot write correct code that
> works for older Make" is a horrible idea.
>
> Also, Kconfig is supposed to check the compiler
> (or toolchains) capability, not host tool versions.

I feel like requiring a Make that's half a decade old for a feature
that also requires a toolchain released last October ago isn't
entirely unreasonable.

That being said, if Masahiro prefers not to rely on the wildcard
function's behavior here, which is a reasonable request, we could
simply use the shell to test for the file's existence:

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 34d257653fb4..c6bd62f518ff 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -388,7 +388,7 @@ ifeq ($(CONFIG_LTO_CLANG) $(CONFIG_MODVERSIONS),y y)
       cmd_update_lto_symversions =                                     \
        rm -f $@.symversions                                            \
        $(foreach n, $(filter-out FORCE,$^),                            \
-               $(if $(wildcard $(n).symversions),                      \
+               $(if $(shell test -s $(n).symversions && echo y),       \
                        ; cat $(n).symversions >> $@.symversions))
 else
       cmd_update_lto_symversions = echo >/dev/null

This is not quite as efficient as using wildcard, but should work with
older Make versions too. Thoughts?

Sami
