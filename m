Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1643041F16D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353658AbhJAPph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhJAPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:45:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1EC06177F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:43:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u7so8247297pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKJJyxKfKlMUnsJQnb0rUQ1STR9PowXhUmgvxDc7CMs=;
        b=2anNGonpk6hs8FlqG1SC8My+b2UdlFhDHFpjWBVsCzgG4MD2Z0f104AYFr4ttQKgMa
         gXLrXlXVbjadxdATVYvWyhjxjEgxl2TDelIGM1aCooJCZUu251aX1aFWQVqVweJ6dhxW
         a2wVagSMdYQ+Tyj0HGjlBu/NZBxNKVFKB3BTncmFd12ouz1i2ORmu/DcB79scqa7Feks
         59POqpGvntpWMKJ7nbwCmLRDDVJy6Y/nqJXw+caWSi3tD4yejfM6TWbgE27UxE2UpXR+
         5S5hqQ4oTRWg0hGNBvCJJ8mWXTSMmuIm//yr8AaU1yaql8IW4ddKgJpTMXIDgfb2VpSS
         L7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKJJyxKfKlMUnsJQnb0rUQ1STR9PowXhUmgvxDc7CMs=;
        b=2QjtVo2Kdkd8mdL1mXgFoKTE8fi2WT7zlAmXr/UMDdrGDjmcRQ6WBde0lT1SA6oMRx
         zmvPlHQGZ6V/qaodKDYmKH7hJikWrWtC1uJmMlMNnGGdRywtRTkSkZ20S1IOL9h3awHe
         OJtqa7UiR7V/ZxfJvDt32k6ScsKthn1lvd4YOrmrpZewwnH35l5QWup9pbuQ5uzr3Q+S
         K69vE1Td36EuEgJKqCQDSzCzeK1i4MD34tkHVASptCF9jzfGWrYVgcYBCVKTJLzcxq06
         Og6XmKVobXF0jT2dRuqiE9sISIoz87OGponKsagWhLff0mo+dfXqqumB1pm9J5or9wuK
         bOOA==
X-Gm-Message-State: AOAM533QRWMOCs9Y9+OCbkVDZFL4X4t4JxABr5JQtcdjiKw2MmkarMYC
        iONWoKGQ/NjwojsLhv65NvkCe3xPVEgJf3DxHbD2IQ==
X-Google-Smtp-Source: ABdhPJy9CD4e0cP7aqfpAf0SORxV5Iael7KQefm/+QjbfMrw2Lsrjt9r+yof+r/QSpM2h3uMbArXmnpzJryeG42/tE8=
X-Received: by 2002:a05:6a00:16cb:b0:44b:bd38:e068 with SMTP id
 l11-20020a056a0016cb00b0044bbd38e068mr12021599pfc.34.1633103030346; Fri, 01
 Oct 2021 08:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235635.1348330-1-willmcvicker@google.com>
 <7766faf8-2dd1-6525-3b9a-8ba790c29cff@canonical.com> <CABYd82YodFDwBxexCv+0hpYrdYEX1Z1CvnRkmnBPkEJNJ4bssQ@mail.gmail.com>
 <CAOesGMgSt_mYvRzF0rC=fnjMYGO9EX0_Ow2cD1d8XKLD5pHsZA@mail.gmail.com>
 <CAGETcx-b0ea-rqH+fj37sq9SLWY=+ePK94Y6rnLPuNbqFVBWmw@mail.gmail.com>
 <CAOesGMhQ3YsLJeQ7aUfb=0oNa3uPCx42wO1U7-ArqJTAUq1G3Q@mail.gmail.com>
 <CAGETcx_k2-mo9oUcYhsXhhsazLdwbifjP7ZT8pvyEbWB5k_qQg@mail.gmail.com>
 <CAK8P3a1HtDoEDeqs42s1hDzCZMwU7MhudJ7TVONn6TjoijaWRw@mail.gmail.com> <YVb/pQ1l34TcP81G@google.com>
In-Reply-To: <YVb/pQ1l34TcP81G@google.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 1 Oct 2021 08:43:38 -0700
Message-ID: <CAOesGMgUdaMEKh5JtDX+iqo7wjpDBT+j3s2Rd=dM88ZZGUWHpQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] arm64: Kconfig: Update ARCH_EXYNOS select configs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Saravana Kannan <saravanak@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 5:31 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 01 Oct 2021, Arnd Bergmann wrote:
> > The vmlinux file is clearly too big and includes too much stuff that should
> > be in loadable modules
>
> This for me is the crux of the matter.
>
> The ability to replace modules was only brought to light as an "and
> also, this is possible".  However in retrospect, given the attention
> this has received, it probably shouldn't have even mentioned, as it's
> not that important.

Too late, unfortunately.

I would actually argue that given the benefit of needing more vendor
engagement upstream for GKI to be smooth, it's in our interest to
welcome those engagements and make the most of it and help vendors get
there, and it's against those interests to make it easier to be
out-of-tree if it comes at the expense of our in-tree users and
maintainers which this does.

> We should focus on the benefits of making parts of the kernel modular
> if technically possible.  The most prominent of those is core binary
> size, since this has a direct impact on boot-time and RAM usage.

The way forward here should be to focus on the problem that needs to
be solved (vmlinux size) and not overly fixate on whether this
patchset is what needs to be merged to reach there, given the
downsides observed. I'm not saying let's not improve vmlinux binary
size, but this particular approach isn't appealing.

> Reclaiming dead code after boot is certainly one way to tackle part of
> the problem.  Ensuring that it's not even loaded into RAM in the first
> place is a better more encompassing solution to both issues IMHO.

See my reply to Arnd; the reason some of these drivers aren't modules
today is because they are needed during early boot to bring the
platform to a stable operating point. Work on fixing the binary size
is terrific, but this approach seems to be shortsighted and it's been
done in a way that rubs the maintainers the wrong way.


-Olof
