Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64296327C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhCAKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234655AbhCAKqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:46:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DA664DB2;
        Mon,  1 Mar 2021 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614595569;
        bh=HXw4HIPStfhGkLrnF2qRO0EDkKdkyxdus6C11B++ZeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvCnCWIv0qBLLsPtph+iQ5qZOzuWRXTUvnJ0lEYbBQhgHV0MCeX7JYUHDSk+khZY6
         9HaVmUgs5pltmAROF8lTYunXVqj8ismHvdSVzfDqSJv7JPYBMVAS9KjJAbKP2WJ6ZX
         RwiWpvPnGRN/eexHOW5AA5Bnt7Z+/l0bfRx+I1z0=
Date:   Mon, 1 Mar 2021 11:46:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
Message-ID: <YDzF7sGvshN2SG5Q@kroah.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
 <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
 <85ft1fjhws.fsf@linux.intel.com>
 <YDzAY8j6R87BFFI/@kroah.com>
 <85czwjjh3b.fsf@linux.intel.com>
 <85a6rnjgys.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a6rnjgys.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:39:23AM +0100, Maciej Kwapulinski wrote:
> 
> Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com> writes:
> 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >
> >> On Mon, Mar 01, 2021 at 11:18:59AM +0100, Maciej Kwapulinski wrote:
> >>> 
> >>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> >>> 
> >>> > On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
> >>> > <maciej.kwapulinski@linux.intel.com> wrote:
> >>> >>
> >>> ....
> >>> >> +static int __init gna_drv_init(void)
> >>> >> +{
> >>> >> +       int ret;
> >>> >> +
> >>> >> +       mutex_init(&gna_drv_priv.lock);
> >>> >> +
> >>> >> +       gna_class = class_create(THIS_MODULE, "gna");
> >>> >> +       if (IS_ERR(gna_class)) {
> >>> >> +               pr_err("class device create failed\n");
> >>> >> +               return PTR_ERR(gna_class);
> >>> >> +       }
> >>> >> +       gna_class->devnode = gna_devnode;
> >>> >> +
> >>> >> +       ret = pci_register_driver(&gna_driver);
> >>> >
> >>> > Is it possible to decouple a PCI glue driver from the class as many
> >>> > other existing examples are doing?
> >>> >
> >>> 
> >>> I see many pci drivers (including staging) that do have it glued though.
> >>> 
> >>> Examples are:
> >>> 1. "static int __init kp2000_pcie_init(void)" (commit on May 20 09:34:11
> >>> 2019)
> >>> 2. "static int __init hl_init(void)" (commit on Mon Feb 18 09:46:43 2019)
> >>> 
> >>> Please give me more details.
> >>
> >> Never use a staging driver for any type of example, _EXECPT_ for a bad
> >> one.  There's a reason the code is in staging and not in the "real" part
> >> of the kernel.
> >
> > ok.
> >
> > another one (1) is not staging..
> 
> I meant "static int __init hl_init(void)" is not staging one....

Still doesn't mean it is a good thing to do.  Again, why isn't this
driver just using the misc driver interface instead?  It's much simpler
to use and should work just fine for this tiny driver, instead of having
to create a custom class just for it.

thanks,

greg k-h
