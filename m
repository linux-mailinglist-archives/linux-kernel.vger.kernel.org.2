Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04733CAF61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhGOWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:48:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53738 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGOWsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:48:05 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A6Q-0005wd-VX; Fri, 16 Jul 2021 00:45:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH resend] soc: rockchip: ROCKCHIP_GRF should not default to y, unconditionally
Date:   Fri, 16 Jul 2021 00:45:10 +0200
Message-ID: <6289896.mzcYPaeBD7@diego>
In-Reply-To: <596ed544412bb45581e9fe42cc519ec5a29ce13b.1626256348.git.geert+renesas@glider.be>
References: <596ed544412bb45581e9fe42cc519ec5a29ce13b.1626256348.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Am Mittwoch, 14. Juli 2021, 11:53:15 CEST schrieb Geert Uytterhoeven:
> Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
> To fix this, restrict the automatic enabling of ROCKCHIP_GRF to
> ARCH_ROCKCHIP, and ask the user in case of compile-testing.
> 
> Fixes: 4c58063d4258f6be ("soc: rockchip: add driver handling grf setup")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I had the original patch picked already, just not pushed yet.
So hopefully nothing changed between the sends.


Heiko

> ---
>  drivers/soc/rockchip/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 2c13bf4dd5dbee76..25eb2c1e31bb2a08 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -6,8 +6,8 @@ if ARCH_ROCKCHIP || COMPILE_TEST
>  #
>  
>  config ROCKCHIP_GRF
> -	bool
> -	default y
> +	bool "Rockchip General Register Files support" if COMPILE_TEST
> +	default y if ARCH_ROCKCHIP
>  	help
>  	  The General Register Files are a central component providing
>  	  special additional settings registers for a lot of soc-components.
> 




