Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274F9419D10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhI0Rj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238746AbhI0RiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F20060F4A;
        Mon, 27 Sep 2021 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632764204;
        bh=tM73L6tUpKXE+ynihqygxcYqjleELU0EBQA2XuR0hX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqURat9AGPOteAcKdZ5kfwQL8rKK8zMPlyvuEd7QZRabxyXpUSQJi8iWJYHn0waU5
         Q8kdCrW9onubWRaaA2ltFTiXOumOc640NZ795VlyHaU/pZVMFfcRTS5zQGhfEyL2Am
         23n4+dcYQydDcFDqvI23qDaem3nnesy+E3ON4+CU=
Date:   Mon, 27 Sep 2021 19:36:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVIBKVB4IN35z/L6@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
 <20210924213157.3584061-2-david.e.box@linux.intel.com>
 <YU7BPIH123HUZKhw@kroah.com>
 <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
 <YVFC0U+wOqbTgDhy@kroah.com>
 <7295cafaf6da34e31390fe621198205d18eac525.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7295cafaf6da34e31390fe621198205d18eac525.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:27:28AM -0700, David E. Box wrote:
> On Mon, 2021-09-27 at 06:04 +0200, Greg KH wrote:
> > On Sun, Sep 26, 2021 at 06:15:16PM -0700, David E. Box wrote:
> > > > > +static struct platform_driver sdsi_driver = {
> > > > > +       .driver = {
> > > > > +               .name           = SDSI_DEV_NAME,
> > > > > +               .dev_groups     = sdsi_groups,
> > > > > +       },
> > > > > +       .probe  = sdsi_probe,
> > > > > +       .remove = sdsi_remove,
> > > > > +};
> > > > > +module_platform_driver(sdsi_driver);
> > > > 
> > > > What causes the platform to know to register, and enable, this platform
> > > > driver?  Shouldn't there be some hardware involved that is discoverable
> > > > to enable it to load dynamically?
> > > 
> > > Ah. The patch that adds the SDSi platform device string was added to a series for the intel_pmt
> > > MFD
> > > driver and it's still waiting review. I see that complicates things. I can combine the two series
> > > together.
> > 
> > Do you have a pointer to the lore.kernel.org location of that series?
> 
> https://lore.kernel.org/all/20210922213007.2738388-1-david.e.box@linux.intel.com/
> 
> > 
> > Your code right here will bind to any system that it is loaded on, a
> > very dangerous thing...
> 
> It won't. It uses module alias to load against the SDSi specific MFD cell.

module aliases do not prevent someone from building the driver into
their kernel, or doing a simple 'modprobe'.  You need to bind your
driver to a real hardware resource (and reject it if it is not present),
otherwise this driver will break systems quite easily.

And again, why is this a platform driver and not just a "real" device on
a bus?  Heck, why not just use the auxiliary bus for stuff like this,
why are you craming pci attributes into the MFD subsystem?

thanks,

greg k-h
