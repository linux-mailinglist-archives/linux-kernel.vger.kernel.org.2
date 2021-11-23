Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A0459D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhKWHyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhKWHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:54:50 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37489C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:51:43 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i13so14365517qvm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yvOcIM2j3nZzor18Y5QvSHxXmcg0lQaJBQsgeAYhYDE=;
        b=X2vIXZM01hoVvANS/dBeyUsKI9ofdstJQdNo443dqZzYdV6jl2LA9Ppc/mLpZfM5oU
         s1D29/wb86e6HQvFrPIm0MHraXZ97tYRIP9ja5BKDYLb/KvTOnPKbZHa6K4yaW0o89kH
         jxdsKtKFu3wDWvcq1pVBOawiA6BTjp8SImw1JvTGcz017r3Gfk9b1CuLD6KpsRkn+w41
         wVIBYom5kNzWwv0uArfnY76rfA1LPUfe3/W+sJpiVe/tAt7W2pVd2bURJ9XoqCmDXUvz
         4AMRObZgzstJJ58jjWvJGPcYLJfWysqQ4jVik7ORgadxxrs9xniUSFz4TsWspZ7+VGHM
         HjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvOcIM2j3nZzor18Y5QvSHxXmcg0lQaJBQsgeAYhYDE=;
        b=cuIE1UPvqOpsdd7fXoYcFG6wbSueOT3xGZGiLxHV/RAUWRxZia2o3LK1y6iSPcNwZV
         5GC9VSeuIC1gktufTfst020KiaIxlssXCqDOXtD4lIvhM/Nvcm+s+SQviDKRlqwTtlZm
         g7uCn9eL2jDd/O0SA0Z/G3FMXrGAU23xqh58Dx1saakr16GQVSQXUvHQyy9T4nfh1Q5A
         js88IfD48TTf4BokroyRVZN75UcyMeuV3ulc76f8mwP6Ss9epcp/9NhqjxlPWD2+2O7t
         HAlk19MSdN9u3d+clVccWGNe9qx1n7PvOYrKck8KY0MTW3zZ9+LX2xXHicITbqzH3Mpd
         xBvQ==
X-Gm-Message-State: AOAM531C4FJbcu8c5GhHR5ihZ68TfIHY+0Idjm6Ghi9VNoTvHbyKxZJP
        tbNlfYiZ1je9fIkDl76UKZc=
X-Google-Smtp-Source: ABdhPJxyOwgLpsaDhS4dDED1azy6c4FZd6kIJ75b49VhhDmLxGV1+dnnKDzTPAAftSsY4YCHvi7XfA==
X-Received: by 2002:ad4:5f87:: with SMTP id jp7mr3883056qvb.28.1637653902273;
        Mon, 22 Nov 2021 23:51:42 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id r26sm5442501qtm.67.2021.11.22.23.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 23:51:41 -0800 (PST)
Date:   Mon, 22 Nov 2021 23:51:40 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20211123075140.GB1628@lapt>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <20211122175414.GA1588@lapt>
 <YZv1/vKe46jmRMJa@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZv1/vKe46jmRMJa@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 09:56:46PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 09:54:14AM -0800, Yury Norov wrote:
> > On Mon, Nov 22, 2021 at 02:57:27PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> > > > On 11/22/21 13:28, Andy Shevchenko wrote:
> > > > > On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> > > > >> There are cases when it is useful to check a bit-mask has only one bit
> > > > >> set. Add a generic helper for it instead of baking own one for each
> > > > >> user.
> > > 
> > > > > So, you decided to reinvent hamming weight...
> > > > > Please, drop this patch and use corresponding hweight() call.
> > > 
> > > > Thanks Andy.
> > > > 
> > > > There are few differences to hamming weight here. We scan only given 
> > > > amount of bits - and we will end scanning immediately when we hit second 
> > > > set bit. Oh, and obviously we only return information whether there is 
> > > > exactly one bit set. So no, this is not hamming weight().
> > > 
> > > What do you mean by this?
> > > 
> > > hweight() will return you the number of the non-zero elements in the set.
> > > In application to boolean based arrays it means the number of bits that
> > > are set. Obviously, the condition `hweight() == 1` is what you are looking
> > > for.
> > 
> > Hi Andy,
> > 
> > I think, Matti means earlier return when part of bitmap counts set
> > bits to a greater nubmer, and we can skip the rest. Right, Matti?
> > 
> > I agree that for Matti's usecase it's useless because 32-bit int is small,
> > and hweight() would count set bits with a single machine instruction. (And
> > it should be hweight32(), not bitmap_weight() in this case.)
> > 
> > But in general, it might be useful for long bitmaps.
> > 
> > The more complete way of doing this would be adding a new set of
> > functions: bitmap_weight_{eq,neq,gt,le}
> > 
> > I'm looking at how bitmap_weight is used in the kernel and see
> > quite a lot of places where this optimization may take place. For
> > example otx2_remove_flow() in drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:
> > 
> >         if (bitmap_weight(&flow_cfg->dmacflt_bmap,
> >                           flow_cfg->dmacflt_max_flows) == 1)
> >                 otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> > 
> > may be replaced with:
> > 
> >         if (bitmap_weight_eq(&flow_cfg->dmacflt_bmap, flow_cfg->dmacflt_max_flows, 1)
> >                 otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> > 
> > Most of that places are in drivers however, and the length of bitmaps
> > there is typically small, so that there's no chance to get any
> > measurable performance improvement.
> > 
> > There is always a chance that we have opencoded bitmap_weight_eq()
> > et all. If we add these API, it might help people wright better code.
> > 
> > What do you think?
> 
> Before answering this I would like to see how hweight() is currently being used
> in the kernel against bitmaps. Like histogram collection

hweight() is not used against bitmap. We have bitmap_weight() for it.
 
> 	comparison number	number of usages
> 	variadic			X
> 	1				Y
> 	2				Z
> 	...				...

I don't think it would be helpful to build this histogram. For the
proposed optimization it's (almost) not important what number is
compared against bitmap_weight().

The important thing is that some callers in core code can save 
measurable amount of time if we switch them from
        bitmap_weight() == XXX
to
        bitmap_weight_eq(..., XXX)

Consider cpumask_weight and nodes_weight.
