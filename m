Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071423EBF36
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhHNBIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:08:48 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27219 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhHNBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:08:47 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 17E182bW009447
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:08:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 17E182bW009447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628903283;
        bh=IIOxmNpjJY0+mi9Qvj3dpkC38f3a/+t9vF+6h5pqjY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VJ9LOAt5oQAtVD1u1zH4a1sKQThIKqLuk1ZB/+gDYznkhaNVNt4+tKiEQU1oI93hw
         /IrshGmnwmp76dfZrrgnotrLlaAtavPkI1/fvgBsLmObISBW24nIHM0qlTO/NeECyQ
         FGh1us7JVyHCn4o1vvp20tK7Q4UUF6ixx/pc8HDJTypaIOxjMLuYI3naWC+ZvEo9fQ
         n94ZPJu/ixtnvMUvsrCMT/5DB5HZZVwkjf609PHfZTlJ+BvtnAYJ43RdepF8p3zm+0
         lAhfflH7V3IojKlM4KRnyJXq4HZSB9326vHx66uRKu1NKfhP/HuRwSMWV/5C8Aa1Rv
         JRF0lfaDjCvIQ==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso18428530pjy.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:08:02 -0700 (PDT)
X-Gm-Message-State: AOAM5333W/4eWiB1Ob60mbJOumylk/0Y7xNxJHeTexZeU0er2heooyFL
        OsSA8fseTiBd/lR0i49bDr+hEZUmJc45dW9oD2U=
X-Google-Smtp-Source: ABdhPJwufRns1AaxLlrpUK03Hmu7to7ofq87FFEsnzYqyeKbm340Mup7IAl+gEh2rsC1Di2qAzPB0vWGy4tzvoqxCpA=
X-Received: by 2002:a65:6459:: with SMTP id s25mr4768167pgv.7.1628903281994;
 Fri, 13 Aug 2021 18:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210810205611.4013424-1-ndesaulniers@google.com>
In-Reply-To: <20210810205611.4013424-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Aug 2021 10:07:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0KR_xjPNzdB1aJ9nj3=A-ktU-aoP0CWvAnMJ91djfyA@mail.gmail.com>
Message-ID: <CAK7LNAT0KR_xjPNzdB1aJ9nj3=A-ktU-aoP0CWvAnMJ91djfyA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Nick to Kbuild reviewers
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 5:56 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Kees' post inspired me to get more involved. I still have a long way to
> go in terms of mastery of GNU make, but at the least I can help with
> more code review. It's also helpful for me to pick up on what's missing
> from the LLVM ecosystem.


Reviews and tests are always appreciated.
Of course, not only from those who are listed in
the MAINTAINERS file, but everybody can provide
reviews to any patches in their interests.

Applied to linux-kbuild. Thanks.


BTW, one struggle about being a maintainter
of this entry is I need to take a look
into random stuff.

KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Another BTW, this patch reminds me of Michal.
He is inactive for a long time.
I should ask him if he wants to continue
to be a kbuild maintainer.





> Link: https://security.googleblog.com/2021/08/linux-kernel-security-done-right.html
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efac6221afe1..9768e4a19662 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10091,6 +10091,7 @@ F:      fs/autofs/
>  KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
>  M:     Masahiro Yamada <masahiroy@kernel.org>
>  M:     Michal Marek <michal.lkml@markovi.net>
> +R:     Nick Desaulniers <ndesaulniers@google.com>
>  L:     linux-kbuild@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> --
> 2.32.0.605.g8dce9f2422-goog
>


-- 
Best Regards
Masahiro Yamada
