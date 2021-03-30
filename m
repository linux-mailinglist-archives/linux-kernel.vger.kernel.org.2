Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506EE34E6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhC3Lra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:47:30 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:52765 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhC3LrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:47:12 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id EBC5519F2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:47:10 +0100 (IST)
Received: (qmail 11040 invoked from network); 30 Mar 2021 11:47:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Mar 2021 11:47:10 -0000
Date:   Tue, 30 Mar 2021 12:47:09 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mm/page_alloc: add a bulk page allocator
Message-ID: <20210330114709.GW3697@techsingularity.net>
References: <61c479aa-18fe-82f3-c859-710c3555cbaa@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <61c479aa-18fe-82f3-c859-710c3555cbaa@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:18:09PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis on linux-next with Coverity has found a potential
> uninitialized variable issue in function __alloc_pages_bulk with the
> following commit:
> 
> commit b0e0a469733fa571ddd8fe147247c9561b51b2da
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Mon Mar 29 11:12:24 2021 +1100
> 
>     mm/page_alloc: add a bulk page allocator
> 
> The analysis is as follows:
> 
> > <SNIP>
>
> 5050        if (nr_pages - nr_populated == 1)
> 5051                goto failed;
> 5052
> 5053        /* May set ALLOC_NOFRAGMENT, fragmentation will return 1
> page. */
> 5054        gfp &= gfp_allowed_mask;
> 5055        alloc_gfp = gfp;
> 
>     Uninitialized scalar variable (UNINIT)
>     15. uninit_use_in_call: Using uninitialized value alloc_flags when
> calling prepare_alloc_pages.
> 
> 5056        if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask,
> &ac, &alloc_gfp, &alloc_flags))

Ok, so Coverity thinks that alloc_flags is potentially uninitialised and
without digging into every part of the report, Coverity is right.

> <SNIP>
>
> So alloc_flags in gfp_to_alloc_flags_cma is being updated with the |=
> operator and we managed to get to this path with uninitialized
> alloc_flags.  Should alloc_flags be initialized to zero in
> __alloc_page_bulk()?
> 

You are correct about the |= updating an initial value, but I think the
initialized value should be ALLOC_WMARK_LOW. A value of 0 would be the same
as ALLOC_WMARK_MIN and that would allow the bulk allocator to potentially
consume too many pages without waking kswapd.  I'll put together a patch
shortly. Thanks Colin!

-- 
Mel Gorman
SUSE Labs
