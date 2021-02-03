Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57A230D69B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhBCJrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:47:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:2805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232967AbhBCJrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:47:40 -0500
IronPort-SDR: zdYSGFiqur8Mkbos/rqEUPOm8jXOXvnO4UeqJjdzEmUGTNFRlkJniEm1N+IrbZRdpVEg/9Hhh+
 D52PJRy/gjzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181160480"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="181160480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:45:39 -0800
IronPort-SDR: zESI6Be6g1Qr4aWJMp9MGP2WTezGi8bJymCwpLw3goEi+ZsveB8TGHGqxI3q6N1XmAPcp7X31O
 QNtcdAgwpn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480285734"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 03 Feb 2021 01:45:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Feb 2021 11:45:35 +0200
Date:   Wed, 3 Feb 2021 11:45:35 +0200
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
Message-ID: <20210203094535.GC1687065@kuha.fi.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
 <20210202150102.GA1687065@kuha.fi.intel.com>
 <CAJZ5v0hVZBhqzLPGPHDZYPcYyJPfwgYwjzKGYaUMZOBw7Eh7CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hVZBhqzLPGPHDZYPcYyJPfwgYwjzKGYaUMZOBw7Eh7CQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 05:08:40PM +0100, Rafael J. Wysocki wrote:
> It looks like there is a use case that cannot be addressed by using
> device_add_properties() and that's why you need this new function.
> 
> Can you describe that use case, please, and explain what the problem
> with using device_add_properties() in it is?

The problem with device_add_properties() is that it gives false
impression that the device properties are somehow directly attached to
the devices, which is not true. Now, that should not be a major issue,
but it seems that it is. I think Lee Jones basically used that as an
argument to refuse changes (and pretty minor changes) that would have
allowed us to use software nodes with the MFD drivers.

Nevertheless, I was not planning to provide a replacement for it
originally. We do in any case have the real issue caused by that
device_remove_properties() call in device_del() which has to be fixed.
I started to fix that by moving device_add_properties() under
drivers/base/swnode.c so I can implement it like I've implemented now
that new function, but after that when I started to tackle the second
issue by removing the subsystem wrappers like
platform_device_add_device_properties() and replacing them with things
like platform_device_add_software_node() in order to give the drivers
a chance to actually use software nodes, I realised that there isn't
much use for device_add_properties() after that.

Also, even though I'm not super happy about adding more API to this
thing, this function - device_create_managed_software_node() - I do
like. Not only is it implemented so that we don't have to rely on
anything else in drivers core in order to achieve the lifetime link
with the device, it is also much more descriptive. The function name
alone does not leave any questions about what is going to happen if
that function is called. You'll end up with a software node that just
happens to be attached to the device.

On top of those two things, by adding the new function it also gives
me a nice stepping stone to do these changes in the normal stages:

        1. Add feature/modification.
        2. Convert users.
        3. Cleanup.

And finally, even though we may not have any users left for
device_add_properties() after I have updated all the subsystems and
drivers, this new function will still be useful. That is because, even
though it can be used as a drop-in replacement for
device_add_properties(), it does add that one small but important
change. It allows the nodes created with it to be part of node
hierarchy, and that alone is useful to me, and I'm planning on using
that feature later.

I'm sorry about the long explanation.

Br,

-- 
heikki
