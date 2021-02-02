Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCCD30C24D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhBBOqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:46:45 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:42139 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbhBBOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:44:57 -0500
Received: by mail-oo1-f46.google.com with SMTP id g46so5167367ooi.9;
        Tue, 02 Feb 2021 06:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/jQlVybev7AS8XByYXCtRCWWc/mZPrcWcS9SplOVXI=;
        b=uSC5JyOSKpmoQT7USVJmzsc12R9X0hRV9oUg5auK4if6kPe0U4Hp+F+oZ5mzgYa9Ul
         nX3UIT9KQNvTpYi1u1b7erFBEIbGZ6KZydfgRWdiZFfMPcUWD5/LPGbC+NNslv6CQwcq
         x4c1++pK8A+Whi3zqW91uEB5xfZU3Pzskh6v41fUAEXdzwU+jqbxyw3+MSHNkwZUIuoB
         HbMximXXdnduWFQE1+8kTllJHIuD4bSHq19rxi8tNf8BxJVNW4CpltGTfKBqgoOrHHaU
         SASQ9M7b4po+3+T0Nd2TwUUxi83NAQ3+CdANDoghkT7NosJR5lMIoaUfKQTt3zehNxWj
         RNkA==
X-Gm-Message-State: AOAM530kpjmixewzClG/IE5jOcGqqVBffed8qZcTblt0a7g7jdGxc8BM
        KJUihjedVcjvpP3tHYTXQMO+xpyy1MFZCkT0nj0=
X-Google-Smtp-Source: ABdhPJyNp6HgZd7qylrM0AlHJLm2D/AGUq/xZy6rpsCfOoDSMj5OpAmclnKRL2X9SzGGGciSrR0dKuGBmy7MmbrTzpg=
X-Received: by 2002:a4a:d50d:: with SMTP id m13mr6409159oos.2.1612277056134;
 Tue, 02 Feb 2021 06:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com> <20210202125032.64982-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210202125032.64982-2-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 15:44:05 +0100
Message-ID: <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
Subject: Re: [PATCH 1/6] software node: Provide replacement for device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 1:50 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Adding function device_create_managed_software_node() that
> is designed to work as a drop-in replacement for
> device_add_properties(). The function has one additional
> feature compared to device_add_properties(). It takes also
> an optional parent node as parameter, and that way allow the
> nodes created with it to be part of a node hierarchy.
>
> The lifetime of the software nodes created with this
> function will be tied to the device they are assigned to.
> The function will therefore behave exactly the same way as
> device_add_properties() is expected to behave, except that
> it does not simply assume that the nodes attached to the
> device are always destroyed in device_del() unconditionally.
>
> The nodes created with this function are guaranteed to be
> removed when the device is removed even after device_del()
> stops calling device_remove_properties() unconditionally.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c    | 43 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  4 ++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 20faa9f4f5ed2..37179a8b1ceba 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -24,6 +24,7 @@ struct swnode {
>         struct swnode *parent;
>
>         unsigned int allocated:1;
> +       unsigned int managed:1;
>  };
>
>  static DEFINE_IDA(swnode_root_ids);
> @@ -1045,6 +1046,43 @@ void device_remove_software_node(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_remove_software_node);
>
> +/**
> + * device_create_managed_software_node - Create a software node for a device
> + * @dev: The device the software node is assigned to.
> + * @properties: Device properties for the software node.
> + * @parent: Parent of the software node.
> + *
> + * Creates a software node as a managed resource for @dev, which means the
> + * lifetime of the newly created software node is tied to the lifetime of @dev.
> + * Software nodes created with this function should not be reused or shared
> + * because of that. The function takes a deep copy of @properties for the
> + * software node.
> + *
> + * Since the new software node is assigned directly to @dev, and since it should
> + * not be shared, it is not returned to the caller. The function returns 0 on
> + * success, and errno in case of an error.
> + */
> +int device_create_managed_software_node(struct device *dev,
> +                                       const struct property_entry *properties,
> +                                       const struct software_node *parent)
> +{
> +       struct fwnode_handle *p = software_node_fwnode(parent);
> +       struct fwnode_handle *fwnode;
> +
> +       if (parent && !p)
> +               return -EINVAL;
> +
> +       fwnode = fwnode_create_software_node(properties, p);
> +       if (IS_ERR(fwnode))
> +               return PTR_ERR(fwnode);
> +
> +       to_swnode(fwnode)->managed = true;
> +       set_secondary_fwnode(dev, fwnode);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(device_create_managed_software_node);
> +
>  int software_node_notify(struct device *dev, unsigned long action)
>  {
>         struct swnode *swnode;
> @@ -1073,6 +1111,11 @@ int software_node_notify(struct device *dev, unsigned long action)
>                 sysfs_remove_link(&swnode->kobj, dev_name(dev));
>                 sysfs_remove_link(&dev->kobj, "software_node");
>                 kobject_put(&swnode->kobj);
> +
> +               if (swnode->managed) {
> +                       set_secondary_fwnode(dev, NULL);
> +                       kobject_put(&swnode->kobj);

Where does the corresponding kobject_get() get called?

> +               }
>                 break;
>         default:
>                 break;
> diff --git a/include/linux/property.h b/include/linux/property.h
> index b0e413dc59271..dafccfce02624 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -491,4 +491,8 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode);
>  int device_add_software_node(struct device *dev, const struct software_node *swnode);
>  void device_remove_software_node(struct device *dev);
>
> +int device_create_managed_software_node(struct device *dev,
> +                                       const struct property_entry *properties,
> +                                       const struct software_node *parent);
> +
>  #endif /* _LINUX_PROPERTY_H_ */
> --
> 2.30.0
>
