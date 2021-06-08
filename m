Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD439F79F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhFHNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:21:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:27184 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbhFHNVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:21:33 -0400
IronPort-SDR: u+aAV8JChRQJ1UvrRF4d6nu5nPCjZGjCX5s+VlHomBohNmElbhxKyZ9rWgWbB/C6ZF9kUwWTjc
 j0ODW1hnVvlg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202982934"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="202982934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:19:22 -0700
IronPort-SDR: UHfUUIYptcsstToighILDc9Jw67z59fJOngbrQiP5u7j6z4jjI3qqQTCWDtYW8MADhea8xYTGm
 Dc4GKZGieS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552276026"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Jun 2021 06:19:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Jun 2021 16:19:19 +0300
Date:   Tue, 8 Jun 2021 16:19:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: intel_pmc_mux: Put fwnode in error
 case during ->probe()
Message-ID: <YL9uVzN2E65nEnay@kuha.fi.intel.com>
References: <20210607205007.71458-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607205007.71458-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:50:05PM +0300, Andy Shevchenko wrote:
> device_get_next_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: moved put call into the conditional inside the loop (Heikki)
>  drivers/usb/typec/mux/intel_pmc_mux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index dc8689db0100..221aa1c0e77a 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -654,8 +654,10 @@ static int pmc_usb_probe(struct platform_device *pdev)
>  			break;
>  
>  		ret = pmc_usb_register_port(pmc, i, fwnode);
> -		if (ret)
> +		if (ret) {
> +			fwnode_handle_put(fwnode);
>  			goto err_remove_ports;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, pmc);
> -- 
> 2.32.0

-- 
heikki
