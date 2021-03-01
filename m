Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81E327C04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhCAKZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhCAKXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:23:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C50DE64E13;
        Mon,  1 Mar 2021 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614594150;
        bh=cXpAgN4LikCvbKoWKcp8iBPz7XpWuUo9aOcmE7Nu8Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2oUweW1E1knpm3/rH0BBQEGcc5mipD7kWYJOFPI7F5JCyW9+zVLQrrbZLHQu2VB2
         B7Pd6M8wqL2IR70lVqSL9Bdpyz+yJO798HbX6G/4QX+DDSFvXzaVlUCzMx0yhz2dy7
         4zOFwzwCvruIO5kbi8S5xCDZszIrHyuT3h5rPK1o=
Date:   Mon, 1 Mar 2021 11:22:27 +0100
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
Message-ID: <YDzAY8j6R87BFFI/@kroah.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
 <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com>
 <85ft1fjhws.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ft1fjhws.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:18:59AM +0100, Maciej Kwapulinski wrote:
> 
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> 
> > On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
> > <maciej.kwapulinski@linux.intel.com> wrote:
> >>
> ....
> >> +static int __init gna_drv_init(void)
> >> +{
> >> +       int ret;
> >> +
> >> +       mutex_init(&gna_drv_priv.lock);
> >> +
> >> +       gna_class = class_create(THIS_MODULE, "gna");
> >> +       if (IS_ERR(gna_class)) {
> >> +               pr_err("class device create failed\n");
> >> +               return PTR_ERR(gna_class);
> >> +       }
> >> +       gna_class->devnode = gna_devnode;
> >> +
> >> +       ret = pci_register_driver(&gna_driver);
> >
> > Is it possible to decouple a PCI glue driver from the class as many
> > other existing examples are doing?
> >
> 
> I see many pci drivers (including staging) that do have it glued though.
> 
> Examples are:
> 1. "static int __init kp2000_pcie_init(void)" (commit on May 20 09:34:11
> 2019)
> 2. "static int __init hl_init(void)" (commit on Mon Feb 18 09:46:43 2019)
> 
> Please give me more details.

Never use a staging driver for any type of example, _EXECPT_ for a bad
one.  There's a reason the code is in staging and not in the "real" part
of the kernel.

thanks,

greg k-h
