Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EAC45EB09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348175AbhKZKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:10:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:29576 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238722AbhKZKIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:08:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="215665448"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="215665448"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:59:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="498358086"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:59:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqY0o-00Ak6P-Vj;
        Fri, 26 Nov 2021 11:59:22 +0200
Date:   Fri, 26 Nov 2021 11:59:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH v1 00/10] misc: at25: Code cleanups and improvements
Message-ID: <YaCv+mkge5AqYm8R@smile.fi.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3Pu-ygd9dkhS=d2ZGKjbt0V=mdxaEG8tXUhueSKMJXQg@mail.gmail.com>
 <YaCucfdYfGCuBBiS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaCucfdYfGCuBBiS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:52:49AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 25, 2021 at 11:03:26PM +0100, Arnd Bergmann wrote:
> > On Thu, Nov 25, 2021 at 10:31 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > It would be nice to change the three remaining board files that fill
> > struct spi_eeprom so they use device properties and unify the
> > rest of the probe path. Not sure how much of a change that would
> > be.
> 
> Do you have a chance to test that if it appears to be the case?

There is one more, actually: arch/mips/txx9/generic/spi_eeprom.c.

But above perhaps some OMAP people can help with... Dunno.

-- 
With Best Regards,
Andy Shevchenko


