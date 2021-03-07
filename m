Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C9330147
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 14:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCGNk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 08:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhCGNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 08:40:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 955E66509B;
        Sun,  7 Mar 2021 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615124404;
        bh=KAdEzK9L5PScgpNAXea/SaJwnc31diz8Kc4lZDKBNQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODp56EExQBe5YBqwFMwKZFkQS82V2r/lVxi3enrxB8rg7DOX/AeqQWV90hw2t2GCH
         FxSLhQxMhKAufgWdvnAgMRx+w2rKi9PaQbqhNwHbHOHI1nxyc8w7wp8XGezbB6vvr3
         DB8asULJ3DNPWARceFOaoTuKJBYftGTAsur8kEFDnCnf9zRIJNTRGp9kazg+oanhIw
         E9ThWB9iY3acPTle3GhyNQgapKYxZHkyqnGImKRFdbuTB28dhYIy6Tr0lkDAtAcIvj
         7UFEqNAd4m8ORMoVl0ry2ib3j9ZMCUjmJkHge6xwtrMKK4uBs3X+TkkV0VFC7uGbWP
         J9gPRfV6qU5KA==
Date:   Sun, 7 Mar 2021 21:39:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v3 4/5] arm64: dts: librem5: protect some partitions of
 the nor-flash
Message-ID: <20210307133958.GH543@dragon>
References: <20210219100439.9428-1-martin.kepplinger@puri.sm>
 <20210219100439.9428-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219100439.9428-5-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:04:38AM +0100, Martin Kepplinger wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> These sections should be read only as they contain important data.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../boot/dts/freescale/imx8mq-librem5.dtsi      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index c2bbbdeb93e3..d39ae27c8e42 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -258,6 +258,23 @@
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			label = "protected0";
> +			reg = <0x0 0x30000>;
> +			read-only;
> +		};
> +		partition@30000 {
> +			label = "protected1";
> +			reg = <0x30000 0x10000>;
> +			read-only;
> +		};

Please have a newline between nodes.

I fixed it up when applying.

Shawn

> +		partition@40000 {
> +			label = "rw";
> +			reg = <0x40000 0x1C0000>;
> +		};
>  	};
>  };
>  
> -- 
> 2.20.1
> 
