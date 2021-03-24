Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C943474B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhCXJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234911AbhCXJbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B33461A02;
        Wed, 24 Mar 2021 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616578261;
        bh=SapQuvedMMoMFZ158PEwXuhwjVzD2GWWS+vzheIkBjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHJEdq1GkzcNicfCW1HMi6LL0POJi5GOw+2MiRFoYYI3Ynu/7d2Z1d+lDY1cZt8g2
         6lUqLa3/7d/6BV+UVXe7brZgFR2Xak17D54z/uRl88G13A8TtAcRVrcMg7htGST2u7
         CdHEQO8ikt0HwyvI48wBEYPYl2NMCoQbIS7oLkUM=
Date:   Wed, 24 Mar 2021 10:30:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        vkoul@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFsG00+iDV/A4i3y@kroah.com>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
 <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
 <YFo0WW8hOsHesSFC@kroah.com>
 <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:14:18PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 3/23/21 1:32 PM, Greg KH wrote:
> > On Tue, Mar 23, 2021 at 01:04:49PM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > > > Note that the auxiliary bus API has separate init and add steps, which
> > > > > requires more attention in the error unwinding paths. The main loop
> > > > > needs to deal with kfree() and auxiliary_device_uninit() for the
> > > > > current iteration before jumping to the common label which releases
> > > > > everything allocated in prior iterations.
> > > > 
> > > > The init/add steps can be moved together in the aux bus code if that
> > > > makes this usage simpler.  Please do that instead.
> > > 
> > > IIRC the two steps were separated during the auxbus reviews to allow the
> > > parent to call kfree() on an init failure, and auxiliary_device_uninit()
> > > afterwards.
> > > 
> > > https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html#auxiliary-device
> > > 
> > > With a single auxbus_register(), the parent wouldn't know whether to use
> > > kfree() or auxiliary_device_uinit() when an error is returned, would it?
> > > 
> > 
> > It should, you know the difference when you call device_register() vs.
> > device_initialize()/device_add(), for what to do, right?
> > 
> > Should be no difference here either :)
> 
> sorry, not following.
> 
> with the regular devices, the errors can only happen on the second "add"
> stage.
> 
> int device_register(struct device *dev)
> {
> 	device_initialize(dev);
> 	return device_add(dev);
> }
> 
> that's not what is currently implemented for the auxiliary bus
> 
> the current flow is
> 
> ldev = kzalloc(..)
> some inits
> ret = auxiliary_device_init(&ldev->auxdev)
> if (ret < 0) {
>     kfree(ldev);
>     goto err1;
> }
> 
> ret = auxiliary_device_add(&ldev->auxdev)
> if (ret < 0)
>     auxiliary_device_uninit(&ldev->auxdev)
>     goto err2;
> }
> ...
> err2:
> err1:
> 
> How would I convert this to
> 
> ldev = kzalloc(..)
> some inits
> ret = auxiliary_device_register()
> if (ret) {
>    kfree(ldev) or not?
>    unit or not?
> }
> 
> IIRC during reviews there was an ask that the parent and name be checked,
> and that's why the code added the two checks below:
> 
> int auxiliary_device_init(struct auxiliary_device *auxdev)
> {
> 	struct device *dev = &auxdev->dev;
> 
> 	if (!dev->parent) {
> 		pr_err("auxiliary_device has a NULL dev->parent\n");
> 		return -EINVAL;
> 	}
> 
> 	if (!auxdev->name) {
> 		pr_err("auxiliary_device has a NULL name\n");
> 		return -EINVAL;
> 	}
> 
> 	dev->bus = &auxiliary_bus_type;
> 	device_initialize(&auxdev->dev);
> 	return 0;
> }
> 
> does this clarify the sequence?

Yes, thanks, but I don't know the answer to your question, sorry.  This
feels more complex than it should be, but I do not have the time at the
moment to look into it, sorry.

Try getting the authors of this code to fix it up :)

thanks,

greg k-h
