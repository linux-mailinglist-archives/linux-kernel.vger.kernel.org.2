Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5133ABFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 01:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhFQXqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 19:46:31 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45077 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230447AbhFQXqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:46:30 -0400
Received: (qmail 296032 invoked by uid 1000); 17 Jun 2021 19:44:21 -0400
Date:   Thu, 17 Jun 2021 19:44:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Segiy Stetsyuk <serg_stetsuk@ukr.net>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: fix endianness issue with descriptors
Message-ID: <20210617234421.GA295854@rowland.harvard.edu>
References: <20210617162755.29676-1-ruslan.bilovol@gmail.com>
 <YMt95iarFDUDvjQ8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMt95iarFDUDvjQ8@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:52:54PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 17, 2021 at 07:27:55PM +0300, Ruslan Bilovol wrote:
> > Running sparse checker it shows warning message about
> > incorrect endianness used for descriptor initialization:
> > 
> > | f_hid.c:91:43: warning: incorrect type in initializer (different base types)
> > | f_hid.c:91:43:    expected restricted __le16 [usertype] bcdHID
> > | f_hid.c:91:43:    got int
> > 
> > Fixing issue with cpu_to_le16() macro
> > 
> > Fixes: 71adf1189469 ("USB: gadget: add HID gadget driver")
> > Cc: Fabien Chouteau <fabien.chouteau@barco.com>
> > Cc: Segiy Stetsyuk <serg_stetsuk@ukr.net>
> > Cc: stable@kernel.org
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> > ---
> >  drivers/usb/gadget/function/f_hid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> > index 70774d8cb14e..02683ac0719d 100644
> > --- a/drivers/usb/gadget/function/f_hid.c
> > +++ b/drivers/usb/gadget/function/f_hid.c
> > @@ -88,7 +88,7 @@ static struct usb_interface_descriptor hidg_interface_desc = {
> >  static struct hid_descriptor hidg_desc = {
> >  	.bLength			= sizeof hidg_desc,
> >  	.bDescriptorType		= HID_DT_HID,
> > -	.bcdHID				= 0x0101,
> > +	.bcdHID				= cpu_to_le16(0x0101),
> 
> This is a BCD value, not a little-endian value, are you sure this
> conversion is correct?

It's a BCD value, but the storage format is little endian.  So yes, the 
conversion is correct.

But even more, the conversion is correct because 0x0101 yields exactly 
the same sequence of bytes in little-endian and big-endian orders!  
Either way, it is two bytes each containing 0x01.

Alan Stern
