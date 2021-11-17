Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54B454DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbhKQTaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbhKQTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:30:49 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:27:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so1470264ooj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tr0Sl1We5IvcoENvUfLIQu3/BdymZukFy5TE6p7PwYA=;
        b=m+b8O1umTXevatOFV8Xz60OssTYRI68WDK8ojk4jwkNsZqSsXa7FFr9HlKSp1j0ZiQ
         zZEwL66mANbBkNPv9pvQL79xT7ZOE8yXAyd/7lM6FTyd83K61Uf5VSoY2iIAZbdzPv+0
         LNYzUJeFiJ02XMXGUTW9sFmJ7yroJPj8b+2706QCy2Z3YzlI3XPZcm26PbsUKHZunS4c
         NzC1lGyOGUdmCjC5Zzuz6zmBzTRls9soRcU2HoOxmnxQyiS11UbdS+8DfNvONZY4QMHF
         deEpsyDc4L8EW8OlyS45j2KkGckneUg9iSqzNXX8dPmzaPTntDcae3v4SF7ekVjTdJcH
         ARFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tr0Sl1We5IvcoENvUfLIQu3/BdymZukFy5TE6p7PwYA=;
        b=E1piOFvbkqmUf/lCNFhLZXkeP78HfITxQFKmgqGvTR0fWO1mwUOPKFmFwbhxZvEpdh
         dFlWmrZc4ZksZ89/FwcGglioOzKyu9xyUl8swoW0ANktI2cLrJ8rgHxbx6mLZ8evY4qX
         xq1xvmBW8OaelePeBx1y4L0unGoI9K2n1fyOrBsdvj2FKxGQmIw88+c7MfW7rLolriO6
         UMZqRF8mqyvKJ5VKhwoq3x2uNIQ8Q9pN6t7TsO6aq0eMKNwbRvGDE7hhKjmMtNK+lqZy
         6JfTl0Wlggt5Bx6GHjKgZRUKw/pxk5d5orwZNSKJaW6PEWhKHJ813pHBIs1tpmxlLfSM
         kFFA==
X-Gm-Message-State: AOAM533ZOBMTAXB4v6bUSnovJGqcP7TRJeKX1pKiI0jgADFLBDqgRgDB
        7UV1Z63MaDBehXXpiakQY6CngA==
X-Google-Smtp-Source: ABdhPJz8U6RGsmGkZuubDSwd/7BmoSwTAPfqw/cPzwa/OvuCckFaAskTRph7fbsGdFgjF/6lYKkqgg==
X-Received: by 2002:a4a:6c0d:: with SMTP id q13mr9926243ooc.88.1637177269380;
        Wed, 17 Nov 2021 11:27:49 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s17sm149237otp.20.2021.11.17.11.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 11:27:48 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:29:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [RFC PATCH 2/5] firmware: upload: Enable firmware uploads
Message-ID: <YZVYIsZx3j9xx3jl@ripper>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <20211111011345.25049-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111011345.25049-3-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Nov 17:13 PST 2021, Russ Weight wrote:

> Extend the Firmware Upload framework to add a character device and provide
> IOCTL support (FW_UPLOAD_WRITE) for uploading a firmware file to a device.
> The IOCTL will return immediately, and the upload will begin in the context
> of a kernel worker thread.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../driver-api/firmware/firmware-upload.rst   |  21 ++
>  MAINTAINERS                                   |   1 +
>  drivers/firmware/firmware-upload.c            | 216 +++++++++++++++++-
>  include/linux/firmware/firmware-upload.h      |  27 +++
>  include/uapi/linux/firmware-upload.h          |  53 +++++
>  5 files changed, 317 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/firmware-upload.h
> 
> diff --git a/Documentation/driver-api/firmware/firmware-upload.rst b/Documentation/driver-api/firmware/firmware-upload.rst
> index 9f38f18be97a..8a7c50087028 100644
> --- a/Documentation/driver-api/firmware/firmware-upload.rst
> +++ b/Documentation/driver-api/firmware/firmware-upload.rst
> @@ -15,3 +15,24 @@ Firmware Upload class driver will interact with the target device to
>  transfer and authenticate the firmware data. Uploads are performed in the
>  context of a kernel worker thread in order to facilitate progress
>  indicators during lengthy uploads.
> +
> +User API
> +========
> +
> +open
> +----
> +
> +An fw_upload device is opened exclusively to control a firmware upload.
> +The device must remain open throughout the duration of the firmware upload.
> +An attempt to close the device while an upload is in progress will block
> +until the firmware upload is complete.
> +
> +ioctl
> +-----
> +
> +FW_UPLOAD_WRITE:
> +

