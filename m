Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0817C3AE5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFUJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhFUJYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:24:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23FE261002;
        Mon, 21 Jun 2021 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624267359;
        bh=7nH7mh7nw4aBeDVanu7wJ25k1fGBowCozGKRrUJTO9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klRlPDCar6MsklKGuq5Jeog4PvJP80d0xihaELpclU7T+Kd2CM3WjPPEUNOkcJ7ks
         ShLQYFBp61AMiiDVS+ZuROCig05qjflnH7vEy40VIvXRSusEi8bHrlOJBVFF3ix+Fq
         19vG+QuUnzSQBFJCJMNV66ZaeNh55VTzV8t3Edz8=
Date:   Mon, 21 Jun 2021 11:22:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Segiy Stetsyuk <serg_stetsuk@ukr.net>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: fix endianness issue with descriptors
Message-ID: <YNBaXLAOq+/UO9sN@kroah.com>
References: <20210617162755.29676-1-ruslan.bilovol@gmail.com>
 <YMt95iarFDUDvjQ8@kroah.com>
 <20210617234421.GA295854@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617234421.GA295854@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:44:21PM -0400, Alan Stern wrote:
> On Thu, Jun 17, 2021 at 06:52:54PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 17, 2021 at 07:27:55PM +0300, Ruslan Bilovol wrote:
> > > Running sparse checker it shows warning message about
> > > incorrect endianness used for descriptor initialization:
> > > 
> > > | f_hid.c:91:43: warning: incorrect type in initializer (different base types)
> > > | f_hid.c:91:43:    expected restricted __le16 [usertype] bcdHID
> > > | f_hid.c:91:43:    got int
> > > 
> > > Fixing issue with cpu_to_le16() macro
> > > 
> > > Fixes: 71adf1189469 ("USB: gadget: add HID gadget driver")
> > > Cc: Fabien Chouteau <fabien.chouteau@barco.com>
> > > Cc: Segiy Stetsyuk <serg_stetsuk@ukr.net>
> > > Cc: stable@kernel.org
> > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> > > ---
> > >  drivers/usb/gadget/function/f_hid.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> > > index 70774d8cb14e..02683ac0719d 100644
> > > --- a/drivers/usb/gadget/function/f_hid.c
> > > +++ b/drivers/usb/gadget/function/f_hid.c
> > > @@ -88,7 +88,7 @@ static struct usb_interface_descriptor hidg_interface_desc = {
> > >  static struct hid_descriptor hidg_desc = {
> > >  	.bLength			= sizeof hidg_desc,
> > >  	.bDescriptorType		= HID_DT_HID,
> > > -	.bcdHID				= 0x0101,
> > > +	.bcdHID				= cpu_to_le16(0x0101),
> > 
> > This is a BCD value, not a little-endian value, are you sure this
> > conversion is correct?
> 
> It's a BCD value, but the storage format is little endian.  So yes, the 
> conversion is correct.
> 
> But even more, the conversion is correct because 0x0101 yields exactly 
> the same sequence of bytes in little-endian and big-endian orders!  
> Either way, it is two bytes each containing 0x01.

Ah, which is why no one has noticed this yet :)

I'll go apply this just to be "correct".

thanks,

greg k-h
