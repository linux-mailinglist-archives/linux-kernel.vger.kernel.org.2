Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FF422841
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJENvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhJENvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:51:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46852613D5;
        Tue,  5 Oct 2021 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633441751;
        bh=+C0YLW1DnbAUg8pMS0qPoTsSFohiDLdMz6pftEU0/sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=we9T7zb78SUDZU/jwEPC39nkre4Qr9mtpRSuUY/lv48QLL1n6nHoTg6T1ICviqIJV
         n31cFHRO9DSZc+huAmcAXn4aJCZjczWMy1SxENMSak0fIOPh8Q/hxofaUfbmRQJ3cE
         5jf0JKpW11MtaR/SRXWwc1QiaZGf5qsu27cleyMU=
Date:   Tue, 5 Oct 2021 15:49:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] staging: most: dim2: fix device registration
Message-ID: <YVxX1f6sgYjTVYt7@kroah.com>
References: <20210929205619.2800-1-nikita.yoush@cogentembedded.com>
 <YVwofSvwGTv3kHjh@kroah.com>
 <d309b4cf-12f5-5f49-fcbe-3141dff9e73f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d309b4cf-12f5-5f49-fcbe-3141dff9e73f@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:33:02PM +0300, Nikita Yushchenko wrote:
> > > Commit 723de0f9171e ("staging: most: remove device from interface
> > > structure") moved registration of driver-provided struct device to
> > > the most subsystem, but did not properly update dim2 driver to
> > > work with that change.
> > > 
> > > After most subsystem passes driver's dev to register_device(), it
> > > becomes refcounted, and can be only deallocated in the release method.
> > > Provide that by:
> > > - not using devres to allocate the device,
> > > - moving shutdown actions from _remove() to the device release method,
> > > - not calling shutdown actions in _probe() after the device becomes
> > >    refcounted.
> > 
> > Should this be 3 patches?
> 
> But these three items are deeply interconnected, and fix the issue together.
> Must not manually free device structure passed to register_device(), thus
> must not allocate via devres (because otherwise, devres will free it). Once
> not using devres for it, must deallocate it somehow else, thus must rework
> the release paths.

Ok, but that was obvious.

> > > Also, driver used to register it's dev itself, to provide a custom
> > > attribute. With the modified most subsystem, this causes duplicate
> > > registration of the same device object. Fix that by adding that custom
> > > attribute to the platform device - that is a better location for
> > > a platform-specific attribute anyway.
> > 
> > Nope, it should be 4 patches.
> 
> Unlike the above three, this item could be separated.
> Will split into two patches now - the first for this (and with fix to the
> attributes issue noted below) and the second for proper device releasing.
> 
> > Also, why have you not cc:ed the original author of the commit you are
> > "fixing" here?   They are the maintainer of this code, right?
> 
> I was under impression that "git send-email" does that automatically...

Nope.

> CCing them now.

They don't see the change :(

> > One note on your change that would keep me from accepting it even if all
> > of the above was not an issue:
> > 
> > > diff --git a/drivers/staging/most/dim2/sysfs.c b/drivers/staging/most/dim2/sysfs.c
> > > index c85b2cdcdca3..22836c8ed554 100644
> > > --- a/drivers/staging/most/dim2/sysfs.c
> > > +++ b/drivers/staging/most/dim2/sysfs.c
> > > @@ -39,11 +39,10 @@ static const struct attribute_group *dev_attr_groups[] = {
> > >   int dim2_sysfs_probe(struct device *dev)
> > >   {
> > > -	dev->groups = dev_attr_groups;
> > > -	return device_register(dev);
> > > +	return sysfs_create_groups(&dev->kobj, dev_attr_groups);
> > 
> > No driver code should ever be calling a sysfs_* function, which is a
> > huge hint that this is incorrect.
> > 
> > You also just raced with userspace and lost, please use the default
> > attributes for the driver or bus for this, but NEVER manually add and
> > remove sysfs files, that way lies madness and hard to maintain code.
> I'm aware of this race, but still creating attributes on device probe is under wide use in the kernel:
> 
> nikita@cobook:~/kernel$ grep -r device_create_file drivers | wc -l
> 448

Just because there are bad examples, does not mean you should add more.

And not all of these are wrong, but do you know when they are not wrong?

> Still, in case of dim2 driver, moving to driver's dev_groups is
> trivial. Preparing that patch now.

That should have already been done, right?

thanks,

greg k-h
