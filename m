Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD51639B94B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFDNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhFDNAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:00:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29475610C9;
        Fri,  4 Jun 2021 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622811523;
        bh=ZvTLHNXYZniZZaf3Un9n0CPoWAaEuLLC3AE7tVW2980=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3lh0F5MhNCVVLpDNdpARd7TauOdvNPyIFk9taXMUtqlpQHGLFPheTTNT2IhXcony
         0l/00Vw7zGqT5bC44ak4xQnxM44pJWwmRTzmpq68akqGsj94b5H2cOmF+sXP4VV81o
         O4fpCqkmsgx0U1gXYg3sBMyLK3KmLDVFSY8PAUwk=
Date:   Fri, 4 Jun 2021 14:58:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        Guillaume Tucker <gtucker.collabora@gmail.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>
Subject: Re: [RFC PATCH 1/1] drivers: base: Expose probe failures via debugfs
Message-ID: <YLojgGvjAO0v/4l2@kroah.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
 <20210603125534.638672-2-adrian.ratiu@collabora.com>
 <YLjWKwhp7akqyR1S@kroah.com>
 <87wnrawwfl.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnrawwfl.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:00:14PM +0300, Adrian Ratiu wrote:
> On Thu, 03 Jun 2021, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jun 03, 2021 at 03:55:34PM +0300, Adrian Ratiu wrote:
> > > This adds a new devices_failed debugfs attribute to list driver
> > > probe failures excepting -EPROBE_DEFER which are still handled as
> > > before via their own devices_deferred attribute.
> > 
> > Who is going to use this?
> > 
> 
> It's for KernelCI testing, I explained the background in my other reply.
> 
> > > This is useful on automated test systems like KernelCI to avoid
> > > filtering dmesg dev_err() messages to extract potential probe
> > > failures.
> > 
> > I thought we listed these already some other way today?
> > 
> 
> The only other place is the printk buffer via dev_err() and only the result
> subset of -EPROBE_DEFER info is exported via debugfs.
> 
> An additional problem with this new interface implementation is that it is
> based on the new-ish driver core "dev_err_probe" helper to which not all
> drivers have been converted (yet...), so there will be a mismatch between
> printk and this new interface.

Then why not move to use the new interface :)

> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Cc: "Rafael J.
> > > Wysocki" <rafael@kernel.org> Cc: Guillaume Tucker
> > > <gtucker.collabora@gmail.com> Suggested-by: Enric Balletbò
> > > <enric.balletbo@collabora.com> Signed-off-by: Adrian Ratiu
> > > <adrian.ratiu@collabora.com> ---  drivers/base/core.c | 76
> > > +++++++++++++++++++++++++++++++++++++++++++--  lib/Kconfig.debug   |
> > > 23 ++++++++++++++ 2 files changed, 96  insertions(+), 3 deletions(-)
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c index
> > > b8a8c96dca58..74bf057234b8 100644 --- a/drivers/base/core.c +++
> > > b/drivers/base/core.c @@ -9,7 +9,9 @@   */   #include <linux/acpi.h>
> > > +#include <linux/circ_buf.h>  #include <linux/cpufreq.h> +#include
> > > <linux/debugfs.h>  #include <linux/device.h> #include <linux/err.h>
> > > #include  <linux/fwnode.h> @@ -53,6 +55,15 @@ static
> > > DEFINE_MUTEX(fwnode_link_lock);  static bool
> > > fw_devlink_is_permissive(void); static bool
> > > fw_devlink_drv_reg_done;  +#ifdef CONFIG_DEBUG_FS_PROBE_ERR +#define
> > > PROBE_ERR_BUF_ELEM_SIZE	64 +#define PROBE_ERR_BUF_SIZE	(1 <<
> > > CONFIG_DEBUG_FS_PROBE_ERR_BUF_SHIFT) +static struct circ_buf
> > > probe_err_crbuf; +static char
> > > failed_probe_buffer[PROBE_ERR_BUF_SIZE]; +static
> > > DEFINE_MUTEX(failed_probe_mutex); +static struct dentry
> > > *devices_failed_probe; +#endif
> > 
> > All of this just for a log buffer?  The kernel provides a great one,
> > printk, let's not create yet-another-log-buffer if at all possible
> > please.
> 
> Yes, that is correct, this is esentially duplicating information already
> exposed via the printk buffer.

Not good, I will not take this for that reason alone.  Also I don't want
to maintain something like this for the next 10+ years for no good
reason.

> > If the existing messages are "hard to parse", what can we do to make
> > them "easier" that would allow systems to do something with them?
> > 
> > What _do_ systems want to do with this information anyway?  What does it
> > help with exactly?
> > 
> 
> I know driver core probe error message formats are unlikely to change over
> time and debugfs in theory is as "stable" as printk, but I think the main
> concern is to find a a more reliable way than parsing printk to extract
> probe erros, like for the existing devices_deferred in debugfs.

But what exactly are you trying to detect?  And what are you going to do
if you detect it?

> The idea in my specific case is to be able to reliably run driver tests in
> KernelCI for expected or unexpected probe errors like -EINVAL.

How about making a "real" test for this type of thing and we add that to
the kernel itself?  Wouldn't that be a better thing to have?

thanks,

greg k-h
