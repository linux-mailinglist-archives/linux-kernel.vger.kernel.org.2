Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229D39D8B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFGJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:27:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:47347 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhFGJ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:27:20 -0400
IronPort-SDR: Rl+CPIDUk1thvbycKcgg4aTi7bcq7/X5h+HaRY6GU3eZyThcBnQ/2+X385ii4pPiP8oajE/oz8
 Xzqo99Xqo13w==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290216544"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="290216544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:25:28 -0700
IronPort-SDR: +cVm1EzLf/U3RD/QzvtEIyFhGCOG/EClA6h2zvq4EVYueCfLhcG05Wb4o7zjffg9m10QQsfTY+
 OYVhnKMEiA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="551817200"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 02:25:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Jun 2021 12:25:24 +0300
Date:   Mon, 7 Jun 2021 12:25:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: typec: intel_pmc_mux: Add missed error check
 for devm_ioremap_resource()
Message-ID: <YL3mBPDLK5PNG8cm@kuha.fi.intel.com>
References: <20210606200911.32076-1-andy.shevchenko@gmail.com>
 <20210606200911.32076-2-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606200911.32076-2-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:09:10PM +0300, Andy Shevchenko wrote:
> devm_ioremap_resource() can return an error, add missed check for it.
> 
> Fixes: 43d596e32276 ("usb: typec: intel_pmc_mux: Check the port status before connect")
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 134325444e6a..de40276cc18b 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -586,6 +586,11 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>  		return -ENOMEM;
>  	}
>  
> +	if (IS_ERR(pmc->iom_base)) {
> +		put_device(&adev->dev);
> +		return PTR_ERR(pmc->iom_base);
> +	}
> +
>  	pmc->iom_adev = adev;
>  
>  	return 0;
> -- 
> 2.31.1

-- 
heikki
