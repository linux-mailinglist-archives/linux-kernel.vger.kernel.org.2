Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158A130C399
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhBBPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:23:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:40315 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235467AbhBBPWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:22:15 -0500
IronPort-SDR: o4A5U9jx95iIqJgLTRSPQPiTYGOkFs5q/KEZk2aBaSEb+gNNXPdUaFp5ynIo30CLjRN0fwO8HD
 pIWJq8NvHw7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180945250"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180945250"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 07:20:29 -0800
IronPort-SDR: rshFNB23BADftRYzLJ7COVK246E9ce692e7ZMR3vKUPo0YOF+agfddVJY/JwT3V/HIAOQiND/1
 S74olwgAJH1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479828665"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 07:20:26 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 17:20:26 +0200
Date:   Tue, 2 Feb 2021 17:20:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     gregkh@linuxfoundation.org, bleung@chromium.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Return void in typec_partner_set_pd_revision
Message-ID: <20210202152026.GB1687065@kuha.fi.intel.com>
References: <20210202095512.761214-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202095512.761214-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 05:55:12PM +0800, Kyle Tso wrote:
> typec_partner_set_pd_revision doesn't need any return value.
> 
> Fixes: 29b01295a829 ("usb: typec: Add typec_partner_set_pd_revision")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Good catch.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 10 ++--------
>  include/linux/usb/typec.h |  2 +-
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b6ceab3dc16b..a7d1bc83c2d4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -755,15 +755,11 @@ EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>   *
>   * This routine is used to report that the PD revision of the port partner has
>   * become available.
> - *
> - * Returns 0 on success or negative error number on failure.
>   */
> -int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision)
> +void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision)
>  {
> -	int ret;
> -
>  	if (partner->pd_revision == pd_revision)
> -		return 0;
> +		return;
>  
>  	partner->pd_revision = pd_revision;
>  	sysfs_notify(&partner->dev.kobj, NULL, "usb_power_delivery_revision");
> @@ -773,8 +769,6 @@ int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision
>  			     "supports_usb_power_delivery");
>  	}
>  	kobject_uevent(&partner->dev.kobj, KOBJ_CHANGE);
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_set_pd_revision);
>  
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 4946eca742d5..a94df82ab62f 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -126,7 +126,7 @@ struct typec_altmode_desc {
>  	enum typec_port_data	roles;
>  };
>  
> -int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision);
> +void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision);
>  int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes);
>  struct typec_altmode
>  *typec_partner_register_altmode(struct typec_partner *partner,
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
