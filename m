Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E265542A091
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhJLJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:07:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42011 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhJLJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:07:27 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mw9Dg-1mqmbQ2oXE-00s80l for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021
 11:05:24 +0200
Received: by mail-wr1-f53.google.com with SMTP id u18so64869726wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:05:24 -0700 (PDT)
X-Gm-Message-State: AOAM531GgGVfloF6sLl0LV4l7KztMFcgf64Pq1iSUSiBbpX7ANiq8Ots
        QgCDlbj6yTZ2cCZZTAFmNSthLMzzPyEjcqWz1Vs=
X-Google-Smtp-Source: ABdhPJy8YBLmE7N8KB4FOO3aYrEez2mklhdQHbuXvneWzb0TO1JbMz5s8fZ9BIbyaa2PD1sNYND2ld5WfJAD3d6JRIE=
X-Received: by 2002:adf:f481:: with SMTP id l1mr29558216wro.411.1634029524152;
 Tue, 12 Oct 2021 02:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me> <20210726140001.24820-9-nikita.shubin@maquefel.me>
 <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
 <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com> <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
In-Reply-To: <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Oct 2021 11:05:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
Message-ID: <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nNUtpjJO7eEbbVpqcYvUb3VILss32duYAgFhOXMHSvFSnnCWZGP
 UgNNtdln4Hmv6iogSUUo3Dyz4skqkd/oxQ0CScy7mGWd4b8M3LE8hhNR3EpucNjtXKdszRM
 iia/N7thek9ZOJWk6q1Z1Te5ldJCzLrqctoqXwCLGO1s94C4+H3ww+lnNnn9H0ZBN/G0WKL
 kAK5adLjqeassPB0XsFyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5p4+YUEj7c=:mEv7AIq5Q43JsXsHIDlQh9
 4V+YTdIe1jykcSZfO0mVe3onTuih9+SKXRA/XsKxOSwMbBiXgscgseD3d/iUfkg+QHn2Ds3m5
 FIunFfkURsw6KkAb5nked6II1L2QQ9jH06m1xvj7l0am4ANSWuoF4REoNbCetg2K3fHRrwzHt
 AsWX4wHcRs8PjOzfHYQuh6oSi4Bbu8biGsUycVTbzcOUw6TkoJxESxLuG8H50XpgO67/cdEZv
 BWR8at1zuj52njqkwv3sG9+rQat4x8MdM4LS/e7shJCymfzG67VrFRzUqya6G8etKWSCZn7IW
 halXZJPsnaFSrkfmxC5xeMnI879XE9+Sfn4kz3UoD5L1v3b4eF3Bq/MCdfOwQCaV/TUwUhQHH
 P1io8JYvxqVVSwi397H1SHkaMHjtWTEKwwGhW4cTLEGTvfOgsyjUKTrpwul6N2Mge11jsbimi
 zePQHxJuNpstqLGSIZWDyYzwNxT0RcAZwLuzv7lmtZu9GWXkSeetYhVqWJO3o4j/Y7IPNY3P5
 oeMPrWP8F3Aei7i27HsUcUjEWgzwDV8MBmrefArjhC9JQc/Q8i6yHkZxlKE4n0EdTnvhlGdo4
 6hAM8GcL3zBRF736vYsqKtsnFOcWxdYl1h56cA7ralCsQa03RrRexqQZKj3MFMxXXcRtR9Zyx
 uEv7phuYpoNybvvDUJ7D/VJOVzKhEsD6l7q7ScDdiwVoE48/TBzj35X4CgjWfnktdXI75xOJl
 nJqxsQKTqYF20gjZ0Th4NSWyCcbJqSrI6QpVamLu9j18A1ytUC0d0S5m4zWBG8aj6dJULdD2Y
 9r4pDYkU9YKKlAI1iDFTO2suITZTiy7VHklUXB3CN+A9qtESvcX6LUUFR2wi/ppJCeKwANhc2
 suoOM3SDMAvYy9oCIaWA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:37 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Tue, 2021-10-12 at 10:29 +0200, Arnd Bergmann wrote:
> > > > Converted in-place without moving file to drivers/clk.
> > It looks like this is just the drivers/spi/ bit of the series. Are
> > there any other driver changes that are needed along with
> > the arch/arm/ patches, or is it just the actual clock support now?
>
> There is "ASoC: cirrus: i2s: Prepare clock before using it" still
> unmerged as well with an ACK from Mark Brown, I did remind him
> about it again this morning, but I can resend it to you if you wish.

(adding Mark to cc)

Let's wait for him to reply then. I don't think it matters much either
way, since the series is not doing an atomic conversion if the other
drivers are merged through different trees, and Mark has given
an Ack for the driver.

       Arnd
