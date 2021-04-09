Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59141359718
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhDIIFH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Apr 2021 04:05:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhDIIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:05:06 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHVWT-1lHu5t1DX7-00DYvM; Fri, 09 Apr 2021 10:04:52 +0200
Received: by mail-oi1-f181.google.com with SMTP id m13so4919559oiw.13;
        Fri, 09 Apr 2021 01:04:51 -0700 (PDT)
X-Gm-Message-State: AOAM531lnVZYH10VAY8dn1wt3M7YLuSxmmgDV9NyqIX/wbJcpNRZTh2P
        ufqP1Pxh4KyeWolFAKAxjz67kDztau7vaSLOotE=
X-Google-Smtp-Source: ABdhPJw1wO5JX6zgBX4BsEiKPFIsDx6YR60lpWDniVPRNgV9yzXLXThF/0H0/g/gIDeI3dzcgbPsffottKejMu0nxec=
X-Received: by 2002:aca:5945:: with SMTP id n66mr8928933oib.11.1617955490914;
 Fri, 09 Apr 2021 01:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
 <CAK8P3a0VfnUucvZNkA9PdxrWiYUOkisV00v-375PmgQYp4aXoQ@mail.gmail.com>
 <YGzZofPvT80b5gS5@latitude> <CACPK8XdbwbsbJuZmvsFqJ+x5viu652vpfR1kwB4Gu+khRHNt_g@mail.gmail.com>
 <YHAI+x4OXBKvJkUH@latitude>
In-Reply-To: <YHAI+x4OXBKvJkUH@latitude>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Apr 2021 10:04:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18ySEmCzkdD-GmQSPFUza_TK3OBPk0Grbz_aFW72+g7g@mail.gmail.com>
Message-ID: <CAK8P3a18ySEmCzkdD-GmQSPFUza_TK3OBPk0Grbz_aFW72+g7g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Initial support for Nuvoton WPCM450 BMC SoC
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:u6MzJMYFGUzBmtK7rb0ux5/iD8kF1aMQxfHYwFOpbxjC6RtGWTC
 E2NsGl1+nHGGa+ezOL+J7hSxOwHk1UQMixR6BSkgqquhQk086V4YnEJcVVFGbC4HTIW4K3Q
 6RXi6U1VAI8vq6xrnzcjjrlJZ+Hwzbxyd98Lfiis16h1G7PUdABiW8HxWAJEBER1FmRA4fs
 /+Vx4q4FotZZr/c8FFmCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHTjioA4VsQ=:qKDLfvU14EljUSBcQLWSOT
 4Qkm2uLnK3mf2Q/F0H9T9AvVtjGwzUgLsZy2KsBFDYUpMUomWnA5gBHGXeIsOFNkZztIictmt
 rnk/xaMotxwue4V0HKHWVlSwBlNhsoVv5TIgg42DxNf8ZUEYCITdsDxHR85sSWedZCT3i/hFu
 qcBHSQAATug3xLUxZkzT/s6jIsmGfE+XcyrYPAg/BcKwQSlh33ZpQyWj0gF5YawK/Sevk9I6W
 AYPSv8rT7NELu8lnF8Q/swC0ZVouX9pIKagDtobXUhakxLlE0sShBVbGBkmdnY7nrxNNC8Bxj
 2fXQAQZ7GGCvMopPD+nBjVI/QIPe02Vf7xubg0DbYxs9KDrdmNlBAeiQxA94itAJUjUy3jc1e
 GahQjDMGU0qO49rZNFn7bIEfAbomDp/xL99e8nHoF6YEwY9FUVcwr+V8J2UQlo/GAiI4zDXvx
 llyn0qI2h70BpcgOtwfV3RCnMTMmWW8iehfknsGgPCBXSrcrQv6BAvq2y4ysli0cCYKF1GbJX
 eQtkkxrdyD/xBT3dkIv0BhTtR349gTjTj/DS/jYftMb7h6a9sRJxn+AyRN1IGNDFlgm/83S2H
 iTzIGkiNbne2CYZiQMEYJj991FBSjX0ccN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 9:58 AM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> On Fri, Apr 09, 2021 at 04:37:34AM +0000, Joel Stanley wrote:
> > On Tue, 6 Apr 2021 at 21:59, Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:
> > I've had a look at the series and it looks good to me:
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > Nice work Jonathan.
> >
> > I'll put this in it's own branch along with the bindings change it
> > depends on and send a pull request to Arnd for v5.13.
>
> Thanks a bunch!
>
> A few patches are going through other branches (IRQ bindings+driver;
> watchdog bindings+driver probably, I guess). That leaves the following
> patches to go into your branch, AFAIUI:
>
> [PATCH v2 01/10] dt-bindings: vendor-prefixes: Add Supermicro
> [PATCH v2 02/10] dt-bindings: arm: npcm: Add nuvoton,wpcm450 compatible string
> [PATCH v2 05/10] ARM: npcm: Introduce Nuvoton WPCM450 SoC
> [PATCH v2 08/10] ARM: dts: Add devicetree for Nuvoton WPCM450 BMC chip
> [PATCH v2 09/10] ARM: dts: Add devicetree for Supermicro X9SCi-LN4F based on WPCM450
> [PATCH v2 10/10] MAINTAINERS: Add entry for Nuvoton WPCM450

Actually for an initial merge, we sometimes just put all the patches into one
branch in the soc tree to avoid conflicts. Unfortunately we already have a
(trivial) conflict now anyway since I merged the irqchip driver for the Apple
M1 SoC through the soc tree but the wpcm irqchip through the irqchip tree.

You did nothing wrong here, this would have just been a way to make the
initial merge a bit easier, and have a tree that is more easily bisectible
when one branch in the merge window contains all the code that is
needed for booting.

        Arnd
