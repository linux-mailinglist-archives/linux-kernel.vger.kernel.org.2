Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8056033FF12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCRFtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhCRFte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A68664ED2;
        Thu, 18 Mar 2021 05:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616046573;
        bh=LJCEzNTa41MBK+Zj2vN8zhRmLwJsr/uH7GrLVUycx+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ye186GQZYQIAAtuIAKtMDUoQyjpu8+nWWwPfkfRUqRCwMjWjqeVbSnz9CWmP9wR7q
         lvioVbL+0JWswFC7qhqzUdKNT0IITceOxNDBAWf/smnVHYONX5It0RwgNvVui/R4vC
         WyRaW2M9pUSN+41+vSqLnAULqQEKUxi9YHr8xga4=
Date:   Thu, 18 Mar 2021 06:49:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH char-misc v1] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YFLp6n70JBXDYvxI@kroah.com>
References: <1616015674-4589-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616015674-4589-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:14:34PM -0400, min.li.xe@renesas.com wrote:
> +static int
> +rsmu_open(struct inode *iptr, struct file *fptr)
> +{
> +	struct rsmu_cdev *rsmu;
> +
> +	rsmu = container_of(iptr->i_cdev, struct rsmu_cdev, rsmu_cdev);
> +	if (!rsmu)
> +		return -EAGAIN;

This check will never happen, so why are you making it?

And what does -EAGIN mean in this case?

> +
> +	fptr->private_data = rsmu;
> +	return 0;
> +}
> +
> +static int
> +rsmu_release(struct inode *iptr, struct file *fptr)
> +{
> +	struct rsmu_cdev *rsmu;
> +
> +	rsmu = container_of(iptr->i_cdev, struct rsmu_cdev, rsmu_cdev);
> +	if (!rsmu)
> +		return -EAGAIN;

Same here, this is impossible to ever have happen.  Please look up how
container_of() works.


> +
> +	return 0;
> +}
> +
> +static long
> +rsmu_ioctl(struct file *fptr, unsigned int cmd, unsigned long data)
> +{
> +	struct rsmu_cdev *rsmu = fptr->private_data;
> +	void __user *arg = (void __user *)data;
> +	int err = 0;
> +
> +	if (!rsmu)
> +		return -EINVAL;

How can this happen?

Why all of these impossible checks?

And the build failures that the kernel test robot obviously need to be
fixed as well...

thanks,

greg k-h
