Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4533F84F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhHZKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241085AbhHZKBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:01:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAADF60FDA;
        Thu, 26 Aug 2021 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629972068;
        bh=aBkNesMqvbH7PzlPklFkGTRo82VXoOZrWukyGg5zmgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0TZIGZ6ilntOAA5Vy+88jsU2oXA4xJa+hAZtzNtj08DKsb39Yj8kyw/ZXdSdCUBWK
         5YuBrPb+Q8mXpsIfk/6G+BuvewMhUVIHhLvKmSjO3r/6e8jd0zD8n46+Lrd1zV+5qw
         nCowxPqAHqV5Npi85sjUfToxptVMdt1mWTa3HdaA=
Date:   Thu, 26 Aug 2021 12:01:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Woody Lin <woodylin@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] ANDROID: staging: add userpanic-dev driver
Message-ID: <YSdmX956TESnJDey@kroah.com>
References: <20210826092854.58694-1-woodylin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826092854.58694-1-woodylin@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> Add char device driver 'userpanic-dev' that exposes an interface to
> userspace processes to request a system panic with customized panic
> message.

Some comments on the code now:

>  obj-$(CONFIG_ASHMEM)			+= ashmem.o
> +obj-$(CONFIG_USERPANIC_CHARDEV)	+= userpanic-dev.o

Why CHARDEV?

> diff --git a/drivers/staging/android/userpanic-dev.c b/drivers/staging/android/userpanic-dev.c
> new file mode 100644
> index 000000000000..b9a0f0c01826
> --- /dev/null
> +++ b/drivers/staging/android/userpanic-dev.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* userpanic-dev.c
> + *
> + * User-panic Device Interface
> + *
> + * Copyright 2021 Google LLC
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__

Why is this needed?

> +
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/miscdevice.h>
> +
> +struct userpanic_crash_info {
> +	void __user *title_uaddr;
> +	void __user *msg_uaddr;
> +};

If this is a user/kernel api, it can not be burried in a .c file,
otherwise it will be wrong over time.

And this is NOT how to handle user/kernel pointers at all, please fix.

> +
> +#define CRASH_INFO		(_IOW('U', 179, struct userpanic_crash_info))

Why does this have to be an ioctl at all?

Why do you have to have a char device for this?

> +
> +static int do_userpanic(const char *title, const char *msg)
> +{
> +	const size_t msgbuf_sz = PAGE_SIZE;
> +	char *msgbuf;
> +
> +	msgbuf = kmalloc(msgbuf_sz, GFP_KERNEL);
> +	if (!msgbuf)
> +		return -ENOMEM;
> +
> +	pr_emerg("User process '%.*s' %d requesting kernel panic\n",
> +		 sizeof(current->comm), current->comm, current->pid);

You have a pointer to a struct device, always use it for this and all
other messages, it should be dev_*(), right?


> +	if (msg)
> +		pr_emerg("   with message: %s\n", msg);

Multi line messages?  Why?

> +
> +	/* Request panic with customized panic title. */
> +	snprintf(msgbuf, msgbuf_sz, "U: %s: %s", current->comm, title);
> +	panic(msgbuf);
> +	kfree(msgbuf);

Nice, you cleaned up after panicing?  Why?

> +	return -EFAULT;
> +}
> +
> +static long userpanic_device_ioctl(struct file *file, u_int cmd, u_long arg)
> +{
> +	struct userpanic_crash_info crash_info;
> +	char *title;
> +	char *msg = NULL;
> +	int ret;
> +
> +	switch (cmd) {
> +	case CRASH_INFO:
> +		if (copy_from_user(&crash_info, (void __user *)arg, sizeof(crash_info)))
> +			return -EFAULT;
> +
> +		if (!crash_info.title_uaddr)
> +			return -EINVAL;
> +
> +		title = strndup_user(crash_info.title_uaddr, PAGE_SIZE);

What if the string was bigger?

> +		if (IS_ERR(title)) {
> +			pr_err("failed to strndup .title_uaddr: %d\n", PTR_ERR(title));
> +			return -EINVAL;
> +		}
> +
> +		if (crash_info.msg_uaddr) {
> +			msg = strndup_user(crash_info.msg_uaddr, PAGE_SIZE);
> +			if (IS_ERR(msg)) {
> +				kfree(title);
> +				pr_err("failed to strndup .msg_uaddr: %d\n", PTR_ERR(msg));
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ret = do_userpanic(title, msg);
> +		kfree(msg);
> +		kfree(title);
> +		return ret;

This can never be hit, right?

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct file_operations userpanic_device_fops = {
> +	.owner          = THIS_MODULE,
> +	.unlocked_ioctl = userpanic_device_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,

No need for the compat ioctl, do it right the first time.

> +};
> +
> +static struct miscdevice userpanic_device = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name  = "userspace_panic",
> +	.fops  = &userpanic_device_fops,
> +};
> +
> +static int __init userspace_panic_dev_init(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&userpanic_device);
> +	if (ret)
> +		pr_err("misc_register failed for userspace_panic device\n");
> +
> +	return ret;
> +}

Use the correct misc macro here, no need for an init or exit function.
Wait, where is your exit function?

> +device_initcall(userspace_panic_dev_init);

Why this init call level?  Why not the normal one?

thanks,

greg k-h
