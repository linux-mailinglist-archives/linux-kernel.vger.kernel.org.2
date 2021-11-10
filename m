Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7811244BCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhKJIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:30:11 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3527C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:27:23 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u74so3846155oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjabyqMriLlEDs0oghOnUdNbhq1Wnfi0um3A6ApanhQ=;
        b=HQOFMTYJ1V/jOeYgrLDR858/DdP3Vy1c/cct+8fLcNBkXEdEq4sc92loWTLjeuONPg
         x47uvloqdX08ZQmEbi3QxrYFYH59xFKmkT2fTFowIYf2/12sp30shdW1IuBO1eBef6El
         YdXTLEbzyYwM3jxajCkH3QibZLkAqs/6pisx3Z1MLcvfheLY1jQ61jeVD7bRjD7SZAD7
         wtR1DJP0T4PDltZ2aR9tz0t00HGa4/OZkLoNUJr5r6vb134jJtJGd1jV3L/isudr8rv6
         WM2rj8sdDkizTeDk9vcZTq+lARV6Y47ubXMpY0KSaPx2FYnLfmtlp1IciHLt5PksPAhc
         bfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjabyqMriLlEDs0oghOnUdNbhq1Wnfi0um3A6ApanhQ=;
        b=C+qIYlpxpfImRqZAgiv/oeOyPRzh1aeswIGuygKebTN6V5u27aJlzh9gEZH2Om4JIP
         2agK+CGcQxNlYJdI2Zyt1Kv2jYSMUP77p+W2pNTrA4yzRhxnUU+etSUjgrVRUUgD5ElG
         AJo8jy4wE+/oUwKswMi+njG2jXo4spiFmEgLneZ90lRiUfzzh9a6Dh8wFn4u5R4ZHSAa
         9036feu4KLADFa7HY9guZEwhh1ztdU8NmZcV/BRcoZhm7yCrnLowVHaSuUshdd7MfVOL
         kM9uyP/EhfHWNQuMArVHIYjJZdWiK1DYCbX/6DNDj0Rk3ugv2EUxN1Eg2FMZe/fhaqis
         tiuA==
X-Gm-Message-State: AOAM533oLHgGpPRvLEVWS2/NDiU1Uh4mJksw2bN3Ce1/Y/yWX4J8OwWl
        xVOfVOtyrCLsUCWxVbIH4tXsiifMM0Ha/P6OJ2BPbQ==
X-Google-Smtp-Source: ABdhPJyH1LONHLtwhuZMcEBp+Yg0krY6vZeudqTwP0iP/LrQGnLZpNokAje6id0/RVcqCXpcn5QWiO0vgqMwvF5aEME=
X-Received: by 2002:aca:120f:: with SMTP id 15mr11009740ois.132.1636532843343;
 Wed, 10 Nov 2021 00:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-7-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-7-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Nov 2021 09:27:12 +0100
Message-ID: <CACRpkdZa2Y3yUteqQp9br65dj248WpGfwpf-ZZ5=PXambiwEcw@mail.gmail.com>
Subject: Re: [PATCH 06/13] arm: ixp4xx: remove dead configs CPU_IXP43X and CPU_IXP46X
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:20 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 73d04ca5f4ac ("ARM: ixp4xx: Delete Intel reference design
> boardfiles") removes the definition of the configs MACH_IXDP465 and
> MACH_KIXRP435, but misses to remove the configs CPU_IXP43X and CPU_IXP46X
> that depend on those removed configs, and hence are dead now.
>
> Fortunately, ./scripts/checkkconfigsymbols.py warns:
>
> MACH_IXDP465
> Referencing files: arch/arm/mach-ixp4xx/Kconfig
>
> MACH_KIXRP435
> Referencing files: arch/arm/mach-ixp4xx/Kconfig
>
> Remove the dead configs CPU_IXP43X and CPU_IXP46X.
>
> A further quick grep for the name of those two symbols did not show any
> use of the two config symbols; so, there are no further clean-up activities
> beyond this config removal needed.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied to my IXP4xx tree!

Yours,
Linus Walleij
