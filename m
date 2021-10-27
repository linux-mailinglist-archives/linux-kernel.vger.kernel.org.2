Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E810643C9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhJ0Md2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:33:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhJ0Md1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:33:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88CC41FD46;
        Wed, 27 Oct 2021 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635337861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ZGtK0xOo2bZRtxCSg2rXfX4YA6Rq3MqUKuL+bVoReU=;
        b=UI5frhLzPfdiR5xuYknfWR+Ixh2SjrSHGdOyajiaPJJjieIWqojZTa7UFWoBrfCROKw5Wh
        LKKhPBIn/apdHkrGtjlggB8yu63PuGIa1aa+1jDxwV9xE6Xo83ALVUFNo3nKqEabWEeM2z
        raoQc8T9XHaK8il6SUahiEcpoAExqUw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BB6DA3B83;
        Wed, 27 Oct 2021 12:31:01 +0000 (UTC)
Date:   Wed, 27 Oct 2021 14:31:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection
 on memcg
Message-ID: <YXlGhEDYtnKtwKUb@dhcp22.suse.cz>
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
 <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz>
 <CAGWkznHVHVBrQEiO32p2uX_5BDUMc1fE64KuV34WJfpwC_23Pw@mail.gmail.com>
 <YXkNJjD4axYlmqQ5@dhcp22.suse.cz>
 <CAGWkznHrZ=Y3kG5j5aYdTV2294QGrQbM6251zcdGphzCGUP6dw@mail.gmail.com>
 <YXk9a3X62vNTyvGE@dhcp22.suse.cz>
 <CAGWkznEZhPxgb_K2vcfyhnGufPMaX3ksxbJvQSurwkNtLKRTGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEZhPxgb_K2vcfyhnGufPMaX3ksxbJvQSurwkNtLKRTGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-10-21 20:05:30, Zhaoyang Huang wrote:
> On Wed, Oct 27, 2021 at 7:52 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 27-10-21 17:19:56, Zhaoyang Huang wrote:
> > > On Wed, Oct 27, 2021 at 4:26 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 27-10-21 15:46:19, Zhaoyang Huang wrote:
> > > > > On Wed, Oct 27, 2021 at 3:20 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > >
> > > > > > > For the kswapd only reclaiming, there is no chance to try again on
> > > > > > > this group while direct reclaim has. fix it by judging gfp flag.
> > > > > >
> > > > > > There is no problem description (same as in your last submissions. Have
> > > > > > you looked at the patch submission documentation as recommended
> > > > > > previously?).
> > > > > >
> > > > > > Also this patch doesn't make any sense. Both direct reclaim and kswapd
> > > > > > use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
> > > > > > for the kswapd part)..
> > > > > ok, but how does the reclaiming try with memcg's min protection on the
> > > > > alloc without __GFP_DIRECT_RECLAIM?
> > > >
> > > > I do not follow. There is no need to protect memcg if the allocation
> > > > request doesn't have __GFP_DIRECT_RECLAIM because that would fail the
> > > > charge if a hard limit is reached, see try_charge_memcg and
> > > > gfpflags_allow_blocking check.
> > > >
> > > > Background reclaim, on the other hand never breaches reclaim protection.
> > > >
> > > > What is the actual problem you want to solve?
> > > Imagine there is an allocation with gfp_mask & ~GFP_DIRECT_RECLAIM and
> > > all processes are under cgroups. Kswapd is the only hope here which
> > > however has a low efficiency of get_scan_count. I would like to have
> > > kswapd work as direct reclaim in 2nd round which will have
> > > protection=memory.min.
> >
> > Do you have an example where this would be a practical problem? Atomic
> > allocations should be rather rare.
> Please find below for the search result of '~__GFP_DIRECT_RECLAIM'
> which shows some drivers and net prefer to behave like that.
> Furthermore, the allocations are always together with high order.

And what is the _practical_ problem you are seeing or trying to solve?

-- 
Michal Hocko
SUSE Labs
