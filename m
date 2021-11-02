Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F101443892
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKBWlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:41:05 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKBWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:41:02 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5mWp-1mfz6Q3OqR-017DVy for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021
 23:38:25 +0100
Received: by mail-wr1-f45.google.com with SMTP id d13so698577wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 15:38:25 -0700 (PDT)
X-Gm-Message-State: AOAM5319TxQr5db0sY0HDTxFEQZqieErcPfplMieRlCG0BsXCUEIj5zd
        Qj4GWjeQkv7bWzPqQgp6g/oyZ9gtF7FBTgaF8PU=
X-Google-Smtp-Source: ABdhPJy60zCJQR1XMCJhReC1GB4Sb24lNtnag2Zp5qca8ElcGLuS5KOeXNPrUKkgPJf+PgBpqIHLJRg4t1COpA2mmyw=
X-Received: by 2002:a05:6000:10cb:: with SMTP id b11mr38955396wrx.71.1635892705511;
 Tue, 02 Nov 2021 15:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211102220203.940290-1-corbet@lwn.net> <20211102220203.940290-8-corbet@lwn.net>
In-Reply-To: <20211102220203.940290-8-corbet@lwn.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Nov 2021 23:38:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1vDjfbx0_y9py69f28nbWLcXUS8H9pRGW3TGzVOfAMig@mail.gmail.com>
Message-ID: <CAK8P3a1vDjfbx0_y9py69f28nbWLcXUS8H9pRGW3TGzVOfAMig@mail.gmail.com>
Subject: Re: [PATCH 7/9] ARM: ixp4xx: remove unused header file pata_ixp4xx_cf.h
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Hs7myEjIVGHxgEaFgAEKAeyhIvgnL/6G9Sjw5X5pdOkh817Og2i
 t4ONK6uqNl3id6VQ08gqnf9yOmlyXt6LkpHJ3DRWkKuiS9wSI+6tvzCS7hJmvuheHSIh/ZN
 HGvROwF1uLbg9LH8BjHi5buayHfV5P5Fe8w5APBECsvjN0nfRH5xGJ13KArDyRB7/BiYvOW
 386uXIVzvI9GylgCEI1VA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:932QEs+nwaE=:GTzWIEOuEn74gvBvsxKr1I
 BeQjYQW6j7xKaVDEalrMUsrCzoz+2mYj8L56d28K/JV6VBupBehjPdC1FXJUSrX5BP0zuzt2U
 5y9Aw1mekhMP3Cord8wYqeHrLPe6Xy/qcgygNPiz15tb7Ogb8sYP+S92bqane7fENffYc7NQy
 mLf1QJOt/SRakmTLRNTq13XJY+wkgrrRq92qwaot9Zzf/dAtU3Wb56XHN3OGDZ5VkL4DeCry3
 lnaOP95immpYof8YtNvTCKdrtczT11YFFl5nPsHaP0Z0AXm2yJSPtNlRrnocF/tZj3AetswaH
 IvTg9M1wN4LaOWSVtD11K8poDdO3M/R9VzSlVDNxwe9swKd8tLOaQhuVmZR+cgJKsUkrAjkA7
 IFz26vSe49+f2T0ENBbtxnpteoOLW6lr17ol8GAQD8izwJRz8v+bu5WbgbAbYp6Qla6pTPhkp
 Mf5LYxDZSz5doyxp4hRuelfkKYHlWpKQ34GNfcxbyZZhgSkIwXk0Dqa1Huw7ulh65x4cqtgOF
 wOtbaLE1W5FP2N3E+EmElIb+nOpNIwD0gQPFPKRG+YPxEni+RqQUZi+Z9wtN0/RfqQnX57A44
 t7hp85N+XuVxX/Nf6x02CICo/KHo0+X0p8rrCqtzopFifnGwrw2SjMOSOartlC2I80vPc2VsE
 j9s1HiEIQCvdzt9BqfVdX0Fbj5iECsSvccjuQldInYLUwxrMfp/iOyKdKKiwvf8v0pZCdxxaV
 RdIVm6tbqX+zb5nI8aQo4k5JUKvgNWh66u3Sge+NNDXhPvIguVPJd31uulk9YuwykZmIaNMk6
 vLB1YDVg6/lDCitK7zMCsMWT1Fyl7Tjpe+TcMNbc3xO0SkbqJQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:02 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Commit b00ced38e317 ("ARM: ixp4xx: Delete Avila boardfiles") removed the
> last use of <linux/platform_data/pata_ixp4xx_cf.h> but left the header file
> in place.  Nothing uses this file, delete it now.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
