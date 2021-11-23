Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9D45A40A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhKWNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:46:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:21270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhKWNqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:46:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="232513571"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="232513571"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:43:27 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="674470888"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:43:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpW4u-009nAU-5G;
        Tue, 23 Nov 2021 15:43:20 +0200
Date:   Tue, 23 Nov 2021 15:43:19 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Vaittinen, Matti'" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Message-ID: <YZzv93tdAJ5V6MT2@smile.fi.intel.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
 <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
 <YZzGwubCr8RZtbFM@smile.fi.intel.com>
 <89f18bd93ce545feb7a02889ae49f079@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f18bd93ce545feb7a02889ae49f079@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:58:44AM +0000, David Laight wrote:
> From: Andy Shevchenko
> > On Tue, Nov 23, 2021 at 10:42:45AM +0000, David Laight wrote:
> > > From: Vaittinen, Matti
> > > > Sent: 22 November 2021 13:19
> > > > On 11/22/21 14:57, Andy Shevchenko wrote:
> > > > > On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > > > >> On 11/22/21 13:28, Andy Shevchenko wrote:
> > > > >>> On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> > > > >
> > > > > What do you mean by this?
> > > > >
> > > > > hweight() will return you the number of the non-zero elements in the set.
> > > >
> > > > Exactly. The function I added did only check if given set of bits had
> > > > only one bit set.
> > >
> > > Checking for exactly one bit can use the (x & (x - 1)) check on
> > > non-zero values - which may even be better on some cpus with a
> > > popcnt instruction.
> > 
> > In the discussed case the value pretty much can be 0, meaning you have
> > to add an additional test which I believe diminishes all efforts for
> > the is_power_of_2() call.
> 
> I wouldn't have thought so.
> Code would be:
> 	if (!scan_for_non_zero())
> 		return 0;
> 	if (!is_power_of_2())
> 		return 0;
> 	return scan_for_non_zero() ? 0 : 1;
> 
> Hand-crafting asm you'd actually check for (x - 1) generating
> carry in the initial scan.

Have you done any benchmarks? Can we see them?

> The latency of popcnt it worse than arithmetic on a lot of x86 cpu.

Ditto.


-- 
With Best Regards,
Andy Shevchenko


