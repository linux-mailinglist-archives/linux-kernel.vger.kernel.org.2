Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D24222CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhJEJ4l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Oct 2021 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhJEJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:56:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F33C06161C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:54:50 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXh9s-00070C-Pi; Tue, 05 Oct 2021 11:54:48 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXh9s-0004ZU-12; Tue, 05 Oct 2021 11:54:48 +0200
Message-ID: <6684a4f191c3252dfc66c93e84717a26634a0dcf.camel@pengutronix.de>
Subject: Re: [PATCH] reset: brcmstb-rescal: fix incorrect polarity of status
 bit
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 05 Oct 2021 11:54:47 +0200
In-Reply-To: <20210914221122.62315-1-f.fainelli@gmail.com>
References: <20210914221122.62315-1-f.fainelli@gmail.com>
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

On Tue, 2021-09-14 at 15:11 -0700, Florian Fainelli wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
> 
> The readl_poll_timeout() should complete when the status bit
> is a 1, not 0.
> 
> Fixes: 4cf176e52397 ("reset: Add Broadcom STB RESCAL reset controller")
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/reset-brcmstb-rescal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
> index b6f074d6a65f..433fa0c40e47 100644
> --- a/drivers/reset/reset-brcmstb-rescal.c
> +++ b/drivers/reset/reset-brcmstb-rescal.c
> @@ -38,7 +38,7 @@ static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
>  	}
>  
>  	ret = readl_poll_timeout(base + BRCM_RESCAL_STATUS, reg,
> -				 !(reg & BRCM_RESCAL_STATUS_BIT), 100, 1000);
> +				 (reg & BRCM_RESCAL_STATUS_BIT), 100, 1000);
>  	if (ret) {
>  		dev_err(data->dev, "time out on SATA/PCIe rescal\n");
>  		return ret;

Thank you, applied to reset/fixes.

regards
Philipp
