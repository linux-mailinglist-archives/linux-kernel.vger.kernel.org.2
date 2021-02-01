Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC330A7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhBAMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:43:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:37202 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhBAMnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:43:37 -0500
IronPort-SDR: vLGyPMvfrjsPfIvwNqLAhymw/XD41SNM7RYG2wl+W8J9w3vw3xCDZzU6LpQ/O8g9ssF4U6DyLK
 BGQAVfZ3uOEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="178113811"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="178113811"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:41:50 -0800
IronPort-SDR: WrD29CuNhTDE9bFNvntO3tcG9OjgV2oGFCIDW1Jts57OrTsdylCee7ShOJTs6BxYTrpG/sel4H
 pGHk6ezUto+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="478947264"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 04:41:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:41:47 +0200
Date:   Mon, 1 Feb 2021 14:41:47 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     enric.balletbo@collabora.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 3/6] usb: typec: Add typec_partner_set_pd_revision
Message-ID: <20210201124147.GC2465@kuha.fi.intel.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-4-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-4-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:03PM -0800, Benson Leung wrote:
> The partner's PD revision may be resolved later than the port partner
> registration since the port partner creation may take place once
> Type-C detects the port has changed state, but before PD communication is
> completed.
> 
> Add a setter so that the partner's PD revision can be attached to it once
> it becomes available.
> 
> If the revision is set to a valid version (not 0), the setter will also
> refresh the partner's usb_pd flag and notify on "supports_usb_power_delivery"
> sysfs property as well.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/usb/typec.h |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b5241f4756c2..b6ceab3dc16b 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -748,6 +748,36 @@ int typec_partner_set_identity(struct typec_partner *partner)
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>  
> +/**
> + * typec_partner_set_pd_revision - Set the PD revision supported by the partner
> + * @partner: The partner to be updated.
> + * @pd_revision:  USB Power Delivery Specification Revision supported by partner
> + *
> + * This routine is used to report that the PD revision of the port partner has
> + * become available.
> + *
> + * Returns 0 on success or negative error number on failure.
> + */
> +int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision)
> +{
> +	int ret;
> +
> +	if (partner->pd_revision == pd_revision)
> +		return 0;
> +
> +	partner->pd_revision = pd_revision;
> +	sysfs_notify(&partner->dev.kobj, NULL, "usb_power_delivery_revision");
> +	if (pd_revision != 0 && !partner->usb_pd) {
> +		partner->usb_pd = 1;
> +		sysfs_notify(&partner->dev.kobj, NULL,
> +			     "supports_usb_power_delivery");
> +	}
> +	kobject_uevent(&partner->dev.kobj, KOBJ_CHANGE);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_partner_set_pd_revision);
> +
>  /**
>   * typec_partner_set_num_altmodes - Set the number of available partner altmodes
>   * @partner: The partner to be updated.
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 42c6b7c07a99..4946eca742d5 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -126,6 +126,7 @@ struct typec_altmode_desc {
>  	enum typec_port_data	roles;
>  };
>  
> +int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision);
>  int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes);
>  struct typec_altmode
>  *typec_partner_register_altmode(struct typec_partner *partner,
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
