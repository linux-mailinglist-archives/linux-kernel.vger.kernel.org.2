Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD64D34945D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCYOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:41:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36153 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231270AbhCYOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:41:10 -0400
Received: (qmail 788698 invoked by uid 1000); 25 Mar 2021 10:41:09 -0400
Date:   Thu, 25 Mar 2021 10:41:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: Iterator for ports
Message-ID: <20210325144109.GB785961@rowland.harvard.edu>
References: <20210325122926.58392-1-heikki.krogerus@linux.intel.com>
 <20210325122926.58392-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325122926.58392-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:29:21PM +0300, Heikki Krogerus wrote:
> Introducing usb_for_each_port(). It works the same way as
> usb_for_each_dev(), but instead of going through every USB
> device in the system, it walks through the USB ports in the
> system.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This has a couple of nasty errors.

> ---
>  drivers/usb/core/usb.c | 43 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb.h    |  1 +
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2ce3667ec6fae..6d49db9a1b208 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -398,6 +398,49 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
>  }
>  EXPORT_SYMBOL_GPL(usb_for_each_dev);
>  
> +struct each_hub_arg {
> +	void *data;
> +	int (*fn)(struct device *, void *);
> +};
> +
> +static int __each_hub(struct device *dev, void *data)
> +{
> +	struct each_hub_arg *arg = (struct each_hub_arg *)data;
> +	struct usb_device *hdev = to_usb_device(dev);

to_usb_device() won't work properly if the struct device isn't embedded 
in an actual usb_device structure.  And that will happen, since the USB 
bus type holds usb_interface structures as well as usb_devices.

In fact, you should use usb_for_each_dev here; it already does what you 
want.

> +	struct usb_hub *hub;
> +	int ret;
> +	int i;
> +
> +	hub = usb_hub_to_struct_hub(hdev);
> +	if (!hub)
> +		return 0;
> +
> +	for (i = 0; i < hdev->maxchild; i++) {
> +		ret = arg->fn(&hub->ports[i]->dev, arg->data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Don't you need some sort of locking or refcounting here?  What would 
happen if this hub got removed while the routine was running?

Alan Stern
