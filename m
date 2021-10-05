Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0742235B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhJEK3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEK3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C529610EA;
        Tue,  5 Oct 2021 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633429631;
        bh=f2XWKf2iAFj6A+NX/6JZz2MseITRKAzBcYBBcrKWIMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcFpHVUsocIb71TcBsvd4vA7ZMBcTMS36XsnH+C/YSaQ4ozoRfct2LpnBuZYSNtaT
         r2tf709bXF7/m9LaEYQigPsniPVAoCpRk7aDF5wmX0aQRevZQqvAaB8UWa81D1Mi2j
         1du8VTd0md0ucnmWyu3FNlKzdDMFZWY+uRMXv+QY=
Date:   Tue, 5 Oct 2021 12:27:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: dim2: fix device registration
Message-ID: <YVwofSvwGTv3kHjh@kroah.com>
References: <20210929205619.2800-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929205619.2800-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:56:20PM +0300, Nikita Yushchenko wrote:
> Commit 723de0f9171e ("staging: most: remove device from interface
> structure") moved registration of driver-provided struct device to
> the most subsystem, but did not properly update dim2 driver to
> work with that change.
> 
> After most subsystem passes driver's dev to register_device(), it
> becomes refcounted, and can be only deallocated in the release method.
> Provide that by:
> - not using devres to allocate the device,
> - moving shutdown actions from _remove() to the device release method,
> - not calling shutdown actions in _probe() after the device becomes
>   refcounted.

Should this be 3 patches?

> Also, driver used to register it's dev itself, to provide a custom
> attribute. With the modified most subsystem, this causes duplicate
> registration of the same device object. Fix that by adding that custom
> attribute to the platform device - that is a better location for
> a platform-specific attribute anyway.

Nope, it should be 4 patches.  Whenever you have to list a bunch of
different things you are doing in a single change, that's a hint that
this should be more than one patch.

Also, why have you not cc:ed the original author of the commit you are
"fixing" here?   They are the maintainer of this code, right?

One note on your change that would keep me from accepting it even if all
of the above was not an issue:

> diff --git a/drivers/staging/most/dim2/sysfs.c b/drivers/staging/most/dim2/sysfs.c
> index c85b2cdcdca3..22836c8ed554 100644
> --- a/drivers/staging/most/dim2/sysfs.c
> +++ b/drivers/staging/most/dim2/sysfs.c
> @@ -39,11 +39,10 @@ static const struct attribute_group *dev_attr_groups[] = {
>  
>  int dim2_sysfs_probe(struct device *dev)
>  {
> -	dev->groups = dev_attr_groups;
> -	return device_register(dev);
> +	return sysfs_create_groups(&dev->kobj, dev_attr_groups);

No driver code should ever be calling a sysfs_* function, which is a
huge hint that this is incorrect.

You also just raced with userspace and lost, please use the default
attributes for the driver or bus for this, but NEVER manually add and
remove sysfs files, that way lies madness and hard to maintain code.

thanks,

greg k-h
