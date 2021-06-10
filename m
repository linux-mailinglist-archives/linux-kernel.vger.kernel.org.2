Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E73A2BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFJMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:35:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:26823 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFJMfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:35:07 -0400
IronPort-SDR: UNxD5yM9qPNkwKyhPjoPzsMJ6L9MRP22ku5imiXs7Y4oZpPhbO0JB2UpMox2NNcoKHUg2MfrXQ
 atY+z8J+Z6vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192603373"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="192603373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 05:33:08 -0700
IronPort-SDR: U8b+ipgi7ha5iwopJ6dXgIEYNDRUmtBHaIpSwrlpi9pNy4R6aMuSVS7xVbwpnDXV8oGSU0LiZB
 yiydpmRsr1nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="553051116"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Jun 2021 05:33:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Jun 2021 15:33:04 +0300
Date:   Thu, 10 Jun 2021 15:33:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: mux: Fix copy-paste mistake in
 typec_mux_match
Message-ID: <YMIGgI34cc7OG+rh@kuha.fi.intel.com>
References: <20210610002132.3088083-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610002132.3088083-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 05:21:32PM -0700, Bjorn Andersson wrote:
> Fix the copy-paste mistake in the return path of typec_mux_match(),
> where dev is considered a member of struct typec_switch rather than
> struct typec_mux.
> 
> The two structs are identical in regards to having the struct device as
> the first entry, so this provides no functional change.
> 
> Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Don't touch the typec_switch part of mux.c...
> 
>  drivers/usb/typec/mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 664fb3513f48..c8340de0ed49 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -246,7 +246,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				mux_fwnode_match);
>  
> -	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> +	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
>  }
>  
>  /**

-- 
heikki
