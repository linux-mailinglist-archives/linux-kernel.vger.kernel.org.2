Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3317F35DBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbhDMJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:49:54 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:45231 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241211AbhDMJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:49:44 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id CD6FABABFE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:49:23 +0100 (IST)
Received: (qmail 31546 invoked from network); 13 Apr 2021 09:49:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Apr 2021 09:49:23 -0000
Date:   Tue, 13 Apr 2021 10:49:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <20210413094920.GC3697@techsingularity.net>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
 <20210412140852.GZ3697@techsingularity.net>
 <b1243b7b-fa4c-496f-5bfc-c83c7cee81cf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b1243b7b-fa4c-496f-5bfc-c83c7cee81cf@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:36:08AM +0200, Vlastimil Babka wrote:
> On 4/12/21 4:08 PM, Mel Gorman wrote:
> > On Mon, Apr 12, 2021 at 02:40:18PM +0200, Vlastimil Babka wrote:
> >> On 4/12/21 2:08 PM, Mel Gorman wrote:
> >
> > the pageset structures in place would be much more straight-forward
> > assuming the structures were not allocated in the zone that is being
> > hot-removed.
> 
> I would expect this is not possible, at least for ZONE_MOVABLE, as the percpu
> allocations should be GFP_KERNEL.

True.

> And it's not realistic to expect offlining to
> succeed at all without using ZONE_MOVABLE.
> 
> AFAIK even Oscar's work on using the node to self-contain its own structures is
> only applicable to struct pages, not percpu allocations?

That I don't know as I didn't check although in general, it would be
somewhat unfortunate if per-cpu structures were remote. It wouldn't be
critical given that they'll be in cache assuming the per-cpu structures
are not straddling cache lines.

-- 
Mel Gorman
SUSE Labs
