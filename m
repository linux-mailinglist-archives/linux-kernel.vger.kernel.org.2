Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAAE37F6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhEMLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232450AbhEMLZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:25:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7E87613DE;
        Thu, 13 May 2021 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620905054;
        bh=jzzh35qDGkFoSJTAN06Jm3tfQzmk5CV26trrlgg59EQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dD7VcROXWD6E7T8dtHaIFbqf9fFpHi4QIi8aUjcZMwxD+0fLBFO4P1oh2R1dq4eiy
         epx0Yo4aBCJPBJOpU/xeByjcnzYhaSvZox03GCygcQo7WkhIxhji0lI6Bn8wcfV2Ls
         8AY37DTxYLhVBRD+gl8TvPwv4vARpQpWVr5wVkPw=
Date:   Thu, 13 May 2021 13:24:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 11/14] intel_gna: add ioctl handler
Message-ID: <YJ0MXK2XSISC1fIl@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:00:37PM +0200, Maciej Kwapulinski wrote:
> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
> 
> Add ioctl handler into GNA driver.
> The ioctl interface provides the ability to do the following:
>  - Map and unmap memory buffers for GNA computation requests.
>  - Retrieve capabilities of the underlying GNA IP.
>  - Submit GNA computation requests.
>  - Request notification of scoring completion.

Do you have a pointer to the userspace code that uses this ioctl?
That's kind of required here, otherwise we have no idea how this all
works.

