Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7177454D76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhKQS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhKQS5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:57:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9190E60F8F;
        Wed, 17 Nov 2021 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637175257;
        bh=HZsEd0xsgiAa1gcWQnMnVjSDW/F7feGMwtoWsG2I2kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6ECcgxkZaoZr9k+XYxyNR96jZ2YtFK7JQ75eXdb0aBxb1fNEk91hgTnlBTKronE9
         VxZs3LP1gP3CJ4laWqr8ELoKGIjpRlLX2Wz2/Wvo0APE0TQ7/2D5MjrozVNI4qQa0L
         shkCBtZfCvT0tLBzswa0VGaow+ODMgTlccouP1d8=
Date:   Wed, 17 Nov 2021 19:54:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, ardb@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [RFC PATCH 1/5] firmware: Create firmware upload framework
Message-ID: <YZVP1jetd/a+dYyf@kroah.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <20211111011345.25049-2-russell.h.weight@intel.com>
 <YZUceupQe67KYJyf@kroah.com>
 <c521bc07-0f10-e89e-a59c-b6e07fc35089@intel.com>
 <YZVHaeuYL8QD/7db@kroah.com>
 <44f1be15-5e16-38fe-392c-b87a29451318@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f1be15-5e16-38fe-392c-b87a29451318@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:47:38AM -0800, Russ Weight wrote:
> 
> 
> On 11/17/21 10:18 AM, Greg KH wrote:
> > On Wed, Nov 17, 2021 at 10:00:54AM -0800, Russ Weight wrote:
> >>
> >> On 11/17/21 7:15 AM, Greg KH wrote:
> >>> On Wed, Nov 10, 2021 at 05:13:41PM -0800, Russ Weight wrote:
> >>>> The Firmware Upload class driver provides a common API for uploading
> >>>> firmware files to devices.
> >>> That is exactly what the existing firmware api in the kernel is supposed
> >>> to be accomplishing.
> >>>
> >>> If it is not doing what you need it to do, then you need to document the
> >>> heck out of why it is not, and why you need a different api for this.  I
> >>> do not see that here in this changelog at all :(
> >> This is part of the documentation included later in this patch. I can add
> >> this to the changelog.
> >>
> >> +Some devices load firmware from on-board FLASH when the card initializes.
> >> +These cards do not require the request_firmware framework to load the
> >> +firmware when the card boots, but they to require a utility to allow
> >> +users to update the FLASH contents.
> > There's no requirement that request_firmware only be done at boot time,
> > why not use it at any point in time?
> Calling request_firmware() is not restricted to boot time. But it requires
> a firmware filename under /lib/firmware

Not really, there are many locations it can be in.  See the different
configuration options we have.

But why would you want firmware in another location?

>, and the convention is to specify the
> filename in the kernel config.

That is not a requirement at all.

> I don't see any support for a user to provide a filename at run time
> to be uploaded to a device, and that is the use case that I want to
> support.

If that's the only difference here, please work with the existing
framework to add that tiny thing (i.e. pass in a name) to the current
framework.  Do not create a whole new one please.

> >> When you say "existing firmware api", I'm thinking request_firmware, which
> >> requires that driver names be specified in the kernel config and wants to
> >> load firmware automatically during device initialization.
> > It can be used at any time, why do you think it's restricted to init
> > time?
> >
> > And I do not understand your issue with driver names.
> Sorry - I meant so say "firmware file names"
> 
> In an earlier iteration of this patchset, you pointed out that allowing a user
> to provide a filename for request_firmware() to use was a security issue.

It is crazy, don't you think?

> The use case that I am targeting is to allow a user to provide an image file
> to a device at run time.

That's not a limitation of the existing firmware layer.

thanks,

greg k-h
