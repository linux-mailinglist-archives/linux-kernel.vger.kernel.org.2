Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB02A3B96D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhGAUF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:05:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46278 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhGAUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:05:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B26511C0B7F; Thu,  1 Jul 2021 22:02:54 +0200 (CEST)
Date:   Thu, 1 Jul 2021 22:02:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: Enable suspend-only swap spaces
Message-ID: <20210701200253.GB983@bug>
References: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Currently it's not possible to enable hibernation without also enabling
> generic swap for a given swap area. These two use cases are not the
> same. For example there may be users who want to enable hibernation,
> but whose drives don't have the write endurance for generic swap
> activities.
> 
> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> generic swapping to it. This region can still be wired up for use in
> suspend-to-disk activities, but will never have regular pages swapped to
> it.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Makes sense to me.

Reviewed-by: Pavel Machek <pavel@ucw.cz>

>  #define SWAP_FLAG_DISCARD_ONCE	0x20000 /* discard swap area at swapon-time */
>  #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
> +#define SWAP_FLAG_NOSWAP	0x80000 /* use only for suspend, not swap */

I'd say "only for hibernation". And actually maybe code would be more clear if logic was reverted.

Aha, and you may want to check... does the hibernation still work for you without the swap?

Because we need half memory free to create swap image and swap is really quite useful for that.

Best regards,
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
