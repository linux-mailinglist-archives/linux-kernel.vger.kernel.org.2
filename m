Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF128360690
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhDOKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:07:19 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:46845 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhDOKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:07:17 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 24CB9FAAA8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:06:53 +0100 (IST)
Received: (qmail 20158 invoked from network); 15 Apr 2021 10:06:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Apr 2021 10:06:52 -0000
Date:   Thu, 15 Apr 2021 11:06:50 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 04/11] mm/vmstat: Convert NUMA statistics to basic NUMA
 counters
Message-ID: <20210415100650.GJ3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-5-mgorman@techsingularity.net>
 <7a7ec563-0519-a850-563a-9680a7bd00d3@suse.cz>
 <20210414151850.GG3697@techsingularity.net>
 <c4dff8a5-7959-c191-c66d-23a515244b80@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <c4dff8a5-7959-c191-c66d-23a515244b80@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:56:53PM +0200, Vlastimil Babka wrote:
> On 4/14/21 5:18 PM, Mel Gorman wrote:
> > On Wed, Apr 14, 2021 at 02:56:45PM +0200, Vlastimil Babka wrote:
> >> So it seems that this intermediate assignment to zone counters (using
> >> atomic_long_set() even) is unnecessary and this could mimic sum_vm_events() that
> >> just does the summation on a local array?
> >> 
> > 
> > The atomic is unnecessary for sure but using a local array is
> > problematic because of your next point.
> 
> IIUC vm_events seems to do fine without a centralized array and handling CPU hot
> remove at the sime time ...
> 

The vm_events are more global in nature. They are not reported
to userspace on a per-zone (/proc/zoneinfo) basis or per-node
(/sys/devices/system/node/node*/numastat) basis so they are not equivalent.

> >> And probably a bit more serious is that vm_events have vm_events_fold_cpu() to
> >> deal with a cpu going away, but after your patch the stats counted on a cpu just
> >> disapepar from the sums as it goes offline as there's no such thing for the numa
> >> counters.
> >> 
> > 
> > That is a problem I missed. Even if zonestats was preserved on
> > hot-remove, fold_vm_zone_numa_events would not be reading the CPU so
> > hotplug events jump all over the place.
> > 
> > So some periodic folding is necessary. I would still prefer not to do it
> > by time but it could be done only on overflow or when a file like
> > /proc/vmstat is read. I'll think about it a bit more and see what I come
> > up with.
> 
> ... because vm_events_fold_cpu() seems to simply move the stats from the CPU
> being offlined to the current one. So the same approach should be enough for
> NUMA stats?
> 

Yes, or at least very similar.

-- 
Mel Gorman
SUSE Labs
