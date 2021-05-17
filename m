Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266BF3827E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhEQJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:10148 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235871AbhEQJKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:50 -0400
IronPort-SDR: 7XHAj6HXySiMR87XJ+xZ2Ir3iLDZGmT6GqoInAK7wDFibjPKIwpvku9Tui/1ROz0DNGX2Z8R2A
 IQZ25gm/mgcw==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="180018720"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="180018720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 02:09:33 -0700
IronPort-SDR: X3esaw6tjhu+pmd2IeB1Gwmzz5yfQDZ6hy2jBv1v38rnCDHKHSlB3N47hnCpqzj6OiAT2F7auf
 CrrEz9Snr+uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="540326831"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2021 02:09:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 May 2021 12:09:30 +0300
Date:   Mon, 17 May 2021 12:09:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Fix copy-paste of the container_of
Message-ID: <YKIyylBF9gxXSg/3@kuha.fi.intel.com>
References: <20210516034833.621530-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516034833.621530-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 15, 2021 at 08:48:33PM -0700, Bjorn Andersson wrote:
> Some of the boilerplate code was copy pasted from the typec_switch and
> retained the use of the switch's container_of macros. The two structs
> are identical in this regard, so this change doesn't cause a functional
> change today, but could possibly cause future issues.
> 
> Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/usb/typec/mux.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 8514bec7e1b8..e4467c4c3742 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -45,7 +45,7 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				switch_fwnode_match);
>  
> -	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> +	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);

That does not look correct to me?

>  }
>  
>  /**
> @@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(typec_switch_put);
>  
>  static void typec_switch_release(struct device *dev)
>  {
> -	kfree(to_typec_switch(dev));
> +	kfree(to_typec_mux(dev));

Ditto.

>  }
>  
>  static const struct device_type typec_switch_dev_type = {
> @@ -239,7 +239,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				mux_fwnode_match);
>  
> -	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> +	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);

That looks correct.

Either I'm missing something, or only the last change is needed.

thanks,

-- 
heikki
