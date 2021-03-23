Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B939346851
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhCWS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhCWS7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D5316198C;
        Tue, 23 Mar 2021 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616525980;
        bh=Duv575Zk2fTDzZ5FhMTZ+jsLUhp6fxAmjWAn2on9og0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZ/vVwaC6AeiZVeYoMjs1Prn/8QLQfHpSc3OzhtyeYxk4LQKQqeoDXE8Po0cx/Gqb
         ZnaBqUObJQMf9PnPZOgUq09/iPh1reiUOGjANf4u7tR1wZuCpt2anL7afgqbRfpBRz
         +UomaJ98qCORnzPuLzGICx5Mw/KrD+zDShSW2cZ8=
Date:   Tue, 23 Mar 2021 19:59:37 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Don Bollinger <don@thebollingers.org>
Cc:     arndb@arndb.de, linux-kernel@vger.kernel.org,
        brandon_chuang@edge-core.com, wally_wang@accton.com,
        aken_liu@edge-core.com, gulv@microsoft.com, jolevequ@microsoft.com,
        xinxliu@microsoft.com
Subject: Re: [PATCH v2] eeprom/optoe: driver to read/write SFP/QSFP/CMIS
 EEPROMS
Message-ID: <YFo6mZqOaY+2zApa@kroah.com>
References: <20210215193821.3345-1-don@thebollingers.org>
 <YFn3ahkF4w/IClaw@kroah.com>
 <008d01d72014$7b113900$7133ab00$@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008d01d72014$7b113900$7133ab00$@thebollingers.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:43:55AM -0700, Don Bollinger wrote:
> On Tue, Mar 23, 2021 at 7:12AM-0700, Greg KH wrote: 
> > On Mon, Feb 15, 2021 at 11:38:21AM -0800, Don Bollinger wrote:
> > > optoe is an i2c based driver that supports read/write access to all
> > > the pages (tables) of MSA standard SFP and similar devices (conforming
> > > to the SFF-8472 spec), MSA standard QSFP and similar devices
> > > (conforming to the SFF-8636 spec) and CMIS and similar devices
> > > (conforming to the Common Management Interface Specfication).
> > 
> 
> I promise not to engage in a drawn out email exchange over this, but I would
> like to appeal your decision, just once...
> 
> > Given this thread, I think that using the SFP interface/api in the kernel
> > already seems like the best idea forward.
> > 
> > That being said, your api here is whack, and I couldn't accept it anyway.
> 
> I don't understand.  I don't mean you are wrong, I literally don't
> understand what is whack about it.  The interface is provided by nvmem.  I
> modeled the calls on at24.  The layout of the data provided by the driver is
> exactly the same layout that ethtool provides (device, offset, length).
> Mapping i2c address, page and offset is exactly what ethtool provides.  So,
> which part of this is whack?

It's sysfs.  Does nvmem use sysfs for device discovery and enablement?

nvmem is just a "raw" maping of hardware (memory) to userspace.

You have a "real" device here that you are trying to also map to
userspace, but when you just expose the "raw" registers (i.e. memory) to
userspace, you are forcing userspace to handle all of the device
differences, instead of the kernel.

That's fine, for some things, but for anything with a standard, that's
not ok, that's what a kernel is for.

In other words, you could do what you want today probably with a UIO
driver, just get the kernel out of the way and do it all in userspace.
But that's not a viable or suportable api in the long-run for any
standard hardware type.

> > Not for the least being it's not even documented in Documentation/ABI/
> like
> > all sysfs files have to be :)
> 
> This could obviously be fixed.  I wasn't aware of this directory.  Now that
> you've pointed it out, I see that nvmem is actually documented there, which
> is the API I am using.  I document that optoe uses the nvmem interface, and
> the mapping of paged memory to linear memory in my patch in
> Documentation/misc-devices/optoe.rst.  If you think it would be useful, I
> could provide similar information in Documentation/ABI/stable.

Again, nvmem in sysfs is just a dump of the hardware memory.  That
should not be how to control a switch device.

> > And it feels like you are abusing sysfs for things it was not ment for,
> you
> > might want to look into configfs?
> 
> I'm using nvmem, which in turn uses sysfs, just like at24.  Why should optoe
> be different?  I would think it is actually better to use the same API (and
> code) as at24, and NOT to put it in a different place.

at24 too is just an eeprom behind an i2c bus.  Accessing it for simple
things is fine for userspace, but not for a standard device type.

The networking developers have said that they feel the kernel should
properly control devices like this, with a standard api.  And I agree
with them (note, I'm biased, I like standard APIs, heck, I've even
written specs for them...)  Doing "raw" hardware accesses is great fun
for things like one-off devices (I have Linux running in a keyboard for
something like that, also as my doorbell), but doing this for a "real"
set of devices is not ok.

Again, it's the difference between the UIO interface and a real ethernet
driver in the kernel.  You could just say "all PCI network devices
should use the UIO interface and put the hardware-specific logic in
userspace", but that's not what we (i.e. the Linux kernel developers)
feel is the proper way to handle the abstraction of device types.

Again, we are kernel developers, we like nice hardware abstractions.
Bonus is that it lets new hardware companies create new devices and no
userspace modifications are needed!  I think history is on our side
here :)

> > But really, these are networking devices, so they should be controllable
> using
> > the standard networking apis, not one-off sysfs files.  Moving to the
> Linux-
> > standard tools is a good thing, and will work out better in the end
> instead of
> > having to encode lots of device-specific state in userspace like this
> "raw" api
> > seems to require.
> 
> This is the real issue.  It turns out, on these switches, there are two
> kinds of networking.  Linux kernel networking handles one port, of 1Gb (or
> less), which functions as a management port.  This is typically used for
> console access.  It is configured and managed as an ordinary network port,
> with a kernel network driver and the usual networking utilities.  'ip addr'
> will show this port as well as loopback ports.  The linux kernel has no
> visibility to the switch networking ports.  'ip addr' will not show any of
> the switch networking ports.
> 
> The switch functions, switching at 25Tb/s, are completely invisible to the
> linux kernel.  The switch ASIC is managed by a device driver provided by the
> ASIC vendor.  That driver is driven by management code from the ASIC vendor
> and a host of network applications.  Multiple vendors compete to provide the
> best, most innovative, most secure, easiest...  network capabilities on top
> of this architecture.  NONE of them use a kernel network driver, or the
> layers of control or management that the linux kernel offers.  On these
> systems, if you ask ethtool to provide EEPROM data, you get 'function not
> implemented'.
> 
> On these systems, SFP/QSFP/CMIS devices are actually not 'networking
> devices' from a Linux kernel perspective.  They are GPIO targets and EEPROM
> memory.  Switch networking just needs the kernel to toggle the GPIO lines
> and read/write the EEPROM.  optoe is just trying to read/write the EEPROM.

That sounds like hell.  Let's create a proper api for everyone to use,
and NOT provide raw access to random device eeproms (i.e. memory).  I
thought that is what switchdev was for.  If it is somehow lacking, I'm
sure that patches are gladly accepted.

Heck, I did a review of the switchdev api and code a long time ago in
response to some companies complaining of just this thing.  Sad to see
they never took my advice of "send patches to get your hardware
supported in that api", and persisted in wanting "raw memory" access
instead.

> One last note...  The networking folks need a better SFP/QSFP/CMIS EEPROM
> driver to access more pages, and to support the new CMIS standard.

Great, work on that!

But raw eeprom/nvram/ram access is not that api.

Again, UIO vs. "struct net_device".  Think of it that way.

thanks,

greg k-h
