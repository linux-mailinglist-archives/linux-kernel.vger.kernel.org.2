Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B29B349541
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCYPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhCYPUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECEE961A17;
        Thu, 25 Mar 2021 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616685618;
        bh=I2CXsEYjwlZ/FRznJeRrrqBihn6wC60KAXqXZjW+CQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9SEECshckRBCqciAvQONmiPmwDYmNxtp1Gx/v7MKR2NlYeQmLGE4Ha8AIsZS59v6
         CR+4onPzDuEzXW3TfNRUM9Q+rglnZXfOrZy/LF7LJGJZg140129c7UCmvYBbrjJidP
         EFDtC+QjZAaUwL7wNLMvlXubqND6QBTxJknDyf3I=
Date:   Thu, 25 Mar 2021 16:20:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: Iterator for ports
Message-ID: <YFyqL9NCI86ehCcN@kroah.com>
References: <20210325122926.58392-1-heikki.krogerus@linux.intel.com>
 <20210325122926.58392-2-heikki.krogerus@linux.intel.com>
 <20210325144109.GB785961@rowland.harvard.edu>
 <YFyo4vM91xdtzacE@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyo4vM91xdtzacE@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:14:42PM +0200, Heikki Krogerus wrote:
> On Thu, Mar 25, 2021 at 10:41:09AM -0400, Alan Stern wrote:
> > On Thu, Mar 25, 2021 at 03:29:21PM +0300, Heikki Krogerus wrote:
> > > Introducing usb_for_each_port(). It works the same way as
> > > usb_for_each_dev(), but instead of going through every USB
> > > device in the system, it walks through the USB ports in the
> > > system.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > This has a couple of nasty errors.
> > 
> > > ---
> > >  drivers/usb/core/usb.c | 43 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/usb.h    |  1 +
> > >  2 files changed, 44 insertions(+)
> > > 
> > > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > > index 2ce3667ec6fae..6d49db9a1b208 100644
> > > --- a/drivers/usb/core/usb.c
> > > +++ b/drivers/usb/core/usb.c
> > > @@ -398,6 +398,49 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_for_each_dev);
> > >  
> > > +struct each_hub_arg {
> > > +	void *data;
> > > +	int (*fn)(struct device *, void *);
> > > +};
> > > +
> > > +static int __each_hub(struct device *dev, void *data)
> > > +{
> > > +	struct each_hub_arg *arg = (struct each_hub_arg *)data;
> > > +	struct usb_device *hdev = to_usb_device(dev);
> > 
> > to_usb_device() won't work properly if the struct device isn't embedded 
> > in an actual usb_device structure.  And that will happen, since the USB 
> > bus type holds usb_interface structures as well as usb_devices.
> 
> OK, so I need to filter them out.
> 
> > In fact, you should use usb_for_each_dev here; it already does what you 
> > want.
> 
> Unfortunately I can't use usb_for_each_dev here, because it deals with
> struct usb_device while I need to deal with struct device in the
> callback.

Why do you need 'struct device' in the callback?  All you really want is
the hub devices, right?

> > > +	struct usb_hub *hub;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	hub = usb_hub_to_struct_hub(hdev);
> > > +	if (!hub)
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < hdev->maxchild; i++) {
> > > +		ret = arg->fn(&hub->ports[i]->dev, arg->data);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > Don't you need some sort of locking or refcounting here?  What would 
> > happen if this hub got removed while the routine was running?
> 
> I'll use a lock then.

That's not going to work to be held over a callback.  Just properly
increment the reference count.

thanks,

greg k-h