The use of an ioctl here means that one need some userspace tool to
drive the firmware update.

Compare this with the CONFIG_FW_LOADER_USER_HELPER_FALLBACK model, which
you can easily operate from a limited environment (e.g. a busybox based
environment on an embedded device):

  echo 1 > loading
  cat /some/binary > data
  echo 0 > loading

Regards,
Bjorn

> +The FW_UPLOAD_WRITE IOCTL passes in the address of a data buffer and starts
> +the firmware upload. This IOCTL returns immediately after assigning the work
> +to a kernel worker thread. This is an exclusive operation; an attempt to
> +start concurrent firmware uploads for the same device will fail with EBUSY.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19b3d3ccc406..4d59e8e11813 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7422,6 +7422,7 @@ S:	Maintained
>  F:	Documentation/driver-api/firmware/firmware-upload.rst
>  F:	drivers/firmware/firmware-upload.c
>  F:	include/linux/firmware/firmware-upload.h
> +F:	include/uapi/linux/firmware-upload.h
>  
>  FLASH ADAPTER DRIVER (IBM Flash Adapter 900GB Full Height PCI Flash Card)
>  M:	Joshua Morris <josh.h.morris@us.ibm.com>
> diff --git a/drivers/firmware/firmware-upload.c b/drivers/firmware/firmware-upload.c
> index bc26df8b6b52..e930611262fb 100644
> --- a/drivers/firmware/firmware-upload.c
> +++ b/drivers/firmware/firmware-upload.c
> @@ -5,18 +5,189 @@
>   * Copyright (C) 2019-2021 Intel Corporation, Inc.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/firmware/firmware-upload.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/uaccess.h>
>  #include <linux/vmalloc.h>
>  
>  #define FW_UPLOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
>  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>  
>  static struct class *fw_upload_class;
> +static dev_t fw_upload_devt;
>  
>  #define to_fw_upload(d) container_of(d, struct fw_upload, dev)
>  
> +static void fw_upload_prog_complete(struct fw_upload *fwl)
> +{
> +	mutex_lock(&fwl->lock);
> +	fwl->progress = FW_UPLOAD_PROG_IDLE;
> +	mutex_unlock(&fwl->lock);
> +}
> +
> +static void fw_upload_do_load(struct work_struct *work)
> +{
> +	struct fw_upload *fwl;
> +	s32 ret, offset = 0;
> +
> +	fwl = container_of(work, struct fw_upload, work);
> +
> +	if (fwl->driver_unload) {
> +		fwl->err_code = FW_UPLOAD_ERR_CANCELED;
> +		goto idle_exit;
> +	}
> +
> +	get_device(&fwl->dev);
> +	if (!try_module_get(fwl->dev.parent->driver->owner)) {
> +		fwl->err_code = FW_UPLOAD_ERR_BUSY;
> +		goto putdev_exit;
> +	}
> +
> +	fwl->progress = FW_UPLOAD_PROG_PREPARING;
> +	ret = fwl->ops->prepare(fwl, fwl->data, fwl->remaining_size);
> +	if (ret) {
> +		fwl->err_code = ret;
> +		goto modput_exit;
> +	}
> +
> +	fwl->progress = FW_UPLOAD_PROG_WRITING;
> +	while (fwl->remaining_size) {
> +		ret = fwl->ops->write(fwl, fwl->data, offset,
> +					fwl->remaining_size);
> +		if (ret <= 0) {
> +			if (!ret) {
> +				dev_warn(&fwl->dev,
> +					 "write-op wrote zero data\n");
> +				ret = -FW_UPLOAD_ERR_RW_ERROR;
> +			}
> +			fwl->err_code = -ret;
> +			goto done;
> +		}
> +
> +		fwl->remaining_size -= ret;
> +		offset += ret;
> +	}
> +
> +	fwl->progress = FW_UPLOAD_PROG_PROGRAMMING;
> +	ret = fwl->ops->poll_complete(fwl);
> +	if (ret)
> +		fwl->err_code = ret;
> +
> +done:
> +	if (fwl->ops->cleanup)
> +		fwl->ops->cleanup(fwl);
> +
> +modput_exit:
> +	module_put(fwl->dev.parent->driver->owner);
> +
> +putdev_exit:
> +	put_device(&fwl->dev);
> +
> +idle_exit:
> +	/*
> +	 * Note: fwl->remaining_size is left unmodified here to provide
> +	 * additional information on errors. It will be reinitialized when
> +	 * the next firmeware upload begins.
> +	 */
> +	vfree(fwl->data);
> +	fwl->data = NULL;
> +	fw_upload_prog_complete(fwl);
> +}
> +
> +static int fw_upload_ioctl_write(struct fw_upload *fwl, unsigned long arg)
> +{
> +	struct fw_upload_write wb;
> +	unsigned long minsz;
> +	u8 *buf;
> +
> +	if (fwl->driver_unload || fwl->progress != FW_UPLOAD_PROG_IDLE)
> +		return -EBUSY;
> +
> +	minsz = offsetofend(struct fw_upload_write, buf);
> +	if (copy_from_user(&wb, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (wb.flags)
> +		return -EINVAL;
> +
> +	buf = vzalloc(wb.size);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
> +		vfree(buf);
> +		return -EFAULT;
> +	}
> +
> +	fwl->data = buf;
> +	fwl->remaining_size = wb.size;
> +	fwl->err_code = 0;
> +	fwl->progress = FW_UPLOAD_PROG_STARTING;
> +	queue_work(system_long_wq, &fwl->work);
> +
> +	return 0;
> +}
> +
> +static long fw_upload_ioctl(struct file *filp, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct fw_upload *fwl = filp->private_data;
> +	int ret = -ENOTTY;
> +
> +	switch (cmd) {
> +	case FW_UPLOAD_WRITE:
> +		mutex_lock(&fwl->lock);
> +		ret = fw_upload_ioctl_write(fwl, arg);
> +		mutex_unlock(&fwl->lock);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int fw_upload_open(struct inode *inode, struct file *filp)
> +{
> +	struct fw_upload *fwl = container_of(inode->i_cdev,
> +						     struct fw_upload, cdev);
> +
> +	if (atomic_cmpxchg(&fwl->opened, 0, 1))
> +		return -EBUSY;
> +
> +	filp->private_data = fwl;
> +
> +	return 0;
> +}
> +
> +static int fw_upload_release(struct inode *inode, struct file *filp)
> +{
> +	struct fw_upload *fwl = filp->private_data;
> +
> +	mutex_lock(&fwl->lock);
> +	if (fwl->progress == FW_UPLOAD_PROG_IDLE) {
> +		mutex_unlock(&fwl->lock);
> +		goto close_exit;
> +	}
> +
> +	mutex_unlock(&fwl->lock);
> +	flush_work(&fwl->work);
> +
> +close_exit:
> +	atomic_set(&fwl->opened, 0);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations fw_upload_fops = {
> +	.owner = THIS_MODULE,
> +	.open = fw_upload_open,
> +	.release = fw_upload_release,
> +	.unlocked_ioctl = fw_upload_ioctl,
> +};
> +
>  /**
>   * fw_upload_register - create and register a Firmware Upload Device
>   *
> @@ -35,6 +206,11 @@ fw_upload_register(struct device *parent, const struct fw_upload_ops *ops,
>  	struct fw_upload *fwl;
>  	int ret;
>  
> +	if (!ops || !ops->prepare || !ops->write || !ops->poll_complete) {
> +		dev_err(parent, "Attempt to register without all required ops\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	fwl = kzalloc(sizeof(*fwl), GFP_KERNEL);
>  	if (!fwl)
>  		return ERR_PTR(-ENOMEM);
> @@ -48,9 +224,13 @@ fw_upload_register(struct device *parent, const struct fw_upload_ops *ops,
>  
>  	fwl->priv = priv;
>  	fwl->ops = ops;
> +	fwl->err_code = 0;
> +	fwl->progress = FW_UPLOAD_PROG_IDLE;
> +	INIT_WORK(&fwl->work, fw_upload_do_load);
>  
>  	fwl->dev.class = fw_upload_class;
>  	fwl->dev.parent = parent;
> +	fwl->dev.devt = MKDEV(MAJOR(fw_upload_devt), fwl->dev.id);
>  
>  	ret = dev_set_name(&fwl->dev, "fw_upload%d", fwl->dev.id);
>  	if (ret) {
> @@ -65,6 +245,16 @@ fw_upload_register(struct device *parent, const struct fw_upload_ops *ops,
>  		return ERR_PTR(ret);
>  	}
>  
> +	cdev_init(&fwl->cdev, &fw_upload_fops);
> +	fwl->cdev.owner = parent->driver->owner;
> +	cdev_set_parent(&fwl->cdev, &fwl->dev.kobj);
> +
> +	ret = cdev_add(&fwl->cdev, fwl->dev.devt, 1);
> +	if (ret) {
> +		put_device(&fwl->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return fwl;
>  
>  error_device:
> @@ -83,10 +273,23 @@ EXPORT_SYMBOL_GPL(fw_upload_register);
>   * @fwl: pointer to struct fw_upload
>   *
>   * This function is intended for use in the parent driver's remove()
> - * function.
> + * function. The driver_unload flag prevents new updates from starting
> + * once the unregister process has begun.
>   */
>  void fw_upload_unregister(struct fw_upload *fwl)
>  {
> +	mutex_lock(&fwl->lock);
> +	fwl->driver_unload = true;
> +	if (fwl->progress == FW_UPLOAD_PROG_IDLE) {
> +		mutex_unlock(&fwl->lock);
> +		goto unregister;
> +	}
> +
> +	mutex_unlock(&fwl->lock);
> +	flush_work(&fwl->work);
> +
> +unregister:
> +	cdev_del(&fwl->cdev);
>  	device_unregister(&fwl->dev);
>  }
>  EXPORT_SYMBOL_GPL(fw_upload_unregister);
> @@ -101,19 +304,30 @@ static void fw_upload_dev_release(struct device *dev)
>  
>  static int __init fw_upload_class_init(void)
>  {
> +	int ret;
>  	pr_info("Firmware Upload Framework\n");
>  
>  	fw_upload_class = class_create(THIS_MODULE, "fw_upload");
>  	if (IS_ERR(fw_upload_class))
>  		return PTR_ERR(fw_upload_class);
>  
> +	ret = alloc_chrdev_region(&fw_upload_devt, 0, MINORMASK,
> +				  "fw_upload");
> +	if (ret)
> +		goto exit_destroy_class;
> +
>  	fw_upload_class->dev_release = fw_upload_dev_release;
>  
>  	return 0;
> +
> +exit_destroy_class:
> +	class_destroy(fw_upload_class);
> +	return ret;
>  }
>  
>  static void __exit fw_upload_class_exit(void)
>  {
> +	unregister_chrdev_region(fw_upload_devt, MINORMASK);
>  	class_destroy(fw_upload_class);
>  	WARN_ON(!xa_empty(&fw_upload_xa));
>  }
> diff --git a/include/linux/firmware/firmware-upload.h b/include/linux/firmware/firmware-upload.h
> index 767e0bdded7b..f80d5ba0c3f1 100644
> --- a/include/linux/firmware/firmware-upload.h
> +++ b/include/linux/firmware/firmware-upload.h
> @@ -7,22 +7,49 @@
>  #ifndef _LINUX_FIRMWARE_UPLOAD_H
>  #define _LINUX_FIRMWARE_UPLOAD_H
>  
> +#include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> +#include <uapi/linux/firmware-upload.h>
>  
>  struct fw_upload;
>  
>  /**
>   * struct fw_upload_ops - device specific operations
> + * @prepare:		    Required: Prepare secure update
> + * @write:		    Required: The write() op receives the remaining
> + *			    size to be written and must return the actual
> + *			    size written or a negative error code. The write()
> + *			    op will be called repeatedly until all data is
> + *			    written.
> + * @poll_complete:	    Required: Check for the completion of the
> + *			    HW authentication/programming process.
> + * @cleanup:		    Optional: Complements the prepare()
> + *			    function and is called at the completion
> + *			    of the update, whether success or failure,
> + *			    if the prepare function succeeded.
>   */
>  struct fw_upload_ops {
> +	u32 (*prepare)(struct fw_upload *fwl, const u8 *data, u32 size);
> +	s32 (*write)(struct fw_upload *fwl, const u8 *data,
> +		     u32 offset, u32 size);
> +	u32 (*poll_complete)(struct fw_upload *fwl);
> +	void (*cleanup)(struct fw_upload *fwl);
>  };
>  
>  struct fw_upload {
>  	struct device dev;
> +	struct cdev cdev;
>  	const struct fw_upload_ops *ops;
>  	struct mutex lock;		/* protect data structure contents */
> +	atomic_t opened;
> +	struct work_struct work;
> +	const u8 *data;			/* pointer to update data */
> +	u32 remaining_size;		/* size remaining to transfer */
> +	u32 progress;
> +	u32 err_code;			/* upload error code */
> +	bool driver_unload;
>  	void *priv;
>  };
>  
> diff --git a/include/uapi/linux/firmware-upload.h b/include/uapi/linux/firmware-upload.h
> new file mode 100644
> index 000000000000..034550071911
> --- /dev/null
> +++ b/include/uapi/linux/firmware-upload.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Header File for Firmware Upload User API
> + *
> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
> + *
> + */
> +
> +#ifndef _UAPI_LINUX_FW_UPLOAD__H
> +#define _UAPI_LINUX_FW_UPLOAD__H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define FW_UPLOAD_MAGIC 0xB9
> +
> +/* Firmware upload progress codes */
> +#define FW_UPLOAD_PROG_IDLE		0
> +#define FW_UPLOAD_PROG_STARTING	1
> +#define FW_UPLOAD_PROG_PREPARING	2
> +#define FW_UPLOAD_PROG_WRITING		3
> +#define FW_UPLOAD_PROG_PROGRAMMING	4
> +#define FW_UPLOAD_PROG_MAX		5
> +
> +/* Firmware upload error codes */
> +#define FW_UPLOAD_ERR_HW_ERROR		1
> +#define FW_UPLOAD_ERR_TIMEOUT		2
> +#define FW_UPLOAD_ERR_CANCELED		3
> +#define FW_UPLOAD_ERR_BUSY		4
> +#define FW_UPLOAD_ERR_INVALID_SIZE	5
> +#define FW_UPLOAD_ERR_RW_ERROR		6
> +#define FW_UPLOAD_ERR_WEAROUT		7
> +#define FW_UPLOAD_ERR_MAX		8
> +
> +/**
> + * FW_UPLOAD_WRITE - _IOW(FW_UPLOAD_MAGIC, 0,
> + *				struct fw_upload_write)
> + *
> + * Upload a data buffer to the target device. The user must provide the
> + * data buffer and size.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct fw_upload_write {
> +	/* Input */
> +	__u32 flags;		/* Zero for now */
> +	__u32 size;		/* Data size (in bytes) to be written */
> +	__u64 buf;		/* User space address of source data */
> +};
> +
> +#define FW_UPLOAD_WRITE	_IOW(FW_UPLOAD_MAGIC, 0, struct fw_upload_write)
> +
> +#endif /* _UAPI_LINUX_FW_UPLOAD_H */
> -- 
> 2.25.1
> 
