Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6D44291F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKBINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:13:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhKBINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:13:43 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwPjf-1mROWt3gHN-00sQyZ; Tue, 02 Nov 2021 09:11:06 +0100
Received: by mail-wr1-f42.google.com with SMTP id u1so296263wru.13;
        Tue, 02 Nov 2021 01:11:06 -0700 (PDT)
X-Gm-Message-State: AOAM533r/joAuQe66f5/Perh50hk81aCKa92TWunQ2TMFp6Vvpp63Vts
        3vItsi0cjba3zrgGW7OB7RucelPYZCPEHalDwB0=
X-Google-Smtp-Source: ABdhPJyFtamfSUetI1AbUBIOvCYQczN1Nlzp9gFqyOAdgQNhP9d2hcmJSPJ8rKmPIqsxt4VD5S+rUEmHQuxxkKHrxEU=
X-Received: by 2002:adf:efc6:: with SMTP id i6mr21099177wrp.428.1635840666461;
 Tue, 02 Nov 2021 01:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-12-lukas.bulwahn@gmail.com> <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
 <CACPK8XfiN5qziPHLU6J=bC34mcjz+ix7jjSX=xk9zsr7+vyTdw@mail.gmail.com> <CAKXUXMyrhrM2o-OEW_qTTKjfKgxt-Z6Nt69geU80AoFnM1OuMA@mail.gmail.com>
In-Reply-To: <CAKXUXMyrhrM2o-OEW_qTTKjfKgxt-Z6Nt69geU80AoFnM1OuMA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Nov 2021 09:10:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2N3zNkGzXQD8Pbs-8pDL7mv6rneJop-C_p_+d7-_sNqA@mail.gmail.com>
Message-ID: <CAK8P3a2N3zNkGzXQD8Pbs-8pDL7mv6rneJop-C_p_+d7-_sNqA@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
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
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:42h7IqhsqzshYTqnIAaEPgcxnXwAftpVOTvW1+XrZM+OcAVffYw
 w8TmUnRnQyWR1Yc6rdfHDVhJJj63lfGNaMuF+LW+ha3zR9tgig3RBswoMWAqNRDe+Svv2QG
 6QKde7/grD06goUhGpJOss8Om7eR5k8H5s7/YlM66+0GQkwpewST4o5U6Wz+T7ylEdkTlEO
 z91qlxh843Btd22w2xnQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JYr3zjFUXr0=:7bwhG4RYoOndC8Z24DQb0X
 nG1zVfiYAyZp2HYSXnAK8NVV40Q6J0hWMyYrrYU53PBJ8EFyBbG9cSuAnfyIBXtOI6JzBWZTC
 zx+zgOwxSLIZ39YQdBlEdTcWz4ZSvvCUtTXReSnOolTTKtjrq1EQYWwT/Oqxosy4L8bCH8Yo0
 qCwkq7VQaMEjdPDOXxw3MCCYq4ce50bBw4nDezP1a6Keji/827FcwTK4ggszPgVGJnNh6F7xx
 Puge+scI0FpYounpxGW9F1L0uS3kLsR13OTRt0L7TWpw5hgjoK3G3cnJ5mX8OM9BCCZJKv0me
 MpCDDqriD+yEAm7gD47AcrgjAiO0tHfJl7DCcuCDOyGyKk/Ut3XXSvT1kbZ+2S8ouSD2+YU5/
 mwV97tbgrnBrQ5UuV+TPdJko5skSft3EC9MBlXAxiwSU/dxEt7DV3Y/ZXfFfuwBkcrQtex1TL
 Ut5vs1WFaH1MTG+M5YEe5JTp/vCUXcXtf84OM/RHxEmoM7ZEdq49VuyHfjMJkBULpHXtDgbvZ
 eK9TvwYWVLlV6P92+MT7pFP18DBKjYwrorKM1WPNIYmlXVPUm4gCZzZExyOum1i5ulbJdhYFV
 v+zdI9aNlNja7Ujxcyv/NN66SsBvGI/5APdNfnFGlVn9z2Xz32S79kYvt15YnsW29qXrbqWdk
 ZV2SIGjf0MpAHmS4dcN/ODKpCaMebxwZ3Xm3e+8J4TvkzIStXP3+U3WtAJQNXGdhQXRHFK0J3
 9kH+2gg44jcZzuu/P781DNlRrYvmHMvASnSzQ0GK3UdjBIhY0zJoN9vg5YtUbtsqn0DqsfnM2
 otUh2BsEIh3X8eOR2bC+bMSHeSgEcAKoyjjo9GvENMni2s/GAo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 8:31 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> On Fri, Oct 29, 2021 at 8:36 AM Joel Stanley <joel@jms.id.au> wrote:
> > On Thu, 28 Oct 2021 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > https://lore.kernel.org/all/6be32e0b5b454ed7b609317266a8e798@BLUPR03MB358.namprd03.prod.outlook.com/
> >
> > It looks like it's the same workaround as ARM_ERRATA_742230, which the
> > kernel does implement.
> >
> > It would be good to hear from the Nuvoton people, or an Arm person.
>
> I will happily update the patch to select ARM_ERRATA_742230 instead of
> the dead non-existing ARM_ERRATA_794072.
>
> In contrast to the current patch that basically only cleans up "dead
> config" and has no effective functional change, the new patch would
> change the behaviour. I cannot test this patch (beyond some basic
> compile test) on the hardware; so, we certainly need someone to have
> that hardware, knows how to test it or confirm otherwise that we
> should select the ARM_ERRATA_742230 fix for this hardware.
>
> The current patch should be subsumed by the new patch; the submission
> of the new patch is deferred until that person shows up. Let's see.

I'd prefer to leave the broken Kconfig symbol in place as a reminder until it
gets fixed properly then.

       Arnd
