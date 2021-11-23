Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFE45A09D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhKWKur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:50:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:10134 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhKWKuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:50:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="235234935"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="235234935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 02:47:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="456659436"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 02:47:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpTKk-009kiM-OV;
        Tue, 23 Nov 2021 12:47:30 +0200
Date:   Tue, 23 Nov 2021 12:47:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <YZzGwubCr8RZtbFM@smile.fi.intel.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
 <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:42:45AM +0000, David Laight wrote:
> From: Vaittinen, Matti
> > Sent: 22 November 2021 13:19
> > 
> > On 11/22/21 14:57, Andy Shevchenko wrote:
> > > On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > >> On 11/22/21 13:28, Andy Shevchenko wrote:
> > >>> On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> > >
> > > What do you mean by this?
> > >
> > > hweight() will return you the number of the non-zero elements in the set.
> > 
> > Exactly. The function I added did only check if given set of bits had
> > only one bit set.
> 
> Checking for exactly one bit can use the (x & (x - 1)) check on
> non-zero values - which may even be better on some cpus with a
> popcnt instruction.

In the discussed case the value pretty much can be 0, meaning you have
to add an additional test which I believe diminishes all efforts for
the is_power_of_2() call.

-- 
With Best Regards,
Andy Shevchenko


