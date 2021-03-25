Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7A349599
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhCYPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:33:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:40679 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhCYPdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:33:22 -0400
IronPort-SDR: PieRAsMXPgg6QGNOK/91OdFxOWMKr6PDlO0CfJbDnx8yjAePH1OKZ+bg8KrRStSjzqLHzk7dxN
 mRwjHHirVmuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211088220"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="211088220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:33:22 -0700
IronPort-SDR: 54Ba1dtwnmKdN/mMr3Vx1g/BYfG6rbdVuoJ7VEyO8+zykORvZXm6eKdYWmivDIcfE9NH7u1bj5
 MtkVPnlkPX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="514681763"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Mar 2021 08:33:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Mar 2021 17:33:18 +0200
Date:   Thu, 25 Mar 2021 17:33:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: Iterator for ports
Message-ID: <YFytPtzRg1Wmhmfl@kuha.fi.intel.com>
References: <20210325122926.58392-1-heikki.krogerus@linux.intel.com>
 <20210325122926.58392-2-heikki.krogerus@linux.intel.com>
 <20210325144109.GB785961@rowland.harvard.edu>
 <YFyo4vM91xdtzacE@kuha.fi.intel.com>
 <YFyqL9NCI86ehCcN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFyqL9NCI86ehCcN@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 04:20:15PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 25, 2021 at 05:14:42PM +0200, Heikki Krogerus wrote:
> > On Thu, Mar 25, 2021 at 10:41:09AM -0400, Alan Stern wrote:
> > > On Thu, Mar 25, 2021 at 03:29:21PM +0300, Heikki Krogerus wrote:
> > > > Introducing usb_for_each_port(). It works the same way as
> > > > usb_for_each_dev(), but instead of going through every USB
> > > > device in the system, it walks through the USB ports in the
> > > > system.
> > > > 
> > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > This has a couple of nasty errors.
> > > 
> > > > ---
> > > >  drivers/usb/core/usb.c | 43 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/usb.h    |  1 +
> > > >  2 files changed, 44 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > > > index 2ce3667ec6fae..6d49db9a1b208 100644
> > > > --- a/drivers/usb/core/usb.c
> > > > +++ b/drivers/usb/core/usb.c
> > > > @@ -398,6 +398,49 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(usb_for_each_dev);
> > > >  
> > > > +struct each_hub_arg {
> > > > +	void *data;
> > > > +	int (*fn)(struct device *, void *);
> > > > +};
> > > > +
> > > > +static int __each_hub(struct device *dev, void *data)
> > > > +{
> > > > +	struct each_hub_arg *arg = (struct each_hub_arg *)data;
> > > > +	struct usb_device *hdev = to_usb_device(dev);
> > > 
> > > to_usb_device() won't work properly if the struct device isn't embedded 
> > > in an actual usb_device structure.  And that will happen, since the USB 
> > > bus type holds usb_interface structures as well as usb_devices.
> > 
> > OK, so I need to filter them out.
> > 
> > > In fact, you should use usb_for_each_dev here; it already does what you 
> > > want.
> > 
> > Unfortunately I can't use usb_for_each_dev here, because it deals with
> > struct usb_device while I need to deal with struct device in the
> > callback.
> 
> Why do you need 'struct device' in the callback?  All you really want is
> the hub devices, right?

I need the ports, not the hubs.

> > > > +	struct usb_hub *hub;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	hub = usb_hub_to_struct_hub(hdev);
> > > > +	if (!hub)
> > > > +		return 0;
> > > > +
> > > > +	for (i = 0; i < hdev->maxchild; i++) {
> > > > +		ret = arg->fn(&hub->ports[i]->dev, arg->data);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > Don't you need some sort of locking or refcounting here?  What would 
> > > happen if this hub got removed while the routine was running?
> > 
> > I'll use a lock then.
> 
> That's not going to work to be held over a callback.  Just properly
> increment the reference count.

I though we have done that already. Does bus_for_each_dev() do that
for the device that it passes to the callback until that callback
returns?

thanks,

-- 
heikki
