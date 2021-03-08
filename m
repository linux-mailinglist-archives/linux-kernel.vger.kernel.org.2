Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F123330DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCHMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCHMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:32:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F21C06174A;
        Mon,  8 Mar 2021 04:32:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ci14so19950730ejc.7;
        Mon, 08 Mar 2021 04:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DyaNixOD/7IKoYOEQqBQtYom5s9K0U3gpxDD086XhLY=;
        b=E3H2VrwL8yCwHpkkbz34PSIbGWXgXJU+Cx/Uwifr00+VEJATQCGjY+4OfvU8gQq2Lu
         K0vMaITat7mtcctIB7ahH3G18mQVy/TcK+APGbtpoLoxmUTaVdieswsxvA4YiKW+TuKI
         muF6YCCEUr3VjbVDWX9h3zf0ylcHVq2c8F1iI1SsK5aIvcFq3fNXRp9Cxg0u6PwP7KeX
         rfcYWGtTdzaZqYjL8CHI4HJb61j+MU36xYpxUJmuWYZfnjXcTyNqpRkcMBY+YyL/ssxj
         Z8dxuqsEnMW3zS2W/Q5ZU+K8r5VFn02h2VRROlogG7KNWR00XV3r1h7Ici8IKq3Cr5Gv
         4YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DyaNixOD/7IKoYOEQqBQtYom5s9K0U3gpxDD086XhLY=;
        b=lrspLe8wVeAkE2BjQ7cTZa+FMb5CHwDa9AkEEc9lKBzNYrgs6nHaegCQIone/Yb5f5
         NPF6UjLiku8KmhiNIv76Nwokccy/2hf5GY1D71LKhDQZ5HHtUxpm0cUZ3j2ohpCaLPsu
         OueAtNMSmoSEVCzPECNh521VSHGLQ36MOasBhu1LkcWuNXvsjeNb9VgK5p0sj1HFMHrN
         gbMFg+N7lGwO89Dq8eiKFLzoG15qm35GNLA1DK6UMQT6W3u7SgrxB4ildK7Lb1/WSZed
         dGqbqgzH5cfO2M89OFm5tNyJuGPeZJBBFOH/uOiTZUYf/pasr1IiuPcIs7j5uSkZDH5L
         cQJw==
X-Gm-Message-State: AOAM532l3e5H8tlSw6OJ82Zh3SDXRnegcMBuzBskZC6c88t8pdVGq64l
        pIt6f0VX+LenqAUCGmbzwWxNb/tGUaS7f2TMG/JCSbh5OLQ=
X-Google-Smtp-Source: ABdhPJzRhu8t1n6m7FXXvNXMx/YrqhDeyO4dO8yMAe0ED0b9Tp/q0lZBc+K+xtf9ARyPF6M/jbyZC4obNIuQvvAeiEU=
X-Received: by 2002:a17:906:d9c9:: with SMTP id qk9mr14451619ejb.504.1615206755625;
 Mon, 08 Mar 2021 04:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
 <20210308004616.GM543@dragon> <CABkfQAHkJ=4Zwhbz0MxhbedK71JzaaQFXR5tN1k=8JmDysGGjA@mail.gmail.com>
 <20210308123030.GA11246@dragon>
In-Reply-To: <20210308123030.GA11246@dragon>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Mon, 8 Mar 2021 13:32:24 +0100
Message-ID: <CABkfQAGBXopCMO2gsNk6WxE3D47wbXbqEMePC0RZs8T3FxXG=w@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add peripheral support for imx8mm-nitrogen-r2 board
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 8 mars 2021 =C3=A0 13:30, Shawn Guo <shawnguo@kernel.org> a =C3=A9c=
rit :
>
> On Mon, Mar 08, 2021 at 12:54:05PM +0100, Adrien Grassein wrote:
> > Le lun. 8 mars 2021 =C3=A0 01:46, Shawn Guo <shawnguo@kernel.org> a =C3=
=A9crit :
> > >
> > > On Tue, Feb 23, 2021 at 08:16:43PM +0100, Adrien Grassein wrote:
> > > > Adrien Grassein (10):
> > > >   arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
> > > >   arm64: dts: imx8mm-nitrogen-r2: rework USDHC1
> > > >   arm64: dts: imx8mm-nitrogen-r2: add USB support
> > > >   arm64: dts: imx8mm-nitrogen-r2: add espi2 support
> > > >   arm64: dts: imx8mm-nitrogen-r2: add UARTs
> > > >   arm64: dts: imx8mm-nitrogen-r2: rework UART 2
> > > >   arm64: dts: imx8mm-nitrogen-r2: add PWMs
> > > >   arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
> > > >   arm64: dts: imx8mm-nitrogen-r2: add audio
> > > >   arm64: defconfig: Enable wm8960 audio driver.
> > >
> > > Applied all, thanks.
> >
> > Thanks,
> >
> > But I think you missed one (arm64: dts: imx8mm-nitrogen-r2: add espi2
> > support) that I don't see on your tree.
>
> Hmm, looks like it did not get posted.
>
> https://lore.kernel.org/linux-arm-kernel/20210223191652.436397-1-adrien.g=
rassein@gmail.com/
>

Oh sorry, my bad.
I will repost this patch alone.

> Shawn

Thanks,
Adrien
