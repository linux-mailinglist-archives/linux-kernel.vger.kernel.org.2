Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82E3763A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhEGK1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:27:39 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:33947 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234400AbhEGK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:27:36 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id D46781A24
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 11:26:35 +0100 (IST)
Received: (qmail 12395 invoked from network); 7 May 2021 10:26:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.16.112])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 May 2021 10:26:35 -0000
Date:   Fri, 7 May 2021 11:26:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: __alloc_pages_bulk(): do bounds check
 before accessing array
Message-ID: <20210507102634.GD9524@techsingularity.net>
References: <20210507064504.1712559-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210507064504.1712559-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 08:45:03AM +0200, Rasmus Villemoes wrote:
> In the event that somebody would call this with an already fully
> populated page_array, the last loop iteration would do an access
> beyond the end of page_array.
> 
> It's of course extremely unlikely that would ever be done, but this
> triggers my internal static analyzer. Also, if it really is not
> supposed to be invoked this way (i.e., with no NULL entries in
> page_array), the nr_populated<nr_pages check could simply be removed
> instead.
> 
> Fixes: 0f87d9d30f21 (mm/page_alloc: add an array-based interface to the bulk page allocator)
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
