Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436833FADBD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhH2S1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235664AbhH2S1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F91460F3A;
        Sun, 29 Aug 2021 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630261598;
        bh=nKCTcBqz5WPjxEtG2krSvcfWV1osO03SdX1Dref/wBc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gRNqnt/A1jEsAGOH5jlXpYyRf1qdZjXZ5zzARBSi99TYNUqCr2PEslLuEV3SEiU7y
         VFPFY+LKrobIP+cGTAX/rqVD+qePRS43myF95JCJtV4b89qXjiYBewo3l4RkDR0G5z
         mgYUFR93yNAMuBHsyADW+Kubp0jDkQg/uaf2GtVfbbCSPiNadoyP+3sP0Aq0VwUH2B
         XqJAxHBxvEly9U48O/SL4nhFvw56dzqnC2C0w2/8FSy1mDaRj0w8Z9/6lKSUfViPeX
         VmDEs4FMjC9/Qce6vGvc3a7v3pzwgrxIbwnaGYqGz1+wcU14HPh5WbLorAXVuZbm/I
         C8rZufk6WKttQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210820111504.350-7-chun-jie.chen@mediatek.com>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-7-chun-jie.chen@mediatek.com>
Subject: Re: [v2 06/24] clk: mediatek: Add MT8195 apmixedsys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 29 Aug 2021 11:26:36 -0700
Message-ID: <163026159693.2676726.8564637566834797534@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-08-20 04:14:46)
> Add MT8195 apmixedsys clock controller which provides Plls
> generated from SoC 26m and ssusb clock gate control.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig                 |   8 +
>  drivers/clk/mediatek/Makefile                |   1 +
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 145 +++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8195-apmixedsys.c
>=20
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 576babd86f98..7ba1f4118e0d 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -580,6 +580,14 @@ config COMMON_CLK_MT8192_VENCSYS
>         help
>           This driver supports MediaTek MT8192 vencsys clocks.
> =20
> +config COMMON_CLK_MT8195
> +        bool "Clock driver for MediaTek MT8195"
> +        depends on ARM64 || COMPILE_TEST
> +        select COMMON_CLK_MEDIATEK
> +        default ARM64

Please no. The default should presumably be ARCH_MEDIATEK, or just
nothing at all.

> +        help
> +          This driver supports MediaTek MT8195 basic clocks.
> +
>  config COMMON_CLK_MT8516
>         bool "Clock driver for MediaTek MT8516"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
