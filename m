Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C419393F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhE1I6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhE1I6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:58:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EBDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:56:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t17so4288524ljd.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngbdHcScRgC66WzU058a9FL4s4wB33eKdqXI7VRFgL8=;
        b=Z87YajfzATDck1XX5ofY/Fo2aSyr0FIl/jwcfoAsLrmWgX0156axO9VdP0Xi4FzEB2
         4mSU3A9VG9vzR7WqoHE5ecEScMKhQVlpkxJu1tJAI7GYOvY34J5DVK1BPfveFDitGKp0
         9bQ3EJ12Ga2/Qn6VmKnZpD50uMIT0O2UJcrAbE4FqXxaUW6hzrmr9ADmPXoMW8X/WEcV
         1Oa+9SQBP5Z6pyUpgGH5r/3BBN/OGgg/C3IRublFx0YGDp5/Li9DkX+j7/GosSwZW5XV
         CWmtVsRXIHETmlhu/opywrTEGYv1/8nIw5z+cLVBuWUit8wwyA+NzeZkVGinzlGuGdSD
         CAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngbdHcScRgC66WzU058a9FL4s4wB33eKdqXI7VRFgL8=;
        b=jVpYgH0ZBYx5fZmTZaW8syNX+6A/azoi8uur3rq5bgitgyznd6kq5Z4MJnHg/R4BDh
         GZmP0g/wgukGrkIl3la6A4YRxQEF2SHS5X98JZ0/55Va4D5M1hKloQhwg2pLmIC7sfC2
         LMeNJCGOkosokG0vJg1+QLPHJEppCttGQtDoWVwJmIDH0VqVQOtAVqoRsxq6ietQ31C5
         AHEiiLzMuWQdrZs72maIUoXXdIIymDiZRjMapVNhwowPfy/WTkVHkWEH8Ojw90kbzhFQ
         9ZyE8t16qTrSyew9qqspK83lBjsg2AmgARRy3Ba4CK7LBG0pZxuhwO29m2s5pXnVw29d
         33Ew==
X-Gm-Message-State: AOAM533vPN41sSgLKoY7ShA7zDPhrEUpfFxDvObJ80u2zCTWcld2YBLt
        La0jqDJtOYR/G7Tb4A4nTRh3la2bRsJjLKy1dWSwUg==
X-Google-Smtp-Source: ABdhPJzzLm/rJxRCdmzE4zdogob2NM2r0tTmXpFKcdZAOhw6J/EJ968PQrD30kgcZJ8Xsk+lp3wgSKowSVClRnDtWb0=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr5617107ljm.467.1622192202689;
 Fri, 28 May 2021 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <be1c35eb997959b4939b304ef26664dfb9cd2275.1621941451.git.esben@geanix.com>
 <CAK8P3a1HGJpYnmhGb_eZzrv0ZopOJ-JuC6hyNP8V87C1Po9ruw@mail.gmail.com>
In-Reply-To: <CAK8P3a1HGJpYnmhGb_eZzrv0ZopOJ-JuC6hyNP8V87C1Po9ruw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 10:56:31 +0200
Message-ID: <CACRpkdZpJOMg2rNbJW_Oi-P5O+k6=rMB1XEUd1BwJQK14fMH2w@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: only enable pinctrl as needed
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Esben Haabendal <esben@geanix.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 9:55 AM Arnd Bergmann <arnd@arndb.de> wrote:

> I think it would be even better to leave all these drivers to be
> user-configurable. The symbols are currently defined as e.g.
>
> config PINCTRL_IMX51
>         bool "IMX51 pinctrl driver"
>         depends on SOC_IMX51
>         select PINCTRL_IMX
>         help
>           Say Y here to enable the imx51 pinctrl driver
>
> which could be changed to
>
> config PINCTRL_IMX51
>         bool "IMX51 pinctrl driver" if COMPILE_TEST && !SOC_IMX51
>         depends on OF
>         default SOC_IMX51
>         select PINCTRL_IMX
>         help
>           Say Y here to enable the imx51 pinctrl driver
>
> Today, having it configurable is pointless because you can't turn it off
> when SOC_IMX51 is set, and you can't turn it on when SOC_IMX51
> is disabled.

I agree this looks better.

With pin control drivers I think this often reflects the desire
to not make it possible to build a kernel that will not boot.

Usually this is because initramfs is assumed not to be used to house
the most necessary modules, so any modules need to be loaded
later from e.g. eMMC and that of course needs pin control
before it can be mounted.

I think it is a bit of "embedded culture" to do things like
this, because the distro way with modules and initramfs isn't
used by all embedded build environments like it is on your
regular Debian, Fedora, ... etc. Instead they assume a
monolithic kernel tailored for the hardware to a certain extent.

Maybe we need to clarify somehow that the driving idea
behind multiplatform also assumes modularization and
using initramfs for the most necessary modules and things
like that.

Yours,
Linus Walleij
