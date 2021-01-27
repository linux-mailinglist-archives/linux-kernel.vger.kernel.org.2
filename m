Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6543305D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhA0Ndn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238477AbhA0NbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:31:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04BA1207A0;
        Wed, 27 Jan 2021 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611754218;
        bh=PRPfyBQ4qTkyM5ldK/G+fxEfNZ+SuyxPadtIZ8ggCS8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=i/J0XSdmNCwo8OkCHOIeKDGqBQYncNk8FULsNG5fhh2wty7WMMKvbJcOdDCM2Pe3z
         0bKsYWFYNIrIFh2MGx9cLVHlOSlVvfDEkLN/K6HONMD4ifSpzyeBd8KfBuBUSv4jJ/
         /jIJ7Uh/N7hqLWJcs5bTiqQ1H7BVXySLd1BBKFzY=
Date:   Wed, 27 Jan 2021 14:30:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: sysfs: Add macro to assign show for RO
 attributes
Message-ID: <YBFq5yiHFJ2/jnGK@kroah.com>
References: <1611721162-29982-1-git-send-email-orsonzhai@gmail.com>
 <YBEbRDOQhczI5/yC@kroah.com>
 <20210127125126.GA7813@lenovo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127125126.GA7813@lenovo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 08:51:26PM +0800, Orson Zhai wrote:
> On Wed, Jan 27, 2021 at 08:50:28AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 27, 2021 at 12:19:22PM +0800, Orson Zhai wrote:
> > > In some circumstances, multiple __ATTR_RO attributes need to be assigned
> > > with a single show function.
> > > 
> > > Add this macro to make life easier with simple code.
> > > 
> > > Signed-off-by: Orson Zhai <orsonzhai@gmail.com>
> > > ---
> > >  Documentation/filesystems/sysfs.rst | 2 ++
> > >  include/linux/sysfs.h               | 5 +++++
> > >  2 files changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> > > index 004d490..0e2274a 100644
> > > --- a/Documentation/filesystems/sysfs.rst
> > > +++ b/Documentation/filesystems/sysfs.rst
> > > @@ -141,6 +141,8 @@ __ATTR_RO_MODE(name, mode):
> > >  	         fore more restrictive RO access currently
> > >                   only use case is the EFI System Resource Table
> > >                   (see drivers/firmware/efi/esrt.c)
> > > +__ATTR_RO_SHOW(name, show):
> > > +		 assumes default mode 0444 with specified show.
> > >  __ATTR_RW(name):
> > >  	         assumes default name_show, name_store and setting
> > >                   mode to 0644.
> > > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > > index 2caa34c..c851592 100644
> > > --- a/include/linux/sysfs.h
> > > +++ b/include/linux/sysfs.h
> > > @@ -117,6 +117,11 @@ struct attribute_group {
> > >  	.show	= _name##_show,						\
> > >  }
> > >  
> > > +#define __ATTR_RO_SHOW(_name, _show) {					\
> > > +	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
> > > +	.show	= _show,						\
> > > +}
> > 
> > Do you have a real user for this?  Using "raw" kobject attributes is
> 
> Yes, I have found at least one user in current kernel code.
> 
> Please refer to [1].
> 
> The author implemented a similar marcro __ATRR_MRO as mine, plus an
> __ATRR_MWO with specified restore.

Ick, no, that should be using DEVICE_ATTR_RO() as it is a struct device
attribute, not a "raw" kobject attribute.  So that code should be fixed
up anyway, no need for this macro :)

> 
> If this patch merged, I'd to replace his marcro with mine.
> 
> > rare and should not be used often, so who needs this?
> 
> Agree. But for some device drivers it might be useful without side effect.

Drivers should NOT be ever using __ATTR* macros.  That is not what they
are there for.

> Another example is from Android increment-fs code out there.
> That driver has 3 sysfs attributes which shared with same show function
> which only prints "support" to userland.

I can't take patches for out-of-tree code, sorry, you know this :)

thanks,

greg k-h
