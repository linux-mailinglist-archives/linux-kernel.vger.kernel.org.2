Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596DC34E406
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhC3JHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:07:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:20670 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhC3JHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:07:39 -0400
IronPort-SDR: 9sp2oeizy7PepEhxo6Juqo8GPlLVd6ht/nHNAEwOwD/FIja3xBEXLEIEjZjnQl9gQTnRCj2DAc
 frLps7u6FSuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="188460374"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="188460374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 02:07:38 -0700
IronPort-SDR: ib6G/Hb2XuCfEYn7nbnGgRtKMarSnykGETsH96NU6JvA5eq9UZ6aTK7o5ZtrX5aX1cel3ADC1N
 FSl+iar7UiUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="516360032"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Mar 2021 02:07:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Mar 2021 12:07:35 +0300
Date:   Tue, 30 Mar 2021 12:07:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] usb: Iterator for ports
Message-ID: <YGLqV4nB/lPS1AOF@kuha.fi.intel.com>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
 <20210329084426.78138-6-heikki.krogerus@linux.intel.com>
 <20210329184946.GA944482@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329184946.GA944482@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 02:49:46PM -0400, Alan Stern wrote:
> On Mon, Mar 29, 2021 at 11:44:25AM +0300, Heikki Krogerus wrote:
> > Introducing usb_for_each_port(). It works the same way as
> > usb_for_each_dev(), but instead of going through every USB
> > device in the system, it walks through the USB ports in the
> > system.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/core/usb.c | 46 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/usb.h    |  1 +
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> > index 2ce3667ec6fae..62368c4ed37af 100644
> > --- a/drivers/usb/core/usb.c
> > +++ b/drivers/usb/core/usb.c
> > @@ -398,6 +398,52 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
> >  }
> >  EXPORT_SYMBOL_GPL(usb_for_each_dev);
> >  
> > +struct each_hub_arg {
> > +	void *data;
> > +	int (*fn)(struct device *, void *);
> > +};
> > +
> > +static int __each_hub(struct usb_device *hdev, void *data)
> > +{
> > +	struct each_hub_arg *arg = (struct each_hub_arg *)data;
> > +	struct usb_hub *hub;
> > +	int ret = 0;
> > +	int i;
> > +
> > +	hub = usb_hub_to_struct_hub(hdev);
> > +	if (!hub)
> > +		return 0;
> 
> What happens if the hub is removed exactly now?  Although hdev is 
> reference-counted (and the loop iterator does take a reference to it), 
> usb_hub_to_struct_hub doesn't take a reference to hub.  And hub->ports 
> isn't refcounted at all.

If the hub is removed right now, and if hub_disconnect() also manages
to remove the ports before we have time to take the lock below, then
hdev->maxchild will be 0 by the time we can take the lock. In that
case nothing happens here.

If on the other hand we manage to acquire the usb_port_peer_mutex
before hub_disconnect(), then hub_disconnect() will simply have to
wait until we are done, and only after that remove the ports.

> > +	mutex_lock(&usb_port_peer_mutex);
> > +
> > +	for (i = 0; i < hdev->maxchild; i++) {
> > +		ret = arg->fn(&hub->ports[i]->dev, arg->data);
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +	mutex_unlock(&usb_port_peer_mutex);
> 
> I have a feeling that it would be better to take and release this mutex 
> in usb_for_each_port (or its caller), so that it is held over the whole 
> loop.

I disagree. The lock is for the ports, not the hubs. We should take
the lock when we are going through the ports of a hub, but release it
between the hubs. Otherwise we will be only keeping things on hold for
a long period of time for no good reason (I for example have to
evaluate the _PLD of every single port which takes a lot of time). We
don't need to prevent other things from happening to the hubs at the
same time.


thanks,

-- 
heikki
