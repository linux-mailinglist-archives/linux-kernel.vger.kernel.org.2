Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8F45A1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhKWLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:49:42 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59817 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236340AbhKWLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E1F345C0134;
        Tue, 23 Nov 2021 06:46:24 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Tue, 23 Nov 2021 06:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=dnTnozKlpPAyNutgApu7nvycef8O
        XC+R5iXmiAkTLRY=; b=LZXGhEI1be7Kxje0WQJvj9fOnxuJEjl/kFqObT33jnUZ
        ua+zBHegd39vG5amKpvIayIpKuJOdRQs2Him0aqR1IGJbwxid/8KspAMJQe3moad
        GxQkm6qWTagYUU0XwDY+1epAYeEzekrpLCnL8XPg6uAyBuYxAJJ9Qzssnu5VyMQz
        wjjt+9BMlDxdeNHFSMerF8fGXH2qu9Fwjkw4arMJsRrU6cSlo0khnVo5X0qzxfI3
        AyKHWr0gohBTLH4gYW3txeYPeSZusvJPxsE32Ex63mYSKDZTqvilQ8gpYRo6OBTx
        /kweLwxb+LXwKngQMYmMaCzfLD+i5HmpnUQz2c+vpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dnTnoz
        KlpPAyNutgApu7nvycef8OXC+R5iXmiAkTLRY=; b=A1Rh4i6ZL3EowVNdCLw1ds
        QzIriY40onVLE1eItybJuXMMqq/bcXrrljZzk/9UTWhHd0VkaDI+ZvngdFzaZmQ3
        g7/z3eMLqIBDDK/KkfxBMu+G5Y2Wq6GaRQkljNQD9DZjvLa+G32t+vWUzTJJfN9H
        ZKI16eMWD86YYLQefwa3Zd6/bH4LJtvzzC8YJyKUr2zfFe+Pc7Icvktgu8Z/94EI
        MwfURFRtnZplEunnM53iABw94NzG90VEXvI6IuMUqKheS6aTJc85A6eqJUbySE/G
        DytHQCGNYWIRD/PPWuYq3lACeIOkVxf7ucHvgAOzhKoyQpjVngYTaWw/6D0YPs+Q
        ==
X-ME-Sender: <xms:kNScYQveokF47KP3RU6A-Icakyy04LJhdSv4ltbFzwwIbyi2znMdfg>
    <xme:kNScYdeI8MnTRlyHUcun29fkVSL2GogaAYRu3uAyElzBxFvd69FXOe2tC0CR-lpso
    066G93thhvYrMKeKF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:kNScYbzF76VJOB6Bah8GRo41Gmt0DXyxFH1oI4_zfiWd4U225FCYnQ>
    <xmx:kNScYTOF8airOLWnf8pS_RFYp_RTBngZbb3ArQO4UZ-r6hQCe1SnGg>
    <xmx:kNScYQ9NyS1z6cb18r2P_aEkS94r2IQLJ2x1Z6qBhWOfYLq2Bsdgbg>
    <xmx:kNScYUYIsMz4e0DKfm_r68juibqwqgQ-7_jRa_fyB6ZYMd8jen2PmA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C5292740616; Tue, 23 Nov 2021 06:46:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <48e73209-29e0-4906-a292-012169ab77d3@www.fastmail.com>
In-Reply-To: <20211122225807.8105-4-j@jannau.net>
References: <20211122225807.8105-1-j@jannau.net>
 <20211122225807.8105-4-j@jannau.net>
Date:   Tue, 23 Nov 2021 12:46:03 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Janne Grunau" <j@jannau.net>, "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 22, 2021, at 23:58, Janne Grunau wrote:
> Apple M1 has at least 5 i2c controllers. i2c0, i2c1 and i2c3 are used
> on all M1 Mac devices. The 2020 Mac Mini uses i2c2 and the 13-inch
> MacBook Pro uses i2c2 and i2c4.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/t8103-j274.dts |  4 ++
>  arch/arm64/boot/dts/apple/t8103-j293.dts |  8 +++
>  arch/arm64/boot/dts/apple/t8103.dtsi     | 92 ++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts 
> b/arch/arm64/boot/dts/apple/t8103-j274.dts
> index 9e01ef70039d..2cd429efba5b 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j274.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
> @@ -39,3 +39,7 @@ ethernet0: ethernet@0,0 {
>  		local-mac-address = [00 10 18 00 00 00];
>  	};
>  };
> +
> +&i2c2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts 
> b/arch/arm64/boot/dts/apple/t8103-j293.dts
> index 466035f00b69..49cdf4b560a3 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j293.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -31,3 +31,11 @@ &pcie0_dart_2 {
> 
>  /delete-node/ &port01;
>  /delete-node/ &port02;
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi 
> b/arch/arm64/boot/dts/apple/t8103.dtsi
> index c320c8baeb41..15fec48f943a 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -126,6 +126,73 @@ serial0: serial@235200000 {
>  			status = "disabled";
>  		};
> 
> +		i2c0: i2c@235010000 {
> +			compatible = "apple,t8103-i2c", "apple,i2c";
> +			reg = <0x2 0x35010000 0x0 0x4000>;
> +			clocks = <&clk24>;
> +			clock-names = "ref";

No need for clock-names in these nodes. The schema only allows a single clock
anyway.
With that removed and Hector's comments addressed:

Reviewed-by: Sven Peter <sven@svenpeter.dev>

