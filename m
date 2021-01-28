Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09330786F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhA1On6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:43:58 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:53599 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhA1Onl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:43:41 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 3ACA6BAE48
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:42:47 +0000 (GMT)
Received: (qmail 20546 invoked from network); 28 Jan 2021 14:42:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2021 14:42:46 -0000
Date:   Thu, 28 Jan 2021 14:42:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210128144245.GH3592@techsingularity.net>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <20210126085243.GE827@dhcp22.suse.cz>
 <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
 <20210126135918.GQ827@dhcp22.suse.cz>
 <20210128134512.GF3592@techsingularity.net>
 <YBLCthvRYtBRQiXW@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YBLCthvRYtBRQiXW@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:57:10PM +0100, Michal Hocko wrote:
> On Thu 28-01-21 13:45:12, Mel Gorman wrote:
> [...]
> > So mostly this is down to the number of times SLUB calls into the page
> > allocator which only caches order-0 pages on a per-cpu basis. I do have
> > a prototype for a high-order per-cpu allocator but it is very rough --
> > high watermarks stop making sense, code is rough, memory needed for the
> > pcpu structures quadruples etc.
> 
> Thanks this is really useful. But it really begs a question whether this
> is a general case or more an exception. And as such maybe we want to
> define high throughput caches which would gain a higher order pages to
> keep pace with allocation and reduce the churn or deploy some other
> techniques to reduce the direct page allocator involvement.

I don't think we want to define "high throughput caches" because it'll
be workload dependant and a game of whack-a-mole. If the "high throughput
cache" is a kmalloc cache for some set of workloads and one of the inode
caches or dcaches for another one, there will be no setting that is
universally good.

-- 
Mel Gorman
SUSE Labs
