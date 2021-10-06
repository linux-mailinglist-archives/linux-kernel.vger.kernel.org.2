Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B2424243
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhJFQMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:12:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57179 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230021AbhJFQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:12:51 -0400
Received: (qmail 661013 invoked by uid 1000); 6 Oct 2021 12:10:58 -0400
Date:   Wed, 6 Oct 2021 12:10:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Dmitry Torokhov <dtor@google.com>, Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub,
 as removable
Message-ID: <20211006161058.GB659483@rowland.harvard.edu>
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com>
 <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu>
 <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
 <20211005195929.GA634685@rowland.harvard.edu>
 <c219168c-2727-0b44-7a05-7c0e31770de4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c219168c-2727-0b44-7a05-7c0e31770de4@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 11:37:58AM +0200, Oliver Neukum wrote:
> 
> On 05.10.21 21:59, Alan Stern wrote:
> > On Tue, Oct 05, 2021 at 09:51:02AM -0700, Dmitry Torokhov wrote:
> >> Hi Alan,
> >>
> >> On Tue, Oct 5, 2021 at 7:56 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >>> As I understand it, the "removable" property refers specifically to
> >>> the device's upstream link, not to whether _any_ of the links leading
> >>> from the device to the computer could be removed.
> >> No, that is not what it means. I'll cite our sysfs ABI:
> >>
> >> What:           /sys/devices/.../removable
> >> Date:           May 2021
> >> Contact:        Rajat Jain <rajatxjain@gmail.com>
> >> Description:
> >>                 Information about whether a given device can be removed from the
> >>                 platform by the user. This is determined by its subsystem in a
> >>                 bus / platform-specific way. This attribute is only present for
> >>                 devices that can support determining such information:
> >>
> >>                 "removable": device can be removed from the platform by the user
> >>                 "fixed":     device is fixed to the platform / cannot be removed
> >>                              by the user.
> >>                 "unknown":   The information is unavailable / cannot be deduced.
> >>
> >>                 Currently this is only supported by USB (which infers the
> >>                 information from a combination of hub descriptor bits and
> >>                 platform-specific data such as ACPI) and PCI (which gets this
> >>                 from ACPI / device tree).
> >>
> >> It specifically talks about _platform_, not about properties of some
> >> peripheral attached to a system. Note that the wording is very similar
> >> to what we had for USB devices that originally implemented "removable"
> >> attribute:
> > In that case, shouldn't Rajat's patch change go into the driver core 
> > rather than the hub driver?  _Every_ device downstream from a 
> > removable link should count as removable, yes?  Not just the USB 
> > devices.
> In theory yes. If your HC is removable by that logic every device is.
> That renders the information content of 'removable' to zero. Everything
> is removable.

So we should add a new attribute.  Call it "unpluggable", perhaps.  It 
will say whether the device's immediate upstream link is 
hot-unpluggable.  Then the device is removable if its parent is 
removable or if it is unpluggable.

> > And to say that the attribute is supported only by USB and PCI is 
> > misleading, since it applies to every device downstream from a 
> > removable link.
> Exactly and it is a difference. If you know that a device is removable
> you must not disable hotplug detection on that port if you want full
> functionality. While if you know that a device is not removable you may
> straight up cut power, even if the _parent_ is still removable.
> 
> The device tree is a tree and if you want to know whether hotplugging
> is possible (let's ignore hibernation), you need to walk the tree top to
> bottom.

Adding the "unpluggable" attribute should take care of this, right?

Alan Stern
