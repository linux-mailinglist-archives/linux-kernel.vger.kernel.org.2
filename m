Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B97326005
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBZJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhBZJZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:25:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF8764F3B;
        Fri, 26 Feb 2021 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614331497;
        bh=nCtH3BlN7/0k3eh6WNHHrnSaaqBcXlvynYDx+WKTIpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+2NS/Fn4NwLiTwoJaeAZgi5cQxU1K0CDXHj9oilmAUM/50cqi1ZeTLgBnfg5JUBi
         tP8GsYhqWlM0idKm5K3D/IyK5NEjLA3UfSNhraGE+irhHp/hCu0gGJ7a2ERTzS81ML
         wJRy1qtCmoIsViqGLAB/GUyDVrIV8UhfkjjR8VyQ=
Date:   Fri, 26 Feb 2021 10:24:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricky Niu <rickyniu@google.com>
Cc:     stern@rowland.harvard.edu, erosca@de.adit-jv.com,
        gustavoars@kernel.org, a.darwish@linutronix.de, oneukum@suse.com,
        kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over
 6
Message-ID: <YDi+Zug0t6lgn+ER@kroah.com>
References: <20210226091612.508639-1-rickyniu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226091612.508639-1-rickyniu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 05:16:12PM +0800, Ricky Niu wrote:
> When the topology of the nested hubs are over 6 layers
> Send uevent to user space when USB TOPO layer over 6.
> Let end user more understand what happened.
> 
> Signed-off-by: Ricky Niu <rickyniu@google.com>
> ---
>  drivers/usb/core/hub.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 7f71218cc1e5..e5e924526822 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -55,6 +55,10 @@ static DEFINE_SPINLOCK(device_state_lock);
>  static struct workqueue_struct *hub_wq;
>  static void hub_event(struct work_struct *work);
>  
> +/* struct to notify userspace of hub events */
> +static struct class *hub_class;
> +static struct device *hub_device;
> +
>  /* synchronize hub-port add/remove and peering operations */
>  DEFINE_MUTEX(usb_port_peer_mutex);
>  
> @@ -1764,6 +1768,13 @@ static bool hub_descriptor_is_sane(struct usb_host_interface *desc)
>          return true;
>  }
>  
> +static void hub_over_tier(void)
> +{
> +	char *envp[2] = { "HUB=OVERTIER", NULL };
> +
> +	kobject_uevent_env(&hub_device->kobj, KOBJ_CHANGE, envp);

Where have you now documented this odd uevent that is never sent by
anything else?

What tool will "catch" this?  Where is that code located at?

uevents are not for stuff like this, you are trying to send "error
conditions" to userspace, please use the "proper" interfaces like this
and not abuse existing ones.


> +}
> +
>  static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  {
>  	struct usb_host_interface *desc;
> @@ -1831,6 +1842,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	if (hdev->level == MAX_TOPO_LEVEL) {
>  		dev_err(&intf->dev,
>  			"Unsupported bus topology: hub nested too deep\n");
> +		hub_over_tier();
>  		return -E2BIG;
>  	}
>  
> @@ -5680,6 +5692,13 @@ int usb_hub_init(void)
>  		return -1;
>  	}
>  
> +	hub_class = class_create(THIS_MODULE, "usb_hub");
> +	if (IS_ERR(hub_class))
> +		return PTR_ERR(hub_class);
> +
> +	hub_device =
> +		device_create(hub_class, NULL, MKDEV(0, 0), NULL, "usb_hub");

You just created a whole new sysfs class with no Documentation/ABI/
update?

{sigh}

greg k-h
