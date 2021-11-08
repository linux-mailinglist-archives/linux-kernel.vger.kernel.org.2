Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77A5448209
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhKHOrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbhKHOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:47:43 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE31C061570;
        Mon,  8 Nov 2021 06:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=tsPEec06c/evSYUwBeagvZhXkAdm4gzB53uPqsCl3+c=; b=Gp5DY
        wJrsjnHyxwFXvB/JNmO6eTfO9hvWDp5Mq/Y4fnRmunO8aDtJ5wpUXGh9sBJ843n1rhcDsNv9ZNaq+
        xb/ezo40P2ire7qA+qQWGq7Flryjz+CHUq9dpYabe3QqUZElnVWOG3HGj/mBy9HXBBS+ADJfD7KKI
        0LugtgkjB65eiIWkwNC3ts85uH7m+p+D28nAlGsIVI8FWiFFXBs/9MBXvFf4rNa26ihcfqmN/Tg7T
        dEjwgXH6G58yHOQrEGdZq9o0yGYICvs6L5DzfC/S8Jom35z8lOxVKPV7sUg3SI4WAXZ1gmrSCEln2
        6KxShESwEFuhZb3+mTlrT/sxownow==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mk5tG-0004qs-Rs; Mon, 08 Nov 2021 14:44:54 +0000
Date:   Mon, 8 Nov 2021 14:44:53 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: respect driver's max_speed
Message-ID: <YYk35SnRf/iaxx+C@donbot>
References: <20211105172304.1308458-1-john@metanate.com>
 <e3652630-f479-185f-0afa-9980a4fdf444@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3652630-f479-185f-0afa-9980a4fdf444@synopsys.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 07:56:50AM +0000, Minas Harutyunyan wrote:
> On 11/5/2021 9:23 PM, John Keeping wrote:
> > UDCs should not enumerate faster than the max_speed set by the gadget
> > driver.  Use this to further restrict the speed set in the DWC2
> > parameters so that the device will not connect faster than is supported
> > by the gadget driver.
> > 
> > For configfs-based composite devices this can be set via the max_speed
> > configfs file.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> 
> Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

Actually, this isn't needed following commit 5324bad66f09 ("usb: dwc2:
gadget: implement udc_set_speed()") - I should have tested on something
more recent than 5.10.

There are still some problems in this area for dwc2 platforms that do
not support high-speed, but this patch is not the fix for them.  Please
drop this.


Sorry for the noise,
John


> > ---
> >   drivers/usb/dwc2/gadget.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > index 744539b78f6c..1f39c2f1be8e 100644
> > --- a/drivers/usb/dwc2/gadget.c
> > +++ b/drivers/usb/dwc2/gadget.c
> > @@ -3377,6 +3377,7 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
> >   	u32 val;
> >   	u32 usbcfg;
> >   	u32 dcfg = 0;
> > +	u8 speed;
> >   	int ep;
> >   
> >   	/* Kill any ep0 requests as controller will be reinitialized */
> > @@ -3418,7 +3419,22 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
> >   
> >   	dcfg |= DCFG_EPMISCNT(1);
> >   
> > -	switch (hsotg->params.speed) {
> > +	speed = hsotg->params.speed;
> > +	if (hsotg->driver) {
> > +		switch (hsotg->driver->max_speed) {
> > +		case USB_SPEED_LOW:
> > +			speed = DWC2_SPEED_PARAM_LOW;
> > +			break;
> > +		case USB_SPEED_FULL:
> > +			if (speed != USB_SPEED_LOW)
> > +				speed = DWC2_SPEED_PARAM_FULL;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	switch (speed) {
> >   	case DWC2_SPEED_PARAM_LOW:
> >   		dcfg |= DCFG_DEVSPD_LS;
> >   		break;
> > 
> 
