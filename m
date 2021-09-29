Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4059541C44F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbhI2MK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:10:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbhI2MKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:10:17 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Md6V3-1n5i9R2Lsh-00aIRr for <linux-kernel@vger.kernel.org>; Wed, 29 Sep
 2021 14:08:34 +0200
Received: by mail-wr1-f52.google.com with SMTP id t18so3955844wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:08:34 -0700 (PDT)
X-Gm-Message-State: AOAM5317NhO7rJO23dqORS6u5aznnqEmoQMrhQF7WwQ5Y1fYw2JnmSA1
        O424SPeJb3DNRKGVRKEmcPcSadEFSV8EC4i3+wo=
X-Google-Smtp-Source: ABdhPJwujhvSCWneL2b8EFkSV0fXIWDHq8QtEYMDRcnY/D6i7dyv+jcvb15fjui4Dj3KPHQQCR5pjkwF2cvD7H9X7ho=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr6276909wrz.369.1632917314213;
 Wed, 29 Sep 2021 05:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210929094442.46383-1-eli.billauer@gmail.com>
In-Reply-To: <20210929094442.46383-1-eli.billauer@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Sep 2021 14:08:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0n7iJDrrn42KA9jPCTKMzW1pxFxP+38-7Viv5hnny79Q@mail.gmail.com>
Message-ID: <CAK8P3a0n7iJDrrn42KA9jPCTKMzW1pxFxP+38-7Viv5hnny79Q@mail.gmail.com>
Subject: Re: [PATCH v2] char: xillybus: Eliminate redundant wrappers to DMA
 related calls
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WVsqfSpCCnEY+duubj/1BK9nI0N+RvrIUNtYxi2kklqYPwHzqeY
 ukIDhgMZupoXaIJbfGXAPURuldB4p1E3xyuSb/cErTebrVrYAnCdDHwm8XX5fv49JDXFjMv
 Faan535S2iyYApYDl4pMgEHDAIQIPYPSZhU7PqGd2bAZY6jFYAMxbFEzuLy6J8Wo65niRja
 oXih5u37MGNDZ4k2+P/Gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SxLPokYcn+g=:Qtqoar/jNcPawDklADAeqi
 aMuqOjzFUpblFFcwbCMZx2ehDQvSJZdzRB8U/zw+KU5aQZk8qCw+RZ5AoETLhvqy8/cPPc1ZZ
 H2kgRzHx2IPT3+DKbI4l+jJrejHmQVgGTWULa9n37qFmgH4/VI0F6M4aDf4pCDWXK61nflI1A
 +/sceOQ2eAzeEa+Qqbg8h4khhBhkaqwTOtQmMDJJSGeeNH2DIkfQ4bkGu96czRZv2/T5Mpd9z
 4eAqwBii+2OZLShOBzUPezOiYWvBuAqIs2znQa/+sQWvfTeqWVeuS0RkM8co/Rdhz4SwgoNkw
 ueLeXaQjKQ6+1iSPTPtd/2edUcXByDhvGtCLhqlN83FxMVNKuR1XLqiuMfg4D9iOkuFm3PMTa
 z6ltQtk3h27gcHGPxHAD8Bj5yu98JL2bfqAhstoO+yiMFnryH2OTbqrQSbM6fwRnkheshnMyx
 BCIWT1+Wj5PsS83y9H/JNl0aIyeOR/PbgngqqXbNzrGOQhR2H95QVgOcZKWEO2jT38LAZqnOn
 wPAASNCQ0u8YLebiL5j35xW6ctU5NcKyflMCT1QE6oxlZ0ga4RL4bu/TVA4V6itg4GKEw/4ta
 eVEuA+sIDzBJbf90LB7kn7h1w4L9evrETkN7u5nXSV4YSTOfV4o/E97502PTkkib3qOYEXFHy
 cjwZxCubWE3MPCtfgV9QJZVz4Zw8+87HXKTfpOAJ1urbStlgJUnqatG1x/72gWa6qlCtK8sqU
 QSxVZB2KoMi1ZS3uCU/vWeXXD+Ei6+ZHGeuv9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:44 AM <eli.billauer@gmail.com> wrote:
>
> From: Eli Billauer <eli.billauer@gmail.com>
>
> The driver was originally written with the assumption that a different
> API must be used for DMA-related functions if the device is PCIe based
> or if not. Since Xillybus' driver supports devices on a PCIe bus (with
> xillybus_pcie) as well as connected directly to the processor (with
> xillybus_of), it originally used wrapper functions that ensure that
> a different API is used for each.
>
> This patch eliminates the said wrapper functions, as all use the same
> dma_* API now. This is most notable by the code deleted in xillybus_pcie.c
> and xillybus_of.c.
>
> It also eliminates the OF driver's check for a "dma-coherent" attribute
> in the device's OF entry, since this is taken care of by the kernel's
> implementation of dma_sync_single_for_*().
>
> There is however still need for one wrapper function, which is merged
> from xillybus_pcie.c and xillybus_of.c into xillybus_core.c: The call to
> dma_map_single() is wrapped by a function that uses the Managed Device
> (devres) framework, in the absence of a relevant function in the current
> kernel's API.
>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
