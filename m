Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A877B45EACF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376600AbhKZJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:58:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:29478 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhKZJ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:56:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="215664841"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="215664841"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:52:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="498356757"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:52:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqXuT-00Ak0b-Im;
        Fri, 26 Nov 2021 11:52:49 +0200
Date:   Fri, 26 Nov 2021 11:52:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH v1 00/10] misc: at25: Code cleanups and improvements
Message-ID: <YaCucfdYfGCuBBiS@smile.fi.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3Pu-ygd9dkhS=d2ZGKjbt0V=mdxaEG8tXUhueSKMJXQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Pu-ygd9dkhS=d2ZGKjbt0V=mdxaEG8tXUhueSKMJXQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:03:26PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 25, 2021 at 10:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Code cleanups and improvements. Please read individual commit messages.
> >
> > Series depends on the fixes series [1] sent earlier.
> >
> > [1]: https://lore.kernel.org/lkml/20211125212729.86585-2-andriy.shevchenko@linux.intel.com/T/#u
> >
> > Andy Shevchenko (10):
> >   misc: at25: Use at25->chip instead of local chip everywhere in
> >     ->probe()
> >   misc: at25: Unshadow error codes in at25_fw_to_chip()
> >   misc: at25: Check new property ("address-width") first
> >   misc: at25: Get platform data via dev_get_platdata()
> >   misc: at25: Get rid of intermediate storage for AT25 chip data
> >   misc: at25: Switch to use BIT() instead of custom approaches
> >   misc: at25: Factor out at_fram_to_chip()
> >   misc: at25: Reorganize headers for better maintenance
> >   misc: at25: Replace commas by spaces in the ID tables
> >   misc: at25: Align comment style
> 
> These also look good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thank you!

> It would be nice to change the three remaining board files that fill
> struct spi_eeprom so they use device properties and unify the
> rest of the probe path. Not sure how much of a change that would
> be.

Do you have a chance to test that if it appears to be the case?

-- 
With Best Regards,
Andy Shevchenko


