Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E04374A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhJVJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhJVJYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3EB960FDA;
        Fri, 22 Oct 2021 09:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634894533;
        bh=9aGfIgQGiaQYTNOWKV+Zae5m5NPz4PloE1ueYrvbcko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dx999myzKkPyX9nYyLuy1encmZJQVXGy3WDSNJ/frpiPbZz7w7nT7oZeMBYVcq1HD
         H9J7uUVZvBE2VUBYeqo7SgMfO0dhlHx+XteJd1sus5uLNuifjcVTTel9JnoVwKRiTx
         KM8Fsm14tGJj1itWm/e+sZl24EkuvlfrB5zGLBb8=
Date:   Fri, 22 Oct 2021 11:22:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 0/5] driver core, of: support for reserved devices
Message-ID: <YXKCw/eEB8n2qtVx@kroah.com>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
 <YXJfHwzIdksUKPIe@kroah.com>
 <YXJ9yR6b5vI3NwF7@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXJ9yR6b5vI3NwF7@hatter.bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:00:57AM -0700, Zev Weiss wrote:
> On Thu, Oct 21, 2021 at 11:50:07PM PDT, Greg Kroah-Hartman wrote:
> > On Thu, Oct 21, 2021 at 07:00:27PM -0700, Zev Weiss wrote:
> > > Hello all,
> > > 
> > > This series is another incarnation of a couple other patchsets I've
> > > posted recently [0, 1], but again different enough in overall
> > > structure that I'm not sure it's exactly a v2 (or v3).
> > > 
> > > As compared to [1], it abandons the writable binary sysfs files and at
> > > Frank's suggestion returns to an approach more akin to [0], though
> > > without any driver-specific (aspeed-smc) changes, which I figure might
> > > as well be done later in a separate series once appropriate
> > > infrastructure is in place.
> > > 
> > > The basic idea is to implement support for a status property value
> > > that's documented in the DT spec [2], but thus far not used at all in
> > > the kernel (or anywhere else I'm aware of): "reserved".  According to
> > > the spec (section 2.3.4, Table 2.4), this status:
> > > 
> > >   Indicates that the device is operational, but should not be used.
> > >   Typically this is used for devices that are controlled by another
> > >   software component, such as platform firmware.
> > > 
> > > With these changes, devices marked as reserved are (at least in some
> > > cases, more on this later) instantiated, but will not have drivers
> > > bound to them unless and until userspace explicitly requests it by
> > > writing the device's name to the driver's sysfs 'bind' file.  This
> > > enables appropriate handling of hardware arrangements that can arise
> > > in contexts like OpenBMC, where a device may be shared with another
> > > external controller not under the kernel's control (for example, the
> > > flash chip storing the host CPU's firmware, shared by the BMC and the
> > > host CPU and exclusively under the control of the latter by default).
> > > Such a device can be marked as reserved so that the kernel refrains
> > > from touching it until appropriate preparatory steps have been taken
> > > (e.g. BMC userspace coordinating with the host CPU to arbitrate which
> > > processor has control of the firmware flash).
> > > 
> > > Patches 1-3 provide some basic plumbing for checking the "reserved"
> > > status of a device, patch 4 is the main driver-core change, and patch
> > > 5 tweaks the OF platform code to not skip reserved devices so that
> > > they can actually be instantiated.
> > 
> > Again, the driver core should not care about this, that is up to the bus
> > that wants to read these "reserved" values and do something with them or
> > not (remember the bus is the thing that does the binding, not the driver
> > core).
> > 
> > But are you sure you are using the "reserved" field properly?
> 
> Well, thus far both Rob Herring and Oliver O'Halloran (originator of the
> "reserved" status in the DT spec, whom I probably should have CCed earlier,
> sorry) have seemed receptive to this interpretation of it, which I'd hope
> would lend it some credence.

Ok, that's up to the DT people, I'll let you all fight it out with the
platform creators :)

Good luck!

greg k-h
