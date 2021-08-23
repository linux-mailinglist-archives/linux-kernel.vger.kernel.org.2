Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4173F4913
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhHWKzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 06:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhHWKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:55:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:54:29 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mI7b1-0002dJ-6J; Mon, 23 Aug 2021 12:54:27 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mI7b0-00059p-K7; Mon, 23 Aug 2021 12:54:26 +0200
Message-ID: <cad2bedf9abd93b68a3a0e97aa5e12b05a6c28fb.camel@pengutronix.de>
Subject: Re: [PATCH] reset: simple: remove ZTE details in Kconfig help
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Peter Robinson <pbrobinson@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Date:   Mon, 23 Aug 2021 12:54:26 +0200
In-Reply-To: <20210821094528.294579-1-pbrobinson@gmail.com>
References: <20210821094528.294579-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, 2021-08-21 at 10:45 +0100, Peter Robinson wrote:
> The ZTE platform support in the simple reset driver has been
> removed but the comment in the help wasn't removed so clean
> this up too.
> 
> Fixes: 89d4f98ae90d ("ARM: remove zte zx platform")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/reset/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 328f70f633eb..ba50729a3371 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -207,7 +207,6 @@ config RESET_SIMPLE
>  	   - Realtek SoCs
>  	   - RCC reset controller in STM32 MCUs
>  	   - Allwinner SoCs
> -	   - ZTE's zx2967 family
>  	   - SiFive FU740 SoCs
>  
>  config RESET_SOCFPGA

Thank you, applied to reset/next.

regards
Philipp
