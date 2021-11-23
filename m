Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EF459B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhKWEvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKWEvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:51:03 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5883AC061574;
        Mon, 22 Nov 2021 20:47:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3568D423AD;
        Tue, 23 Nov 2021 04:47:51 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211122225807.8105-1-j@jannau.net>
 <20211122225807.8105-4-j@jannau.net>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <c0acaf72-cd86-4e92-63e5-3f903c025943@marcan.st>
Date:   Tue, 23 Nov 2021 13:47:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122225807.8105-4-j@jannau.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 07.58, Janne Grunau wrote:
> Apple M1 has at least 5 i2c controllers. i2c0, i2c1 and i2c3 are used
> on all M1 Mac devices. The 2020 Mac Mini uses i2c2 and the 13-inch
> MacBook Pro uses i2c2 and i2c4.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   arch/arm64/boot/dts/apple/t8103-j274.dts |  4 ++
>   arch/arm64/boot/dts/apple/t8103-j293.dts |  8 +++
>   arch/arm64/boot/dts/apple/t8103.dtsi     | 92 ++++++++++++++++++++++++
>   3 files changed, 104 insertions(+)
> 

> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index c320c8baeb41..15fec48f943a 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -126,6 +126,73 @@ serial0: serial@235200000 {
>   			status = "disabled";
>   		};
>   
> +		i2c0: i2c@235010000 {
> +			compatible = "apple,t8103-i2c", "apple,i2c";
> +			reg = <0x2 0x35010000 0x0 0x4000>;
> +			clocks = <&clk24>;
[...]

Please put these before serial0; I want to keep the nodes sorted by address.

With that fixed:

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
