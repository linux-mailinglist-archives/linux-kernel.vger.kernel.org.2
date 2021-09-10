Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB94B406DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhIJPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:03:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:49924 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234176AbhIJPDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:03:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="221131538"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="221131538"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 08:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="540634981"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2021 08:02:16 -0700
Date:   Fri, 10 Sep 2021 22:55:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v15 6/6] fpga: image-load: enable cancel of image upload
Message-ID: <20210910145545.GA757507@yilunxu-OptiPlex-7050>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-7-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909021846.681121-7-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 07:18:46PM -0700, Russ Weight wrote:
> Extend the FPGA Image Load class driver to include a cancel IOCTL that
> can be used to request that an image upload be canceled. The IOCTL may
> return EBUSY if it cannot be canceled by software or ENODEV if there
> is no update in progress.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v15:
>  - Compare to previous patch:
>      [PATCH v14 6/6] fpga: sec-mgr: enable cancel of secure update
>  - Changed file, symbol, and config names to reflect the new driver name
>  - Cancel is now initiated by IOCT instead of sysfs
>  - Removed signed-off/reviewed-by tags
> v14:
>  - Updated ABI documentation date and kernel version
> v13:
>   - No change
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - No change
> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v9:
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - No change
> v7:
>   - Changed Date in documentation file to December 2020
> v6:
>   - No change
> v5:
>   - No change
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - No change
> v2:
>   - Bumped documentation date and version
>   - Minor code cleanup per review comments
> ---
> ---
>  Documentation/fpga/fpga-image-load.rst |  6 ++++
>  drivers/fpga/fpga-image-load.c         | 45 +++++++++++++++++++++++---
>  include/linux/fpga/fpga-image-load.h   |  1 +
>  include/uapi/linux/fpga-image-load.h   |  1 +
>  4 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> index 3d5eb51223e3..763e7833a6ea 100644
> --- a/Documentation/fpga/fpga-image-load.rst
> +++ b/Documentation/fpga/fpga-image-load.rst
> @@ -37,3 +37,9 @@ FPGA_IMAGE_LOAD_STATUS:
>  Collect status for an on-going image upload. The status returned includes
>  how much data remains to be transferred, the progress of the image load,
>  and error information in the case of a failure.
> +
> +FPGA_IMAGE_LOAD_CANCEL:
> +
> +Request that a on-going image upload be cancelled. This IOCTL may return
> +EBUSY if it cannot be cancelled by software or ENODEV if there is no update
> +in progress.
> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> index 6ec0a39f07b3..c32e4b1ea35a 100644
> --- a/drivers/fpga/fpga-image-load.c
> +++ b/drivers/fpga/fpga-image-load.c
> @@ -46,6 +46,24 @@ static void fpga_image_dev_error(struct fpga_image_load *imgld,
>  	imgld->lops->cancel(imgld);
>  }
>  
> +static int fpga_image_prog_transition(struct fpga_image_load *imgld,
> +				      enum fpga_image_prog new_progress)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&imgld->lock);
> +	if (imgld->request_cancel) {
> +		imgld->err_progress = imgld->progress;
> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
> +		imgld->lops->cancel(imgld);
> +		ret = -ECANCELED;
> +	} else {
> +		imgld->progress = new_progress;
> +	}
> +	mutex_unlock(&imgld->lock);
> +	return ret;
> +}
> +
>  static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>  {
>  	mutex_lock(&imgld->lock);
> @@ -77,8 +95,10 @@ static void fpga_image_do_load(struct work_struct *work)
>  		goto modput_exit;
>  	}
>  
> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
> -	while (imgld->remaining_size) {
> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_WRITING))
> +		goto done;
> +
> +	while (imgld->remaining_size && !imgld->request_cancel) {
>  		ret = imgld->lops->write_blk(imgld, offset);
>  		if (ret != FPGA_IMAGE_ERR_NONE) {
>  			fpga_image_dev_error(imgld, ret);
> @@ -88,7 +108,9 @@ static void fpga_image_do_load(struct work_struct *work)
>  		offset = size - imgld->remaining_size;
>  	}
>  
> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_PROGRAMMING))
> +		goto done;
> +
>  	ret = imgld->lops->poll_complete(imgld);
>  	if (ret != FPGA_IMAGE_ERR_NONE)
>  		fpga_image_dev_error(imgld, ret);
> @@ -159,6 +181,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>  	imgld->remaining_size = wb.size;
>  	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>  	imgld->progress = FPGA_IMAGE_PROG_STARTING;
> +	imgld->request_cancel = false;
>  	reinit_completion(&imgld->update_done);
>  	schedule_work(&imgld->work);
>  	return 0;
> @@ -189,7 +212,7 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>  				  unsigned long arg)
>  {
>  	struct fpga_image_load *imgld = filp->private_data;
> -	int ret = -ENOTTY;
> +	int ret = 0;
>  
>  	mutex_lock(&imgld->lock);
>  
> @@ -200,6 +223,17 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>  	case FPGA_IMAGE_LOAD_STATUS:
>  		ret = fpga_image_load_ioctl_status(imgld, arg);
>  		break;
> +	case FPGA_IMAGE_LOAD_CANCEL:
> +		if (imgld->progress == FPGA_IMAGE_PROG_PROGRAMMING)
> +			ret = -EBUSY;
> +		else if (imgld->progress == FPGA_IMAGE_PROG_IDLE)
> +			ret = -ENODEV;
> +		else
> +			imgld->request_cancel = true;
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +		break;
>  	}
>  
>  	mutex_unlock(&imgld->lock);
> @@ -374,6 +408,9 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
>  		goto unregister;
>  	}
>  
> +	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
> +		imgld->request_cancel = true;
> +

Why we cancel the programing rather than waiting for programing done?

Thanks,
Yilun

>  	mutex_unlock(&imgld->lock);
>  	wait_for_completion(&imgld->update_done);
>  
> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> index 68f3105b51d2..4e51b9fd1724 100644
> --- a/include/linux/fpga/fpga-image-load.h
> +++ b/include/linux/fpga/fpga-image-load.h
> @@ -52,6 +52,7 @@ struct fpga_image_load {
>  	enum fpga_image_prog progress;
>  	enum fpga_image_prog err_progress;	/* progress at time of failure */
>  	enum fpga_image_err err_code;		/* image load error code */
> +	bool request_cancel;
>  	bool driver_unload;
>  	struct eventfd_ctx *finished;
>  	void *priv;
> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> index 6a995bcc0fb7..8d0dfa1f9b77 100644
> --- a/include/uapi/linux/fpga-image-load.h
> +++ b/include/uapi/linux/fpga-image-load.h
> @@ -39,6 +39,7 @@ enum fpga_image_err {
>  
>  #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>  #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
> +#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
>  
>  /**
>   * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
> -- 
> 2.25.1
