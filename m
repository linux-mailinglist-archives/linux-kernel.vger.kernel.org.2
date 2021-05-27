Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ECF392445
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 03:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhE0BYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 21:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhE0BYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 21:24:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A2A161360;
        Thu, 27 May 2021 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622078598;
        bh=bmskH63qX10L9v1hjB1V+AdpwXXXrtuHRvniDeUQKAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgxqJY8/kYMROrZBkujR5cpLP3HL0L+Pzz+fyfG3WsNXMetBze8ss02msQIquENmO
         +cdghd/hNvFJJoy3IfAwDG9WM2GJN2U48CvE30Sc4Qh/aZhRcCc+Sk5rTabvsPal7v
         Wishn3ZZEPsOhohgAOtyIOysteWDPOVPnttdWejQ9D5Z0rfNMOZZ4Klft2ckM2/MQ7
         cF0dLjDfye5CP/zjwQOfRf/4FW9kCd21hhQtLamGIL2U7t2r9Chb7Y63NxF0AJ4gXl
         Qxq451D2JZtU8PHCE70uCKmAhbkpSAUTP0oJhxTfs75yaL9EbJAmh4/CW5thv+1/KS
         9aQ7T+pksGUJA==
Date:   Thu, 27 May 2021 09:23:13 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Sanket Parmar <sparmar@cadence.com>, pawell@cadence.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com, gregkh@linuxfoundation.org, kishon@ti.com
Subject: Re: [PATCH] usb: cdns3: Enable TDL_CHK only for OUT ep
Message-ID: <20210527012313.GA20398@nchen>
References: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
 <e4c41fa3-6739-ab4f-51bf-74ede67749bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c41fa3-6739-ab4f-51bf-74ede67749bb@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-26 20:30:37, Aswath Govindraju wrote:
> Hi Peter,
> 
> On 17/05/21 8:35 pm, Sanket Parmar wrote:
> > ZLP gets stuck if TDL_CHK bit is set and TDL_FROM_TRB is used
> > as TDL source for IN endpoints. To fix it, TDL_CHK is only
> > enabled for OUT endpoints.
> > 
> > Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> > Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> > ---
> 
> May I know if this patch will be picked up as a bug fix for -rc.

Yes, it has already at my fixes tree, to make sure no one report issues,
I will send to Greg after several days later.

Peter
> 
> Thanks,
> Aswath
> 
> >  drivers/usb/cdns3/cdns3-gadget.c |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> > index 105855a..f3c0276 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -2007,7 +2007,7 @@ static void cdns3_configure_dmult(struct cdns3_device *priv_dev,
> >  		else
> >  			mask = BIT(priv_ep->num);
> >  
> > -		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
> > +		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
> >  			cdns3_set_register_bit(&regs->tdl_from_trb, mask);
> >  			cdns3_set_register_bit(&regs->tdl_beh, mask);
> >  			cdns3_set_register_bit(&regs->tdl_beh2, mask);
> > @@ -2046,15 +2046,13 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
> >  	case USB_ENDPOINT_XFER_INT:
> >  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
> >  
> > -		if ((priv_dev->dev_ver == DEV_VER_V2 && !priv_ep->dir) ||
> > -		    priv_dev->dev_ver > DEV_VER_V2)
> > +		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
> >  			ep_cfg |= EP_CFG_TDL_CHK;
> >  		break;
> >  	case USB_ENDPOINT_XFER_BULK:
> >  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
> >  
> > -		if ((priv_dev->dev_ver == DEV_VER_V2  && !priv_ep->dir) ||
> > -		    priv_dev->dev_ver > DEV_VER_V2)
> > +		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
> >  			ep_cfg |= EP_CFG_TDL_CHK;
> >  		break;
> >  	default:
> > 
> 

-- 

Thanks,
Peter Chen

