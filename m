Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34DD3E0FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhHEIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhHEIFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:05:52 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E78C061765;
        Thu,  5 Aug 2021 01:05:38 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y1so5613035iod.10;
        Thu, 05 Aug 2021 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CigNGT2AbpQ4wSDNvI4oyMY6a17yp6Be3VnQFnnxIus=;
        b=JX7XqMPvKDwANHLr7Enzl+BbR0IM9eNOOR3t0GtMmz6BzEx/pFH+05ZcDMFFVitd9c
         IC/2Aya2UKd+/QuB8Za9waPJHAiCfWB3oJhH1xWkE0HedjNlZoc4EdgozMsrexA2Jace
         MIrUgzpSjoTv5j7X04YGWDHCvowVMbt8sc5zxzX0dxByq9d8ILrcDmyxNf+Sdgu3EctO
         lp5T4eWZ2pZbrB9CeGiYts9fyyzpqFZLi36YatacdiicQX/EcJ0JDSNF77av6m9OM2Q4
         c1/o2Z7wzCcwRVODHMh+rMlaMVUKM3ptLXDPbXB2XlkG4q8tBcVCQAtrQOZXCbSNm4Mj
         zQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CigNGT2AbpQ4wSDNvI4oyMY6a17yp6Be3VnQFnnxIus=;
        b=K7viJCEHTmHJeUUCt3ErdDUGIJoLOYY+DJBxZ3lUu10NtM4rG4hku23+WMuNdXdGop
         dWn1o8PMPnYPaXjfybpclfRPS6lT2rXpo4LxQ84IZMEgqfivO/iROFY6nfdzerUlPBgx
         Hw6mgZknTiRjylDfsDccr6jaTaFIFcNWarutUxZJs1a8t4owe0J+eJFRgwASW8T7QHyW
         tFNpch/3CmHbBVkAHFp/CcnvV+Io4yuWP9aqbheaU17d0xE/NvKpQ75pQR3ITKuasWAI
         hfD8afxuBzgAZ485awEjO3V5FWv2nr3ruZNwDQq1xKbq08RfQ/zJIUppDRWSRIrMMuqu
         wHqg==
X-Gm-Message-State: AOAM532nSHRRCMl5i8s+3KHSuSB31jDG7EryHdT+N9w6POUup0MGuw1K
        fdqa+9J5WCADA7ntfMSfKEpiGcMJqp1fcu6s4RQ=
X-Google-Smtp-Source: ABdhPJzNZBZGzsK7tlcjpKcsAXlaEqOYn7z2XrzBU57p8Gp2GSqg5xZGhQOyWMvdk4HUSzuxcdaWGxn7STU14selZn4=
X-Received: by 2002:a5d:8541:: with SMTP id b1mr4078ios.105.1628150737727;
 Thu, 05 Aug 2021 01:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210803084456.198-1-alistair@alistair23.me> <20210803084456.198-9-alistair@alistair23.me>
 <YQqLiAtAtREWTvD7@google.com>
In-Reply-To: <YQqLiAtAtREWTvD7@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 5 Aug 2021 18:05:00 +1000
Message-ID: <CAKmqyKO_QeNTRZx9P9vhX7DQoBfE6igOtJroTEer-OKoVO-RGQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/11] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 10:43 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 03 Aug 2021, Alistair Francis wrote:
>
> > Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
> > reMarkable2.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 42 +++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
>
> I don't see the DT documentation for this device.

Which device?

The imx7d-remarkable2 is in current master and there is a single line
at `Documentation/devicetree/bindings/arm/fsl.yaml`

The silergy,sy7636a-regulator is also already in master, but it isn't
exposed to device tree and the compatible string shouldn't be included
in this patch. I'll fix that.

Alistair

>
> Has it been accepted/merged already?
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
