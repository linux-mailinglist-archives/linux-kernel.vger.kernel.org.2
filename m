Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9078A427298
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbhJHUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbhJHUvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:51:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C2C061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:49:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso6219060pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9TiIjRscGsypMhkU3F5Luwnaj1KEJJFH5jSCl+q5Ag=;
        b=5aYWkO1/pER1U5USV1nEzyfxkbQO2mlcDkvrtX6sMaZlASzY45T8jVHT1yvAxYPWEB
         EwS3cXT17cKvL/uUwqyF5aUu0nfLax8wNDE7eBZ1rXm/Z87sWBH2V0kjJG4aw5PDVdku
         sywmFFwo7yQ2Eej3VeweCP5KSbkvcmYtqVKxeRp2tW5oAEsBnQPvQn/5th4E+7rEAjaJ
         RZBbWZ1DuY+xf3V5rQiwoftIG2wSM0u4ay+xVYcPNg1KcFEbh2rIDAX3NpgdCVqtxD4V
         HclRMV4uqx91lL3UL88OlDgphWkDFbWhPzQiRA5PeyDWYAlQH8Zu1AxxfW7BWLe0oO6R
         pLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9TiIjRscGsypMhkU3F5Luwnaj1KEJJFH5jSCl+q5Ag=;
        b=5KFvlod1pjIrtPSu0Ch+0pL/UeeQ4c0eJYCxN5J8P6ByO6+x8r5TOK4MSAPzR+Q/uX
         FJorTIUMhZPWxkkm4r8JCZtPFaRiqmtXMa7Ag37Z/dvMnFN9VQ98pLNQBi/7G8f6rM7F
         n0+CoxZHgbbToStMqeS0wxhwR5VLDw/Vo6SdhqQA17izoYsTDkGroBDImTVFMMj34Ubv
         XiAN6xg2ej0iENXvkcOl5dgoELtbjx5hJfFxbDI/gbApIuWMGb8rQwx1+TJrQ6D7a2vC
         c3OLDRh6WoU3qhfIQPMT/WQ/zoimWd1txz4dm2wwGHK5CYjjoRPn1Cn6TySl/QRtarPA
         mBxw==
X-Gm-Message-State: AOAM5313ISy2qO/DazJ3ohcRar/etCdkVRDzWHe+3xibp4pP2lE32BbK
        g0FAo4w0Ms/3SFl8TSWbfHpmSGox6dxoq5u2+edbQXUu6Sk=
X-Google-Smtp-Source: ABdhPJxMnEH2xoi24RNEnru2y/0LaOJW4Sqmk5pa8/ErFS/VB9m9afA2AKxUjRr9u00R1TH2nvvEVqnmYTqcMO6JgUs=
X-Received: by 2002:a17:90a:7301:: with SMTP id m1mr14090869pjk.34.1633726157928;
 Fri, 08 Oct 2021 13:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211008163532.75569-1-sven@svenpeter.dev>
In-Reply-To: <20211008163532.75569-1-sven@svenpeter.dev>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 8 Oct 2021 13:49:06 -0700
Message-ID: <CAOesGMgm-8c9ADbFSGRascCEE+ADEsK0v04tVCdd+wC_=GieCw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add Apple M1 support to PASemi i2c driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 8, 2021 at 9:36 AM Sven Peter <sven@svenpeter.dev> wrote:
>
> Hi,
>
> v1: https://lore.kernel.org/linux-i2c/20210926095847.38261-1-sven@svenpeter.dev/
>
> Changes for v2:
>  - Added reviewed-by/acks
>  - Switched from ioport_map to pci_iomap as suggested by Arnd Bergmann
>  - Renamed i2c-pasemi-apple.c to i2c-pasemi-platform.c as suggested by
>    Wolfram Sang
>  - Replaced the ioport number in the adapter name with dev_name to be
>    able to identify separate busses in e.g. i2cdetect.
>
> I still don't have access to any old PASemi hardware but the changes from
> v1 are pretty small and I expect them to still work. Would still be nice
> if someone with access to such hardware could give this a quick test.
>
>
> And for those who didn't see v1 the (almost) unchanged original cover letter:
>
> This series adds support for the I2C controller found on Apple Silicon Macs
> which has quite a bit of history:
>
> Apple bought P.A. Semi in 2008 and it looks like a part of its legacy continues
> to live on in the M1. This controller has actually been used since at least the
> iPhone 4S and hasn't changed much since then.
> Essentially, there are only a few differences that matter:
>
>         - The controller no longer is a PCI device
>         - Starting at some iPhone an additional bit in one register
>           must be set in order to start transmissions.
>         - The reference clock and hence the clock dividers are different
>
> In order to add support for a platform device I first replaced PCI-specific
> bits and split out the PCI driver to its own file. Then I added support
> to make the clock divider configurable and converted the driver to use
> managed device resources to make it a bit simpler.
>
> The Apple and PASemi driver will never be compiled in the same kernel
> since the Apple one will run on arm64 while the original PASemi driver
> will only be useful on powerpc.
> I've thus followed the octeon (mips)/thunderx(arm64) approach to do the
> split: I created a -core.c file which contains the shared logic and just
> compile that one for both the PASemi and the new Apple driver.

Series:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
