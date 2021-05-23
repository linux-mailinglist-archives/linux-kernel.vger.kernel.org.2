Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B550338D895
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 05:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhEWDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 23:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhEWDvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 23:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B80C61175;
        Sun, 23 May 2021 03:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621741797;
        bh=cVG1RavaakT/pbgpnySkkEFeSCJvpy6r1jIbJQU+Z3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSMN7xUmw98yGP3zS5SiXFGjJf6T4YWGxdDwiZorcjGUKhn+55do0WwRYCimOJD+f
         o1hhDZ4BkqrEJD2MSXDeg8ytM9cdqXRVnDEkjz9Mqgj9Wv16X4MxlnOmE9aHjKJC/T
         dtv/McBBHjwAa2WrYKfk7M/caxH4agkTKN5LvaKvRFSQa/HVWcGmxw/G2we8TmU730
         9WHc42cHIU0Q4GEqCreXWBf01+7f0M6ze+b+aSm2VJs4ev7K55BFa9NL9qEyx5BhXp
         COIylFS+nmXa9B9KdAxKxXMgCSofj9C82Y7tgmFTFDFR+fT7Qhs4gQqx86+6KyoKyD
         y0OyqncsCGygg==
Date:   Sun, 23 May 2021 11:49:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Configure the OLED
 display segment offset
Message-ID: <20210523034952.GU8194@dragon>
References: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:55:14AM +0200, Michal Vokáč wrote:
> The imx6dl-yapp4 platform uses a GE-LX012864FWPP3N0000 OLED display.
> The display consist of a 128x64 OLED panel and a SSD1305 controller.
> 
> The OLED panel resolution is 128x64 but the built-in controller default
> resolution is 132x64. To display properly a segment offset needs to be
> configured.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Why are you resending?  Please state reason when you resend.


Shawn

> ---
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> index 51972c85e207..111d4d331f98 100644
> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -373,6 +373,7 @@
>  		solomon,height = <64>;
>  		solomon,width = <128>;
>  		solomon,page-offset = <0>;
> +		solomon,col-offset = <4>;
>  		solomon,prechargep2 = <15>;
>  		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
>  		vbat-supply = <&sw2_reg>;
> -- 
> 2.1.4
> 
