Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD60239D8B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:28:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:47402 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhFGJ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:28:01 -0400
IronPort-SDR: d9PaIble/3xNHKdXjHW4ETTJtNxuX9Z/2J++q9zminlbnjbSPmeUn1jgPOBJgEf5/0J19dfdT+
 g35EGtInomgg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290216613"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="290216613"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:26:10 -0700
IronPort-SDR: Y4IQSNGa/k8/6Zxb0SxD1MgDkfeyv2ozTtLYV6nDj8xImH73VZMhN4nfPaoZhDiArWQkgflyRj
 gL5cEIA2cPdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="551817326"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 02:26:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Jun 2021 12:26:07 +0300
Date:   Mon, 7 Jun 2021 12:26:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] usb: typec: intel_pmc_mux: Put ACPI device using
 acpi_dev_put()
Message-ID: <YL3mL4wylbWZEOO4@kuha.fi.intel.com>
References: <20210606200911.32076-1-andy.shevchenko@gmail.com>
 <20210606200911.32076-3-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606200911.32076-3-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:09:11PM +0300, Andy Shevchenko wrote:
> For ACPI devices we have a symmetric API to put them, so use it in the driver.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index de40276cc18b..2d0a863956c7 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -582,12 +582,12 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>  	acpi_dev_free_resource_list(&resource_list);
>  
>  	if (!pmc->iom_base) {
> -		put_device(&adev->dev);
> +		acpi_dev_put(adev);
>  		return -ENOMEM;
>  	}
>  
>  	if (IS_ERR(pmc->iom_base)) {
> -		put_device(&adev->dev);
> +		acpi_dev_put(adev);
>  		return PTR_ERR(pmc->iom_base);
>  	}
>  
> @@ -657,7 +657,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
>  		usb_role_switch_unregister(pmc->port[i].usb_sw);
>  	}
>  
> -	put_device(&pmc->iom_adev->dev);
> +	acpi_dev_put(pmc->iom_adev);
>  
>  	return ret;
>  }
> @@ -673,7 +673,7 @@ static int pmc_usb_remove(struct platform_device *pdev)
>  		usb_role_switch_unregister(pmc->port[i].usb_sw);
>  	}
>  
> -	put_device(&pmc->iom_adev->dev);
> +	acpi_dev_put(pmc->iom_adev);
>  
>  	return 0;
>  }
> -- 
> 2.31.1

-- 
heikki
