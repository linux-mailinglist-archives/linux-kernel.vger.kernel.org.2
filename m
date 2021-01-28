Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3B307785
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhA1N6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:58:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:48700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhA1N55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:57:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611842231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2RipEAGjkALucqYfiM9qo0yGIYcs4S2Tqn5F8XA884=;
        b=PqaCl56ujHm2bP9OoWJY3JiPBzBqTsaqdlmuOBE0hZWRpDX9gD/5qfVHMOl0LIRFJFdxDq
        y3WstcNbzhvD5pWHquB8cBQifeAz4OWnWTlaKNeIhszax3BmvOcxmMjGstg5p5ROw7djeu
        Fhx+TRURrL/1SJK5jg3OxfEV83g5Saw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25E39ABD6;
        Thu, 28 Jan 2021 13:57:11 +0000 (UTC)
Date:   Thu, 28 Jan 2021 14:57:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <YBLCthvRYtBRQiXW@dhcp22.suse.cz>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <20210126085243.GE827@dhcp22.suse.cz>
 <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
 <20210126135918.GQ827@dhcp22.suse.cz>
 <20210128134512.GF3592@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128134512.GF3592@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-01-21 13:45:12, Mel Gorman wrote:
[...]
> So mostly this is down to the number of times SLUB calls into the page
> allocator which only caches order-0 pages on a per-cpu basis. I do have
> a prototype for a high-order per-cpu allocator but it is very rough --
> high watermarks stop making sense, code is rough, memory needed for the
> pcpu structures quadruples etc.

Thanks this is really useful. But it really begs a question whether this
is a general case or more an exception. And as such maybe we want to
define high throughput caches which would gain a higher order pages to
keep pace with allocation and reduce the churn or deploy some other
techniques to reduce the direct page allocator involvement.
-- 
Michal Hocko
SUSE Labs
