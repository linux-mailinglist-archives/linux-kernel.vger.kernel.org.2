Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB74A43E474
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhJ1PA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:00:58 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhJ1PAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:00:53 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmDZI-1n6KsD2Dxo-00iFeg; Thu, 28 Oct 2021 16:58:25 +0200
Received: by mail-wm1-f48.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so1315537wmj.5;
        Thu, 28 Oct 2021 07:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM531D/Guk8zXFE3WjnJnk5BMtjQsnf5ISICTL/nREvA+tzdBQY70N
        YOLXFwXqK2dAk7dPhLJsc0GOp/I037EFBsxLiQk=
X-Google-Smtp-Source: ABdhPJyxtaNUvQd3ORnZZLVNyfjqzZs6I7zhKEo88W2DuaBpk6rVRMQ3tnGcCmQgFkwreY3eIJUseYuOL31zp8mKkaA=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr5036190wmg.35.1635433105169;
 Thu, 28 Oct 2021 07:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-13-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-13-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:58:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qjnVZqdO7HV+gMGOQN4N9nR1KbsxCYuAwpbDWvK16Vw@mail.gmail.com>
Message-ID: <CAK8P3a0qjnVZqdO7HV+gMGOQN4N9nR1KbsxCYuAwpbDWvK16Vw@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm: socfpga: always select PL310_ERRATA_753970
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
X-Provags-ID: V03:K1:jFeUUn/MNplR5EQ0ly0VytYdKd0gQK4raT4lAR46rrqIHI8jC5P
 Zzpp3bi4VYBosBT/TszBUNvhLOwxyO8EnIEIhwOkxcYz37z6QFad+vC8ArcDOaM90E/jY0+
 SDk0r/aSOHmrPr9QtwqtJmMvcs6UiWnfSlPiz6Ax6n8pYLHEJl2qF0vL8BplUogVFoxzn8R
 67ug5dGSwh5aU8UpAdUkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jK7m9r3kSrY=:tJkPEhyNHu3YLCN7Q1H7j3
 SCqJMTZQmdQRzFXpki7QvrpS2SMnsfTwJfjqs+4ZFcMi5LM8lCBfXyWf0JhuYFn8coFQprjQE
 Z3w/HGkSSzVFX28GPLKx2iuk1gxYfLFwNx8cYXUD4fZrDB0/n4Dg/4rg5y1QPnL9Ew0aF2sY2
 3yRtyX6UbWnLKseyynoBEVlf+mgQxxYh9hvdCPBNUxCbA8nbskWXq7FmkhkNRmb3w4Xykf8L8
 MTIIOju0MOjr0XFR6LaznvSTflAkzfQ8vEQihxbpvq1AwEZ0MrENBSHRqF1pS2te7sW/7Mr7Q
 NA3qwPQMkerRwZSRJGQiqxl/v51BQ262JEuZ7OIWjNkJOdyS8o/3EIyjWarY2aCR+3uJ/KKZb
 1ajFOXKKMS45v+M99YT009bNT6sWqlKISPFauOS592FTmWk6vDGL2le5lVEdqa8fKlz/bFEbm
 IgkHO59aI8zfnpTIfCV/mZ3Gcn4EVwuDDgaXk1TcQjpgAaneI+bSc0JKVaz2m4hsSNwnCoYqN
 lRx3jjlfX970E2abZyodUFg0BUxuturs+L/FFOuk5vudyLDMcJJQeDL59Y8rzvvstUE4hsmeT
 PQU+De+i8PZPeL8uGMKDfME01LsW1jggcbGYgoVQwAw+6va8xMB3yES3pA5U+vzERLiqASusV
 VuducWInS46slC1hPLvcW+jo21zgPkGtPMYPw9G/gzN2xX1Z3gZckungnFIwvpRuUTLyuV4fV
 bA8zQnJ3hvcq004KerIcwME2fg6TmA13SbhfIiWhpaXR+Aepz10Rv62c342Gm0uwACnPERbTW
 j0LF+FiRPshWeMP2awAhdsnlL2q15LUbVw7tNWRZY54AjwarQm3sHc9/xvvh8LAvjU9LBHkNw
 oH6Q7aNs0kRcNesEpm4JzoqKqzJNKCDp3t//YMj/31WrO4pKvfkwTnzESxfpq4FI3CEofvjZb
 sEjnMH0pMdQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit fbc125afdc50 ("ARM: socfpga: Turn on ARM errata for L2 cache") adds
> some selects in ./arch/arm/mach-socfpga/Kconfig, with one select being
> conditionally selected on the non-existing Kconfig symbol PL310.
>
> Hence, ./scripts/checkkconfigsymbols.py warns:
>
> PL310
> Referencing files: arch/arm/mach-socfpga/Kconfig
>
> Assuming that this errata should actually be selected for
> ARCH_INTEL_SOCFPGA, simply select this config unconditionally.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I think it has to be

       select PL310_ERRATA_753970 if CACHE_L2X0

otherwise you get a Kconfig warning when building a kernel without the
L2X0 driver.

         Arnd
