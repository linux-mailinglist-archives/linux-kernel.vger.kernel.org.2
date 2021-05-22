Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1961238D505
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhEVKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhEVKKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:10:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B95D61182;
        Sat, 22 May 2021 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621678158;
        bh=aFrt6ABG40tFAQSuyTdLlrinFx0PuyvgSdE1Yz010s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnMMGM9QgIf3/R3O3DhQeb36yjQi1k6zihs0111Ykftu0V6SQQiIkR3DOA8G9NMnB
         NuJwc8mlRpa3x+jkzDXk6TGS7dOQvvjtgV5Y1nIuWjqtCW+rV7rZcDWaQ1uzF6Naro
         vK2HOkTczyuY6qpbajDXrrHkxSJug3XuUC0VJibNLWyZqpcZiTRWheppW789qJKnrq
         O/aRh+k+Qqw3i9nvwKPCBtUMgyP2+5RbnPySebBXxf5z4rDonqkO0ZgMs0RSI1kagh
         flrGALVjUTBMyP+tSag8J7QSAdGaEc7jfy8J7GIBm1rTuAQBDiuGUxa6/igGcBbOwZ
         Emr5dPM06rlJw==
Date:   Sat, 22 May 2021 18:09:13 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Sanket Parmar <sparmar@cadence.com>, pawell@cadence.com
Cc:     a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        gregkh@linuxfoundation.org, kishon@ti.com
Subject: Re: [PATCH] usb: cdns3: Enable TDL_CHK only for OUT ep
Message-ID: <20210522100913.GB12415@b29397-desktop>
References: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-17 17:05:12, Sanket Parmar wrote:
> ZLP gets stuck if TDL_CHK bit is set and TDL_FROM_TRB is used
> as TDL source for IN endpoints. To fix it, TDL_CHK is only
> enabled for OUT endpoints.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 105855a..f3c0276 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2007,7 +2007,7 @@ static void cdns3_configure_dmult(struct cdns3_device *priv_dev,
>  		else
>  			mask = BIT(priv_ep->num);
>  
> -		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
> +		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
>  			cdns3_set_register_bit(&regs->tdl_from_trb, mask);
>  			cdns3_set_register_bit(&regs->tdl_beh, mask);
>  			cdns3_set_register_bit(&regs->tdl_beh2, mask);
> @@ -2046,15 +2046,13 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  	case USB_ENDPOINT_XFER_INT:
>  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
>  
> -		if ((priv_dev->dev_ver == DEV_VER_V2 && !priv_ep->dir) ||
> -		    priv_dev->dev_ver > DEV_VER_V2)
> +		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
>  			ep_cfg |= EP_CFG_TDL_CHK;
>  		break;
>  	case USB_ENDPOINT_XFER_BULK:
>  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
>  
> -		if ((priv_dev->dev_ver == DEV_VER_V2  && !priv_ep->dir) ||
> -		    priv_dev->dev_ver > DEV_VER_V2)
> +		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
>  			ep_cfg |= EP_CFG_TDL_CHK;
>  		break;
>  	default:
> -- 

Sanket & Pawel, please confirm this behaviour could apply for DEV_VER_V3,
that is TDL_CHK can't be used for bulk in for DEV_VER_V3?

-- 

Thanks,
Peter Chen

