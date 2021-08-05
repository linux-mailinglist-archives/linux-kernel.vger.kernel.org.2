Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08B83E0F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhHEHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhHEHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:49:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D3760E52;
        Thu,  5 Aug 2021 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628149772;
        bh=8V+u9ge4g03YYnm+FPxnFp01rnH/4iSe0E9VA7TrEdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmHw5yb4esLTnKfFpAaoQ8pxDVHHmm8BYTMBcsvZQEMl7aB5eIJ6qcdTstvlPal8d
         swb2mwhd1jyaDp6Vyjpg0nZ+lkIwymc2EemWpdneueZtABBYvr7M162Ls9umiWe+pX
         CeqDl9K35PslCTkOrpCFgZx7daNA+em/DYu8UtjM=
Date:   Thu, 5 Aug 2021 09:49:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQuYCePPZEmVbkfc@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 12:50:24PM -0700, Andi Kleen wrote:
> 
> > So you are trying to work around the "problem" that distro kernels
> > provides drivers for everything by adding additional kernel complexity?
> > 
> > What prevents you from using a sane, stripped down, kernel image for
> > these vms which would keep things sane and simpler and easier to audit
> > and most importantly, prove, that the image is not doing something you
> > don't expect it to do?
> > 
> > Why not just make distros that want to support this type of platform,
> > also provide these tiny kernel images?  Why are you pushing this work on
> > the kernel community instead?
> 
> 
> Greg, I'm surprised by your comment. Traditionally we've been tried to
> support all platforms in unified binary kernels and gone to considerable
> complications to do so. That has been standard Linux practice for at least
> the 90ies. In some cases we went to considerable pain to support that, for
> example for the 5 level page tables or for paravirt ops.
> 
> Imagine there were 10 new features or platforms and they would all ask
> distributions to produce custom kernels for them, they would need to
> maintain 10 different kernel packages forever for all these different cases.
> It's totally reasonable that they don't want to do that.

Ok, but that's not what it sounded like you wanted to have here.

It looked like you wanted something like a "stripped down kernel with
only a specific number of drivers allowed to work", which for a virtual
system, would seem to imply a uniform kernel image/configuration.

> Also even if they were willing to do custom configs it's not clear how this
> could be maintained and distributed. We would either have a standard TDX
> config and get everyone to agree on it (very difficult).

Why not try that?  Can't hurt and no need to change anything in the
kernel at all.  'make tdx_defconfig' should be trivial enough for you
all to maintain a single config file template, right?

> Or some enforcement
> mechanism at the Kconfig level that forces most drivers to be disabled when
> TDX is on, which would be also a considerable new mechanism and
> complication. In addition there are drivers which are not covered by Kconfig
> today (like quite a few of the basic platform drivers), but which we still
> want to filter. So to implement a full build time mechanism would likely
> need more changes than this relatively straight forward run time mechanism
> based on the driver model.
> 
> And of course there other use cases for a run time filter mechanism. For
> example let's say you want filtering for Thunderbolt security. In this case
> it has to be done at runtime because it's not practical to have a kernel
> that is only built for Thunderbolt drivers, but doesn't support anything
> else that is on the SOC. The only sane way to handle such a case is to make
> a runtime distinction.

We already have filtering for thunderbolt driver security in the kernel,
why do you want to add more?

> > And what's wrong with the current method of removing drivers from
> > devices that you do not want them to be bound to?  We offer that support
> > for all busses now that want to do it, what driver types are you needing
> > to "control" here that does not take advantage of the existing
> > infrastructure that we currently have for this type of thing?
> 
> I'm not sure what mechanism you're referring to here, but in general don't
> want the drivers to initialize at all because they might get exploited in
> any code that they execute.

That is exactly the mechanism we have today in the kernel for all busses
if they wish to take advantage of it.  We have had this for all USB
drivers for well over a decade now, this is not a new feature.  Please
use that instead.

> The intention is to disable all drivers except
> for a small allow list, because it's not practical to harden all 25M lines
> of Linux code.

Great, do that in userspace using the functionality we have today
please.

thanks,

greg k-h
