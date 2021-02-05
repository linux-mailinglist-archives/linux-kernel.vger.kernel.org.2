Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30BD3111D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhBESU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:20:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:43424 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233181AbhBEPTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:19:38 -0500
IronPort-SDR: rxS+TVhcopjXwZ6XmNNrx8MUSPNNRE0ZzC1GQoI0Q3p8Ch9m2Q+5urUnMqBGXv50cctWeIWhi1
 AriKJC9FuxqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161202209"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="161202209"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:46:05 -0800
IronPort-SDR: fKiQcixdo1R4YTDE5iV17j5dO3VrKf4tjh90qvMYApi6TvuIeeYcXZs/aZ62r1MI4oRvvI9UC+
 XvVZIISPmdaA==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="434502902"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:46:05 -0800
Date:   Fri, 5 Feb 2021 07:47:22 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Russ Weight <russell.h.weight@intel.com>
cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v4 1/1] fpga: dfl: afu: harden port enable logic
In-Reply-To: <20210204212713.256021-1-russell.h.weight@intel.com>
Message-ID: <alpine.DEB.2.22.394.2102050747010.1307505@rhweight-WRK1>
References: <20210204212713.256021-1-russell.h.weight@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

On Thu, 4 Feb 2021, Russ Weight wrote:

> Port enable is not complete until ACK = 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK == 0.
>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v4:
>  - Added a dev_warn() call for the -EINVAL case of afu_port_err_clear()
>  - Modified dev_err() message in __afu_port_disable() to say "disable"
>    instead of "reset"
> v3:
>  - afu_port_err_clear() changed to prioritize port_enable failure over
>    other a detected mismatch in port errors.
>  - reorganized code in port_reset() to be more readable.
> v2:
>  - Fixed typo in commit message
> ---
> drivers/fpga/dfl-afu-error.c | 10 ++++++----
> drivers/fpga/dfl-afu-main.c  | 33 +++++++++++++++++++++++----------
> drivers/fpga/dfl-afu.h       |  2 +-
> 3 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..601e599fc33d 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
> 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> 	struct platform_device *pdev = to_platform_device(dev);
> 	void __iomem *base_err, *base_hdr;
> -	int ret = -EBUSY;
> +	int enable_ret = 0, ret = -EBUSY;
> 	u64 v;
>
> 	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> @@ -96,18 +96,20 @@ static int afu_port_err_clear(struct device *dev, u64 err)
> 		v = readq(base_err + PORT_FIRST_ERROR);
> 		writeq(v, base_err + PORT_FIRST_ERROR);
> 	} else {
> +		dev_warn(dev, "__func__: received 0x%llx, expected 0x%llx\n",
> +			 v, err);
> 		ret = -EINVAL;
> 	}
>
> 	/* Clear mask */
> 	__afu_port_err_mask(dev, false);
>
> -	/* Enable the Port by clear the reset */
> -	__afu_port_enable(pdev);
> +	/* Enable the Port by clearing the reset */
> +	enable_ret = __afu_port_enable(pdev);
>
> done:
> 	mutex_unlock(&pdata->lock);
> -	return ret;
> +	return enable_ret ? enable_ret : ret;
> }
>
> static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..77dadaae5b8f 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -21,6 +21,9 @@
>
> #include "dfl-afu.h"
>
> +#define RST_POLL_INVL 10 /* us */
> +#define RST_POLL_TIMEOUT 1000 /* us */
> +
> /**
>  * __afu_port_enable - enable a port by clear reset
>  * @pdev: port platform device.
> @@ -32,7 +35,7 @@
>  *
>  * The caller needs to hold lock for protection.
>  */
> -void __afu_port_enable(struct platform_device *pdev)
> +int __afu_port_enable(struct platform_device *pdev)
> {
> 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> 	void __iomem *base;
> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
> 	WARN_ON(!pdata->disable_count);
>
> 	if (--pdata->disable_count != 0)
> -		return;
> +		return 0;
>
> 	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
>
> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
> 	v = readq(base + PORT_HDR_CTRL);
> 	v &= ~PORT_CTRL_SFTRST;
> 	writeq(v, base + PORT_HDR_CTRL);
> -}
>
> -#define RST_POLL_INVL 10 /* us */
> -#define RST_POLL_TIMEOUT 1000 /* us */
> +	/*
> +	 * HW clears the ack bit to indicate that the port is fully out
> +	 * of reset.
> +	 */
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       !(v & PORT_CTRL_SFTRST_ACK),
> +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
>
> /**
>  * __afu_port_disable - disable a port by hold reset
> @@ -86,7 +99,7 @@ int __afu_port_disable(struct platform_device *pdev)
> 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> 			       v & PORT_CTRL_SFTRST_ACK,
> 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> -		dev_err(&pdev->dev, "timeout, fail to reset device\n");
> +		dev_err(&pdev->dev, "timeout, failure to disable device\n");
> 		return -ETIMEDOUT;
> 	}
>
> @@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
>
> 	ret = __afu_port_disable(pdev);
> 	if (!ret)
> -		__afu_port_enable(pdev);
> +		return ret;
>
> -	return ret;
> +	return __afu_port_enable(pdev);
> }
>
> static int port_reset(struct platform_device *pdev)
> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
> static int port_enable_set(struct platform_device *pdev, bool enable)
> {
> 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	int ret = 0;
> +	int ret;
>
> 	mutex_lock(&pdata->lock);
> 	if (enable)
> -		__afu_port_enable(pdev);
> +		ret = __afu_port_enable(pdev);
> 	else
> 		ret = __afu_port_disable(pdev);
> 	mutex_unlock(&pdata->lock);
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 576e94960086..e5020e2b1f3d 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -80,7 +80,7 @@ struct dfl_afu {
> };
>
> /* hold pdata->lock when call __afu_port_enable/disable */
> -void __afu_port_enable(struct platform_device *pdev);
> +int __afu_port_enable(struct platform_device *pdev);
> int __afu_port_disable(struct platform_device *pdev);
>
> void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> -- 
> 2.25.1
>
>
