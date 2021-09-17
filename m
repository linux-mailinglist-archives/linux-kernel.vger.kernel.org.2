Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1908740F2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhIQHNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:13:04 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhIQHNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:13:02 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIxFi-1mCL0I0NSc-00KSF2 for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021
 09:11:40 +0200
Received: by mail-wm1-f47.google.com with SMTP id y132so6536557wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:11:40 -0700 (PDT)
X-Gm-Message-State: AOAM530uyZBffIZwMoaAeKg9n6zhT8ZC6buPuNnzF89bzEIHYl4q39dO
        FGTr55wz+0svfcHWvq7/2SVY554EUr6I2sYGwc8=
X-Google-Smtp-Source: ABdhPJxFTrlvC3MihXqJ3h9pNAleNze2LQT6u+V8cD/dqelAjsVcxdmnT55O4mrL9MxC08iMzOz+RsSRo6YGxkc0GBg=
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr13503869wmp.173.1631862699797;
 Fri, 17 Sep 2021 00:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210830213846.2609349-1-ndesaulniers@google.com>
In-Reply-To: <20210830213846.2609349-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 09:11:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2JJ=5t16enn2LaZE_zT1ZqNVyi9FQpTUrgVsQWiMtDkw@mail.gmail.com>
Message-ID: <CAK8P3a2JJ=5t16enn2LaZE_zT1ZqNVyi9FQpTUrgVsQWiMtDkw@mail.gmail.com>
Subject: Re: [PATCH] ARM: select HAVE_FUTEX_CMPXCHG
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:quBDYVuaFJN4uivfgbd4R9FWqJPfytLaRgKOJ16WMMGzHYIVMyq
 H43HG/I5sUbq5+Hty3nK8X2etn6OPYT39j18JAkpXClXSF0j8boRe4gd5bMIgu+h+39VV2k
 hO2CbBbNiS+qsRDN8iqpwi7bqygSltDesknUYcqyk7fI3yV1otuPETzoc2SRIxf/iRHKpkU
 1jyJifRLzJcUyEhB/czSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+x7oeoRqoiw=:Z/gbgC2cIMARF+giK/Qznv
 wAjXnII7O4PvB0DCjKaoR/6ep5H/Dqvc4VlrBCMAuv2CQhqzAkJVTW1y09ixniEDJI6NT7/ra
 22Qi4Z2s98FepQ/VjGa2hcp8bJmLH8ekyX28FI7uiCZNd3FMxEjgJuctnNr5AWtbmMLoiwXMK
 llukHOAqKXkDkoqHG6HVSfNvuOmpd4kCL9XUWl+9JfOvn+dBWB5WM0iWCgPiyzci08X87OEl+
 +7AJFFKVRud1g5bu9/In8wK2GPxovrFF61J2iA/e2lCX1xRaKSkkGwbplZ/Pj6qx44dbBKsu0
 JSvcQf3yNYprpMxpdQFfQpoXCemXhFJmmDwL+r+rZIm28ERaz+k6FlV5mnyTGqHRoTo6w+LbR
 5ZKcQ48Vvu+GteOaLGhzBVXrRY5oj2ggCk3YLX5WbzjG2i3vGHOdT5Bn/vWtFHn0H2RXp1pVi
 kWLjOirOZBcgadwqX+mLd9PgHbJvK7c60iW68hCl9ldoS1dvtDeO2hc0c15KzgMf93jyQwIEq
 RgUcoDImEwWCeLEBNyxQ4mA9E/KttvwdCLvoBE728zdtZ9Kr9bpQh8DpeFHotzwH6oZt4ML6a
 xCFWoW6km26KIBlad3hrK0i2c7mB71l5FPsHCE0mJW6htmBwKao3sEo5ZyD7fRQNpSITUg0/c
 60ncIGeAOpPsi+FJ5UNYowjxJnleSYgValDk5yX+tzNQcz+HB4FD9fmK6EoWuHfyU7vgaR2w9
 STayfKSH+KNTNUsMecBTOOBfa+P8eBoYAkD2j/VSW2gejm/I+qTsQ+VDg/H60iiquUGJfeDGe
 uBuSU0J0LM7IHds7VS42VFV4rJhcuJudha3f47kKj6gNEfVll1js1w70qqqIktHBJ4KFWkVFy
 PpAl9nqMq+6qDLnQcdSQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:38 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> tglx notes:
>   This function [futex_detect_cmpxchg] is only needed when an
>   architecture has to runtime discover whether the CPU supports it or
>   not.  ARM has unconditional support for this, so the obvious thing to
>   do is the below.
>
> Fixes linkage failure from Clang randconfigs:
> kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> and boot failures for CONFIG_THUMB2_KERNEL.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/325
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Nice! I did remember that we had come up with a number of solutions
for the build error and that at least one of them was an obvious and
nice fix, but I could never figure out what it was. This is clearly better
than any of the other ones I had found when I last looked.

I would add a reference to the commit that introduced the conditional,
and a request for backports as well:

See-also: 03b8c7b623c8 ("futex: Allow architectures to skip
futex_atomic_cmpxchg_inatomic() test")
Cc: stable@vger.kernel.org # v3.14+
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
