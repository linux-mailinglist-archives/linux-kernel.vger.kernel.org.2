Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC05424233
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbhJFQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:10:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39501 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231768AbhJFQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:10:13 -0400
Received: (qmail 660907 invoked by uid 1000); 6 Oct 2021 12:08:19 -0400
Date:   Wed, 6 Oct 2021 12:08:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rajat Jain <rajatxjain@gmail.com>
Cc:     Dmitry Torokhov <dtor@google.com>, Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, jsbarnes@google.com,
        pmalani@google.com
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub,
 as removable
Message-ID: <20211006160819.GA659483@rowland.harvard.edu>
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com>
 <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu>
 <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
 <20211005195929.GA634685@rowland.harvard.edu>
 <CAA93t1qzJuN8M2zbs+Kt9JXWP1H2kjKSxBp8-TXEfaMeZ1iggQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1qzJuN8M2zbs+Kt9JXWP1H2kjKSxBp8-TXEfaMeZ1iggQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:43:33PM -0700, Rajat Jain wrote:
> Hello,
> 
> On Tue, Oct 5, 2021 at 12:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Oct 05, 2021 at 09:51:02AM -0700, Dmitry Torokhov wrote:
> > > Hi Alan,
> > >
> > > On Tue, Oct 5, 2021 at 7:56 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > As I understand it, the "removable" property refers specifically to
> > > > the device's upstream link, not to whether _any_ of the links leading
> > > > from the device to the computer could be removed.
> > >
> > > No, that is not what it means. I'll cite our sysfs ABI:
> > >
> > > What:           /sys/devices/.../removable
> > > Date:           May 2021
> > > Contact:        Rajat Jain <rajatxjain@gmail.com>
> > > Description:
> > >                 Information about whether a given device can be removed from the
> > >                 platform by the user. This is determined by its subsystem in a
> > >                 bus / platform-specific way. This attribute is only present for
> > >                 devices that can support determining such information:
> > >
> > >                 "removable": device can be removed from the platform by the user
> > >                 "fixed":     device is fixed to the platform / cannot be removed
> > >                              by the user.
> > >                 "unknown":   The information is unavailable / cannot be deduced.
> > >
> > >                 Currently this is only supported by USB (which infers the
> > >                 information from a combination of hub descriptor bits and
> > >                 platform-specific data such as ACPI) and PCI (which gets this
> > >                 from ACPI / device tree).
> > >
> > > It specifically talks about _platform_, not about properties of some
> > > peripheral attached to a system. Note that the wording is very similar
> > > to what we had for USB devices that originally implemented "removable"
> > > attribute:
> >
> > In that case, shouldn't Rajat's patch change go into the driver core
> > rather than the hub driver?  _Every_ device downstream from a
> > removable link should count as removable, yes?  Not just the USB
> > devices.
> 
> I have no preference either way, and can do that if that is more acceptable.
> 
> >
> > And to say that the attribute is supported only by USB and PCI is
> > misleading, since it applies to every device downstream from a
> > removable link.
> 
> However I do think it makes sense to have the bus control whether this
> attribute applies to it or not.

The sysfs ABI quoted by Dmitry above is a little vague.  It seems to 
say that only certain buses can determine whether a device is 
removable, but this simply isn't true, because any device downstream 
from something removable will itself be removable, no matter what kind 
of bus it's on.

>  Determining the first point in a
> hierarchy of devices, where a device can be removed is highly bus
> specific (set_usb_port_removable()).

Yes, the bus must be at least partially responsible for _determining_ 
the value of the removable attribute.  But the attribute should _apply_ 
to all devices, regardless of what bus they are on.

To be more precise, the bus can determine whether a device's upstream 
link (the first link in the chain leading from the device back to the 
CPU) can be hot-unplugged.  The device is removable if any of the links 
in that chain are hot-unpluggable.

> AFAIK, the primary reason / use of this attribute was to distinguish
> devices that can be removed by the user, and really all such devices
> (at least the ones that matter to user) today sit either on PCI or USB
> bus. We intend to use this attribute to segregate internal devices
> from external devices, and collect some statistics about usb device
> usage this way. There is also a VM case that I think Dmitry or Benson
> on this thread can elaborate more about. There seem to be hundreds of
> other bus types and I'm not sure if we want to unnecessarily flood the
> sysfs with a removable attribute under each device.

sysfs already contains a lot of mostly unused information.  I don't 
think adding one or two more will hurt much.

Alan Stern
