Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88368333364
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhCJCzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhCJCyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:54:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC673C061761;
        Tue,  9 Mar 2021 18:54:41 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n132so16356921iod.0;
        Tue, 09 Mar 2021 18:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hye7a38rXTNI1SCZAq9FjOmi6j8GoBMhyqfw/nAPiao=;
        b=nESiPiFkYSu4eDoCWA3HpeZRytLbODo369VhGGS3fWIsEirsaQsDiAmFx3egmSSxn9
         nJgzvvJNSjgco+ww9g++pCQnLNxxLj70mq02mI0YGODSNEw5tEeQT9kA4S+UrQFxUcvY
         5OETXEZQF7Wr7jPa/8RtJODFWiqGxPUMCG0WmMPhjp2ZLVqbkTqCw62eJjqExTo5IBBx
         PHvGa1D/brWprF/FpKsooUANUYGbcScWfln/doHVvV7zxO5jUySMZD7d8gHpCm5Cutmg
         8GsDM1FW/89ErQk2c6yvWf1D3Q8wtRXpm60QgXEBsgkU3KdqcedxQYsEh5KiKyWghWdG
         nukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hye7a38rXTNI1SCZAq9FjOmi6j8GoBMhyqfw/nAPiao=;
        b=bePbOZy0OrnxwHuH7K9yBNBc7nBzDe85jnlimaXASo8Qdglf/olZ3n4mf8miLuDt6z
         XeDwRqc7eD5R8xvkNIH7S7kVyH+WcZ6ISj4pzhih5zH4v3Zee5rZ5HyXVR69Mi8j7bWP
         NyLDw9YpdBobii3yP0zjHZovMwrxKW4eHp5Tpels0g/gfppfl3U4hFtgaa+UVDn5WthV
         +Bmhj8h5p5ZgNdrT4AQqcJdb5AtaOMJIJYumzjwX/UxRjYraIyvZebnKNCbu1jlHoszD
         hgUHwcqDiJyi1oLFaElUXLfz14EOkh+zwHeqUvxPUL3NOX774rC1LkNHxRuSzVsK1a5l
         E+Ww==
X-Gm-Message-State: AOAM5316VPiyXJdZrsWyWUHDhZSHhR55pXlCuHxilGKVF8tgCYFjyKnm
        5O8RGXtlOwIRnulO3wfvYK+8i6jc3OSm3uFtti0=
X-Google-Smtp-Source: ABdhPJw3qiZYQygEZtdApPt9vDrti6XQ1M0BC8sZaWv8O48riStgllRv6ybY8VmbvAoavFXif3HFNdc+TZ0hmP/LTl0=
X-Received: by 2002:a6b:4f09:: with SMTP id d9mr1019988iob.60.1615344881266;
 Tue, 09 Mar 2021 18:54:41 -0800 (PST)
MIME-Version: 1.0
References: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com> <20210309121836.GU4207@pengutronix.de>
In-Reply-To: <20210309121836.GU4207@pengutronix.de>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 10 Mar 2021 10:54:05 +0800
Message-ID: <CAL9mu0JOyM8n9LABwrOYgV4Qxj27XKTchWiGKsE3dMU0W5RNbw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6ull: fix ubi mount failed on MYS-6ULX-IOT board
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, shawnguo@kernel.org,
        parthiban@linumiz.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

Thanks for reviewing.

On Tue, Mar 9, 2021 at 8:18 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Tue, Mar 09, 2021 at 02:15:19PM +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patch intend to fix ubi filesystem mount failed on MYS-6ULX-IOT board,
> > from Micron MT29F2G08ABAEAWP's datasheets, we need to choose 4-bit ECC.
> >
> > Table 18: Error Management Details
> >
> > Description                                   Requirement
> >
> > Minimum number of valid blocks (NVB) per LUN  2008
> > Total available blocks per LUN                        2048
> > First spare area location                     x8: byte 2048 x16: word 1024
> > Bad-block mark                                        x8: 00h x16: 0000h
> > Minimum required ECC                          4-bit ECC per 528 bytes
> > Minimum ECC with internal ECC enabled         4-bit ECC per 516 bytes (user data) + 8
> >                                               bytes (parity data)
> > Minimum required ECC for block 0 if PROGRAM/
> > ERASE cycles are less than 1000                       1-bit ECC per 528 bytes
>
> 4-bit ECC is the minimum this chip requires. There's nothing wrong with
> choosing a better ECC like the GPMI driver does by default.
>
Yes, indeed, the mt29f2g08's minimum ecc is 4-bit, you can use 8-bits ecc.
but there is a dependency between new kernel gpmi-nand with the old
mfg-kernel's , which means
if the old nand ecc layout is 4-bits, you should use ecc 4-bit in the
new kernel (by fsl,use-minimum-ecc),
else use 8-bits.

For my case, the ubifs filesystem was created by ecc 4-bits, without
reflash filesystem or change
gpmi-nand.c , so the better way is to use dts configure.

use legacy_set_geometry() :
[    6.713115] GF length              : 13
[    6.713115] ECC Strength           : 8
[    6.713115] Page Size in Bytes     : 2110
[    6.713115] Metadata Size in Bytes : 10
[    6.713115] ECC Chunk Size in Bytes: 512
[    6.713115] ECC Chunk Count        : 4
[    6.713115] Payload Size in Bytes  : 2048
[    6.713115] Auxiliary Size in Bytes: 16
[    6.713115] Auxiliary Status Offset: 12
[    6.713115] Block Mark Byte Offset : 1999
[    6.713115] Block Mark Bit Offset  : 0

use set_geometry_by_ecc_info()
[    6.701262] GF length              : 13
[    6.701262] ECC Strength           : 4
[    6.701262] Page Size in Bytes     : 2084
[    6.701262] Metadata Size in Bytes : 10
[    6.701262] ECC Chunk Size in Bytes: 512
[    6.701262] ECC Chunk Count        : 4
[    6.701262] Payload Size in Bytes  : 2048
[    6.701262] Auxiliary Size in Bytes: 16
[    6.701262] Auxiliary Status Offset: 12
[    6.701262] Block Mark Byte Offset : 2018
[    6.701262] Block Mark Bit Offset  : 4

here are some background tips (fsl,use-minimum-ecc) for your refer:

The bug was submitted in regression test,
[1] https://linux-mtd.infradead.narkive.com/hfRFPn3P/gpmi-mtd-ecc-regression

First patch to fix it
[2] https://stable.vger.kernel.narkive.com/mupPGUPj/patch-v2-mtd-gpmi-fix-the-ecc-regression

Introduce devicetree to configure by user(more flexibility)
[3] https://linux-mtd.infradead.narkive.com/tqQZ75Iz/patch-v2-mtd-gpmi-add-a-new-dt-property-to-use-the-datasheet-s-minimum-required-ecc



> It looks like you are papering over some other problem.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
