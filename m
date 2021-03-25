Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B6349552
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhCYPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:23:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:14725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhCYPXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:23:34 -0400
IronPort-SDR: nLuTA4Q48M5v4Wrw+diwdw0P0j5K9vjQSp7O0HBSThBl7AN53mMviyjEt9ja9zSk+qUXsppVn4
 8tcuWuDR5z1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="190982625"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="190982625"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:23:32 -0700
IronPort-SDR: 1KKFaS7stE79Gw49FzsF2skSROJMQmjDMd8dYTej+kYEI4s9FEVrMQS58C+B7pgJffiv3ZrGo/
 EOCVjJwVT8yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="514678197"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Mar 2021 08:23:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Mar 2021 17:23:28 +0200
Date:   Thu, 25 Mar 2021 17:23:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: Iterator for ports
Message-ID: <YFyq8KK1J3IudCGv@kuha.fi.intel.com>
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

On Thu, Mar 25, 2021 at 05:14:45PM +0200, Heikki Krogerus wrote:
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

Ah, I can use it instead of bus_for_each_dev() in usb_for_each_port().
I'll fix these in v2.

For the lock I guess I can just use the peer lock (usb_port_peer_mutex)?

thanks,

-- 
heikki
