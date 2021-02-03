Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FB30DCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBCO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:28:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:52078 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232288AbhBCO2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:28:45 -0500
IronPort-SDR: BUPyRh4ALGavjx2cTi3DIeIl0QjmAbabyWAo2lXzZTWSMMiWF1Iu+IG0qqe5NVtblMmBkBLLRo
 7P5ErfWpaRbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242558900"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="242558900"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 06:26:59 -0800
IronPort-SDR: w3a5kiB1zW1t7dcUqkb1DwajHAXQVz8hzyc2kRKm3D+I5sgOHzduCCTGXqbosP6ChLdC+OblVU
 sRwAexB0HrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480366006"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 03 Feb 2021 06:26:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Feb 2021 16:26:55 +0200
Date:   Wed, 3 Feb 2021 16:26:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/6] software node: Provide replacement for
 device_add_properties()
Message-ID: <20210203142655.GG1687065@kuha.fi.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
 <20210202150102.GA1687065@kuha.fi.intel.com>
 <CAJZ5v0hVZBhqzLPGPHDZYPcYyJPfwgYwjzKGYaUMZOBw7Eh7CQ@mail.gmail.com>
 <20210203094535.GC1687065@kuha.fi.intel.com>
 <CAJZ5v0j6oY=hXOJtoJ=_vdWqwLDDAO8SJoG1N3nehaAcAz8G8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j6oY=hXOJtoJ=_vdWqwLDDAO8SJoG1N3nehaAcAz8G8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:50:24PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 3, 2021 at 10:45 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Feb 02, 2021 at 05:08:40PM +0100, Rafael J. Wysocki wrote:
> > > It looks like there is a use case that cannot be addressed by using
> > > device_add_properties() and that's why you need this new function.
> > >
> > > Can you describe that use case, please, and explain what the problem
> > > with using device_add_properties() in it is?
> >
> > The problem with device_add_properties() is that it gives false
> > impression that the device properties are somehow directly attached to
> > the devices, which is not true. Now, that should not be a major issue,
> > but it seems that it is. I think Lee Jones basically used that as an
> > argument to refuse changes (and pretty minor changes) that would have
> > allowed us to use software nodes with the MFD drivers.
> >
> > Nevertheless, I was not planning to provide a replacement for it
> > originally. We do in any case have the real issue caused by that
> > device_remove_properties() call in device_del() which has to be fixed.
> 
> What's that issue, specifically?

The problem is that we can't now reuse or share if necessary, or just
in general be in charge of the lifetime of the software nodes because
that call is in device_del(). Now the lifetime of the software nodes
is always tied to the devices they are attached, no questions asked.

> > I started to fix that by moving device_add_properties() under
> > drivers/base/swnode.c so I can implement it like I've implemented now
> > that new function, but after that when I started to tackle the second
> > issue by removing the subsystem wrappers like
> > platform_device_add_device_properties() and replacing them with things
> > like platform_device_add_software_node() in order to give the drivers
> > a chance to actually use software nodes, I realised that there isn't
> > much use for device_add_properties() after that.
> >
> > Also, even though I'm not super happy about adding more API to this
> > thing, this function - device_create_managed_software_node() - I do
> > like. Not only is it implemented so that we don't have to rely on
> > anything else in drivers core in order to achieve the lifetime link
> > with the device, it is also much more descriptive. The function name
> > alone does not leave any questions about what is going to happen if
> > that function is called. You'll end up with a software node that just
> > happens to be attached to the device.
> >
> > On top of those two things, by adding the new function it also gives
> > me a nice stepping stone to do these changes in the normal stages:
> >
> >         1. Add feature/modification.
> >         2. Convert users.
> >         3. Cleanup.
> >
> > And finally, even though we may not have any users left for
> > device_add_properties() after I have updated all the subsystems and
> > drivers, this new function will still be useful. That is because, even
> > though it can be used as a drop-in replacement for
> > device_add_properties(), it does add that one small but important
> > change. It allows the nodes created with it to be part of node
> > hierarchy, and that alone is useful to me, and I'm planning on using
> > that feature later.
> >
> > I'm sorry about the long explanation.
> 
> No need to be sorry,  now I know what this really is about. :-)
> 
> I'm not against this patch, but I IMO the "motivation" part of the
> changelog needs to be improved.
> 
> If the final goal is to get rid of device_add_properties(), please
> spell it out and say what problems there are with it and why the new
> function will be better.

Sure thing. Thanks Rafael.


Br,

-- 
heikki
