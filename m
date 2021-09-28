Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D341B30F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhI1PjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241371AbhI1PjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09854611EF;
        Tue, 28 Sep 2021 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843454;
        bh=eohuFr/IeIJvfs6UQivrQ9AQUwsZ25wJN069iFwQHDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPSENyU+48ZiSCy1Jc7YzXakqX6SW7kdIfv3Lh0lq10vSlw8m1KOjF85N+eQ0ga20
         zfQZAidOeahlB003pae+JrFR5hM9Xf0lBQSPxjTxQyRuBCu5t/OByeRPMnZfR4dhgh
         U7dYNinbV+TKetYK+nBArllXEZIC3fE155Mmlu41HoTMZWOZ9tBEZCh33diQR5zmD6
         iYWUMAyFdjasxexVLSNQ8dudDaYOsQ9z9ExOzsrBVZd1ZkCzqGuL2JdY+4M/NTh1GH
         kse2VG60+PUlJ5BHwngVcD+RdfUvvR8s9vF8jn8bnANipCD+McRaI4t4Y9rCOcffPh
         54B8fpseYBTxA==
Received: by pali.im (Postfix)
        id 8953A7E1; Tue, 28 Sep 2021 17:37:31 +0200 (CEST)
Date:   Tue, 28 Sep 2021 17:37:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: marvell: espressobin-ultra: enable front
 USB3 port
Message-ID: <20210928153731.7we6p7mclil2e5j2@pali>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
 <20210927154159.2168500-4-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927154159.2168500-4-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2021 17:41:59 Robert Marko wrote:
> Espressobin Ultra has a front panel USB3.0 Type-A port which works
> just fine so enable it.
> I dont see a reason why it was disabled in the first place anyway.

If USB 3.0 port is was tested and is working fine, then what about
adding Fixes: tag into commit message?

> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index 96855a10b4a0..aada43fa236c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -112,7 +112,6 @@ rtc@51 {
>  
>  &usb3 {
>  	usb-phy = <&usb3_phy>;
> -	status = "disabled";
>  };
>  
>  &mdio {
> -- 
> 2.31.1
> 
