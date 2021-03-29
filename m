Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0E34D796
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhC2SuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:50:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35611 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230224AbhC2Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:49:47 -0400
Received: (qmail 945935 invoked by uid 1000); 29 Mar 2021 14:49:46 -0400
Date:   Mon, 29 Mar 2021 14:49:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] usb: Iterator for ports
Message-ID: <20210329184946.GA944482@rowland.harvard.edu>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
 <20210329084426.78138-6-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329084426.78138-6-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:44:25AM +0300, Heikki Krogerus wrote:
> Introducing usb_for_each_port(). It works the same way as
> usb_for_each_dev(), but instead of going through every USB
> device in the system, it walks through the USB ports in the
> system.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/core/usb.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb.h    |  1 +
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2ce3667ec6fae..62368c4ed37af 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -398,6 +398,52 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
>  }
>  EXPORT_SYMBOL_GPL(usb_for_each_dev);
>  
> +struct each_hub_arg {
> +	void *data;
> +	int (*fn)(struct device *, void *);
> +};
> +
> +static int __each_hub(struct usb_device *hdev, void *data)
> +{
> +	struct each_hub_arg *arg = (struct each_hub_arg *)data;
> +	struct usb_hub *hub;
> +	int ret = 0;
> +	int i;
> +
> +	hub = usb_hub_to_struct_hub(hdev);
> +	if (!hub)
> +		return 0;

What happens if the hub is removed exactly now?  Although hdev is 
reference-counted (and the loop iterator does take a reference to it), 
usb_hub_to_struct_hub doesn't take a reference to hub.  And hub->ports 
isn't refcounted at all.

> +
> +	mutex_lock(&usb_port_peer_mutex);
> +
> +	for (i = 0; i < hdev->maxchild; i++) {
> +		ret = arg->fn(&hub->ports[i]->dev, arg->data);
> +		if (ret)
> +			break;
> +	}
> +
> +	mutex_unlock(&usb_port_peer_mutex);

I have a feeling that it would be better to take and release this mutex 
in usb_for_each_port (or its caller), so that it is held over the whole 
loop.

Alan Stern

> +
> +	return ret;
> +}
> +
> +/**
> + * usb_for_each_port - interate over all USB ports in the system
> + * @data: data pointer that will be handed to the callback function
> + * @fn: callback function to be called for each USB port
> + *
> + * Iterate over all USB ports and call @fn for each, passing it @data. If it
> + * returns anything other than 0, we break the iteration prematurely and return
> + * that value.
> + */
> +int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
> +{
> +	struct each_hub_arg arg = {data, fn};
> +
> +	return usb_for_each_dev(&arg, __each_hub);
> +}
> +EXPORT_SYMBOL_GPL(usb_for_each_port);
> +
>  /**
>   * usb_release_dev - free a usb device structure when all users of it are finished.
>   * @dev: device that's been disconnected
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index ddd2f5b2a2827..e4d2eb703cf89 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -871,6 +871,7 @@ extern int usb_match_one_id(struct usb_interface *interface,
>  			    const struct usb_device_id *id);
>  
>  extern int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *));
> +int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
>  extern struct usb_interface *usb_find_interface(struct usb_driver *drv,
>  		int minor);
>  extern struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
> -- 
> 2.30.2
> 
