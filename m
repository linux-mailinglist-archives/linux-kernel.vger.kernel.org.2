Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5E41B475
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhI1QyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241900AbhI1QyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3094E60F6B;
        Tue, 28 Sep 2021 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632847956;
        bh=DEqROobCKT5p9pSxxcEXxtlrsyu1eUWa3E++ibpuKA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOPi8FtU5wpEgaz7n0q6Sm8ueKsENGnmVdrmTHXbiJVU3DKYC5GEITOkhz2b0ZKZF
         sI/oZB7kVUuP6PxXhTvDdUuFf8J8hB2u90qakJbpboFH///IVBuRigS6/EdOviJa1V
         4nEZoOzlxbyqY2KiQFmALxuPtJVezKyS+2ktQNiP4jHVeEk1XPW74n1TRNhyfztXvL
         MPXRRTZA5LRy//Tp/n/QXLi/Y7qTfEWscJDNbwBKsqTOBoUpO7iNu7x27Xf8U+HyHa
         rZ6kMfP/7a4ZWVmCfZ054Pcjx5bEGrt85FCOR34MZK3RLWRHMU60+jTqv53cRGUh8w
         qpEPTOkHfDYmA==
Received: by pali.im (Postfix)
        id 019BB7E1; Tue, 28 Sep 2021 18:52:33 +0200 (CEST)
Date:   Tue, 28 Sep 2021 18:52:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: marvell: espressobin-ultra: fix
 SPI-NOR config
Message-ID: <20210928165233.iu3lo3nq5hqtegy2@pali>
References: <20210928162704.687513-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928162704.687513-1-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2021 18:27:02 Robert Marko wrote:
> SPI config for the SPI-NOR is incorrect and completely breaking
> reading/writing to the onboard SPI-NOR.
> 
> SPI-NOR is connected in the single(x1) IO mode and not in the quad
> (x4) mode.
> Also, there is no need to override the max frequency from the DTSI
> as the mx25u3235f that is used supports 104Mhz.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Fixes: 3404fe15a60f ("arm64: dts: marvell: add DT for ESPRESSObin-Ultra")

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index c5eb3604dd5b..610ff6f385c7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -71,10 +71,6 @@ &sdhci1 {
>  
>  &spi0 {
>  	flash@0 {
> -		spi-max-frequency = <108000000>;
> -		spi-rx-bus-width = <4>;
> -		spi-tx-bus-width = <4>;
> -
>  		partitions {
>  			compatible = "fixed-partitions";
>  			#address-cells = <1>;
> -- 
> 2.31.1
> 
