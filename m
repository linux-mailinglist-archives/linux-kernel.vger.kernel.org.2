Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85908454736
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhKQNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:30:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36775 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237561AbhKQNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:30:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A9B355C024A;
        Wed, 17 Nov 2021 08:27:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 17 Nov 2021 08:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=Z
        4kv6l8PmW/t7OA18U34PRf4IA+Xh+8qP1Nvfqg/0xs=; b=FkRAjDYh8lOzP8huS
        Mr12ls55L/rRTxOGgM7g6juq4H8Y7ldo6h0ak4wnHx5o5DtgBmXb5YABfoql51aM
        X6+fOjmcaBYurME7wrQ5yZ6cWYcsjtS5ytorBgU47Ie5/yMuxBd3LKgNGi1bgWFY
        rRdRMtrmMrG4THd8h5Ez50PRdTW6AF9Y7O1fzoQWBhkokmg+T/Zl2fqZhpeuedCa
        NzaOHiN+LMP1UD6ORAHxEml/P8CpewFyVpO4yYSjcIYEaYGoKzpLcec6IMQ0zx+F
        YZnECsKK9hJ/muF0kqWU55Gb1WTLy/wSRlSJ+GQ6nL/gB0jtR48zOzI6+yocEXmw
        tCX+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Z4kv6l8PmW/t7OA18U34PRf4IA+Xh+8qP1Nvfqg/0
        xs=; b=K9eN/5yssiSfpPVY3V1Zz7R06RaxsHseszT2+Y8BK381zXgMh1ct/bB4A
        VrT9+ZZdQ1WAGMCvjR6Yvj2xfho0qQBDLFFPOJ+b9u6IR2xP5hBckOsCRTStP+wM
        D30+MRpSHokt0yNuaD7SvjtLK1dRNjfbzljIrZdESGXFMrGuOVlwjX9Ke91/FhnB
        cQtBVQojr3Q67oMP+VIsZ4+iDWWlpu1LSvUcehR4FycPJipei7VxtynF0IS9MzOV
        t9aL0LlQ4fVs+KNoAy4WLbOrfahtYIhXzByVf39T0BQdpl3P5NMuwK0+ynMeDhBX
        CaNkDXBjibdDx2/IG44I8isLo6Q3Q==
X-ME-Sender: <xms:UQOVYRS_0YSc5wmje-JF-T6gT11L03tSvLnhsQlDx2d6jkCt6k06yg>
    <xme:UQOVYaxvYMXVo2OfCwgcGlMHK6gcvnCggn3AR3nia_aVl58HsK_jl0EjPIwo3zao2
    Eh_4i2nz0Gu0sRWNQ>
X-ME-Received: <xmr:UQOVYW1sVMDaQbTFqFoYleDtz73GK1hHsEDLNbQJXLAhPppqne2FGUw7kQMcMj6yDU8RNamOg17qdL804PQfXQsAwJ61OZNS1SeQeYi-wJyPlPWTWoKSu4ufPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:UQOVYZCEu3wRu5oufTGM97TtkxIkE4JA0PlrTy8Qn3xkTwLDhZzDSQ>
    <xmx:UQOVYaiV9OV1ko3DeFOo8YHDQHWSrTxXtlsGYViFvr-CrplaCzhVjA>
    <xmx:UQOVYdpEX8-KdUkulfDH0DlAeT-8Hv433f8lHQxh-oAupcjKU7h9hQ>
    <xmx:UQOVYTVKW7dcZj5NR64BpyDxtIMJDrckFYnsxdx1iNlpQbqnjIxapg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 08:27:44 -0500 (EST)
Subject: Re: [PATCH] arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Ron Goossens <rgoossens@gmail.com>
References: <20211117094701.11974-1-robert.marko@sartura.hr>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ff93c342-1b78-ede9-007d-bd2e8d1ef16f@sholland.org>
Date:   Wed, 17 Nov 2021 07:27:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117094701.11974-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/21 3:47 AM, Robert Marko wrote:
> Orange Pi Zero Plus uses a Realtek RTL8211E RGMII Gigabit PHY, but its
> currently set to plain RGMII mode meaning that it doesn't introduce
> delays.
> 
> With this setup, TX packets are completely lost and changing the mode to
> RGMII-ID so the PHY will add delays internally fixes the issue.
> 
> Tested-by: Ron Goossens <rgoossens@gmail.com>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Tested-by: Samuel Holland <samuel@sholland.org>

Also please add:

Fixes: a7affb13b271 ("arm64: allwinner: H5: Add Xunlong Orange Pi Zero
Plus")

so this will get backported to stable releases.

Regards,
Samuel

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> index d13980ed7a79..7ec5ac850a0d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> @@ -69,7 +69,7 @@ &emac {
>  	pinctrl-0 = <&emac_rgmii_pins>;
>  	phy-supply = <&reg_gmac_3v3>;
>  	phy-handle = <&ext_rgmii_phy>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  	status = "okay";
>  };
>  
> 

