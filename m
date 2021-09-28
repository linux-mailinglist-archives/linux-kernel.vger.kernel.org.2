Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951B41A662
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhI1ETt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhI1ETo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:19:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A102A60FE3;
        Tue, 28 Sep 2021 04:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632802685;
        bh=yBitKBKAgLE4ulPlX3HMhKhMpQBqvjuOFFQmaCDT27E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZieJGm77q2ZvHLTHIlXZGwAVukchy3yejCqF3WMo5XFGGCxGIjbRnWBMwIjGSoDIE
         7zBgCCSaROEieFZC9PMVVbFQSpoipWxxMwyX5lJ4LYCwNCkfX5sfi/OFMFkD7oWfB0
         uYrF9N8Y+5cJGORwctit8HXbG2ZI8/2CqbDhdcCAErrajFtNsCYjG+m09O1hpTYcns
         2dpzZDWH43Qyy8AgPSbCFhitvn32pN0nS5NNZgQgFRs5jV2n24s8uhCmcWz30TKix6
         eCYu42ghyYZ2ja47EwCMs8jGg/d1fbsW+zHYazxzpBOYIKkIGDP6nbk2qpVq3ClN7e
         smWR0a5Wa25Hw==
Date:   Mon, 27 Sep 2021 21:18:05 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Juergen Gross <jgross@suse.com>
cc:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "julien@xen.org" <julien@xen.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] xen-pciback: prepare for the split for stub and
 PV
In-Reply-To: <1cf5fbf3-6453-e258-3940-8b5bb96117b6@suse.com>
Message-ID: <alpine.DEB.2.21.2109272112150.5022@sstabellini-ThinkPad-T480s>
References: <20210927065822.350973-1-andr2000@gmail.com> <e472468a-625e-6c4d-a9c2-85594e2ff908@suse.com> <accd0220-a9d7-145b-6632-9dee085ffc65@epam.com> <1cf5fbf3-6453-e258-3940-8b5bb96117b6@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021, Juergen Gross wrote:
> On 27.09.21 09:35, Oleksandr Andrushchenko wrote:
> > 
> > On 27.09.21 10:26, Jan Beulich wrote:
> > > On 27.09.2021 08:58, Oleksandr Andrushchenko wrote:
> > > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > > 
> > > > Currently PCI backend implements multiple functionalities at a time.
> > > > To name a few:
> > > > 1. It is used as a database for assignable PCI devices, e.g. xl
> > > >      pci-assignable-{add|remove|list} manipulates that list. So,
> > > > whenever
> > > >      the toolstack needs to know which PCI devices can be passed through
> > > >      it reads that from the relevant sysfs entries of the pciback.
> > > > 2. It is used to hold the unbound PCI devices list, e.g. when passing
> > > >      through a PCI device it needs to be unbound from the relevant
> > > > device
> > > >      driver and bound to pciback (strictly speaking it is not required
> > > >      that the device is bound to pciback, but pciback is again used as a
> > > >      database of the passed through PCI devices, so we can re-bind the
> > > >      devices back to their original drivers when guest domain shuts
> > > > down)
> > > > 3. Device reset for the devices being passed through
> > > > 4. Para-virtualised use-cases support
> > > > 
> > > > The para-virtualised part of the driver is not always needed as some
> > > > architectures, e.g. Arm or x86 PVH Dom0, are not using backend-frontend
> > > > model for PCI device passthrough. For such use-cases make the very
> > > > first step in splitting the xen-pciback driver into two parts: Xen
> > > > PCI stub and PCI PV backend drivers.
> > > > 
> > > > Signed-off-by: Oleksandr Andrushchenko
> > > > <oleksandr_andrushchenko@epam.com>
> > > > 
> > > > ---
> > > > Changes since v3:
> > > > - Move CONFIG_XEN_PCIDEV_STUB to the second patch
> > > I'm afraid this wasn't fully done:
> > > 
> > > > --- a/drivers/xen/xen-pciback/Makefile
> > > > +++ b/drivers/xen/xen-pciback/Makefile
> > > > @@ -1,5 +1,6 @@
> > > >    # SPDX-License-Identifier: GPL-2.0
> > > >    obj-$(CONFIG_XEN_PCIDEV_BACKEND) += xen-pciback.o
> > > > +obj-$(CONFIG_XEN_PCIDEV_STUB) += xen-pciback.o
> > > While benign when added here, this addition still doesn't seem to
> > > belong here.
> > 
> > My bad. So, it seems without CONFIG_XEN_PCIDEV_STUB the change seems
> > 
> > to be non-functional. With CONFIG_XEN_PCIDEV_STUB we fail to build on 32-bit
> > 
> > architectures...
> > 
> > What would be the preference here? Stefano suggested that we still define
> > 
> > CONFIG_XEN_PCIDEV_STUB, but in disabled state, e.g. we add tristate to it
> > 
> > in the second patch
> > 
> > Another option is just to squash the two patches.
> 
> Squashing would be fine for me.
 
It is fine for me to squash the two patches.

But in any case, wouldn't it be better to modify that specific change to:

diff --git a/drivers/xen/xen-pciback/Makefile b/drivers/xen/xen-pciback/Makefile
index e2cb376444a6..e23c758b85ae 100644
--- a/drivers/xen/xen-pciback/Makefile
+++ b/drivers/xen/xen-pciback/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_XEN_PCIDEV_BACKEND) += xen-pciback.o
-obj-$(CONFIG_XEN_PCIDEV_STUB) += xen-pciback.o
+obj-$(CONFIG_XEN_PCI_STUB) += xen-pciback.o
 
 xen-pciback-y := pci_stub.o pciback_ops.o xenbus.o
 xen-pciback-y += conf_space.o conf_space_header.o \


instead?
