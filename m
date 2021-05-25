Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90E3903DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhEYO06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:26:58 -0400
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:46427 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233600AbhEYO04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:26:56 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 44FD0FAC79
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:25:26 +0100 (IST)
Received: (qmail 29112 invoked from network); 25 May 2021 14:25:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 14:25:26 -0000
Date:   Tue, 25 May 2021 15:25:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/14] Clean W=1 build warnings for mm/
Message-ID: <20210525142524.GU30378@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
 <aad3f04f-850a-b134-d0a7-b24af9721ddb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <aad3f04f-850a-b134-d0a7-b24af9721ddb@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:48:26PM +0200, Vlastimil Babka wrote:
> On 5/20/21 10:47 AM, Mel Gorman wrote:
> > This is a janitorial only. During development of a tool to catch build
> > warnings early to avoid tripping the Intel lkp-robot, I noticed that mm/
> > is not clean for W=1. This is generally harmless but there is no harm in
> > cleaning it up. It disrupts git blame a little but on relatively obvious
> > lines that are unlikely to be git blame targets.
> > 
> >  include/asm-generic/early_ioremap.h | 9 +++++++++
> >  include/linux/mmzone.h              | 5 ++++-
> >  include/linux/swap.h                | 6 +++++-
> >  mm/internal.h                       | 3 +--
> >  mm/mapping_dirty_helpers.c          | 2 +-
> >  mm/memcontrol.c                     | 2 +-
> >  mm/memory_hotplug.c                 | 6 +++---
> >  mm/mmap_lock.c                      | 2 ++
> >  mm/page_alloc.c                     | 2 +-
> >  mm/vmalloc.c                        | 3 +++
> >  mm/vmscan.c                         | 2 +-
> >  mm/z3fold.c                         | 2 ++
> >  mm/zbud.c                           | 2 ++
> >  13 files changed, 35 insertions(+), 11 deletions(-)
> 
> Thanks, looks good.
> 
> patch 3/14 subject looks like it should read just "mm/page_alloc: Make
> should_fail_alloc_page a static function"
> 

Yes it should. Andrew, do you mind fixing it directly instead of
resending the entire series?

> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks!

-- 
Mel Gorman
SUSE Labs
