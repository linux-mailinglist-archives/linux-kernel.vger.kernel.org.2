Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18496459ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhKWJG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:06:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:53754 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhKWJG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:06:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215013724"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="215013724"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:03:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="606749898"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 01:03:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpRiH-009j5i-QC;
        Tue, 23 Nov 2021 11:03:41 +0200
Date:   Tue, 23 Nov 2021 11:03:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Message-ID: <YZyubUvWW98ThOPe@smile.fi.intel.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <20211122175414.GA1588@lapt>
 <9b524543-e868-7b9d-aae7-97c47f41db52@fi.rohmeurope.com>
 <20211123073346.GA1628@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123073346.GA1628@lapt>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:33:46PM -0800, Yury Norov wrote:
> On Tue, Nov 23, 2021 at 05:26:56AM +0000, Vaittinen, Matti wrote:
> > On 11/22/21 19:54, Yury Norov wrote:
> > > On Mon, Nov 22, 2021 at 02:57:27PM +0200, Andy Shevchenko wrote:
> > >> On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > >>> On 11/22/21 13:28, Andy Shevchenko wrote:
> > >>>> On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:

...

> > >>>> So, you decided to reinvent hamming weight...
> > >>>> Please, drop this patch and use corresponding hweight() call.
> > >>
> > >>> Thanks Andy.
> > >>>
> > >>> There are few differences to hamming weight here. We scan only given
> > >>> amount of bits - and we will end scanning immediately when we hit second
> > >>> set bit. Oh, and obviously we only return information whether there is
> > >>> exactly one bit set. So no, this is not hamming weight().
> > >>
> > >> What do you mean by this?
> > >>
> > >> hweight() will return you the number of the non-zero elements in the set.
> > >> In application to boolean based arrays it means the number of bits that
> > >> are set. Obviously, the condition `hweight() == 1` is what you are looking
> > >> for.
> > > 
> > > Hi Andy,
> > > 
> > > I think, Matti means earlier return when part of bitmap counts set
> > > bits to a greater nubmer, and we can skip the rest. Right, Matti?
> > 
> > Yes.
> > 
> > > But in general, it might be useful for long bitmaps.
> > > 
> > > The more complete way of doing this would be adding a new set of
> > > functions: bitmap_weight_{eq,neq,gt,le}
> > > 
> > > I'm looking at how bitmap_weight is used in the kernel and see
> > > quite a lot of places where this optimization may take place. For
> > > example otx2_remove_flow() in drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:
> > > 
> > >          if (bitmap_weight(&flow_cfg->dmacflt_bmap,
> > >                            flow_cfg->dmacflt_max_flows) == 1)
> > >                  otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> > > 
> > > may be replaced with:
> > > 
> > >          if (bitmap_weight_eq(&flow_cfg->dmacflt_bmap, flow_cfg->dmacflt_max_flows, 1)
> > >                  otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> > > 
> > > Most of that places are in drivers however, and the length of bitmaps
> > > there is typically small, so that there's no chance to get any
> > > measurable performance improvement.
> > > 
> > > There is always a chance that we have opencoded bitmap_weight_eq()
> > > et all. If we add these API, it might help people wright better code.
> > > 
> > > What do you think?
> > 
> > My uneducated opinion (for what it matters :]) is thet the cost of 
> > adding such functions is negligible so I am all for adding them if there 
> > are even few users who can benefit from those.
> 
> I think I changed my opinion. We have enough examples of opencoded
> bitmap_weight_{eq,...} in core code which will definitely benefit
> from this optimization. For example, sched_cpu_activate:
> 
>          if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
>                  static_branch_inc_cpuslocked(&sched_smt_present);
> 
> Considering computers with thousands of CPUs, early return would save a
> lot. 
> 
> I'll take a look on it at this weekend.

Be sure you get better assembly in these cases. As I have told already,
hweight() is a single assembly instruction, I'm not sure open coded variant
may be better even for long bitmaps. That said, assembly comparison and
some performance tests would be nice to have.

As an API per se it might make sense to have such, but you know that we don't
add it without users.

-- 
With Best Regards,
Andy Shevchenko


