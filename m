Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48A643D85F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJ1BFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJ1BFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:05:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265ABC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 18:03:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b4so1057659plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xlCc7Z1e4GadDTRFmw2EkFwl1UE1nzrwFhoIf8evImM=;
        b=jrHfocbGWZjYndnSJh5Lv8bCYIgZNnv1om4Nxt3Ye6uTFRkyxmeulCcY6t9B8DgpLH
         5unXtr8uUZY7UjDPAdUoqCYRDjCeoXZSd38z3C4KNup7LoDtGLyKPFikeQ0kusVoy1rx
         hy7N3FU+lxvpuOy0kHCWKfkfWm/FqxNM9s8dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xlCc7Z1e4GadDTRFmw2EkFwl1UE1nzrwFhoIf8evImM=;
        b=5PZNacZ78+NMX7miy5jMm+D6xeKB5smaWRhekfG30RG7R3h7Wk88tgLWCJsbnwDol2
         8uYLeJ8nQlDeNvyGP9qx+ii3SUdLPxrvkbpr9x1+tsduEiZZSAzk2hRurVtCzjQBBSjq
         QKfDM8uG/TN18qjVfrssEHnPQgcyyiLz5dI9Is5juQWT0f/8MIRjp8LyyCnMcdSt+WWy
         LfRAxVvt2M2s3UR6jihy7bFYY5WdKrlWaed/YLQqf32R1ycC4JzwKHvT9qXoL6ZCNaLo
         G8XwhG80kOYk1nDaMpw4nuPIjUckaV4+Sr0nvUhiTBAur6twAVafiSjSEae16VhYl9Iw
         w5yA==
X-Gm-Message-State: AOAM531yXBxkJwAV4UDH33n6YlJh/qw5/jTM/Lp/w3e6nKe7edHhXXHJ
        M16ChNYYoMxV9RpkkAWLN87KYQ==
X-Google-Smtp-Source: ABdhPJwxfZbRBibNFccrbI0cu7Sb0+htg7U7Vk2tzArj5wMlL868qnVJLZjDbACergDrOBZUEX5Reg==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr1155531pjb.228.1635382989596;
        Wed, 27 Oct 2021 18:03:09 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:eed8:5671:5fed:996c])
        by smtp.gmail.com with ESMTPSA id c11sm5099882pji.38.2021.10.27.18.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 18:03:09 -0700 (PDT)
Date:   Wed, 27 Oct 2021 18:03:08 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] usb: typec: Character device for USB Power
 Delivery devices
Message-ID: <YXn2zCA9lasDY/Xl@google.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <20211026143352.78387-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026143352.78387-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks for sending the RFC.

