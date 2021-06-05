Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5439C939
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFEOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 10:50:33 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:46374 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFEOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:50:32 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 155EmEWE016438
        for <linux-kernel@vger.kernel.org>; Sat, 5 Jun 2021 23:48:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 155EmEWE016438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622904495;
        bh=cRMYCqyhbuHYo3PtQo2hB2py/0ma5qgzmiV8CCsV0Io=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hLQnNZVovI1oAWggePY0HMHN++z6up/fxQh/OTiAlhkMSeU9GVX1ZsTBEDGjK1thP
         hxT3xr8Y/HpH7yO+BuXDpLxszUcZCE0Tfl0/I0CiMFXr6YEfvpb+D3ujJIf6JUa9u7
         iN4Ukr/BoQ+NX/nSEGBCCdlyb2/uniXgftvOIxEvvSXxL8cB99A2ePA+AMeGWSwdAZ
         dAHkQH/Tc/9SXFuPug0QIa/6RsunUuL94o9cK6iA5C1eUEXm8tN+uV1HMVVutvPvqP
         tAXbxEnhYZTWQWrEv7bguUuBLwHnPdKdgZeQuFjJLjeFb7PyhKt37JWYd006r4CaAF
         7Grs9emLV6stg==
X-Nifty-SrcIP: [209.85.210.170]
Received: by mail-pf1-f170.google.com with SMTP id d16so9565501pfn.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 07:48:15 -0700 (PDT)
X-Gm-Message-State: AOAM532swFACewIvEq3e4hwFczJvLB/XjraeRF1fp4jSUJfw5TSxOXFb
        7g3n701YYapjY7HOGVGjFr7CLGIuLo5WGCU1mmU=
X-Google-Smtp-Source: ABdhPJz1hAvmJW1oyuAhOamHZfEhkrQJm9BPserYFjsywFJEnd6o6imkyq8dp4rY8Nl9//tYLkUwF3X2h8y1Sr6BJlU=
X-Received: by 2002:a63:36c1:: with SMTP id d184mr10124119pga.47.1622904494341;
 Sat, 05 Jun 2021 07:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210601213143.1973770-1-helgaas@kernel.org> <819816a2-be1a-8d63-a26b-31f8caa8c944@infradead.org>
In-Reply-To: <819816a2-be1a-8d63-a26b-31f8caa8c944@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 5 Jun 2021 23:47:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSxkAJp_PmW2wnZeadQq30UXJY+4hGFmTm5X=sxMPr1Q@mail.gmail.com>
Message-ID: <CAK7LNARSxkAJp_PmW2wnZeadQq30UXJY+4hGFmTm5X=sxMPr1Q@mail.gmail.com>
Subject: Re: [PATCH] kconfig.h: explain IS_MODULE(), IS_ENABLED()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 6:53 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 6/1/21 2:31 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Extend IS_MODULE() and IS_ENABLED comments to explain why one might use
> > "#if IS_ENABLED(CONFIG_FOO)" instead of "#ifdef CONFIG_FOO".
> >
> > To wit, "#ifdef CONFIG_FOO" is true only for CONFIG_FOO=y, while
> > "#if IS_ENABLED(CONFIG_FOO)" is true for both CONFIG_FOO=y and
> > CONFIG_FOO=m.
> >
> > This is because "CONFIG_FOO=m" in .config does not result in "CONFIG_FOO"
> > being defined.  The actual definitions are in autoconf.h, where:
> >
> >   CONFIG_FOO=y   results in   #define CONFIG_FOO 1
> >   CONFIG_FOO=m   results in   #define CONFIG_FOO_MODULE 1
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>



Applied to linux-kbuild. Thanks.




> Thanks.
>
> > ---
> >  include/linux/kconfig.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> > index cc8fa109cfa3..20d1079e92b4 100644
> > --- a/include/linux/kconfig.h
> > +++ b/include/linux/kconfig.h
> > @@ -51,7 +51,8 @@
> >
> >  /*
> >   * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
> > - * otherwise.
> > + * otherwise.  CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1" in
> > + * autoconf.h.
> >   */
> >  #define IS_MODULE(option) __is_defined(option##_MODULE)
> >
> > @@ -66,7 +67,8 @@
> >
> >  /*
> >   * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
> > - * 0 otherwise.
> > + * 0 otherwise.  Note that CONFIG_FOO=y results in "#define CONFIG_FOO 1" in
> > + * autoconf.h, while CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1".
> >   */
> >  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
> >
> >
>
>
> --
> ~Randy
>


-- 
Best Regards
Masahiro Yamada
