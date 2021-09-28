Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7741B2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbhI1PPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241392AbhI1PPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:15:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B419F6101E;
        Tue, 28 Sep 2021 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842030;
        bh=9W+NZwnA2OzBhJ20rRTXExWsHLn9LLXH115/Fe1t9Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhL/Wcl1jpPJL0ypEjPfiT1QuOuJ4DHSaRxkv7efNrx9SaTBhDrZWl78bIu8TRimp
         +xsqHNqqXmqacW1EXEzqUbCfzGd/3jttHGQzrWccQhO1ROdhnSd2zL5o0tVUR//h2E
         r0/69TRzltdOWYQt00aEKqZPJx4igAHPxxyXp7VQsp7veX9zpM413Etr8iQgUh55fp
         WuYPXjzrgwQKW/dnjIMQBXHVPb5CHQt0PtmOVR1GnA4BnjYDpf8KqnKvblOxJA6dQh
         CLle/vwyDnOk7kOE0G/hYdLJfxoeug7zPvP9cs3uoeWRMoMK+42xE6hyca8su5Osfr
         bYsBEAJM5aW+w==
Received: by pali.im (Postfix)
        id 620EB7E1; Tue, 28 Sep 2021 17:13:48 +0200 (CEST)
Date:   Tue, 28 Sep 2021 17:13:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: marvell: espressobin-ultra: enable UART
 output by default
Message-ID: <20210928151348.cqgy6uuxs3owxaug@pali>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927154159.2168500-1-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2021 17:41:56 Robert Marko wrote:
> Since Espressobin Ultra board has a microUSB port
> with the onboard USB to UART connected to it to be
> used as a debug UART it makes no sense to require
> the bootloader to pass console args to the kernel in
> order to get console working.
> 
> So, use the "stdout-path" property to enable the UART
> output on the microUSB port by default.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index c5eb3604dd5b..c1770ceff3c1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -15,6 +15,10 @@ / {
>  	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
>  		     "marvell,armada3710";
>  
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +

This code is duplication of common espressobin code from
armada-3720-espressobin.dtsi file:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi

>  	aliases {
>  		/* ethernet1 is WAN port */
>  		ethernet1 = &switch0port5;
> -- 
> 2.31.1
> 
