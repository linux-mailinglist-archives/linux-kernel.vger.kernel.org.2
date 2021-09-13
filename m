Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CB408B73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhIMNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:01:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34184 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhIMNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:01:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 283BD21D0D;
        Mon, 13 Sep 2021 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631537984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/tlWcoP9A24cTc3rdiSQ4RXTgCKXNy2vtw4XLRi7lQ=;
        b=hdc8wWXwUuu5JM2kELvLjga+XS6q8+5HeAU1zR087Qrv7NwPkNuT1Wfg51WVw8WH4bgNRO
        pNWNww1Gpvn7Lf5TCNCYGBv3CM3d0SKE/NOh6rUok6Um8FhJpsdUSK5OquDAN8+osWv7Ic
        JVvKvbu5PrTXsQtirlDvqg0ltwJuwnU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C7FF2A3B88;
        Mon, 13 Sep 2021 12:59:42 +0000 (UTC)
Date:   Mon, 13 Sep 2021 14:59:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-ID: <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
 <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
 <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-09-21 20:43:35, Miaohe Lin wrote:
> On 2021/9/13 20:20, David Hildenbrand wrote:
> > On 13.09.21 14:12, Michal Hocko wrote:
> >> On Mon 13-09-21 19:51:25, Miaohe Lin wrote:
> >>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
> >>> the first pfn in a pageblock while __first_valid_page() will traverse the
> >>> pageblock until the first online pfn is found. So we may miss the call to
> >>> unset_migratetype_isolate() in undo path and pages will remain isolated
> >>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
> >>> also help to simplify the code further.
> >>
> >> I like the clean up part but is this a real problem that requires CC
> >> stable? Have you ever seen this to be a real problem? It looks like
> >> something based on reading the code.
> 
> I'm sorry but I haven't seen this to be a real problem. It's a theoretical bug.

Make it clear in the changelog

> > We discussed that it isn't an issue anymore (we never call it on
> > memory holes), but might have been an issue on older kernels, back
> > when we didn't have the "memory holes" check in the memory offlining
> > path in place.
> 
> So is the Cc:stable needed in this case?

I do not think so. Even if this was happening in the practice then the
practical consequences would be pretty minor, right? (few pageblocks
stay isolated thus unavailable).

I do realize that the stable tree is in a hoarding mode for quite some
years but my general approach has been (in line with the documentation)
to mark and backport only fixes that really do matter.
-- 
Michal Hocko
SUSE Labs
