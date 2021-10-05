Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA53A423134
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhJEUB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:01:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39781 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235134AbhJEUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:01:21 -0400
Received: (qmail 635423 invoked by uid 1000); 5 Oct 2021 15:59:29 -0400
Date:   Tue, 5 Oct 2021 15:59:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Rajat Jain <rajatja@google.com>,
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
Message-ID: <20211005195929.GA634685@rowland.harvard.edu>
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com>
 <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu>
 <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:51:02AM -0700, Dmitry Torokhov wrote:
> Hi Alan,
> 
> On Tue, Oct 5, 2021 at 7:56 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > As I understand it, the "removable" property refers specifically to
> > the device's upstream link, not to whether _any_ of the links leading
> > from the device to the computer could be removed.
> 
> No, that is not what it means. I'll cite our sysfs ABI:
> 
> What:           /sys/devices/.../removable
> Date:           May 2021
> Contact:        Rajat Jain <rajatxjain@gmail.com>
> Description:
>                 Information about whether a given device can be removed from the
>                 platform by the user. This is determined by its subsystem in a
>                 bus / platform-specific way. This attribute is only present for
>                 devices that can support determining such information:
> 
>                 "removable": device can be removed from the platform by the user
>                 "fixed":     device is fixed to the platform / cannot be removed
>                              by the user.
>                 "unknown":   The information is unavailable / cannot be deduced.
> 
>                 Currently this is only supported by USB (which infers the
>                 information from a combination of hub descriptor bits and
>                 platform-specific data such as ACPI) and PCI (which gets this
>                 from ACPI / device tree).
> 
> It specifically talks about _platform_, not about properties of some
> peripheral attached to a system. Note that the wording is very similar
> to what we had for USB devices that originally implemented "removable"
> attribute:

In that case, shouldn't Rajat's patch change go into the driver core 
rather than the hub driver?  _Every_ device downstream from a 
removable link should count as removable, yes?  Not just the USB 
devices.

And to say that the attribute is supported only by USB and PCI is 
misleading, since it applies to every device downstream from a 
removable link.

> > This is probably what Oliver meant when he complained about losing
> > information.  With the knowledge of whether each individual link is
> > removable, you can easily tell whether there's some way to remove a
> > device from the system.  But if you only know whether the device is
> > removable from the system overall, you generally can't tell whether
> > the link to the device's parent is removable.
> 
> If we need this data then we need to establish some new attribute to
> convey this info.

I don't know if we need it, but such an attribute seems like a good 
idea.

Alan Stern
