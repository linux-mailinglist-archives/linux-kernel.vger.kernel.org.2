Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DF3824F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhEQHEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhEQHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:04:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C6C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:02:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n25so5544894edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj7/eeVK8Edah3JiRyTpzLjFLHpF71QxTSpD3NHSET4=;
        b=cILk+c51J+yBb9a2fGrHCgUck205+8zEeJKqZmdODDzcFs4AKqeWKJXrZheTCiw7OF
         7CLNObPf1FoEifjj8+JKueb6ReLuvsP+WkXb08TPXynd9ovdJZkizlCJ0M4OWD91qN/C
         hAOjkk2N7BbFbPw4cTnGOt0Yr4fWVnYy3lb+5GNfZ2kAZu1Ut0CQDSSCtazMZSY9Xxt/
         Msh66sUzpSYfHvS205c8jR2UYRhUUYwbuzAcF4fmApfyvM+gS3RSf1pMfU9zfWzTUn5u
         KCZF+3jo6mgOeRHGlDon2Q6kl8ZVERwCNQQVtxyyER6yVwDyU+UADJNOw3YGLXBmgmQ6
         Ne3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj7/eeVK8Edah3JiRyTpzLjFLHpF71QxTSpD3NHSET4=;
        b=JUJxv9av4DXLPURDfWI0455ia03SljPjPECU4h5WWI8OHvbTFmPiHFh2+1T7fYq/a8
         BZfRbDNts2p4lykhCmz4luiMxodE5Mk1K4S3N2GZJy2ujFShh+ZgnRPLbzpDtpPvGWO6
         iUoqrDdYz3lFll1vHF0qMpSN4QQNxO+HjC6XstUWxU9wcxuAKl83iGu60TxICcKhDcJR
         laNE/cQya683lmui2cm+M3NYR108ACa758VK8e62jNW1TXgWLdMUEEQ5JLytrSJQOzZl
         /uMU1z3jqTjVEFJy08Ig3uFzoyU0h5V5s2PbAEyUZMmmWQZ3mwE2Vo/QMW//2i75aS3h
         JqYA==
X-Gm-Message-State: AOAM532BBRylqjRqdKZ7b/dKwG/w/JH/JDmjctrNxiPSkOEUBkvavB6V
        j/SqkWC9abhKmuhJP/kJRIpIESos2Tv5NkxZ47c=
X-Google-Smtp-Source: ABdhPJx7+ELSz0Pncidn9AbQMJfY5M/wxo/Y8QTizZwgYfnstP5XP4wAvZ/vn1VMMqGix74zX7goj3BM3TO3/7Nvh2E=
X-Received: by 2002:a05:6402:752:: with SMTP id p18mr70989517edy.127.1621234967348;
 Mon, 17 May 2021 00:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210513085725.45528-1-guy.zadicario@intel.com> <20210513085725.45528-7-guy.zadicario@intel.com>
In-Reply-To: <20210513085725.45528-7-guy.zadicario@intel.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 17 May 2021 17:02:36 +1000
Message-ID: <CAPM=9twyrFt6FNfw1jZUoGB8sDd=fW2QbP9jT0w-xYtMngBfZg@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] misc: nnpi: Allow usermode to manage host resources
To:     Guy Zadicario <guy.zadicario@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        alexander.shishkin@linux.intel.com, andriy.shevchenko@intel.com,
        yochai.shefi-simchon@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 19:55, Guy Zadicario <guy.zadicario@intel.com> wrote:
