Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC7E320B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBUPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhBUPsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:48:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9321564F06;
        Sun, 21 Feb 2021 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613922492;
        bh=jcWCoBwWx2HnSC/EBefOB99kQ2ZXLE7HTEG/sXIXKog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qquIW9v/tVu4EORzsxrDLsva3f/tNw/QNj5R3UeooTpAeXX3KNXGE+M9v6YrLWiSk
         CX+tU/SLV7vtuIoP1+PygFsBpGidFYgeTbDkDtFnchBIhmUCw4p0yBoWz2app5T0S1
         9hGMZYaChoGyqQZ9zRPXzlfQcPH/ugSzCtxy5oppeu/iWebWxay1VpB1z/HmnG4atw
         ZFR1MQpufrjahC2LvVZ2m8jNwdTLczR6u1n6dcIVJDuM3nu6MPb054hWPfOfTlODzp
         pH14Y8fSMOGHPibWx1X8fZA5f+WwXIdTgYFLKjXHUCoEbZSJW6ZE6xNdGdY3LAh4ZG
         X3tMmOMMHpl5A==
Received: by mail-ej1-f54.google.com with SMTP id hs11so25266976ejc.1;
        Sun, 21 Feb 2021 07:48:12 -0800 (PST)
X-Gm-Message-State: AOAM5309OKVyrGbzfurxoODzOLeAbhXS3O8RK+cg+A7NEAS8g9z14oDZ
        /UlQhD57H9pF08NIXDQKvMLp6EZjIkdtAKWFn98=
X-Google-Smtp-Source: ABdhPJyP+b6iCRU0oPc1IlpU3m6/5pCUO3+cOICburAsl7GU24805l8o9tUdORtu3NiHyRXBuySfbjnBtOKawO2nvE4=
X-Received: by 2002:a17:906:1c4f:: with SMTP id l15mr6507034ejg.148.1613922491110;
 Sun, 21 Feb 2021 07:48:11 -0800 (PST)
MIME-Version: 1.0
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com> <1613750416-11901-16-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1613750416-11901-16-git-send-email-abel.vesa@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 21 Feb 2021 16:47:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdNx7LSpNS7VmwpGXyNSUSZjEVDMmVpz1T3nmqWWuqH=g@mail.gmail.com>
Message-ID: <CAJKOXPdNx7LSpNS7VmwpGXyNSUSZjEVDMmVpz1T3nmqWWuqH=g@mail.gmail.com>
Subject: Re: [RFC 15/19] arm64: dts: imx8mq: Add all pl301 nodes
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021 at 17:04, Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add all the pl301s found on i.MX8MQ, according to the bus diagram.
> Each pl301 has its own clock, icc id and opp table. They are probed
> by the imx-bus driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 180 ++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index e30e948648e9..5f9ffa465d6c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1447,5 +1447,185 @@ ddr-pmu@3d800000 {
>                         interrupt-parent = <&gic>;
>                         interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>                 };
> +
> +               pl301_main: pl301@0 {
> +                       compatible = "fsl,imx8m-nic";

Does it pass dtc W=1 and dtbs_check without the "reg" property?

Please also name the node in a generic way (see for example  DT spec
"2.2.2 Generic Names Recommendation").

Best regards,
Krzysztof
