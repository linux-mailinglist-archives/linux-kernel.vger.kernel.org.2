Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F9437240
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJVGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhJVGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9B9B60EE3;
        Fri, 22 Oct 2021 06:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634885458;
        bh=OSgVZt2dBvOr1icobnDe4jE2cavapX8RlBuovn8t5PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgXMtZQs3fJHPo4bNQ4kon5k41VWKK1ySFMtTdq8J3NopVZxu4dOkxqHj4dE77CWl
         wYBIBvv/RVeZsUX7j4pF9BA+sxFDRaLea8dS1dcQOh5QVRz8h/l6c6KbZZzl92azYH
         viR6p2Wy8LOOkaYYU8TyH7R3x5W33gnPO6XE/RO0=
Date:   Fri, 22 Oct 2021 08:50:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Frank Rowand <frowand.list@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] driver core, of: support for reserved devices
Message-ID: <YXJfTbSuoNITD4gj@kroah.com>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
 <CAL_JsqLmonXoV2qJ4zY1wfDTRuQAYQuymXEB2kTpUmkKWwPGjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLmonXoV2qJ4zY1wfDTRuQAYQuymXEB2kTpUmkKWwPGjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 09:58:46PM -0500, Rob Herring wrote:
> On Thu, Oct 21, 2021 at 9:00 PM Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > Hello all,
> >
> > This series is another incarnation of a couple other patchsets I've
> > posted recently [0, 1], but again different enough in overall
> > structure that I'm not sure it's exactly a v2 (or v3).
> >
> > As compared to [1], it abandons the writable binary sysfs files and at
> > Frank's suggestion returns to an approach more akin to [0], though
> > without any driver-specific (aspeed-smc) changes, which I figure might
> > as well be done later in a separate series once appropriate
> > infrastructure is in place.
> 
> I skimmed this, and overall I like the approach.
> 
> > The basic idea is to implement support for a status property value
> > that's documented in the DT spec [2], but thus far not used at all in
> > the kernel (or anywhere else I'm aware of): "reserved".  According to
> > the spec (section 2.3.4, Table 2.4), this status:
> >
> >   Indicates that the device is operational, but should not be used.
> >   Typically this is used for devices that are controlled by another
> >   software component, such as platform firmware.
> >
> > With these changes, devices marked as reserved are (at least in some
> > cases, more on this later) instantiated, but will not have drivers
> > bound to them unless and until userspace explicitly requests it by
> > writing the device's name to the driver's sysfs 'bind' file.  This
> > enables appropriate handling of hardware arrangements that can arise
> > in contexts like OpenBMC, where a device may be shared with another
> > external controller not under the kernel's control (for example, the
> > flash chip storing the host CPU's firmware, shared by the BMC and the
> > host CPU and exclusively under the control of the latter by default).
> > Such a device can be marked as reserved so that the kernel refrains
> > from touching it until appropriate preparatory steps have been taken
> > (e.g. BMC userspace coordinating with the host CPU to arbitrate which
> > processor has control of the firmware flash).
> >
> > Patches 1-3 provide some basic plumbing for checking the "reserved"
> > status of a device, patch 4 is the main driver-core change, and patch
> > 5 tweaks the OF platform code to not skip reserved devices so that
> > they can actually be instantiated.
> >
> > One shortcoming of this series is that it doesn't automatically apply
> > universally across all busses and drivers -- patch 5 enables support
> > for platform devices, but similar changes would be required for
> > support in other busses (e.g. in of_register_spi_devices(),
> > of_i2c_register_devices(), etc.) and drivers that instantiate DT
> > devices.  Since at present a "reserved" status is treated as
> > equivalent to "disabled" and this series preserves that status quo in
> > those cases I'd hope this wouldn't be considered a deal-breaker, but
> > a thing to be aware of at least.
> >
> > Greg: I know on [1] you had commented nack-ing the addition of boolean
> > function parameters; patch 4 adds a flags mask instead in an analogous
> > situation.  I'm not certain how much of an improvement you'd consider
> > that (hopefully at least slightly better, in that the arguments passed
> > at the call site are more self-explanatory); if that's still
> > unsatisfactory I'd welcome any suggested alternatives.
> 
> Can't we add a flag bit in struct device to reflect manual binding?
> bind will set it and unbind clears it.

The driver core does not "know" the difference betwen manual and not
manual binding, nor should it.  That's up to the bus.

thanks,

greg k-h
