Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB4330CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCHLyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhCHLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:54:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554CEC06174A;
        Mon,  8 Mar 2021 03:54:17 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lr13so19805211ejb.8;
        Mon, 08 Mar 2021 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hf+MOkGUF/+XQY0pW7Vbm65mukIT+Daskh6kozp2n0U=;
        b=Ue5RtR/3KmxIr3UVZ9kA4eB6Q1jR6Vi+LeNv/my5+qFyo00wEmZIeU+fOLIYy1c3QB
         Y9a6mnl+br2JrOIoXdCAATL0XZtmlzm5zwqYVxn6tGXnyV2QL44rpzHveqibV8+PWnx2
         ESXrssSpHfybm+EJEM/sw0IWC7Av0ZozG+lI27NI3dknOaKRF7Tb7/Xk7vvdgnN0mEnP
         QdA6/O8H6BVOLWprkp7oyM4kXUQPBjWMCaR08J1Z6xzpt/Kf1IBQ/rKmWtQ55RJMbqNS
         A7LvFnmaBuQsdZ4si9NeoLJClI6fIT18qHpnqSbciQkckcGgUv3d4yP0rgkEaobxcGDQ
         TcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hf+MOkGUF/+XQY0pW7Vbm65mukIT+Daskh6kozp2n0U=;
        b=lN9LS22aS1rbwDW/dHww1fso3uIggr3Sn1gNDmTS5Jgy0yxoI4t/sWjoDk2ah0EXVy
         BS2aLlXXwif6wBDe5PaiBo8amxHHx5fMJlwMheOqhr6Q0RoqR0uPRIeUvQxA7+Gwk1fu
         nvcSSsBdAgvPsmAd/9fMRatN1cteAv218y/pfzgsTgz+vfM+5Bw4U6GmcCHfoculEih/
         GdF/Cu/zuJdwspzAKlES5qFEubZtYPvSl71WmqXZhBNdYdcwXyZd1iLnVi42pcDaWx04
         ZIaRD3W9w9bAQ8Zlek1boipaf7bYHBt34nxidOv2c4uktOYcQKX8umQP0hgdau22SpbV
         AiwA==
X-Gm-Message-State: AOAM533SaRsNISSxWtC/xuPBmJWhSA2aXd197YnTu4F1nwbxeHjLiHEQ
        VZE21Ydplpm4wkRM/0hd6nA2z5Ek2naofbUYPoc=
X-Google-Smtp-Source: ABdhPJz7Er0NxP1bgf96XJBVCneoiYeg4YBHYhXXpcIG3JcC0jHjfx3cK0ugKBaMBJUAlM5NGW/fSRJ6VZFtAWIr8D0=
X-Received: by 2002:a17:906:b2c3:: with SMTP id cf3mr14115564ejb.133.1615204456076;
 Mon, 08 Mar 2021 03:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20210223191652.436397-1-adrien.grassein@gmail.com> <20210308004616.GM543@dragon>
In-Reply-To: <20210308004616.GM543@dragon>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Mon, 8 Mar 2021 12:54:05 +0100
Message-ID: <CABkfQAHkJ=4Zwhbz0MxhbedK71JzaaQFXR5tN1k=8JmDysGGjA@mail.gmail.com>
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

Le lun. 8 mars 2021 =C3=A0 01:46, Shawn Guo <shawnguo@kernel.org> a =C3=A9c=
rit :
>
> On Tue, Feb 23, 2021 at 08:16:43PM +0100, Adrien Grassein wrote:
> > Adrien Grassein (10):
> >   arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
> >   arm64: dts: imx8mm-nitrogen-r2: rework USDHC1
> >   arm64: dts: imx8mm-nitrogen-r2: add USB support
> >   arm64: dts: imx8mm-nitrogen-r2: add espi2 support
> >   arm64: dts: imx8mm-nitrogen-r2: add UARTs
> >   arm64: dts: imx8mm-nitrogen-r2: rework UART 2
> >   arm64: dts: imx8mm-nitrogen-r2: add PWMs
> >   arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
> >   arm64: dts: imx8mm-nitrogen-r2: add audio
> >   arm64: defconfig: Enable wm8960 audio driver.
>
> Applied all, thanks.

Thanks,

But I think you missed one (arm64: dts: imx8mm-nitrogen-r2: add espi2
support) that I don't see on your tree.

Thanks a lot,
Adrien
