Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A92459EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhKWJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235743AbhKWJBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:01:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F0960187;
        Tue, 23 Nov 2021 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637657928;
        bh=J7kwUKVNN/3CJzDlKIPH1Apy8xKg2S6cz4ypVO1LfSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6ThtLd6By+yo0589CRi3GyKLYS/z3CcFbZrVqf6f4qZDTbt4t+NGdM/WE9pyEZBP
         Oe+nsJaHFTuQnJCOhe1Vwtrm1nq1bdcK3ciiRZhlVWn/6qQ48OFSK9GCCHqM2Hu5ku
         hDlPys25WtcZ4DVjrztqSgP48LZqFVF6tSzPeSbQr3obgFB/KzEVz4eBhX8Ucki6I3
         FGaC04z3XHYQat5e2KOJEB6daWCZpj7245EqmKdHwafAyveGhUlpQ++5QvBfsopSEf
         Mm1RjmdzbFMcRe83j+U/mwqAejkv+TX1h12a5kkrXZ3DWo1Ba+SNqtlqxDRNSq5BRB
         HuhnwZ5ZyadAw==
Date:   Tue, 23 Nov 2021 16:58:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Martin Kepplinger <martink@posteo.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: imx8mq: Disable noc dts node
Message-ID: <20211123085841.GX31998@dragon>
References: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 01:16:09PM +0200, Abel Vesa wrote:
> Adding interconnect properties to the consumer nodes creates
> a dependency on noc device. The imx-bus devfreq driver is not usable
> without the full interconnect support. The interconnect is not yet
> working on i.MX platforms. The devlink created on device_add makes
> the lcdif and other nodes that have the interconnect properties
> wait for the noc (imx-bus driver) to probe first.
> 
> To make sure the interconnect consumers (nodes that have interconnect
> properties already added) will still probe, lets disable the noc node
> for now. Once the interconnect on i.MX platforms is fully functional,
> the status of the noc node can be changed.
> 
> Fixes: ad1abc8a03fdbc05b ("arm64: dts: imx8mq: Add interconnect for lcdif")

Martin,

Do you have any comment?  So your commit added something untested?

Shawn

> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 972766b67a15..f3182878f596 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1305,6 +1305,7 @@ noc: interconnect@32700000 {
>  			fsl,ddrc = <&ddrc>;
>  			#interconnect-cells = <1>;
>  			operating-points-v2 = <&noc_opp_table>;
> +			status = "disabled";
>  
>  			noc_opp_table: opp-table {
>  				compatible = "operating-points-v2";
> -- 
> 2.31.1
> 
