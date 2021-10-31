Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEF44112D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhJaWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 18:18:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43198 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhJaWSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 18:18:46 -0400
Received: from p508fde95.dip0.t-ipconnect.de ([80.143.222.149] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mhJ7W-0001BA-FH; Sun, 31 Oct 2021 23:16:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Heidelberg <david@ixit.cz>
Cc:     ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: dts: make dts use gpio-fan matrix instead of array
Date:   Sun, 31 Oct 2021 23:16:05 +0100
Message-ID: <6620342.YEPOndrCoh@phil>
In-Reply-To: <20211029114948.41841-2-david@ixit.cz>
References: <20211029114948.41841-1-david@ixit.cz> <20211029114948.41841-2-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 29. Oktober 2021, 13:49:45 CET schrieb David Heidelberg:
> No functional changes.
> 
> Adjust to comply with dt-schema requirements
> and make possible to validate values.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++----
>  arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts     | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi     | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts    | 5 +++--

for the Rockchip boards:
Acked-by: Heiko Stuebner <heiko@sntech.de>



