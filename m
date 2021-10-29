Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B131043F750
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhJ2GjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhJ2Gis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:38:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4AC061570;
        Thu, 28 Oct 2021 23:36:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y10so8350170qkp.9;
        Thu, 28 Oct 2021 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEILQQUesMLhwBV9VT8SbrMsd7pCCV240pHTJH2Qsog=;
        b=QXSViklaM4teVWomsS6nozIFsVAusS+qiaF6O6FPcwppPbquWn9haZBHBXZHRPe9H9
         CAfcJpRnxjo9Bo72NsgpeacT9Gs2yQKGGmq7Ghk7f8n4MiEInB/dfxccL/Hs8k6k7+vu
         D6NxYtVzEX5+K7GpE5cJI4K6Hl1aQKeXN/Ug8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEILQQUesMLhwBV9VT8SbrMsd7pCCV240pHTJH2Qsog=;
        b=nR6EsyskmV/XCz1upN870MERZv5Geg9thy7TvoDqE0AKumkygM5O4Hr/l93TpNefle
         aTybIQ8XyTHKDKyRzbVNEQDPvW/akiO5iOLZJ9rD17fQrEn3/YL8zmQm2OzQPU/ukesv
         dkjciaHIUaCXXNeioZOgMzw6vUb7XDdXdyJqymoCtGG7hCf7nZ9BsJ0GcHHQ3KgC3+rf
         ZpPe4ZzB+B1pGUYPCswMHAQh8Zsv5PGhO2yv81W8xgmzJYcYnLH3s45z0tAjMwguoiTg
         6xf01NxeXtA64fkN++lBAoufzVcfLmaOJOUoEs+4jXxNXxIMX8v58ivYhvV8tZLLemFB
         0a2w==
X-Gm-Message-State: AOAM533f3n1UDZYylhBFdLwNNrGZbYIwm1tuPMaBV7Xvo5CCr70EIv6e
        3nnTizQk0VKGwHdP48AtC8UnVpO7NiXlfB1Y2cM=
X-Google-Smtp-Source: ABdhPJw+DYkn9qbJPDwLbtukPFCsVeNOpMOGwR9WpQvTJfSN3aB1GiBugZUngVxGSoZiaEgDJPquEP13D4o2XPpJ450=
X-Received: by 2002:a05:620a:440f:: with SMTP id v15mr7337283qkp.381.1635489380025;
 Thu, 28 Oct 2021 23:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-12-lukas.bulwahn@gmail.com> <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
In-Reply-To: <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 29 Oct 2021 06:36:08 +0000
Message-ID: <CACPK8XfiN5qziPHLU6J=bC34mcjz+ix7jjSX=xk9zsr7+vyTdw@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
To:     Arnd Bergmann <arnd@arndb.de>, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > There is no and never was a Kconfig for ARM_ERRATA_794072 in the kernel
> > tree. So, there is no need to select ARM_ERRATA_794072 in
> > ./arch/arm/mach-npcm/Kconfig.
> >
> > Simply drop selecting the non-existing ARM_ERRATA_794072.
> >
> > This issue was discovered with ./scripts/checkkconfigsymbols.py.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
>
> Could this be a typo? Maybe we need to enable a different errata workaround
> here, or maybe that code is actually needed and has to get sent.

Doing some searching, u-boot had a workaround for something called
ARM_ERRATA_794072.

https://github.com/u-boot/u-boot/commit/f71cbfe3ca5d2ad20159871700e8e248c8818ba8

Lore has the review history for that patch:

https://lore.kernel.org/all/6be32e0b5b454ed7b609317266a8e798@BLUPR03MB358.namprd03.prod.outlook.com/

It looks like it's the same workaround as ARM_ERRATA_742230, which the
kernel does implement.

It would be good to hear from the Nuvoton people, or an Arm person.

Cheers,

Joel
