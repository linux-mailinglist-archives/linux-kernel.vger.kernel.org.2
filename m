Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2A395621
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhEaHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:32:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:44624 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhEaHcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:32:11 -0400
IronPort-SDR: CkU6A60l8mrrDHVYqewOs1dnPuB3I1YOhMTAV4P+BH9Vuh8tFnC4IqYNdLYhj1blz7hVELfwc1
 X0cd7bWjoLnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190675158"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="190675158"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 00:30:30 -0700
IronPort-SDR: SZzBJuKQD0HxWaGhu2yzpe3QbxO+h8ghMOqgvxAESyh39LMhymrtbHzKJBCnTVNrA5KAxfj+Gv
 oWNJc2NCZ4lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549330770"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2021 00:30:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 May 2021 10:30:27 +0300
Date:   Mon, 31 May 2021 10:30:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: mux: Use device type instead of device
 name for matching
Message-ID: <YLSQkynoJO2+hYGW@kuha.fi.intel.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526153548.61276-2-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 06:35:47PM +0300, Heikki Krogerus wrote:
> Both the USB Type-C switch and mux have already a device
> type defined for them. We can use those types instead of the
> device name to differentiate the two.

This should still be OK, right?

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux.c | 26 ++++++++++----------------
>  drivers/usb/typec/mux.h |  6 ++++++
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 8514bec7e1b89..e40a555724fb6 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -17,21 +17,12 @@
>  #include "class.h"
>  #include "mux.h"
>  
> -static bool dev_name_ends_with(struct device *dev, const char *suffix)
> -{
> -	const char *name = dev_name(dev);
> -	const int name_len = strlen(name);
> -	const int suffix_len = strlen(suffix);
> -
> -	if (suffix_len > name_len)
> -		return false;
> -
> -	return strcmp(name + (name_len - suffix_len), suffix) == 0;
> -}
> -
>  static int switch_fwnode_match(struct device *dev, const void *fwnode)
>  {
> -	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
> +	if (!is_typec_switch(dev))
> +		return 0;
> +
> +	return dev_fwnode(dev) == fwnode;
>  }
>  
>  static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
> @@ -90,7 +81,7 @@ static void typec_switch_release(struct device *dev)
>  	kfree(to_typec_switch(dev));
>  }
>  
> -static const struct device_type typec_switch_dev_type = {
> +const struct device_type typec_switch_dev_type = {
>  	.name = "orientation_switch",
>  	.release = typec_switch_release,
>  };
> @@ -180,7 +171,10 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
>  
>  static int mux_fwnode_match(struct device *dev, const void *fwnode)
>  {
> -	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
> +	if (!is_typec_mux(dev))
> +		return 0;
> +
> +	return dev_fwnode(dev) == fwnode;
>  }
>  
>  static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
> @@ -295,7 +289,7 @@ static void typec_mux_release(struct device *dev)
>  	kfree(to_typec_mux(dev));
>  }
>  
> -static const struct device_type typec_mux_dev_type = {
> +const struct device_type typec_mux_dev_type = {
>  	.name = "mode_switch",
>  	.release = typec_mux_release,
>  };
> diff --git a/drivers/usb/typec/mux.h b/drivers/usb/typec/mux.h
> index 4fd9426ee44f6..b1d6e837cb747 100644
> --- a/drivers/usb/typec/mux.h
> +++ b/drivers/usb/typec/mux.h
> @@ -18,4 +18,10 @@ struct typec_mux {
>  #define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
>  #define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
>  
> +extern const struct device_type typec_switch_dev_type;
> +extern const struct device_type typec_mux_dev_type;
> +
> +#define is_typec_switch(dev) ((dev)->type == &typec_switch_dev_type)
> +#define is_typec_mux(dev) ((dev)->type == &typec_mux_dev_type)
> +
>  #endif /* __USB_TYPEC_MUX__ */
> -- 
> 2.30.2

-- 
heikki
