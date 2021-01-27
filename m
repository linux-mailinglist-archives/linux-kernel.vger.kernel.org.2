Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDD306279
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhA0RrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbhA0Rqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:46:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F99C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:45:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c2so3446664edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=x2CXSxSq2enuM8qJRJ4/hN373ovcf2FkfR8Rw2oWvKQ=;
        b=VqkUilBvr2UIs7DDfnpftOdumw9SlRIbCSdTGs0bfrUZaf5Ew59l/Bg7b7873LKIjC
         xN8nSxSTm6sCzhnfjMsqMHr9eK1gheb2c6qCVO8urfJTzRzMOcETOHTL494h5yuT3yWk
         tWiFJ4WM13AmfE8BVw8w3CfcsQECKDvo8s5896HJfWVXGfMapzr5xU7K7G92lZIVo3W6
         oI+jSGSXlKHOYIpDsKBGTZSB6mI0eam9yNCoNZt2CSrzdAoG/njy+e++YUAv6OHwKGWF
         Kl0cEMqdkhbM7g0g4Wt7D4eBWmPXF7FnOVFDCpRWFBw13iLx8o9H7cXNbk7k4mQLij92
         G6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=x2CXSxSq2enuM8qJRJ4/hN373ovcf2FkfR8Rw2oWvKQ=;
        b=etTiOyyzNH4hwbxawfFle6knUyCUgfNLy4tHsGxg55nSCcocACYZdb83rYvgWw9med
         sHXFXMsNvwtstqHuyCuC1JpFrFGEhKa12+sRlEbhprRbGTpkslQQrIOdiS2fcEza8ImB
         2HM+nqJ6t5+/LdWx/hobhMgfnN4QDkCia3i/LUXj0VY684J6pQxnMCJzzAI9QvBQs/VI
         1ceTqo6UMFgg0mtgH17j25UheOpoJgUX6x6iEIJnGALh1FLWLmrCi+m3bEdJy0NC4B8j
         ZmunM2eqslI40TQzWEsbEp4e/vPwsqpkeHDfQ1syc4Vj+nhZU7bVEa1nvp5dvE8/ggin
         z0lA==
X-Gm-Message-State: AOAM5304AetKO7C7HyWl6ca6eWDvQaeIoN+Mh9+/XAuWr0PgFQUwvZiq
        Ivg6ikGkNP/TxR49AeOr0JRxcdgLR8ykjc7HUzQ=
X-Received: by 2002:a05:6402:306a:: with SMTP id bs10mt9459884edb.209.1611769552624;
 Wed, 27 Jan 2021 09:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20210118111531.903154-1-adrien.grassein@gmail.com>
In-Reply-To: <20210118111531.903154-1-adrien.grassein@gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Wed, 27 Jan 2021 18:45:41 +0100
Message-ID: <CABkfQAG70BWULqrDqyhL84v1XuPZRQ3NQT88V+2eFrbVaEzWig@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for Boundary Nitrogen8M Mini SBC
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

Could you please have a look at the new patch set made after your commentar=
ies?
Thank a lot for your time,

Thanks,

Le lun. 18 janv. 2021 =C3=A0 12:15, Adrien Grassein
<adrien.grassein@gmail.com> a =C3=A9crit :
>
> Hello,
>
> This patch set aims is to add the support of the Nitrogen8M Mini SBC
> from Boundary Devices.
>
> Thanks,
>
> Update in v2:
>   - Rewrite the dts (Remove the unused wlan and audio);
>   - Remove useless definition;
>   - Take in account review.
>
> Update in v3:
>   - Take in account review.
>
> Update in v4:
>   - Reorder definition in pmic
>
> Update in v5:
>   - Take in account review.
>   - Remove useless i2c groups
>
> Adrien Grassein (3):
>   dt-bindings: arm: imx: add imx8mm nitrogen support
>   arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
>   arm64: defconfig: Enable PF8x00 as builtin
>
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 395 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  4 files changed, 398 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2=
.dts
>
> --
> 2.25.1
>
