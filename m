Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823F73BEA17
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhGGOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhGGOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:52:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0003C061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:49:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r20so3013421ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Vn+em1ID7ATdxCUA5IBEHrTiU+3PNuM9csIImsnZbc=;
        b=Zlq24O50WWP45T38/kEVFhaAkqqzwT7Ed8S+ZwVjEDWxTuYEayH8ZTypGlpMTbkKf5
         b0ZE32ZadrUa0l91Z+oMIhYvd74uIbmOW7Hctd9J7XpqoJAbiPM6iuDb0x1LW68IlAzw
         bAqg+Ly+Zft9sx/MhJ7qtnpaLEitgMryf2ypy+iQ/HofEPCWQDLEk0pVRbKchlA0ODgP
         7JLVv8BVbTLuCzH5+jcDGaO2duzQ4KOt5iIFg/9JRKt8YQN9PXYWF5K2hYP/l0xQDtzp
         vF+yPPW+5lyzVRy+udzx2ncIj9e0lBzBTRvU2RFORziWLNYUXP/ERk+nLl8L+EzMX0MT
         lyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Vn+em1ID7ATdxCUA5IBEHrTiU+3PNuM9csIImsnZbc=;
        b=LrteLHCVJbEa9f42o7xwkZLhY6ZudjgVerxE9yW+3NIwZVKzpOODot/LhFS2fxhSSr
         r3m8MLpPgPE6K3XQpEpEEN5cTsKkA5lNePDiXTY7B4THy3/IWwB7eclkeN2eQaccL6AM
         44EFabJ+TIpVK1b0Dw9Bp3tPDprNQPjZT72mn4plc9+E4P27rObcZSVJQ4bIquBSUMuY
         BtP+yG982j2cY3YOtTdbJ2HBsuADQwkhpjXDt1fznZ0QY0LOoW4NYyOrY1Q5DdKtOb+A
         0g3Xq62Hsg3UobKCHzYTcOa++luceFGPPK8GH17/sKSMRorPi0g1lK9ePtLE3DBRtGvS
         isBQ==
X-Gm-Message-State: AOAM530FH8CJku6DlDYMobElzSRmXeOZfqfxtuF+JQFmBEXeLQKxJmGu
        yI2rjwE4i8d3/Xeq90x/+Do=
X-Google-Smtp-Source: ABdhPJyJPXRoC4JT8C/knZ1R9nSnqASINy4wLHxvoEuE3hPsUPVsQiY/TIQxVS/ngtkA+4iQRcnCGg==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr2117588ljj.90.1625669363318;
        Wed, 07 Jul 2021 07:49:23 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u11sm1506554lja.129.2021.07.07.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 07:49:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 7 Jul 2021 16:49:21 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Use batched page requests in
 bulk-allocator
Message-ID: <20210707144921.GC1863@pc638.lan>
References: <20210705170537.43060-1-urezki@gmail.com>
 <20210706132653.8374852963b25989e360d599@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706132653.8374852963b25989e360d599@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 01:26:53PM -0700, Andrew Morton wrote:
> On Mon,  5 Jul 2021 19:05:36 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > In case of simultaneous vmalloc allocations, for example it is 1GB and
> > 12 CPUs my system is able to hit "BUG: soft lockup" for !CONFIG_PREEMPT
> > kernel.
> > 
> > <snip>
> > ...
> >
> > are obtained, i.e. do batched page requests adding cond_resched() meanwhile
> > to reschedule. Batched value is hard-coded and is 100 pages per call.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Can we please have a Fixes: for this?
> 
> Is this fix important enough for 4.14-rcx?  I think so...
> 
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2785,10 +2785,32 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  	 * to fails, fallback to a single page allocator that is
> >  	 * more permissive.
> >  	 */
> > -	if (!order)
> > -		nr_allocated = alloc_pages_bulk_array_node(
> > -			gfp, nid, nr_pages, pages);
> > -	else
> > +	if (!order) {
> > +		while (nr_allocated < nr_pages) {
> > +			int nr, nr_pages_request;
> > +
> > +			/*
> > +			 * A maximum allowed request is hard-coded and is 100
> > +			 * pages per call. That is done in order to prevent a
> > +			 * long preemption off scenario in the bulk-allocator
> > +			 * so the range is [1:100].
> > +			 */
> > +			nr_pages_request = min(100, (int)(nr_pages - nr_allocated));
> 
> Yes, they types are all over the place.
> 
> nr_pages: unsigned long
> nr_allocated: unsigned int
> nr, nr_pages_request: int
> 
> Can we please choose the most appropriate type and use that
> consistently?
> 
Let me think over it to see what i can do.

--
Vlad Rezki
