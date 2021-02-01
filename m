Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3369E30A7CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhBAMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:40:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:4714 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBAMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:40:45 -0500
IronPort-SDR: sOARduTKgxAkJvWAC+9H3aLNqk6LRMuXcTvaSWc2cv79XbghUtep5WLh/w5p/vS5Hn8CJYx8MK
 +B5u2krkU3Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177169993"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="177169993"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:38:57 -0800
IronPort-SDR: TJuz0phK4oOqIfxePadztRLFArdp9XudFC8zyIRt+0WwiiyPsvdrZZB9jaAK3ekmE4NJk5K/Zi
 mEqgXqIkqg7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="478937475"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Feb 2021 04:38:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:38:53 +0200
Date:   Mon, 1 Feb 2021 14:38:53 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     enric.balletbo@collabora.com, pmalani@chromium.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 1/6] usb: typec: Standardize PD Revision format with
 Type-C Revision
Message-ID: <20210201123853.GA2465@kuha.fi.intel.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
 <20210129061406.2680146-2-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-2-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:01PM -0800, Benson Leung wrote:
> The Type-C Revision was in a specific BCD format "0120H" for 1.2.
> USB PD revision numbers follow a similar pattern with "0300H" for 3.0.
> 
> Standardizes the sysfs format for usb_power_delivery_revision
> to align with the BCD format used for usb_typec_revision.
> 
> Example values:
> - "2.0": USB Power Delivery Release 2.0
> - "3.0": USB Power Delivery Release 3.0
> - "3.1": USB Power Delivery Release 3.1
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>

I guess it's OK to modify the ABI like this.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/ABI/testing/sysfs-class-typec | 7 ++++++-
>  drivers/usb/typec/class.c                   | 3 ++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 8eab41e79ce6..b61480535fdc 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -105,7 +105,12 @@ Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Revision number of the supported USB Power Delivery
> -		specification, or 0 when USB Power Delivery is not supported.
> +		specification, or 0.0 when USB Power Delivery is not supported.
> +
> +		Example values:
> +		- "2.0": USB Power Delivery Release 2.0
> +		- "3.0": USB Power Delivery Release 3.0
> +		- "3.1": USB Power Delivery Release 3.1
>  
>  What:		/sys/class/typec/<port>/usb_typec_revision
>  Date:		April 2017
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 8f77669f9cf4..4f60ee7ba76a 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1500,8 +1500,9 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  						char *buf)
>  {
>  	struct typec_port *p = to_typec_port(dev);
> +	u16 rev = p->cap->pd_revision;
>  
> -	return sprintf(buf, "%d\n", (p->cap->pd_revision >> 8) & 0xff);
> +	return sprintf(buf, "%d.%d\n", (rev >> 8) & 0xff, (rev >> 4) & 0xf);
>  }
>  static DEVICE_ATTR_RO(usb_power_delivery_revision);
>  
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