On Tue, Oct 26, 2021 at 05:33:50PM +0300, Heikki Krogerus wrote:
> Interim.
> 
> TODO/ideas:
> - Figure out a proper magic value for the ioctl and check if
>   the ioctl range is OK.
> - Register separate PD device for the cdev, and register it
>   only if the device (port, plug or partner) actually
>   supports USB PD (or come up with some other solution?).
> - Introduce something like
> 
> 	struct pd_request {
> 		struct pd_message request;
> 		struct pd_message __user *response;
> 	};
> 
>   and use it instead of only single struct pd_messages everywhere.
> 
> - Add compat support.
> - What do we do with Alerts and Attentions?
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/usb/typec/Makefile                    |   2 +-
>  drivers/usb/typec/class.c                     |  42 ++++
>  drivers/usb/typec/class.h                     |   4 +
>  drivers/usb/typec/pd-dev.c                    | 210 ++++++++++++++++++
>  drivers/usb/typec/pd-dev.h                    |  15 ++
>  include/linux/usb/pd_dev.h                    |  22 ++
>  include/linux/usb/typec.h                     |   8 +
>  include/uapi/linux/usb/pd_dev.h               |  55 +++++
>  9 files changed, 358 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/typec/pd-dev.c
>  create mode 100644 drivers/usb/typec/pd-dev.h
>  create mode 100644 include/linux/usb/pd_dev.h
>  create mode 100644 include/uapi/linux/usb/pd_dev.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 0ba463be6c588..fd443fd21f62a 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -175,6 +175,7 @@ Code  Seq#    Include File                                           Comments
>  'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
>  'P'   00-0F  drivers/usb/class/usblp.c                               conflict!
>  'P'   01-09  drivers/misc/pci_endpoint_test.c                        conflict!
> +'P'   70-7F  uapi/linux/usb/pd_dev.h                                 <mailto:linux-usb@vger.kernel.org>
>  'Q'   all    linux/soundcard.h
>  'R'   00-1F  linux/random.h                                          conflict!
>  'R'   01     linux/rfkill.h                                          conflict!
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index a0adb8947a301..be44528168013 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TYPEC)		+= typec.o
> -typec-y				:= class.o mux.o bus.o port-mapper.o
> +typec-y				:= class.o mux.o bus.o port-mapper.o pd-dev.o
>  obj-$(CONFIG_TYPEC)		+= altmodes/
>  obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
>  obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index aeef453aa6585..19fcc5da175d7 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -15,6 +15,7 @@
>  
>  #include "bus.h"
>  #include "class.h"
> +#include "pd-dev.h"
>  
>  static DEFINE_IDA(typec_index_ida);
>  
> @@ -665,6 +666,11 @@ static const struct attribute_group *typec_partner_groups[] = {
>  	NULL
>  };
>  
> +char *typec_partner_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
> +{
> +	return kasprintf(GFP_KERNEL, "pd%u/partner", to_typec_port(dev->parent)->id);
> +}
> +
>  static void typec_partner_release(struct device *dev)
>  {
>  	struct typec_partner *partner = to_typec_partner(dev);
> @@ -676,6 +682,7 @@ static void typec_partner_release(struct device *dev)
>  const struct device_type typec_partner_dev_type = {
>  	.name = "typec_partner",
>  	.groups = typec_partner_groups,
> +	.devnode = typec_partner_devnode,
>  	.release = typec_partner_release,
>  };
>  
> @@ -807,6 +814,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  
>  	ida_init(&partner->mode_ids);
>  	partner->usb_pd = desc->usb_pd;
> +	partner->pd_dev = desc->pd_dev;
>  	partner->accessory = desc->accessory;
>  	partner->num_altmodes = -1;
>  	partner->pd_revision = desc->pd_revision;
> @@ -826,6 +834,9 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	partner->dev.type = &typec_partner_dev_type;
>  	dev_set_name(&partner->dev, "%s-partner", dev_name(&port->dev));
>  
> +	if (partner->pd_dev)
> +		partner->dev.devt = MKDEV(PD_DEV_MAJOR, port->id * 4 + 3);
> +
>  	ret = device_register(&partner->dev);
>  	if (ret) {
>  		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
> @@ -853,6 +864,13 @@ EXPORT_SYMBOL_GPL(typec_unregister_partner);
>  /* ------------------------------------------------------------------------- */
>  /* Type-C Cable Plugs */
>  
> +char *typec_plug_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
> +{
> +	return kasprintf(GFP_KERNEL, "pd%u/plug%d",
> +			 to_typec_port(dev->parent->parent)->id,
> +			 to_typec_plug(dev)->index);
> +}
> +
>  static void typec_plug_release(struct device *dev)
>  {
>  	struct typec_plug *plug = to_typec_plug(dev);
> @@ -891,6 +909,7 @@ static const struct attribute_group *typec_plug_groups[] = {
>  const struct device_type typec_plug_dev_type = {
>  	.name = "typec_plug",
>  	.groups = typec_plug_groups,
> +	.devnode = typec_plug_devnode,
>  	.release = typec_plug_release,
>  };
>  
> @@ -973,11 +992,16 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
>  	ida_init(&plug->mode_ids);
>  	plug->num_altmodes = -1;
>  	plug->index = desc->index;
> +	plug->pd_dev = desc->pd_dev;
>  	plug->dev.class = &typec_class;
>  	plug->dev.parent = &cable->dev;
>  	plug->dev.type = &typec_plug_dev_type;
>  	dev_set_name(&plug->dev, "%s-%s", dev_name(cable->dev.parent), name);
>  
> +	if (plug->pd_dev)
> +		plug->dev.devt = MKDEV(PD_DEV_MAJOR,
> +				       to_typec_port(cable->dev.parent)->id * 4 + 1 + plug->index);
> +
>  	ret = device_register(&plug->dev);
>  	if (ret) {
>  		dev_err(&cable->dev, "failed to register plug (%d)\n", ret);
> @@ -1595,6 +1619,11 @@ static int typec_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return ret;
>  }
>  
> +char *typec_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
> +{
> +	return kasprintf(GFP_KERNEL, "pd%u/port", to_typec_port(dev)->id);
> +}
> +
>  static void typec_release(struct device *dev)
>  {
>  	struct typec_port *port = to_typec_port(dev);
> @@ -1611,6 +1640,7 @@ const struct device_type typec_port_dev_type = {
>  	.name = "typec_port",
>  	.groups = typec_groups,
>  	.uevent = typec_uevent,
> +	.devnode = typec_devnode,
>  	.release = typec_release,
>  };
>  
> @@ -2044,6 +2074,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  
>  	port->id = id;
>  	port->ops = cap->ops;
> +	port->pd_dev = cap->pd_dev;
>  	port->port_type = cap->type;
>  	port->prefer_role = cap->prefer_role;
>  
> @@ -2055,6 +2086,9 @@ struct typec_port *typec_register_port(struct device *parent,
>  	dev_set_name(&port->dev, "port%d", id);
>  	dev_set_drvdata(&port->dev, cap->driver_data);
>  
> +	if (port->pd_dev)
> +		port->dev.devt = MKDEV(PD_DEV_MAJOR, id * 4);
> +
>  	port->cap = kmemdup(cap, sizeof(*cap), GFP_KERNEL);
>  	if (!port->cap) {
>  		put_device(&port->dev);
> @@ -2121,8 +2155,15 @@ static int __init typec_init(void)
>  	if (ret)
>  		goto err_unregister_mux_class;
>  
> +	ret = usbpd_dev_init();
> +	if (ret)
> +		goto err_unregister_class;
> +
>  	return 0;
>  
> +err_unregister_class:
> +	class_unregister(&typec_class);
> +
>  err_unregister_mux_class:
>  	class_unregister(&typec_mux_class);
>  
> @@ -2135,6 +2176,7 @@ subsys_initcall(typec_init);
>  
>  static void __exit typec_exit(void)
>  {
> +	usbpd_dev_exit();
>  	class_unregister(&typec_class);
>  	ida_destroy(&typec_index_ida);
>  	bus_unregister(&typec_bus);
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index aef03eb7e1523..87c072f2ad753 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -14,6 +14,7 @@ struct typec_plug {
>  	enum typec_plug_index		index;
>  	struct ida			mode_ids;
>  	int				num_altmodes;
> +	const struct pd_dev		*pd_dev;
>  };
>  
>  struct typec_cable {
> @@ -33,6 +34,7 @@ struct typec_partner {
>  	int				num_altmodes;
>  	u16				pd_revision; /* 0300H = "3.0" */
>  	enum usb_pd_svdm_ver		svdm_version;
> +	const struct pd_dev		*pd_dev;
>  };
>  
>  struct typec_port {
> @@ -59,6 +61,8 @@ struct typec_port {
>  	struct mutex			port_list_lock; /* Port list lock */
>  
>  	void				*pld;
> +
> +	const struct pd_dev		*pd_dev;
>  };
>  
>  #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
> diff --git a/drivers/usb/typec/pd-dev.c b/drivers/usb/typec/pd-dev.c
> new file mode 100644
> index 0000000000000..436853e046ce4
> --- /dev/null
> +++ b/drivers/usb/typec/pd-dev.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB Power Delivery /dev entries
> + *
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/fs.h>
> +#include <linux/slab.h>
> +#include <linux/usb/pd_dev.h>
> +
> +#include "class.h"
> +
> +#define PD_DEV_MAX (MINORMASK + 1)
> +
> +dev_t usbpd_devt;
> +static struct cdev usb_pd_cdev;
> +
> +struct pddev {
> +	struct device *dev;
> +	struct typec_port *port;
> +	const struct pd_dev *pd_dev;
> +};
> +
> +static ssize_t usbpd_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
> +{
> +	/* FIXME TODO XXX */
> +
> +	/* Alert and Attention handling here (with poll) ? */
> +
> +	return 0;
> +}
> +
> +static long usbpd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pddev *pd = file->private_data;
> +	void __user *p = (void __user *)arg;
> +	unsigned int pwr_role;
> +	struct pd_message msg;
> +	u32 configuration;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case USBPDDEV_INFO:
> +		if (copy_to_user(p, pd->pd_dev->info, sizeof(*pd->pd_dev->info)))
> +			return -EFAULT;
> +		break;
> +	case USBPDDEV_CONFIGURE:
> +		if (!pd->pd_dev->ops->configure)
> +			return -ENOTTY;
> +
> +		if (copy_from_user(&configuration, p, sizeof(configuration)))
> +			return -EFAULT;
> +
> +		ret = pd->pd_dev->ops->configure(pd->pd_dev, configuration);
> +		if (ret)
> +			return ret;
> +		break;
> +	case USBPDDEV_PWR_ROLE:
> +		if (is_typec_plug(pd->dev))
> +			return -ENOTTY;
> +
> +		if (is_typec_partner(pd->dev)) {
> +			if (pd->port->pwr_role == TYPEC_SINK)
> +				pwr_role = TYPEC_SOURCE;
> +			else
> +				pwr_role = TYPEC_SINK;
> +		} else {
> +			pwr_role = pd->port->pwr_role;
> +		}
> +
> +		if (copy_to_user(p, &pwr_role, sizeof(unsigned int)))
> +			return -EFAULT;
> +		break;
> +	case USBPDDEV_GET_MESSAGE:
> +		if (!pd->pd_dev->ops->get_message)
> +			return -ENOTTY;
> +
> +		if (copy_from_user(&msg, p, sizeof(msg)))
> +			return -EFAULT;
> +
> +		ret = pd->pd_dev->ops->get_message(pd->pd_dev, &msg);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user(p, &msg, sizeof(msg)))
> +			return -EFAULT;
> +		break;
> +	case USBPDDEV_SET_MESSAGE:
> +		if (!pd->pd_dev->ops->set_message)
> +			return -ENOTTY;
> +
> +		ret = pd->pd_dev->ops->set_message(pd->pd_dev, &msg);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user(p, &msg, sizeof(msg)))
> +			return -EFAULT;
> +		break;
> +	case USBPDDEV_SUBMIT_MESSAGE:
> +		if (!pd->pd_dev->ops->submit)
> +			return -ENOTTY;
> +
> +		if (copy_from_user(&msg, p, sizeof(msg)))
> +			return -EFAULT;
> +
> +		ret = pd->pd_dev->ops->submit(pd->pd_dev, &msg);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user(p, &msg, sizeof(msg)))
> +			return -EFAULT;
> +		break;

Why is USBPDDEV_SUBMIT_MESSAGE different from USBPDDEV_SET_MESSAGE?
Shouldn't "setting" a PDO or property automatically "submit" it (using TCPM
or whatever interface is actually performing the PD messaging) if
appropriate (e.g Source Caps?). Is there a situation where one would
want to "set" a property but not "send" it?

It seems to me that the two can be combined into 1 rather than having
a separate command just for ports.

Best regards,

-Prashant

