Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7E388305
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhERXTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhERXTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:19:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB302C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:18:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so14899450lfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t1lUkNBuVC2UZABZ7mjXl1iS2OFEu1Ax24kG7Pa9v9o=;
        b=oIb6bCshL727qAb4uQIy4tdqNvs4pKTGrZeO2A2o7UfVH/eztAfkfvbBEipSokq+59
         FoJYB78uhQ4mijp8vZr0SP4cPRxTCgv+9YN3uSxCr2FnO74K7P78F1v6PtUE7f6iC8Pv
         FPES6jgvgT3i/uSIj/QqFa76gtm49FrRaxPB30vHeUYSMgKZxTDA9R4MdmfdBPJPUrAk
         PXjdR2Bdhpl2t8wkJ57L3l+BRB1V7Q+57X8geh0vCm1fe1G8J0cZ40q6tT3ssBW4SGXn
         7chziYboyIHfa834KfPzy+3k9wESGMTH0oTvTN+o2L+36uT6tElzd3NtoyPiJe6LOZLv
         Maww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t1lUkNBuVC2UZABZ7mjXl1iS2OFEu1Ax24kG7Pa9v9o=;
        b=nGytIMyK0FG/ZrbO/VI3ykibL14xr+zP5Z49E2NMiPIALQX8eGQuoL8c2ReIokUugM
         mcLmRXR5qDG60xbLIf9sLQkwKCsC2yM24FoSD/4mFCLdc+1gAK7F14CCjQ5L/xba9kD9
         hLK5+PlGZ5WvYhMsr4AoAw1y7WMBESWeCp8p+Ic/gIB7uUdpp2G9osg29V3Ot47TAdpV
         +qgYTGCrJq0xtwg4nsWQARm4UWyZcYWRYRsdeBMe2f0hrSSg+eHZ6g27EkozSSuy0vnT
         nxOOgfypj/599VghW5uyGEpX6/aSv/bdso8mhD08uRolA4maeCm/z2loGDOn+4ZoPU7F
         0/9A==
X-Gm-Message-State: AOAM531X29j5hODTFjaBNe4viYvXqIygiOnrJjU3lbCi0JoqYzSRfVDF
        UaBIBF2IM/gdnW37Xf7+jl3OkyFz56Smx75zlLLFfg==
X-Google-Smtp-Source: ABdhPJwbX+FemxVEp4TpL+OaKW57UtYIhtlS+hTGYuSbNLuqKI0W4v/DXLByxnfuX+1snj0AfuXOkxd2UaRJJjUo3pw=
X-Received: by 2002:ac2:5145:: with SMTP id q5mr3321479lfd.529.1621379890103;
 Tue, 18 May 2021 16:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193205.691147-1-clabbe@baylibre.com> <20210517193205.691147-5-clabbe@baylibre.com>
 <CACRpkdY3c4uvo1zbEgNW0meF-4P8be_nmoOEQAHP5V+GXgoG=A@mail.gmail.com> <YKOO8UxdmZBjYbt4@Red>
In-Reply-To: <YKOO8UxdmZBjYbt4@Red>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 01:17:59 +0200
Message-ID: <CACRpkdYqaoggyBO9=fdi2iUh9O0Y_jT5jnc7+qbE9HzEWK57Sg@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: gemini: add device tree for edimax NS2502
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:55 AM LABBE Corentin <clabbe@baylibre.com> wrote=
:
> Le Tue, May 18, 2021 at 01:46:20AM +0200, Linus Walleij a =C3=A9crit :

> > Is the FIS broken since you hardcode the partitions?
> >
> > Doesn't this work:
> >
> > partitions {
> >     compatible =3D "redboot-fis";
> >     /* Eraseblock at 0x7e0000 */
> >     fis-index-block =3D <0xfc>;
> > };
> >
> > (Needs CONFIG_MTD_REDBOOT_PARTS)
>
> No it does not.
>
> physmap-flash 30000000.flash: no enabled pin control state
> physmap-flash 30000000.flash: no disabled pin control state
> physmap-flash 30000000.flash: initialized Gemini-specific physmap control
> physmap-flash 30000000.flash: physmap platform flash device: [mem 0x30000=
000-0x331fffff]
> 30000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer I=
D 0x000001 Chip ID 0x002201
> number of CFI chips: 1
> Searching for RedBoot partition table in 30000000.flash at offset 0x1fe00=
00
> No RedBoot partition table detected in 30000000.flash
> Searching for RedBoot partition table in 30000000.flash at offset 0x1fe00=
00
> No RedBoot partition table detected in 30000000.flash

Hm since it searches at 0x1fe0000 that's where it thinks the last
eraseblock is so the erase blocks are 0x20000 (128KB).

FIS at 0x7e0000 should be erase block
0x7e0000/0x20000 =3D 0x3f

Can you test fis-index-block =3D <0x3f> and see what happens?

Yours,
Linus Walleij
