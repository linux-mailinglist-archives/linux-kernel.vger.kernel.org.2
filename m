Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4243E459
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhJ1O6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:58:41 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33537 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJ1O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:58:40 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mz9lL-1mswmd0Cm3-00wBpl; Thu, 28 Oct 2021 16:56:12 +0200
Received: by mail-wr1-f49.google.com with SMTP id p14so10658012wrd.10;
        Thu, 28 Oct 2021 07:56:11 -0700 (PDT)
X-Gm-Message-State: AOAM530zHgU/Vw5xnI07VQu5CNYWmyot/ZYrpzoRqofhbc+8/SuVZ5XG
        SJT2o1dqBIhqgzIoKZ87YQ9HXhM2FwD1ONvWf7o=
X-Google-Smtp-Source: ABdhPJwx9NcCmHJMSLM29R/SVHRZzG6w605oc3D2wfqxIx3V41SSM8/BC8wbtl7pPHOGIthLY2prb87n5I3vpE71OMU=
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr6338651wrb.336.1635432971649;
 Thu, 28 Oct 2021 07:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-11-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-11-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:55:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3O0ZGmvaZkRnBCjqUG70+CpmitP2RebW44y=JCEd92Kw@mail.gmail.com>
Message-ID: <CAK8P3a3O0ZGmvaZkRnBCjqUG70+CpmitP2RebW44y=JCEd92Kw@mail.gmail.com>
Subject: Re: [PATCH 10/13] arm: nomadik: drop selecting obsolete CLKSRC_NOMADIK_MTU_SCHED_CLOCK
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FOVKSMgYrX4xdntFWeLP8fgcAfyuwbT1pfSao+mxRVQHjC4oiZv
 98iTMHUER3SBCnEBNtisi45oGy+tOjbNjUnQQ19owJMJC7XKH7an8UHgDunqmuWr5FPmhf9
 sZ+9LjlaGT3+TFEc8huFBdPItz+31Uh6UUe0IOwjSjfbbDEv7G38G98pWGEe3KrFVqidex7
 OP5zVNjMMZaqawB8dsMdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FrJN2Hl+xLc=:UP5kNEn6SFr2XgZ4WrHTf9
 lpIuiGIjDVOuOATaWy7gfiLQ46YYEjxemMSk0SI6jZvyLrbntls30WBQ5+IzEULIm5l2ZljXK
 vx0v4rMecW40fnibhjKiwY7CwaDLs5p/QT02WV/sZdLxn+LvX9+yqqRggzysWiL/dbthZefS0
 /Dbh/wPtKusXDj/5Y3czRMddtP6WItNh0icGJsDHqLWUcGbd5rLOTVwj3X67tdtc6xn6c+KXS
 w/gkQVbBOGqlvl5UpcPvo5C9gfR0K+TUJKvRV9dH1cOftYoHmlqVU72UW9Rg1r/ZIDP9nGFX6
 NCSlJ5Y0o9GH4CjBv52pRrfrwNW3M2TL2W/NpOK3ZG+FrrA7og3pqSMD8LoCN8FItPZvXCYVM
 XNCq7RClVaayye8v3RzSMDxzmTLjrhg5slTJXLAc5XhNg9kydg7zTlSQb31+TS7nHNpuxQuJM
 ybmezmXOsZ+BFgK707S4EJKLWp+5EDz1uF1hfcy07TuBpMtQj5gmLIUH5oP44AHRVior6MJOZ
 /lW6vjIot5I5y01k7B2Rnt0slvOiWOg+CI1gC/wS/CopDzMN5GpN4LiI9/STns9O35Uf09BU/
 1/eKdU11+tRydtR55lfGGlRdMUaMIZCkJq6L0JOv1YcxTM6vMwTkUYf8nZ/SHfiIICtfysct+
 ou39kuAEzT6xzOgSiuRScGdqnB3/abqhYKnvVLkyFYm4QOzHN6jKEJx9LYTGRXBzfe/wpcwaU
 rC7ZnnBhIdm2Bpom+DLyhZ8lDyXzjCgqSAxONLBAp18bZL7Ai58TFjga+H/g3ATFlXV3SfWED
 d0BzcU056Dz0uvSvsKe6EFXkTwt9XsAACwGAcYpyjo3/nhKYmiaYby3yRKvPNDwvZQuBIm8K8
 JxH5B6yx1UPaIqNidpnGRqRtOc3Iody96pcB467XgGtf9qNqb4CHhRtJM5Zs4LqeyR96oRhkf
 PBguNa72vqw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 85b6fcadcf66 ("clocksource/drivers/ux500: Drop Ux500 custom
> SCHED_CLOCK") removes a sched_clock workaround and its corresponding
> config CLKSRC_NOMADIK_MTU_SCHED_CLOCK. Since then, selecting
> CLKSRC_NOMADIK_MTU_SCHED_CLOCK in ./arch/arm/mach-nomadik/Kconfig has no
> effect and ./scripts/checkkconfigsymbols.py warns:
>
> CLKSRC_NOMADIK_MTU_SCHED_CLOCK
> Referencing files: arch/arm/mach-nomadik/Kconfig
>
> Simply drop selecting the obsolete CLKSRC_NOMADIK_MTU_SCHED_CLOCK.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
