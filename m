Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6347D331849
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhCHUNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhCHUNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:13:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3106C64EEA;
        Mon,  8 Mar 2021 20:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615234417;
        bh=V/DLtJWmXubJNcI+enXmrDekzLFAX7ilE6JsPJaJS6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/+kApxyZxjHaWjZy5B8x9qJuZ7GSJw5blaoTsIx2GUYKnma6irxaZWxTf6E6Y+mZ
         VppzmmbG0eJ8so56OGvGnG6bQUnWyDUP+VKaYw9HvSn+p4TkhLmuY3Et/E6rNVC9VF
         +k2jONOdMj1NRAzpJKZcOjGYsTMZvD7XaLjNNZEc=
Date:   Mon, 8 Mar 2021 21:13:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: [PATCH v10 01/20] dlb: add skeleton for DLB driver
Message-ID: <YEaFbyUM0Fu763vm@kroah.com>
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
 <20210127225641.1342-2-mike.ximing.chen@intel.com>
 <YCKP5ZUL1/wMzmf4@kroah.com>
 <CAPcyv4hC2dJGAXbG2ogO=2THuDUHjgYekkNy4K_zwEmQcXLcjA@mail.gmail.com>
 <BYAPR11MB3095C54BA878D8A5502CA891D9939@BYAPR11MB3095.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3095C54BA878D8A5502CA891D9939@BYAPR11MB3095.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 08:00:00PM +0000, Chen, Mike Ximing wrote:
> 
> 
> > -----Original Message-----
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Tuesday, February 9, 2021 11:30 AM
> > To: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Chen, Mike Ximing <mike.ximing.chen@intel.com>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Arnd Bergmann <arnd@arndb.de>; Pierre-Louis
> > Bossart <pierre-louis.bossart@linux.intel.com>; Gage Eads <gage.eads@intel.com>
> > Subject: Re: [PATCH v10 01/20] dlb: add skeleton for DLB driver
> > 
> > On Tue, Feb 9, 2021 at 5:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 27, 2021 at 04:56:22PM -0600, Mike Ximing Chen wrote:
> > > > Add basic driver functionality (load, unload, probe, and remove callbacks)
> > > > for the DLB driver.
> > > >
> > > > Add documentation which describes in detail the hardware, the user
> > > > interface, device interrupts, and the driver's power-management strategy.
> > > > For more details about the driver see the documentation in the patch.
> > > >
> > > > Add a DLB entry to the MAINTAINERS file.
> > > >
> > > > Signed-off-by: Gage Eads <gage.eads@intel.com>
> > > > Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> > > > Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  Documentation/misc-devices/dlb.rst   | 259 +++++++++++++++++++++++++++
> > > >  Documentation/misc-devices/index.rst |   1 +
> > > >  MAINTAINERS                          |   8 +
> > > >  drivers/misc/Kconfig                 |   1 +
> > > >  drivers/misc/Makefile                |   1 +
> > > >  drivers/misc/dlb/Kconfig             |  18 ++
> > > >  drivers/misc/dlb/Makefile            |   9 +
> > > >  drivers/misc/dlb/dlb_hw_types.h      |  32 ++++
> > > >  drivers/misc/dlb/dlb_main.c          | 156 ++++++++++++++++
> > > >  drivers/misc/dlb/dlb_main.h          |  37 ++++
> > > >  10 files changed, 522 insertions(+)
> > > >  create mode 100644 Documentation/misc-devices/dlb.rst
> > > >  create mode 100644 drivers/misc/dlb/Kconfig
> > > >  create mode 100644 drivers/misc/dlb/Makefile
> > > >  create mode 100644 drivers/misc/dlb/dlb_hw_types.h
> > > >  create mode 100644 drivers/misc/dlb/dlb_main.c
> > > >  create mode 100644 drivers/misc/dlb/dlb_main.h
> > > >
> > > > diff --git a/Documentation/misc-devices/dlb.rst b/Documentation/misc-
> > devices/dlb.rst
> > > > new file mode 100644
> > > > index 000000000000..aa79be07ee49
> > > > --- /dev/null
> > > > +++ b/Documentation/misc-devices/dlb.rst
> > > > @@ -0,0 +1,259 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +===========================================
> > > > +Intel(R) Dynamic Load Balancer Overview
> > > > +===========================================
> > > > +
> > > > +:Authors: Gage Eads and Mike Ximing Chen
> > > > +
> > > > +Contents
> > > > +========
> > > > +
> > > > +- Introduction
> > > > +- Scheduling
> > > > +- Queue Entry
> > > > +- Port
> > > > +- Queue
> > > > +- Credits
> > > > +- Scheduling Domain
> > > > +- Interrupts
> > > > +- Power Management
> > > > +- User Interface
> > > > +- Reset
> > > > +
> > > > +Introduction
> > > > +============
> > > > +
> > > > +The Intel(r) Dynamic Load Balancer (Intel(r) DLB) is a PCIe device that
> > > > +provides load-balanced, prioritized scheduling of core-to-core
> > communication.
> > > > +
> > > > +Intel DLB is an accelerator for the event-driven programming model of
> > > > +DPDK's Event Device Library[2]. The library is used in packet processing
> > > > +pipelines that arrange for multi-core scalability, dynamic load-balancing,
> > and
> > > > +variety of packet distribution and synchronization schemes.
> > >
> > > As this is a networking related thing, I would like you to get the
> > > proper reviews/acks from the networking maintainers before I can take
> > > this.
> > >
> > > Or, if they think it has nothing to do with networking, that's fine too,
> > > but please do not try to route around them.
> > 
> > To be clear, I did not sense any attempt to route around networking
> > review as it appeared generically centered around hardware accelerated
> > IPC. At the same time I don't know what I don't know about how this
> > might interact with networking initiatives so the review trip seems
> > reasonable to me.
> 
> Hi Greg,
> 
> While waiting for the feedback from the networking maintainers, I am
> wondering if you have any other comments/suggestions that I  should address
> in parallel.

It's in my "to-review" queue, which is huge at the moment.  But the
networking developers review will determine how this should go forward,
so I'll just wait for them to get to it.

thanks,

greg k-h
