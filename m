Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA24222F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhJEKAt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Oct 2021 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJEKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:00:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AFC06161C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:58:56 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhDq-0007cQ-Tk; Tue, 05 Oct 2021 11:58:54 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhDq-0004n4-8u; Tue, 05 Oct 2021 11:58:54 +0200
Message-ID: <2c2f76c93e963c19c22976548bef8380975b2730.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Allow building Broadcom STB RESCAL as module
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@Broadcom.com,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 05 Oct 2021 11:58:54 +0200
In-Reply-To: <20210924030840.9650-1-f.fainelli@gmail.com>
References: <20210924030840.9650-1-f.fainelli@gmail.com>
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

On Thu, 2021-09-23 at 20:08 -0700, Florian Fainelli wrote:
> The driver can be built as a module and uses device managed resources.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index be799a5abf8a..f9d8b364db5f 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -58,7 +58,7 @@ config RESET_BRCMSTB
>  	  a SUN_TOP_CTRL_SW_INIT style controller.
>  
>  config RESET_BRCMSTB_RESCAL
> -	bool "Broadcom STB RESCAL reset controller"
> +	tristate "Broadcom STB RESCAL reset controller"
>  	depends on HAS_IOMEM
>  	depends on ARCH_BRCMSTB || COMPILE_TEST
>  	default ARCH_BRCMSTB

Thank you, applied to reset/next.

regards
Philipp
