Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED03E0286
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhHDNzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:55:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbhHDNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:55:40 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxmBc-1n4jGi12SM-00zFI1; Wed, 04 Aug 2021 15:55:26 +0200
Received: by mail-wm1-f53.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so1516857wmd.3;
        Wed, 04 Aug 2021 06:55:26 -0700 (PDT)
X-Gm-Message-State: AOAM5303ILmV8BKgi/SZR040uPX1afQSYRfNM2WqhFLZ/NkHbLFnuELr
        1P0XtHM4pY7gVDLK214FKC+eme/6d3jk+VDGbUM=
X-Google-Smtp-Source: ABdhPJwDFsHBF22f8Wqozeaut6UIlHtczJbkX0G3MU6rJlQNmQa5Uqm62X/H+k4KrenEDbOxO68Jg/vZ6B5uO0dsHAk=
X-Received: by 2002:a1c:208e:: with SMTP id g136mr9939159wmg.142.1628085325875;
 Wed, 04 Aug 2021 06:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210804043439.11757-1-o.rempel@pengutronix.de>
In-Reply-To: <20210804043439.11757-1-o.rempel@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Aug 2021 15:55:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0285V=N5HPS5grOTQ+q1HF8J6_PsxCLgLvYMsD0hVeUg@mail.gmail.com>
Message-ID: <CAK8P3a0285V=N5HPS5grOTQ+q1HF8J6_PsxCLgLvYMsD0hVeUg@mail.gmail.com>
Subject: Re: [PATCH v34 0/3] Mainline imx6 based SKOV boards
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, SoC Team <soc@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XCcqNK5JlckTjb+hLwBfXaYnPANPzABvZEDtzdK+Nq1duykj8Yl
 JpgV7CdAM614Pw4RFFYrxrtUonHIUVwjZUNlE8kdmuRKXbcL2y/+gFq3YJHPo6OQPOV1iQD
 qDEf26kgaXd7r435Y8V2DZfXNxUPo/hAjR+lAYyZgKJtKGGTody5+s+TYEurVC9heTzv4bM
 mN7n8kESsJ6MOCvpd8Fhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKqE8Qi0Uk8=:kcPh2urtWp7BEfU81ZdsZ0
 R/vM2+n3ukG/dErbrTno828CmJTfvEDlyvvDrO7Z1E8DYxScNA8ORZ7oBA/PWRQRmBtsnI9O0
 OQCdD153bGLdOZ69R6fqemmddAFd9Iag9Govsft0O07Ba/9p3PryZNsHqnnV+WDa5A8h5Qyez
 S4Wl6oIojW+jRlWpunzlsBegb4m1zdj26SIdbJ6Mo60dU/4y4IfImBZ4HZ3uXrdJ9i5+7i6fc
 eAnnUWRYSNlfWDm4S8fxkVRiquA0GY4PqQuCK6Hh463R1BXSiOBqVIfwpb4U2EMI/5NGvmwEE
 EwZqkRqDYIUCfYf57egRm9DDSutREP/+L6FGo0YW9kgTgSzuqDFQtY0aT3HnQ7z+sz6JI02HF
 2bWDVYD6vKbwZfg7l+Om+l3luKNdfO421juGUuq7C/kyf1X6NwUsvdNbzs1Sou+2Cj3pV1+UG
 en3dmSg4dLuG9Enw8dDOqbkdfPQULW3NRtnghDsfGSRT1ixO6qh1yo1OChX0G8Gfyv2fUoii7
 V2b74ZpvHPTScdj6h8Yvf/5KNzxhKep7HNgJmahvXbvzE1VA/k6FAI/VxX3avGEXRx31vmoxx
 f6Hv9T99bzGONqPUpBbjm1FDFToZ0Bk6FqFfIzyF7om/EhlW6dkU4a96nyiMTQq0FRZfa21lZ
 ap+TM9z52R6U/rJ9q24qUNlZOBuWmjU8hmH9/9UtdV/+T/UuHagyqUiIHp8ckaHYZC9hWD9gc
 l+x9xpdUi1YtVEf/kGK4Q7B7YeIgJmfNo94SrAdqrbA7Tu7Rj2oeacecYDPJujsALEdPyvTqZ
 hm/0jmuPg6owEKNjx8x+/sExHuFd9UFFnfUeG06XIt29p+WjhfjUehcg6mgkRmBuz0ucQwmOr
 Ban567U62oYSTHVZLqdycSmT9ukyQjcP7egUHP65WKciGS6Spr2W4xjJNcD8J3kbgc3/vrVWS
 R2lrXn2Ay87RVFaHijfbOtpnLghtuGyzOYSmvHIkNrjtjZ3haSYip
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 6:36 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> changes v4:
> - add vref-supply to adc@0
> - split gpio assignment for the mdio node

Hi Oleksij,

I've dropped the series from the soc patchwork, since this looks like
something that
should go through the i.MX tree. Please make it clear from the cover
letter and from
the 'to' list what you want to happen with the patches, and who should take care
of them.

Any patches that are meant for platform maintainers should not get sent to
soc@kernel.org. If you think you need me to review the patches, you can
send them cc my personal address.

      Arnd
