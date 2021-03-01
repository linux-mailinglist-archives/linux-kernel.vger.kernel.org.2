Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF56328200
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhCAPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:15:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:22651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236993AbhCAPMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:12:43 -0500
IronPort-SDR: AlMnMs+TgJxYmm8EvpYRPhGNDxSR2/AsC97e0JbCruQ2xSUYDzw/8MedY3jgdur4QL2lQnPZDS
 deK6KiG9u/pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="185817195"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="185817195"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:11:19 -0800
IronPort-SDR: +XUb1TVSZ43p3xudTjqRp2GZdMQGk11BBzaI8X+kUgV9TM9XyDT1qgIp7s4VQqEHg8mbXiE2U2
 a255QNoKk/jQ==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="366734781"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 07:11:17 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lGkCY-009AMJ-Uc; Mon, 01 Mar 2021 17:11:14 +0200
Date:   Mon, 1 Mar 2021 17:11:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] software node: Fix device_add_software_node()
Message-ID: <YD0EEthlwXek9NFZ@smile.fi.intel.com>
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
 <20210301143012.55118-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301143012.55118-3-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:30:12PM +0300, Heikki Krogerus wrote:
> The function device_add_software_node() was meant to
> register the node supplied to it, but only if that node
> wasn't already registered. Right now the function attempts
> to always register the node. That will cause a failure with
> nodes that are already registered.
> 
> Fixing that by incrementing the reference count of the nodes
> that have already been registered, and only registering the
> new nodes. Also, clarifying the behaviour in the function
> documentation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(On Intel Galileo Gen 2 with some custom patches to convert gpio-dwapb et al.
  to use swnodes. Those patches a subject to further submission.)

Thanks!

> Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c    | 26 +++++++++++++++++---------
>  include/linux/property.h |  2 +-
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 74db8c971db74..fa3719ef80e4d 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1005,25 +1005,33 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
>  /**
>   * device_add_software_node - Assign software node to a device
>   * @dev: The device the software node is meant for.
> - * @swnode: The software node.
> + * @node: The software node.
>   *
> - * This function will register @swnode and make it the secondary firmware node
> - * pointer of @dev. If @dev has no primary node, then @swnode will become the primary
> - * node.
> + * This function will make @node the secondary firmware node pointer of @dev. If
> + * @dev has no primary node, then @node will become the primary node. The
> + * function will register @node automatically if it wasn't already registered.
>   */
> -int device_add_software_node(struct device *dev, const struct software_node *swnode)
> +int device_add_software_node(struct device *dev, const struct software_node *node)
>  {
> +	struct swnode *swnode;
>  	int ret;
>  
>  	/* Only one software node per device. */
>  	if (dev_to_swnode(dev))
>  		return -EBUSY;
>  
> -	ret = software_node_register(swnode);
> -	if (ret)
> -		return ret;
> +	swnode = software_node_to_swnode(node);
> +	if (swnode) {
> +		kobject_get(&swnode->kobj);
> +	} else {
> +		ret = software_node_register(node);
> +		if (ret)
> +			return ret;
> +
> +		swnode = software_node_to_swnode(node);
> +	}
>  
> -	set_secondary_fwnode(dev, software_node_fwnode(swnode));
> +	set_secondary_fwnode(dev, &swnode->fwnode);
>  
>  	return 0;
>  }
> diff --git a/include/linux/property.h b/include/linux/property.h
> index dafccfce02624..dd4687b562393 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -488,7 +488,7 @@ fwnode_create_software_node(const struct property_entry *properties,
>  			    const struct fwnode_handle *parent);
>  void fwnode_remove_software_node(struct fwnode_handle *fwnode);
>  
> -int device_add_software_node(struct device *dev, const struct software_node *swnode);
> +int device_add_software_node(struct device *dev, const struct software_node *node);
>  void device_remove_software_node(struct device *dev);
>  
>  int device_create_managed_software_node(struct device *dev,
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