>
> Provide an IOCTL interface for creating and destroying host memory
> resources through a character device (/dev/nnpi_host).
>
> There is a single instance of this character device in the system
> regardless of the number of NNP-I devices attached because it
> controls host resources which may be shared between different devices.
>
> A nnp_user object, created when an application opens this character
> device, identifies the user (client) of the driver and holds a list of
> all host resources allocated by that user through the opened file
> descriptor.
>
> Host memory resources created through this character device can be mapped
> to device access through IOCTLs made to a different, per-device, chardev
> (will be introduced on next commits).
>
> All resources will be destroyed when the application closes the connection
> or exits.
>
> The IOCTL interface is defined in: include/uapi/misc/intel_nnpi.h
>
> Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
> Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  MAINTAINERS                            |   1 +
>  drivers/misc/intel-nnpi/Makefile       |   2 +-
>  drivers/misc/intel-nnpi/device.c       |  14 ++
>  drivers/misc/intel-nnpi/host_chardev.c | 346 +++++++++++++++++++++++++++++++++
>  drivers/misc/intel-nnpi/host_chardev.h |  12 ++
>  drivers/misc/intel-nnpi/nnp_user.c     | 131 +++++++++++++
>  drivers/misc/intel-nnpi/nnp_user.h     |  79 ++++++++
>  include/uapi/misc/intel_nnpi.h         | 150 ++++++++++++++
>  8 files changed, 734 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/intel-nnpi/host_chardev.c
>  create mode 100644 drivers/misc/intel-nnpi/host_chardev.h
>  create mode 100644 drivers/misc/intel-nnpi/nnp_user.c
>  create mode 100644 drivers/misc/intel-nnpi/nnp_user.h
>  create mode 100644 include/uapi/misc/intel_nnpi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff0c3d7..42f3e54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9320,6 +9320,7 @@ INTEL NNP-I PCI DRIVER
>  M:     Guy Zadicario <guy.zadicario@intel.com>
>  S:     Supported
>  F:     drivers/misc/intel-nnpi/
> +F:     include/uapi/misc/intel_nnpi.h
>
>  INTEL P-Unit IPC DRIVER
>  M:     Zha Qipeng <qipeng.zha@intel.com>
> diff --git a/drivers/misc/intel-nnpi/Makefile b/drivers/misc/intel-nnpi/Makefile
> index 3713d51..da2863b 100644
> --- a/drivers/misc/intel-nnpi/Makefile
> +++ b/drivers/misc/intel-nnpi/Makefile
> @@ -5,7 +5,7 @@
>
>  obj-$(CONFIG_INTEL_NNPI) := intel_nnpi.o intel_nnpi_pcie.o
>
> -intel_nnpi-y := device.o msg_scheduler.o hostres.o
> +intel_nnpi-y := device.o msg_scheduler.o hostres.o host_chardev.o nnp_user.o
>
>  intel_nnpi_pcie-y := nnp_pcie.o
>
> diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
> index 60c5a94..0f98398 100644
> --- a/drivers/misc/intel-nnpi/device.c
> +++ b/drivers/misc/intel-nnpi/device.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>
>  #include "device.h"
> +#include "host_chardev.h"
>  #include "msg_scheduler.h"
>
>  static DEFINE_IDA(dev_ida);
> @@ -99,6 +100,19 @@ void nnpdev_destroy(struct nnp_device *nnpdev)
>  }
>  EXPORT_SYMBOL(nnpdev_destroy);
>
> +static int __init nnp_init(void)
> +{
> +       return nnp_init_host_interface();
> +}
> +subsys_initcall(nnp_init);
> +
> +static void __exit nnp_cleanup(void)
> +{
> +       nnp_release_host_interface();
> +       /* dev_ida is already empty here - no point calling ida_destroy */
> +}
> +module_exit(nnp_cleanup);
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Intel(R) NNPI Framework");
>  MODULE_AUTHOR("Intel Corporation");
> diff --git a/drivers/misc/intel-nnpi/host_chardev.c b/drivers/misc/intel-nnpi/host_chardev.c
> new file mode 100644
> index 0000000..6048fda
> --- /dev/null
> +++ b/drivers/misc/intel-nnpi/host_chardev.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2019-2021 Intel Corporation */
> +
> +#define pr_fmt(fmt)   KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/hashtable.h>
> +#include <linux/idr.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <uapi/misc/intel_nnpi.h>
> +
> +#include "device.h"
> +#include "host_chardev.h"
> +#include "ipc_protocol.h"
> +#include "nnp_user.h"
> +
> +static struct cdev cdev;
> +static dev_t       devnum;
> +static struct class *class;
> +static struct device *dev;
> +
> +static inline int is_host_file(struct file *f);
> +
> +static enum dma_data_direction to_dma_dir(unsigned int nnp_dir)
> +{
> +       /* Ignore IOCTL_INF_RES_NETWORK */
> +       switch (nnp_dir & (IOCTL_INF_RES_INPUT | IOCTL_INF_RES_OUTPUT)) {
> +       case (IOCTL_INF_RES_INPUT | IOCTL_INF_RES_OUTPUT):
> +               return DMA_BIDIRECTIONAL;
> +       case IOCTL_INF_RES_INPUT:
> +               return DMA_TO_DEVICE;
> +       case IOCTL_INF_RES_OUTPUT:
> +               return DMA_FROM_DEVICE;
> +       default:
> +               break;
> +       }
> +
> +       return DMA_NONE;
> +}
> +
> +static long create_hostres(struct nnp_user_info *user_info, void __user *arg,
> +                          unsigned int size)
> +{
> +       int ret;
> +       struct nnpdrv_ioctl_create_hostres req;
> +       struct host_resource *hostres;
> +       struct user_hostres *user_hostres_entry;
> +       void __user *uptr;
> +       unsigned int io_size = sizeof(req);
> +
> +       if (size != io_size)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&req, arg, io_size))
> +               return -EFAULT;
> +
> +       if (req.usage_flags & ~IOCTL_RES_USAGE_VALID_MASK)
> +               return -EINVAL;
> +
> +       uptr = u64_to_user_ptr(req.user_ptr);
> +       hostres = nnp_hostres_from_usermem(uptr, req.size,
> +                                          to_dma_dir(req.usage_flags));
> +
> +       if (IS_ERR(hostres))
> +               return PTR_ERR(hostres);
> +
> +       ret = nnp_user_add_hostres(user_info, hostres, &user_hostres_entry);
> +       if (ret < 0) {
> +               nnp_hostres_put(hostres);
> +               return ret;
> +       }
> +
> +       req.size = nnp_hostres_size(hostres);
> +
> +       /*
> +        * The created user_hostres_entry holds refcount to the resource,
> +        * no need to keep another one here.
> +        */
> +       nnp_hostres_put(hostres);
> +
> +       req.user_handle = user_hostres_entry->user_handle;
> +       if (copy_to_user(arg, &req, io_size)) {
> +               ret = -EFAULT;
> +               goto destroy_hostres_entry;
> +       }
> +
> +       return 0;
> +
> +destroy_hostres_entry:
> +       nnp_user_remove_hostres(user_hostres_entry);
> +
> +       return ret;
> +}
> +
> +static long destroy_hostres(struct nnp_user_info *user_info, void __user *arg,
> +                           unsigned int size)
> +{
> +       struct nnpdrv_ioctl_destroy_hostres destroy_args;
> +       struct user_hostres *user_hostres_entry;
> +       unsigned int io_size = sizeof(destroy_args);
> +       int ret = 0;
> +
> +       if (size != io_size)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&destroy_args, arg, io_size))
> +               return -EFAULT;
> +
> +       /* errno must be cleared on entry */
> +       if (destroy_args.o_errno)
> +               return -EINVAL;
> +
> +       mutex_lock(&user_info->mutex);
> +       user_hostres_entry = idr_find(&user_info->idr, destroy_args.user_handle);
> +       if (user_hostres_entry) {
> +               nnp_user_remove_hostres_locked(user_hostres_entry);
> +       } else {
> +               destroy_args.o_errno = NNPER_NO_SUCH_RESOURCE;
> +               if (copy_to_user(arg, &destroy_args, io_size))
> +                       ret = -EFAULT;
> +       }
> +
> +       mutex_unlock(&user_info->mutex);
> +       return ret;
> +}
> +
> +static long lock_hostres(struct nnp_user_info *user_info, void __user *arg,
> +                        unsigned int size)
> +{
> +       int ret = 0;
> +       struct nnpdrv_ioctl_lock_hostres lock_args;
> +       struct user_hostres *user_hostres_entry;
> +       unsigned int io_size = sizeof(lock_args);
> +
> +       if (size != io_size)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&lock_args, arg, io_size))
> +               return -EFAULT;
> +
> +       /* errno must be cleared on entry */
> +       if (lock_args.o_errno)
> +               return -EINVAL;
> +
> +       mutex_lock(&user_info->mutex);
> +       user_hostres_entry = idr_find(&user_info->idr, lock_args.user_handle);
> +       if (user_hostres_entry) {
> +               ret = nnp_hostres_user_lock(user_hostres_entry->hostres);
> +       } else {
> +               lock_args.o_errno = NNPER_NO_SUCH_RESOURCE;
> +               if (copy_to_user(arg, &lock_args, io_size))
> +                       ret = -EFAULT;
> +       }
> +
> +       mutex_unlock(&user_info->mutex);
> +       return ret;
> +}
> +
> +static long unlock_hostres(struct nnp_user_info *user_info, void __user *arg,
> +                          unsigned int size)
> +{
> +       int ret = 0;
> +       struct user_hostres *user_hostres_entry;
> +       struct nnpdrv_ioctl_lock_hostres lock_args;
> +       unsigned int io_size = sizeof(lock_args);
> +
> +       if (size != io_size)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&lock_args, arg, io_size))
> +               return -EFAULT;
> +
> +       /* errno must be cleared on entry */
> +       if (lock_args.o_errno)
> +               return -EINVAL;
> +
> +       mutex_lock(&user_info->mutex);
> +       user_hostres_entry = idr_find(&user_info->idr, lock_args.user_handle);
> +       if (user_hostres_entry) {
> +               ret = nnp_hostres_user_unlock(user_hostres_entry->hostres);
> +       } else {
> +               lock_args.o_errno = NNPER_NO_SUCH_RESOURCE;
> +               if (copy_to_user(arg, &lock_args, sizeof(lock_args)))
> +                       ret = -EFAULT;
> +       }
> +
> +       mutex_unlock(&user_info->mutex);
> +       return ret;
> +}
> +
> +struct file *nnp_host_file_get(int host_fd)
> +{
> +       struct file *host_file;
> +
> +       host_file = fget(host_fd);
> +       if (is_host_file(host_file))
> +               return host_file;
> +
> +       if (host_file)
> +               fput(host_file);
> +
> +       return NULL;
> +}
> +
> +/*
> + * Inference host cdev (/dev/nnpi_host) file operation functions
> + */
> +
> +static int host_open(struct inode *inode, struct file *f)
> +{
> +       struct nnp_user_info *user_info;
> +
> +       if (!is_host_file(f))
> +               return -EINVAL;
> +
> +       user_info = kzalloc(sizeof(*user_info), GFP_KERNEL);
> +       if (!user_info)
> +               return -ENOMEM;
> +
> +       nnp_user_init(user_info);
> +
> +       f->private_data = user_info;
> +
> +       return 0;
> +}
> +
> +static int host_release(struct inode *inode, struct file *f)
> +{
> +       struct nnp_user_info *user_info;
> +
> +       if (!is_host_file(f))
> +               return -EINVAL;
> +
> +       user_info = f->private_data;
> +
> +       nnp_user_destroy_all(user_info);
> +       f->private_data = NULL;
> +
> +       return 0;
> +}
> +
> +static long host_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +       long ret = 0;
> +       struct nnp_user_info *user_info = f->private_data;
> +       unsigned int ioc_nr, size;
> +
> +       if (!is_host_file(f))
> +               return -ENOTTY;
> +
> +       if (_IOC_TYPE(cmd) != 'h')
> +               return -EINVAL;
> +
> +       ioc_nr = _IOC_NR(cmd);
> +       size = _IOC_SIZE(cmd);
> +
> +       switch (ioc_nr) {
> +       case _IOC_NR(IOCTL_INF_CREATE_HOST_RESOURCE):
> +               ret = create_hostres(user_info, (void __user *)arg, size);
> +               break;
> +       case _IOC_NR(IOCTL_INF_DESTROY_HOST_RESOURCE):
> +               ret = destroy_hostres(user_info, (void __user *)arg, size);
> +               break;
> +       case _IOC_NR(IOCTL_INF_UNLOCK_HOST_RESOURCE):
> +               ret = unlock_hostres(user_info, (void __user *)arg, size);
> +               break;
> +       case _IOC_NR(IOCTL_INF_LOCK_HOST_RESOURCE):
> +               ret = lock_hostres(user_info, (void __user *)arg, size);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct file_operations host_fops = {
> +       .owner = THIS_MODULE,
> +       .open = host_open,
> +       .release = host_release,
> +       .unlocked_ioctl = host_ioctl,
> +       .compat_ioctl = host_ioctl,
> +};
> +
> +static inline int is_host_file(struct file *f)
> +{
> +       return f && f->f_op == &host_fops;
> +}
> +
> +int nnp_init_host_interface(void)
> +{
> +       int ret;
> +
> +       ret = alloc_chrdev_region(&devnum, 0, 1, NNPDRV_INF_HOST_DEV_NAME);
> +       if (ret < 0)
> +               return ret;
> +
> +       cdev_init(&cdev, &host_fops);
> +       cdev.owner = THIS_MODULE;
> +
> +       ret = cdev_add(&cdev, devnum, 1);
> +       if (ret < 0)
> +               goto err_region;
> +
> +       class = class_create(THIS_MODULE, NNPDRV_INF_HOST_DEV_NAME);
> +       if (IS_ERR(class)) {
> +               ret = PTR_ERR(class);
> +               goto err_cdev;
> +       }
> +
> +       dev = device_create(class, NULL, devnum, NULL, NNPDRV_INF_HOST_DEV_NAME);
> +       if (IS_ERR(dev)) {
> +               ret = PTR_ERR(dev);
> +               goto err_class;
> +       }
> +
> +       ret = nnp_hostres_init_sysfs(dev);
> +       if (ret < 0)
> +               goto err_device;
> +
> +       return 0;
> +
> +err_device:
> +       device_destroy(class, devnum);
> +err_class:
> +       class_destroy(class);
> +err_cdev:
> +       cdev_del(&cdev);
> +err_region:
> +       unregister_chrdev_region(devnum, 1);
> +
> +       return ret;
> +}
> +
> +void nnp_release_host_interface(void)
> +{
> +       nnp_hostres_fini_sysfs(dev);
> +       device_destroy(class, devnum);
> +       class_destroy(class);
> +       cdev_del(&cdev);
> +       unregister_chrdev_region(devnum, 1);
> +}
> diff --git a/drivers/misc/intel-nnpi/host_chardev.h b/drivers/misc/intel-nnpi/host_chardev.h
> new file mode 100644
> index 0000000..5812e0f
> --- /dev/null
> +++ b/drivers/misc/intel-nnpi/host_chardev.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2019-2021 Intel Corporation */
> +
> +#ifndef _NNPDRV_INFERENCE_H
> +#define _NNPDRV_INFERENCE_H
> +
> +int nnp_init_host_interface(void);
> +void nnp_release_host_interface(void);
> +
> +struct file *nnp_host_file_get(int host_fd);
> +
> +#endif
> diff --git a/drivers/misc/intel-nnpi/nnp_user.c b/drivers/misc/intel-nnpi/nnp_user.c
> new file mode 100644
> index 0000000..51d7418
> --- /dev/null
> +++ b/drivers/misc/intel-nnpi/nnp_user.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2019-2021 Intel Corporation */
> +
> +#include <linux/slab.h>
> +
> +#include "nnp_user.h"
> +
> +void nnp_user_init(struct nnp_user_info *user_info)
> +{
> +       INIT_LIST_HEAD(&user_info->hostres_list);
> +       mutex_init(&user_info->mutex);
> +       kref_init(&user_info->ref);
> +       idr_init(&user_info->idr);
> +}
> +
> +void nnp_user_get(struct nnp_user_info *user_info)
> +{
> +       kref_get(&user_info->ref);
> +}
> +
> +static void nnp_user_release(struct kref *kref)
> +{
> +       struct nnp_user_info *user_info =
> +               container_of(kref, struct nnp_user_info, ref);
> +       struct completion *completion = user_info->close_completion;
> +
> +       idr_destroy(&user_info->idr);
> +       kfree(user_info);
> +       complete(completion);
> +}
> +
> +void nnp_user_put(struct nnp_user_info *user_info)
> +{
> +       kref_put(&user_info->ref, nnp_user_release);
> +}
> +
> +int nnp_user_add_hostres(struct nnp_user_info *user_info,
> +                        struct host_resource *hostres,
> +                        struct user_hostres **user_hostres_entry)
> +{
> +       struct user_hostres *hr_entry;
> +       int id;
> +
> +       hr_entry = kmalloc(sizeof(*hr_entry), GFP_KERNEL);
> +       if (!hr_entry)
> +               return -ENOMEM;
> +
> +       /*
> +        * Increment refcount to hostres for the entry reference.
> +        * (caller holds reference to it, so we know it exist).
> +        */
> +       nnp_hostres_get(hostres);
> +       hr_entry->hostres = hostres;
> +
> +       /*
> +        * We are called from ioctl of file that own this user_info,
> +        * So it safe to assume it exist.
> +        */
> +       nnp_user_get(user_info);
> +       hr_entry->user_info = user_info;
> +
> +       mutex_lock(&user_info->mutex);
> +       /*
> +        * We allocate handle starting from 1 and not 0 to allow
> +        * user-space treat zero as invalid handle
> +        */
> +       id = idr_alloc(&user_info->idr, hr_entry, 1, -1, GFP_KERNEL);
> +       if (id < 0) {
> +               nnp_user_put(user_info);
> +               nnp_hostres_put(hostres);
> +               kfree(hr_entry);
> +               mutex_unlock(&user_info->mutex);
> +               return -ENOSPC;
> +       }
> +       hr_entry->user_handle = id;
> +       list_add(&hr_entry->node, &user_info->hostres_list);
> +       mutex_unlock(&user_info->mutex);
> +
> +       *user_hostres_entry = hr_entry;
> +
> +       return 0;
> +}
> +
> +void nnp_user_remove_hostres_locked(struct user_hostres *hr_entry)
> +{
> +       struct nnp_user_info *user_info = hr_entry->user_info;
> +
> +       idr_remove(&user_info->idr, hr_entry->user_handle);
> +       list_del(&hr_entry->node);
> +
> +       nnp_hostres_put(hr_entry->hostres);
> +
> +       kfree(hr_entry);
> +       nnp_user_put(user_info);
> +}
> +
> +void nnp_user_remove_hostres(struct user_hostres *hr_entry)
> +{
> +       struct nnp_user_info *user_info = hr_entry->user_info;
> +
> +       mutex_lock(&user_info->mutex);
> +       nnp_user_remove_hostres_locked(hr_entry);
> +       mutex_unlock(&user_info->mutex);
> +}
> +
> +void nnp_user_destroy_all(struct nnp_user_info *user_info)
> +{
> +       struct user_hostres *user_hostres_entry;
> +       DECLARE_COMPLETION_ONSTACK(completion);
> +
> +       mutex_lock(&user_info->mutex);
> +
> +       /* destroy all hostreses owned by the "user" */
> +       while (!list_empty(&user_info->hostres_list)) {
> +               user_hostres_entry = list_first_entry(&user_info->hostres_list,
> +                                                     struct user_hostres, node);
> +               /*
> +                * We can safely destroy this object without checking
> +                * its refcount since we get here only after the host char-dev
> +                * as well as all cmd_chan char-devs that may hold temporary
> +                * reference to this object are already released.
> +                */
> +               nnp_user_remove_hostres_locked(user_hostres_entry);
> +       }
> +       mutex_unlock(&user_info->mutex);
> +
> +       /* wait for all channels and hostreses to be destroyed */
> +       user_info->close_completion = &completion;
> +       nnp_user_put(user_info);
> +       wait_for_completion(&completion);
> +}
> diff --git a/drivers/misc/intel-nnpi/nnp_user.h b/drivers/misc/intel-nnpi/nnp_user.h
> new file mode 100644
> index 0000000..429ac13
> --- /dev/null
> +++ b/drivers/misc/intel-nnpi/nnp_user.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2019-2021 Intel Corporation */
> +
> +#ifndef _NNPDRV_INF_PROC_H
> +#define _NNPDRV_INF_PROC_H
> +
> +#include <linux/kref.h>
> +#include <linux/types.h>
> +
> +#include "hostres.h"
> +
> +/**
> + * struct nnp_user_info - structure for per-user info
> + * @ref: refcount to this "user" object
> + * @hostres_list: list of host resources
> + * @close_completion: used to wait for all channels of this user to be
> + *                    destroyed before closing the user.
> + * @mutex: protects hostres_list and idr modifications
> + * @idr: used to generate user handles to created host resources
> + * @user_list_node: list node to attach this struct in "list of users".
> + *
> + * structure to hold per-user info,
> + * a "user" is created for each open made to the host char dev (/dev/nnpi_host).
> + * It holds a list of all host resources created through requests from
> + * the same client ("user").
> + * device communication "channels", created by device char dev (/dev/nnpi%d)
> + * must be correlated with a "user" object which is supplied from user-space
> + * by the opened file descriptor to /dev/nnpi_host. Such "channel" may access
> + * only host resources created by the same "user".
> + * The lifetime of this object last at least for the duration of the host char
> + * device file struct but can last longer if some channel objects still hold
> + * a reference to it (this is why @ref is needed).
> + */
> +struct nnp_user_info {
> +       struct kref         ref;
> +       struct list_head    hostres_list;
> +       struct completion   *close_completion;
> +       struct mutex        mutex;
> +       struct idr          idr;
> +       struct list_head    user_list_node;
> +};
> +
> +/**
> + * struct user_hostres - structure for host resource created by user
> + * @node: list node to attach this struct to nnp_user_info::hostres_list
> + * @hostres: the actual host resource object
> + * @user_handle: handle allocated from idr object, used as handle to this
> + *               object in ioctl ABI.
> + * @user_info: pointer to "user" which created this resource.
> + *             it is used only during destruction of the object.
> + *
> + * structure for a host resource object which created through host char dev
> + * request. The lifetime of this structure ends when the user request to
> + * destroy it through ioctl call. The underlying @hostres may still continue
> + * to exist if command channel (cmd_chan) objects has mapped the resource to
> + * device access.
> + */
> +struct user_hostres {
> +       struct list_head             node;
> +       struct host_resource         *hostres;
> +       int                          user_handle;
> +       struct nnp_user_info         *user_info;
> +};
> +
> +void nnp_user_init(struct nnp_user_info *user_info);
> +
> +void nnp_user_get(struct nnp_user_info *user_info);
> +void nnp_user_put(struct nnp_user_info *user_info);
> +
> +int nnp_user_add_hostres(struct nnp_user_info *user_info,
> +                        struct host_resource *hostres,
> +                        struct user_hostres **user_hostres_entry);
> +
> +void nnp_user_remove_hostres(struct user_hostres *hr_entry);
> +void nnp_user_remove_hostres_locked(struct user_hostres *hr_entry);
> +
> +void nnp_user_destroy_all(struct nnp_user_info *user_info);
> +
> +#endif
> diff --git a/include/uapi/misc/intel_nnpi.h b/include/uapi/misc/intel_nnpi.h
> new file mode 100644
> index 0000000..5114aea
> --- /dev/null
> +++ b/include/uapi/misc/intel_nnpi.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/* Copyright (C) 2019-2021 Intel Corporation */
> +
> +#ifndef _NNP_UAPI_H
> +#define _NNP_UAPI_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +#include <stdbool.h>
> +
> +#define NNPDRV_INF_HOST_DEV_NAME "nnpi_host"
> +
> +/*
> + * ioctls for /dev/nnpi_host device
> + */
> +
> +/*
> + * IOCTL_INF_CREATE_HOST_RESOURCE:
> + *
> + * A request to create a host memory resource object that can then be mapped
> + * and accessed by the NNP-I device's DMA engine.
> + * The created host resource is pinned in memory for its entire lifecycle.

Drive-by comments, but who has access to this interface? non-root?

How much memory can they pin with it?

Pinning is not a nice way to do things, you likely need some sort of
memory manager and fencing system.

Dave.