> 
> Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
> Tested-by: Savo Novakovic <savox.novakovic@intel.com>
> Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
> Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> ---
>  drivers/misc/intel/gna/Kbuild   |   2 +-
>  drivers/misc/intel/gna/device.c |  47 ++++++
>  drivers/misc/intel/gna/device.h |   2 +
>  drivers/misc/intel/gna/ioctl.c  | 257 ++++++++++++++++++++++++++++++++
>  drivers/misc/intel/gna/ioctl.h  |  11 ++
>  include/uapi/misc/intel/gna.h   |  53 +++++++
>  6 files changed, 371 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/intel/gna/ioctl.c
>  create mode 100644 drivers/misc/intel/gna/ioctl.h
> 
> diff --git a/drivers/misc/intel/gna/Kbuild b/drivers/misc/intel/gna/Kbuild
> index 38ff97360ed8..745a192a7304 100644
> --- a/drivers/misc/intel/gna/Kbuild
> +++ b/drivers/misc/intel/gna/Kbuild
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> -intel_gna-y := device.o hw.o mem.o pci.o request.o score.o
> +intel_gna-y := device.o hw.o ioctl.o mem.o pci.o request.o score.o
>  
>  obj-$(CONFIG_INTEL_GNA) += intel_gna.o
> diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
> index 75d8e1675485..0e31b8c6bb70 100644
> --- a/drivers/misc/intel/gna/device.c
> +++ b/drivers/misc/intel/gna/device.c
> @@ -6,8 +6,11 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  
> +#include <uapi/misc/intel/gna.h>
> +
>  #include "device.h"
>  #include "hw.h"
> +#include "ioctl.h"
>  #include "request.h"
>  
>  static int recovery_timeout = 60;
> @@ -145,6 +148,50 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
>  	return 0;
>  }
>  
> +static u32 gna_device_type_by_hwid(u32 hwid)
> +{
> +	switch (hwid) {
> +	case GNA_DEV_HWID_CNL:
> +		return GNA_DEV_TYPE_0_9;
> +	case GNA_DEV_HWID_GLK:
> +	case GNA_DEV_HWID_EHL:
> +	case GNA_DEV_HWID_ICL:
> +		return GNA_DEV_TYPE_1_0;
> +	case GNA_DEV_HWID_JSL:
> +	case GNA_DEV_HWID_TGL:
> +	case GNA_DEV_HWID_RKL:
> +		return GNA_DEV_TYPE_2_0;
> +	case GNA_DEV_HWID_ADL:
> +	case GNA_DEV_HWID_RPL:
> +		return GNA_DEV_TYPE_3_0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param)
> +{
> +	switch (param->in.id) {
> +	case GNA_PARAM_DEVICE_ID:
> +		param->out.value = gna_priv->info.hwid;
> +		break;

Why do you need an ioctl to get the device id?  What's wrong with sysfs?

> +	case GNA_PARAM_RECOVERY_TIMEOUT:
> +		param->out.value = jiffies_to_msecs(gna_priv->recovery_timeout_jiffies) / 1000;
> +		break;
> +	case GNA_PARAM_INPUT_BUFFER_S:
> +		param->out.value = gna_priv->hw_info.in_buf_s;
> +		break;
> +	case GNA_PARAM_DEVICE_TYPE:
> +		param->out.value = gna_device_type_by_hwid(gna_priv->info.hwid);

Same here, why isn't this a sysfs file?

> +		break;
> +	default:
> +		dev_err(gna_dev(gna_priv), "unknown parameter id %llu\n", param->in.id);

Userspace can cause syslog DoS?  Not nice :(

Please just eat the error and move on.

> +		return -EINVAL;

Wrong error value for invalid ioctl value.


> +	}
> +
> +	return 0;
> +}
> +
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_DESCRIPTION("Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA) Driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
> index d3c86d649b5c..75784882f57c 100644
> --- a/drivers/misc/intel/gna/device.h
> +++ b/drivers/misc/intel/gna/device.h
> @@ -17,6 +17,7 @@
>  #define GNA_DV_NAME	"intel_gna"
>  
>  struct workqueue_struct;
> +union gna_parameter;
>  struct device;
>  struct file;
>  
> @@ -71,6 +72,7 @@ struct gna_private {
>  };
>  
>  int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase, int irq);
> +int gna_getparam(struct gna_private *gna_priv, union gna_parameter *param);
>  
>  static inline u32 gna_reg_read(struct gna_private *gna_priv, u32 reg)
>  {
> diff --git a/drivers/misc/intel/gna/ioctl.c b/drivers/misc/intel/gna/ioctl.c
> new file mode 100644
> index 000000000000..4a90135b3cc6
> --- /dev/null
> +++ b/drivers/misc/intel/gna/ioctl.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2017-2021 Intel Corporation
> +
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/idr.h>
> +#include <linux/jiffies.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/uaccess.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +
> +#include <uapi/misc/intel/gna.h>
> +
> +#include "device.h"
> +#include "ioctl.h"
> +#include "mem.h"
> +#include "request.h"
> +#include "score.h"
> +
> +static int gna_ioctl_score(struct gna_file_private *file_priv, void __user *argptr)
> +{
> +	union gna_compute score_args;
> +	struct gna_private *gna_priv;
> +	u64 request_id;
> +	int ret;
> +
> +	gna_priv = file_priv->gna_priv;
> +
> +	if (copy_from_user(&score_args, argptr, sizeof(score_args))) {
> +		dev_err(gna_dev(gna_priv), "could not copy score ioctl config from user\n");

No need for errors that userspace can cause, please drop, you already
got a message if there needed to be one.

> +		return -EFAULT;
> +	}
> +
> +	ret = gna_validate_score_config(&score_args.in.config, file_priv);

This function is in a different patch?  Now I have to dig through that
to try to figure out if you really are validating the data properly?
That's just mean to reviewers, would you want to review code like this?
Please fix.

> +	if (ret) {
> +		dev_err(gna_dev(gna_priv), "request not valid\n");

Same here, clean up all error reporting in your ioctl to be none at all
please.

> +		return ret;
> +	}
> +
> +	ret = gna_enqueue_request(&score_args.in.config, file_priv, &request_id);

Same here, where is this function to review?

Same for all your other ioctl handlers, please fix up, this is rough to
review...

greg k-h
