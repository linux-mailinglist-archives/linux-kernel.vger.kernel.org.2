Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1C459CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhKWHg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhKWHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:36:57 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:33:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id f20so19029763qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 23:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LuChIw9xMWFBmqNMQjSpCC5rOutc4R3W8vDGlVokDCo=;
        b=bH28N4Eoz+66UT3Vnsv4YfyVVKTTvYDiyzWvuqVjcsgoB/xKqrJ7wojknNFQYJDQhk
         053yFMIlWMdS7Pf4W5J4X6g6bVqNkdOZ7rI2Yhzoo/p3JQYPvcbwz7JHnp6FAG6+8LHq
         qKBK80hwRR9oclLqrQY81fHY9w7BLI/ikURIzuj57ENNoGGMbuhRoPxJRmkXxmCBLFuo
         pq74rWRu8mwY/0FpyCGV1aV7siSN0FQafG8Nz9vZzElQkHOXUeJ31RHMDMfGw57Ba+PY
         AxROIXrDdDMabaJ2n7dZFgVNMCUREM6A9hvpMpJYzzU82InNy1CeapJ2ivSeIMfmRRZM
         3OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LuChIw9xMWFBmqNMQjSpCC5rOutc4R3W8vDGlVokDCo=;
        b=z37bwAcr7F8iAOzXvGlqLWYYll+Q06lhkODruA/334Eyuacb0xB2DlXPBai7zeU4uH
         hn4wwoLvGsabsXxmG9EykNmmzJtBLIXpW8va8Fvc7Z5PQPcKpA0nYlWmhCb8GCtvvSG/
         Wzp5puV8sM0r853U5amMMIS3y7u/AkHihFSGIZnQkdVMNGY1wTKkcx9xstWquy+yN/PD
         YrdskeyeXidBBvCw41UXUMaC6W694nzq4k+zCsTrF6NJbKMXFuNlkZq3X72ibTxjctaA
         oCuJG1dIn/yTvwuufpWImM8kKzoCDVhq/Ot7jSQiW5ZPTaYUkJjhAS8WBrI1Su2GFof5
         XnZA==
X-Gm-Message-State: AOAM530f7zGjBOhUQiFRgr50uDJR0yvvW0tRu+f6uT1y697btR8s9NqJ
        LAkKzVjwyrhRk7YVAkp33uw=
X-Google-Smtp-Source: ABdhPJzdEVpbGAmKCEl8MWW+gPNaScEM8B1aKIVYZ1soywOtilqDVn2XZ6l4cdWyK22Xht3vpeT/uA==
X-Received: by 2002:a05:622a:3d3:: with SMTP id k19mr3892721qtx.334.1637652828466;
        Mon, 22 Nov 2021 23:33:48 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id j20sm6495481qko.117.2021.11.22.23.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 23:33:47 -0800 (PST)
Date:   Mon, 22 Nov 2021 23:33:46 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20211123073346.GA1628@lapt>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <20211122175414.GA1588@lapt>
 <9b524543-e868-7b9d-aae7-97c47f41db52@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b524543-e868-7b9d-aae7-97c47f41db52@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:26:56AM +0000, Vaittinen, Matti wrote:
> Morning <please apply local timezone> Yuru, & all,
> 
> On 11/22/21 19:54, Yury Norov wrote:
> > On Mon, Nov 22, 2021 at 02:57:27PM +0200, Andy Shevchenko wrote:
> >> On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> >>> On 11/22/21 13:28, Andy Shevchenko wrote:
> >>>> On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> >>>>> There are cases when it is useful to check a bit-mask has only one bit
> >>>>> set. Add a generic helper for it instead of baking own one for each
> >>>>> user.
> >>
> >>>> So, you decided to reinvent hamming weight...
> >>>> Please, drop this patch and use corresponding hweight() call.
> >>
> >>> Thanks Andy.
> >>>
> >>> There are few differences to hamming weight here. We scan only given
> >>> amount of bits - and we will end scanning immediately when we hit second
> >>> set bit. Oh, and obviously we only return information whether there is
> >>> exactly one bit set. So no, this is not hamming weight().
> >>
> >> What do you mean by this?
> >>
> >> hweight() will return you the number of the non-zero elements in the set.
> >> In application to boolean based arrays it means the number of bits that
> >> are set. Obviously, the condition `hweight() == 1` is what you are looking
> >> for.
> > 
> > Hi Andy,
> > 
> > I think, Matti means earlier return when part of bitmap counts set
> > bits to a greater nubmer, and we can skip the rest. Right, Matti?
> 
> Yes.
> 
> > But in general, it might be useful for long bitmaps.
> > 
> > The more complete way of doing this would be adding a new set of
> > functions: bitmap_weight_{eq,neq,gt,le}
> > 
> > I'm looking at how bitmap_weight is used in the kernel and see
> > quite a lot of places where this optimization may take place. For
> > example otx2_remove_flow() in drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:
> > 
> >          if (bitmap_weight(&flow_cfg->dmacflt_bmap,
> >                            flow_cfg->dmacflt_max_flows) == 1)
> >                  otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
> > 
> > may be replaced with:
> > 
> >          if (bitmap_weight_eq(&flow_cfg->dmacflt_bmap, flow_cfg->dmacflt_max_flows, 1)
> >                  otx2_update_rem_pfmac(pfvf, DMAC_ADDR_DEL);
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
> My uneducated opinion (for what it matters :]) is thet the cost of 
> adding such functions is negligible so I am all for adding them if there 
> are even few users who can benefit from those.

I think I changed my opinion. We have enough examples of opencoded
bitmap_weight_{eq,...} in core code which will definitely benefit
from this optimization. For example, sched_cpu_activate:

         if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
                 static_branch_inc_cpuslocked(&sched_smt_present);

Considering computers with thousands of CPUs, early return would save a
lot. 

I'll take a look on it at this weekend.
