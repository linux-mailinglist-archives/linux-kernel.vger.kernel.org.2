Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467D838738C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbhERHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbhERHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:53:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C444C061573;
        Tue, 18 May 2021 00:51:54 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u144so8954863oie.6;
        Tue, 18 May 2021 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2cj8ECLCxMgNZu56e2rlhFF7iooXQEs3pOnpmb/q+s=;
        b=jrNj0cUBDqctrofWFJLsVPDWCudnMRdR5M8HYGs+8B5bFknxVqpLBteG5UpoWZIrvq
         DaLKEeYvtUVw80mOOywl0jnYFT8ZKbzPuZfzbsPIR5Slgcqvzh93w772bJ9dNeytbPl6
         DPAkeCyBt5GG4G+S04znXVGElxopgjTq2AEQaxTpHU5F0eOS4E9jlyoaSAtmUfxF4qAs
         rxPQvrDLidiqR5XWZm52vS/Fd4ldiOD9XACNvlhg1e7iihUXaGXjlyvVaMdsFF/yGO2Z
         EsWlRFTEs9cZnhdO2RPxSOPx5Sh6MHPlakKOBfQHwWU/+kiP53o98ieE+ZuA+NkhBJK7
         wqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2cj8ECLCxMgNZu56e2rlhFF7iooXQEs3pOnpmb/q+s=;
        b=szMn4WGWI0a7UDT3QO8FntdFDVLC/iJZBzfAgwuKsxS868D87DOQgNitQ4J2pAzjKJ
         uyns+98Za2qbtFmN0w8Faxz6XttWxLg3s23PKfjWn8BRMiRqBOaa+mYkWbfv2gH7WQvv
         LjESCwTMH8cgygqxxvis/hDuwm6NN7XX6VhHu7A/j5KNGtwaXx+mPUgx6BiDWzVvDk59
         6DxWjuYNMJC6RWKHBfLnv1ozTcSKpTPEiBI0t4o5QH7LC5qFOZ39uRnUFoEkVZdvo0zk
         CdOI0Soy0Uifrb6ouWWCujzhJGe0fwNnQhN+MOYfIisryYpWsu8pz+c7HqBjWZ3pvr/b
         +MHw==
X-Gm-Message-State: AOAM5333k0U2Aa3HxDKloIKXCSkp2mn5ciEdTOXrDT1/INIb62nLYR72
        3glNUI/ikwhUKoTfoZlyD7qmFKhfhRqRMQLqAIU1GtM9
X-Google-Smtp-Source: ABdhPJyBLA2tDSH492cLueiUr6azzs8hwwDINXO75eeGgYT5N2zIyZLToMnynsss4gF80aL4Ilwqr83kP/8rUbAnkm4=
X-Received: by 2002:a05:6808:7c1:: with SMTP id f1mr1552093oij.142.1621324313553;
 Tue, 18 May 2021 00:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-3-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-3-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:50:51 +0800
Message-ID: <CAA+hA=RhJ56aQdndPxopXCeQf9UK1AMrLy0QXAmY8Fs7UJucrg@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: dts: imx8-ss-lsio: Add mu5a mailbox
To:     Abel Vesa <abelvesa@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:14 AM <abelvesa@kernel.org> wrote:
>
> From: Abel Vesa <abel.vesa@nxp.com>
>
> The mailbox of the lsio mu5a is used by rpmsg on imx8qxp and
> imx8dxl platforms.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> index ee4e585a9c39..8e3c92c82fac 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
> @@ -141,6 +141,15 @@ lsio_mu4: mailbox@5d1f0000 {
>                 status = "disabled";
>         };
>
> +       lsio_mu5: mailbox@5d200000 {
> +               compatible = "fsl,imx6sx-mu";

For normal devices node, the compatible string are prefered to be
defined in soc-ss-xxx.dtsi
in case to handle HW minus difference. e.g. mu13


> +               reg = <0x5d200000 0x10000>;
> +               interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +               #mbox-cells = <2>;
> +               power-domains = <&pd IMX_SC_R_MU_5A>;
> +       };
> +
> +
>         lsio_mu13: mailbox@5d280000 {
>                 reg = <0x5d280000 0x10000>;
>                 interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
