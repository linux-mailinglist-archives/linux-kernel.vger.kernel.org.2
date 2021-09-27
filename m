Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5C419D03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhI0RhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:37:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:46134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239261AbhI0RfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:35:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288185019"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="288185019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 10:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="615905152"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2021 10:27:28 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 939735802BD;
        Mon, 27 Sep 2021 10:27:28 -0700 (PDT)
Message-ID: <7295cafaf6da34e31390fe621198205d18eac525.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Mon, 27 Sep 2021 10:27:28 -0700
In-Reply-To: <YVFC0U+wOqbTgDhy@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
         <20210924213157.3584061-2-david.e.box@linux.intel.com>
         <YU7BPIH123HUZKhw@kroah.com>
         <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
         <YVFC0U+wOqbTgDhy@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-27 at 06:04 +0200, Greg KH wrote:
> On Sun, Sep 26, 2021 at 06:15:16PM -0700, David E. Box wrote:
> > > > +static struct platform_driver sdsi_driver = {
> > > > +       .driver = {
> > > > +               .name           = SDSI_DEV_NAME,
> > > > +               .dev_groups     = sdsi_groups,
> > > > +       },
> > > > +       .probe  = sdsi_probe,
> > > > +       .remove = sdsi_remove,
> > > > +};
> > > > +module_platform_driver(sdsi_driver);
> > > 
> > > What causes the platform to know to register, and enable, this platform
> > > driver?  Shouldn't there be some hardware involved that is discoverable
> > > to enable it to load dynamically?
> > 
> > Ah. The patch that adds the SDSi platform device string was added to a series for the intel_pmt
> > MFD
> > driver and it's still waiting review. I see that complicates things. I can combine the two series
> > together.
> 
> Do you have a pointer to the lore.kernel.org location of that series?

https://lore.kernel.org/all/20210922213007.2738388-1-david.e.box@linux.intel.com/

> 
> Your code right here will bind to any system that it is loaded on, a
> very dangerous thing...

It won't. It uses module alias to load against the SDSi specific MFD cell.

> 
> thanks,
> 
> greg k-h


