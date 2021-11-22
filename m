Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886844595D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbhKVUAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:00:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:36504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239711AbhKVUAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:00:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="214894091"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="214894091"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:56:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="456773329"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:56:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpFQl-009ZN3-31;
        Mon, 22 Nov 2021 21:56:47 +0200
Date:   Mon, 22 Nov 2021 21:56:46 +0200
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
Message-ID: <YZv1/vKe46jmRMJa@smile.fi.intel.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <20211122175414.GA1588@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122175414.GA1588@lapt>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 09:54:14AM -0800, Yury Norov wrote:
> On Mon, Nov 22, 2021 at 02:57:27PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > > On 11/22/21 13:28, Andy Shevchenko wrote:
> > > > On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> > > >> There are cases when it is useful to check a bit-mask has only one bit
> > > >> set. Add a generic helper for it instead of baking own one for each
> > > >> user.
> > 
> > > > So, you decided to reinvent hamming weight...
> > > > Please, drop this patch and use corresponding hweight() call.
> > 
> > > Thanks Andy.
> > > 
> > > There are few differences to hamming weight here. We scan only given 
> > > amount of bits - and we will end scanning immediately when we hit second 
> > > set bit. Oh, and obviously we only return information whether there is 
> > > exactly one bit set. So no, this is not hamming weight().
> > 
> > What do you mean by this?
> > 
> > hweight() will return you the number of the non-zero elements in the set.
> > In application to boolean based arrays it means the number of bits that
> > are set. Obviously, the condition `hweight() == 1` is what you are looking
> > for.
> 
> Hi Andy,
> 
> I think, Matti means earlier return when part of bitmap counts set
> bits to a greater nubmer, and we can skip the rest. Right, Matti?
> 
> I agree that for Matti's usecase it's useless because 32-bit int is small,
> and hweight() would count set bits with a single machine instruction. (And
> it should be hweight32(), not bitmap_weight() in this case.)
> 
> But in general, it might be useful for long bitmaps.
> 
> The more complete way of doing this would be adding a new set of
> functions: bitmap_weight_{eq,neq,gt,le}
> 
> I'm looking at how bitmap_weight is used in the kernel and see
> quite a lot of places where this optimization may take place. For
> example otx2_remove_flow() in drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:
> 
>         if (bitmap_weight(&flow_cfg->dmacflt_bmap,
>                           flow_cfg->dmacflt_max_flows) == 1)
>                 otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> 
> may be replaced with:
> 
>         if (bitmap_weight_eq(&flow_cfg->dmacflt_bmap, flow_cfg->dmacflt_max_flows, 1)
>                 otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> 
> Most of that places are in drivers however, and the length of bitmaps
> there is typically small, so that there's no chance to get any
> measurable performance improvement.
> 
> There is always a chance that we have opencoded bitmap_weight_eq()
> et all. If we add these API, it might help people wright better code.
> 
> What do you think?

Before answering this I would like to see how hweight() is currently being used
in the kernel against bitmaps. Like histogram collection

	comparison number	number of usages
	variadic			X
	1				Y
	2				Z
	...				...


-- 
With Best Regards,
Andy Shevchenko


