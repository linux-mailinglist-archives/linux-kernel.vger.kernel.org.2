Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A93872E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhERHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346993AbhERHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:14:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648ECC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:12:53 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j19so6742446qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Etv0bMy2ExffqTEHNnEhIyqEg6RVlF3RhM8zehwKhik=;
        b=bmRk3P6jArq3zPHbmcniMQI5mWZATkEkWOdoWWi6h8QgyyK4DCXa2XgWay+glqvkao
         lpgUkalbToVuU92SXkckVQC12P4RorR94hxXq1eVGztHPgbhnoOgHIWK14g2+NlThnnW
         HcNnTeFFQUWBMkA1G22Kvqkud+KuujzC7N4ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Etv0bMy2ExffqTEHNnEhIyqEg6RVlF3RhM8zehwKhik=;
        b=qiOqN23mVOnp/cKG6nML+Swf24olT1dsGmGHXK7Bwgw49JhZJEJuCEYN1rkeU2//3b
         lV/xPyHyqaeHz94b5hEKXlHTk8v97ngyk8GQtHh/162HNNmK6+7V1wABCpnIek/bxuIU
         BFST0imfvnTZ9OOTgQH0Z278aZyYmCwpKZ2RaDOkZLAhF6dz5aOZTJC3wfCi3ZCRSHGz
         RnYuAzFN3OUuFfV8Rn751PNKRBPEAuSWTtyCLTE4A2CmNxM1oGlQP6WLJ31PA+m1z1Lf
         /t0MgHm6zHL+H3uhQQbUT7VQDnmQtwPgwEPSfIFA23thchoOXYixnTGAYkmpfnpaaGoN
         iboQ==
X-Gm-Message-State: AOAM533oeTLJWdXJriuYUrHnwPR3xOrs8p7hpbRrQUNrSzLp3M9XUKX9
        lQXn/HvbuftiDmXrURk/u2DcB9y+llLP1Q0MY+NF4+ysPNMi47VW
X-Google-Smtp-Source: ABdhPJwNPEB5drum/0sCovBhc4pXK0FsAFtk8mgvPaStQbzG1cdaf29xvwOtKdyKDt8CPcQhTwzzoIahBimIAkuTPb0=
X-Received: by 2002:ac8:6911:: with SMTP id e17mr3338284qtr.135.1621321972505;
 Tue, 18 May 2021 00:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165627.1767093-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210513165627.1767093-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 18 May 2021 07:12:40 +0000
Message-ID: <CACPK8XdVNfjbs+KmhT8g899d74t7M8b6iBuGC_3=DEBy+A_VHg@mail.gmail.com>
Subject: Re: [PATCH] ARM: npcm: wpcm450: select interrupt controller driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 16:57, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> The interrupt controller driver is necessary in order to have a
> functioning Linux system on WPCM450. Select it in mach-npcm/Kconfig.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Fixes: ece3fe93e8f4 ("ARM: npcm: Introduce Nuvoton WPCM450 SoC")
Reviewed-by: Joel Stanley <joel@jms.id.au>

I will send this to the soc maintainers to apply as a fix.

Thanks!

Joel

> ---
>  arch/arm/mach-npcm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> index 658c8efb4ca14..a71cf1d189ae5 100644
> --- a/arch/arm/mach-npcm/Kconfig
> +++ b/arch/arm/mach-npcm/Kconfig
> @@ -10,6 +10,7 @@ config ARCH_WPCM450
>         bool "Support for WPCM450 BMC (Hermon)"
>         depends on ARCH_MULTI_V5
>         select CPU_ARM926T
> +       select WPCM450_AIC
>         select NPCM7XX_TIMER
>         help
>           General support for WPCM450 BMC (Hermon).
> --
> 2.30.2
>
