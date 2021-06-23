Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929183B12FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 06:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWEvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 00:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhFWEvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36BC860232;
        Wed, 23 Jun 2021 04:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1624423763;
        bh=ywwVYbdUsNZrOrC2GmcdNjUsIwfz2tDlgh0SpQ0ew4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JBkzQP3n0JrXWbPRSLfm3oFr8sQvRVBX2I+5vt35ARb/GU3bEmkCuPttKpuIMMRwi
         /LuMg1mdqbR8KEYSDNc6sqRWISy3Ralxj53qCCthTjRAi8YGhNXfAWKgVGbhXDKrI/
         SqEgi26QW7VP+r2hU5X2mjNaFC07jKgndGSRL1LM=
Date:   Tue, 22 Jun 2021 21:49:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Alexander Lobakin <alobakin@pm.me>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: __alloc_pages_bulk(): do bounds check
 before accessing array
Message-Id: <20210622214922.fbf7ce7eb2864292d91ca4f2@linux-foundation.org>
In-Reply-To: <387ca68d-7c59-b316-7d95-cf13a3b26770@rasmusvillemoes.dk>
References: <20210507064504.1712559-1-linux@rasmusvillemoes.dk>
        <20210507102634.GD9524@techsingularity.net>
        <387ca68d-7c59-b316-7d95-cf13a3b26770@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 18:01:17 +0200 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 07/05/2021 12.26, Mel Gorman wrote:
> > On Fri, May 07, 2021 at 08:45:03AM +0200, Rasmus Villemoes wrote:
> >> In the event that somebody would call this with an already fully
> >> populated page_array, the last loop iteration would do an access
> >> beyond the end of page_array.
> >>
> >> It's of course extremely unlikely that would ever be done, but this
> >> triggers my internal static analyzer. Also, if it really is not
> >> supposed to be invoked this way (i.e., with no NULL entries in
> >> page_array), the nr_populated<nr_pages check could simply be removed
> >> instead.
> >>
> >> Fixes: 0f87d9d30f21 (mm/page_alloc: add an array-based interface to the bulk page allocator)
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > 
> 
> Andrew, will you get this to Linus before 5.13 is released? I got a mail
> on May 9 that it had been added to your queue, but I don't see it in
> master yet.

I had it queued for 5.14-rc1.

I'll move it into the 5.13 queue as it fixes a post-5.12 thing, but
nothing in the changelog indicates that it's at all urgent?  Was the
changelog missing some important info?

: In the event that somebody would call this with an already fully populated
: page_array, the last loop iteration would do an access beyond the end of
: page_array.
: 
: It's of course extremely unlikely that would ever be done, but this
: triggers my internal static analyzer.  Also, if it really is not supposed
: to be invoked this way (i.e., with no NULL entries in page_array), the
: nr_populated<nr_pages check could simply be removed instead.

