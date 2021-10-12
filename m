Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F642A356
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhJLLce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:32:34 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:37475 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:32:32 -0400
Received: by mail-ua1-f47.google.com with SMTP id f4so12151712uad.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mxx6LhYcnZkltIS5O+8bqf9djcqENUX/1eFzYLlP5Lg=;
        b=nmv/W0yVar4shargUhbY8OPj5b6Inuc2xamVJF1fmzFu9e+/ZK3obJZXEMPNj5h4MK
         baQBew+Z28ky/ePDWGywbnO9TNwdjYudliahE5jxLv1g6cnWW1uT+7Y7v0PT5dzTdn2T
         KkDp6KqYy2Bf6pzNomntVzDkN2yChl+VRsJ9S5hp42yevFTxVJKR5Gfp9wX/j+iHlHlw
         0jTYNMmS1wgKoXOf8E2eBWscWqZTdkdC9/OZqYpqGnfjXWfmPAKcHpS2FxfoYmD9vCNV
         7JCZX96FbVRGBd2chDma7NdR38aoZTv2Csy/Kt8MYxtXSs/YEbL7++KfYZfctGlo0l0i
         SfrQ==
X-Gm-Message-State: AOAM530LVo1Y9+gzm0KtQLINYbd+iBnOTDB1xs8AR54bVA7vI3Sud/J/
        x43ui1XwCNm3ZhRdWDk1Meoesa+PaO6vC55z2Ng=
X-Google-Smtp-Source: ABdhPJzhbMf9LdDAbzUzsAhrGUK+yvRDXd5WORrlMPZf9brhwBfRpEWs7MqT7CHyxmMUVCsqCWLd24+Cn2Fd8eGISLQ=
X-Received: by 2002:a67:d583:: with SMTP id m3mr29630362vsj.41.1634038230323;
 Tue, 12 Oct 2021 04:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-9-nikita.shubin@maquefel.me> <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
 <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
 <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
 <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
 <YWVixgDQtJ8EGbwo@sirena.org.uk> <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
 <YWVmvHsEkPFkrD/R@sirena.org.uk> <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
 <YWVvyKq4W4VShiRU@sirena.org.uk> <00781d5212bb4015064d07e762ae0695d16e834e.camel@gmail.com>
In-Reply-To: <00781d5212bb4015064d07e762ae0695d16e834e.camel@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Oct 2021 13:30:19 +0200
Message-ID: <CAMuHMdUCpfpORD9r28r1hdtdKMPyvXtkYZQsiBCfM8WDcLYKFw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Tue, Oct 12, 2021 at 1:26 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Tue, 2021-10-12 at 12:21 +0100, Mark Brown wrote:
> >  Looks like Arnd is ready to pick it, and the only dependency which is
> > > not yet merged into Linus's tree is "ASoC: cirrus: i2s: Prepare clock before using it".
> >
> > OK, so I'm still unclear as to what's going on here.  Arnd's mail where
> > I got copied into this subthread suggested that things were getting
> > merged by individual trees which is generally easiest?
>
> I only wanted to ask you to pick ASoC patch, I can resend it if you'd like.
> It has no dependencies and all the previous patches were already picked
> and are visible in the Linus's master.

So it might be better for Arnd to pick up the ASoC patch, too.
Else he has to postpone the final CCF conversion patch one more cycle,
to avoid regressions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
