Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021643827B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhEQJDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:03:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:35715 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhEQJDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:03:40 -0400
IronPort-SDR: iKMG091Zdj+qP5n5OcLy9lWS3gng87LX6rDyOUPpFYMq7yOobi31oZNmdDP5eBMrb7+K+YmcuD
 VbtFjikgjtrQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="221454012"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="221454012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 02:02:23 -0700
IronPort-SDR: tccyjVpD8nkjvIVGmGjgKxuz5Kgtr5A9tJeZ+PC8yPQti4ptgQhdAmGyJnUwzEd+r/K6TxRYha
 +Gb9aJ6B0P6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="540323965"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2021 02:02:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 May 2021 12:02:07 +0300
Date:   Mon, 17 May 2021 12:02:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <jun.li@nxp.com>, Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Fix matching with typec_altmode_desc
Message-ID: <YKIxDz/vqXzS5EtO@kuha.fi.intel.com>
References: <20210516034730.621461-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516034730.621461-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 08:47:30PM -0700, Bjorn Andersson wrote:
> In typec_mux_match() "nval" is assigned the number of elements in the
> "svid" fwnode property, then the variable is used to store the success
> of the read and finally attempts to loop between 0 and "success" - i.e.
> not at all - and the code returns indicating that no match was found.
> 
> Fix this by using a separate variable to track the success of the read,
> to allow the loop to get a change to find a match.
> 
> Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 9da22ae3006c..8514bec7e1b8 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -191,6 +191,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>  	bool match;
>  	int nval;
>  	u16 *val;
> +	int ret;
>  	int i;
>  
>  	/*
> @@ -218,10 +219,10 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>  	if (!val)
>  		return ERR_PTR(-ENOMEM);
>  
> -	nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> -	if (nval < 0) {
> +	ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> +	if (ret < 0) {
>  		kfree(val);
> -		return ERR_PTR(nval);
> +		return ERR_PTR(ret);
>  	}
>  
>  	for (i = 0; i < nval; i++) {
> -- 
> 2.29.2

thanks,

-- 
heikki
