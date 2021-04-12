Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF235C9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhDLP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:28:01 -0400
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:51549 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237512AbhDLP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:27:58 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 8C9C0FBC0D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:27:39 +0100 (IST)
Received: (qmail 25959 invoked from network); 12 Apr 2021 15:27:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Apr 2021 15:27:39 -0000
Date:   Mon, 12 Apr 2021 16:27:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <20210412152737.GB3697@techsingularity.net>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
 <20210412140852.GZ3697@techsingularity.net>
 <a0d73ce0-b2bd-1928-539d-39cb9da9bf1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a0d73ce0-b2bd-1928-539d-39cb9da9bf1f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:12:11PM +0200, David Hildenbrand wrote:
> > After v1 of the patch, the race was reduced to the point between the
> > zone watermark check and the rmqueue_pcplist but yes, it still existed.
> > Closing it completely was either complex or expensive. Setting
> > zone->pageset = &boot_pageset before the free would shrink the race
> > further but that still leaves a potential memory ordering issue.
> > 
> > While fixable, it's either complex, expensive or both so yes, just leaving
> > the pageset structures in place would be much more straight-forward
> > assuming the structures were not allocated in the zone that is being
> > hot-removed. As things stand, I had trouble even testing zone hot-remove
> > as there was always a few pages left behind and I did not chase down
> > why.
>
> Can you elaborate? I can reliably trigger zone present pages going to 0 by
> just hotplugging a DIMM, onlining the memory block devices to the MOVABLE
> zone, followed by offlining the memory block again.
> 

For the machine I was testing on, I tried offlining all memory within
a zone on a NUMA machine. Even if I used movable_zone to create a zone
or numa=fake to create multiple fake nodes and zones, there was always
either reserved or pinned pages preventing the full zone being removed.

-- 
Mel Gorman
SUSE Labs
