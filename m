Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD19C32D865
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhCDRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhCDRLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:11:51 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F8C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:11:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id r5so19375919pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IjgJ9/3K5CRSSHL4CLYVhM+GUoIM3xtOH0lXjMHAB0M=;
        b=dii//ITjUsKowFowTTP1E1LTWtEwmiRgmEVICDDCTkCkHpBu6r78JazS81hW6s7TEj
         UCnyLKnc3+fhGcCIKh7C+VydZ9yMjrCKv+yKQqOZ4S10waVwLLX7YlPCXFk9FHqOotKd
         V3knGRwFCOU1Xr7Nmg66ibThdSjEVXGDuWEPwqaED8FDsPsucGzdVMqgPoWMJ7nLB8tN
         /T0CX+GPSWXe2hXC7fY3NMLY7Sq+StSpMnkLt5iGqixPu0n4af9myrLnZVJWOibG/Zom
         2di+VPSS9R4vmLowHIIPK6RWKDYOycT50yRTvUh23tVYLxnNjtuH3y+YTH+GnrlJiN4i
         gU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IjgJ9/3K5CRSSHL4CLYVhM+GUoIM3xtOH0lXjMHAB0M=;
        b=S1r2UJSm2Wc+upzvsddGLtnu8NRJm0TmvhK7Afl1fo8yQ6eaxV/NOMrNZrznWPonJ7
         b+2ytIAdDHqAt6cR+4khyxmqWprV/2DqgWFu8JQkI9HKUOjbxtn2uV4i8FQ4k/7Augpz
         1CW0AWPBIJHHfM1yLnNaWCGErs8qzJYiSoIYM68PmMjGNmARrA2QSebx0Yi1ZvwpjNjr
         21plO9hVkH/0MFwkOT8IRg3tZd8wBbOZlsggCZJjHfJQu8Gn+w8rReqAlhZJaVL/Vn7Y
         6CTigLQpb4jNYAZ19/xDC27aWui6od9lXytMX3KDYR+p4afgp5BrXtvqkN3V0sWIH83V
         gVKw==
X-Gm-Message-State: AOAM532NTeyGVGfJjQC6I21Jq+me4bThOSJOlXveXlqcE47p4IlcOp+3
        pyUCE9CyWvgcjt9jhDfjLT0=
X-Google-Smtp-Source: ABdhPJxnqcDGOXICXrUSCd8uAqGBd7VyTluejhYthAxalBG8eT6LGXDqc9qerjryCBjJn7KAfIji4A==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr4439422pgv.108.1614877870398;
        Thu, 04 Mar 2021 09:11:10 -0800 (PST)
Received: from google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id l12sm11179pfd.33.2021.03.04.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 09:11:09 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Mar 2021 09:11:07 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEEUq8ZRn4WyYWVx@google.com>
References: <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com>
 <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 05:28:32PM +0100, David Hildenbrand wrote:
> On 04.03.21 17:23, Minchan Kim wrote:
> > On Thu, Mar 04, 2021 at 05:10:52PM +0100, David Hildenbrand wrote:
> > > On 04.03.21 17:01, Minchan Kim wrote:
> > > > On Tue, Mar 02, 2021 at 09:23:49AM -0800, Minchan Kim wrote:
> > > > > On Fri, Feb 19, 2021 at 10:28:12AM +0100, Michal Hocko wrote:
> > > > > > On Thu 18-02-21 08:19:50, Minchan Kim wrote:
> > > > > > > On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
> > > > > > > > On 18.02.21 10:35, Michal Hocko wrote:
> > > > > > > > > On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> > > > > > > > > > On 18.02.21 09:56, Michal Hocko wrote:
> > > > > > > > > > > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > > > > > > > > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > > > > > > > > > It's critical if the page migration fails on those areas so
> > > > > > > > > > > > dump more debugging message like memory_hotplug unless user
> > > > > > > > > > > > specifiy __GFP_NOWARN.
> > > > > > > > > > > 
> > > > > > > > > > > I agree with David that this has a potential to generate a lot of output
> > > > > > > > > > > and it is not really clear whether it is worth it. Page isolation code
> > > > > > > > > > > already has REPORT_FAILURE mode which currently used only for the memory
> > > > > > > > > > > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > > > > > > > > > > ("mm: only report isolation failures when offlining memory").
> > > > > > > > > > > 
> > > > > > > > > > > Maybe migration failures are less likely to fail but still.
> > > > > > > > > > 
> > > > > > > > > > Side note: I really dislike that uncontrolled error reporting on memory
> > > > > > > > > > offlining path we have enabled as default. Yeah, it might be useful for
> > > > > > > > > > ZONE_MOVABLE in some cases, but otherwise it's just noise.
> > > > > > > > > > 
> > > > > > > > > > Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
> > > > > > > > > 
> > > > > > > > > Anyway we can discuss this in a separate thread but I think this is not
> > > > > > > > > a representative workload.
> > > > > > > > 
> > > > > > > > Sure, but the essence is "this is noise", and we'll have more noise on
> > > > > > > > alloc_contig_range() as we see these calls more frequently. There should be
> > > > > > > > an explicit way to enable such *debug* messages.
> > > > > > > 
> > > > > > > alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
> > > > > > > Why shouldn't people use it if they don't care the failure?
> > > > > > > Semantically, it makes sense to me.
> > > > > 
> > > > > Sorry for the late response.
> > > > > 
> > > > > > 
> > > > > > Well, alloc_contig_range doesn't really have to implement all the gfp
> > > > > > flags. This is a matter of practicality. alloc_contig_range is quite
> > > > > > different from the page allocator because it is to be expected that it
> > > > > > can fail the request. This is avery optimistic allocation request. That
> > > > > > would suggest that complaining about allocation failures is rather
> > > > > > noisy.
> > > > > 
> > > > > That was why I'd like to approach for per-call site indicator with
> > > > > __GFP_NOWARN. Even though it was allocation from CMA, some of them
> > > > > wouldn't be critical for the failure so those wouldn't care of
> > > > > the failure. cma_alloc already has carried on "bool no_warn"
> > > > > which was changed into gfp_t recently. What alloc_contig_range
> > > > > should do is to take care of the request.
> > > > > 
> > > > > > 
> > > > > > Now I do understand that some users would like to see why those
> > > > > > allocations have failed. The question is whether that information is
> > > > > > generally useful or it is more of a debugging aid. The amount of
> > > > > > information is also an important aspect. It would be rather unfortunate
> > > > > > to dump thousands of pages just because they cannot be migrated.
> > > > > 
> > > > > Totally, agree dumping thounds of pages as debugging aid are bad.
> > > > > Couldn't we simply ratelimit them like other places?
> > > > > 
> > > > > > 
> > > > > > I do not have a strong opinion here. We can make all alloc_contig_range
> > > > > > users use GFP_NOWARN by default and only skip the flag from the cma
> > > > > > allocator but I am slowly leaning towards (ab)using dynamic debugging
> > > > > 
> > > > > I agree the rest of the places are GFP_NOWARN by default except CMA
> > > > > if they expect alloc_contig_range are optimistic allocation request.
> > > > > However, I'd like to tweak it for CMA - accept gfp_t from cma_alloc
> > > > > and take care of the __GFP_NOWARN since some sites of CMA could be
> > > > > fault tolerant so no need to get the warning.
> > > > 
> > > > Any thought to proceed?
> > > 
> > > IMHO, add some proper debug mechanisms and don't try squeezing debug
> > > messages into "WARN" semantics.
> > > 
> > > Any alloc_contig_range() user can benefit from that.
> > 
> > So the point is how we could add proper debug mechanism here.
> > Think about call site A is not critical for the failure but
> > called very frquently. Call site B is critical for the failure
> > but called very rarely so turns on system wide dynamic debugging.
> > You could see a lot of debug message from A even though we
> > dont't want it. Even, it could hide B's debugging message
> > by ratelimiting.
> 
> Do you have a real life example how this would be an issue? This sounds like
> a purely theoretical construct.

I don't have sepcific a example at this moment but it would be not hard
to think about the usecase. Someone want to use big contiguous memory
to perform better their job but it's not necessary since they have
fallback options with working order-0 pages. In the case, it's not
critical for the failure. However, the other user uses big contiguous
memory to enable some feature for enduser in the mobile phone.
In the case, the allocation failure is significant so really looking
for clues.

> 
> You want to debug something, so you try triggering it and capturing debug
> data. There are not that many alloc_contig_range() users such that this
> would really be an issue to isolate ...

cma_alloc uses alloc_contig_range and cma_alloc has lots of users.
Even, it is expoerted by dmabuf so any userspace would trigger the
allocation by their own. Some of them could be tolerant for the failure,
rest of them could be critical. We should't expect it by limited kernel
usecase.

> 
> Strictly speaking: any allocation failure on ZONE_MOVABLE or CMA is
> problematic (putting aside NORETRY logic and similar aside). So any such
> page you hit is worth investigating and, therefore, worth getting logged for
> debugging purposes.

If you believe the every alloc_contig_range failure is problematic
and there is no such realy example I menionted above in the world,
I am happy to put this chunk to support dynamic debugging.
Okay?

+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+        (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
+               DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+int alloc_contig_ratelimit(void)
+{
+       return __ratelimit(&alloc_contig_ratelimit_state);
+}
+
+void dump_migrate_failure_pages(struct list_head *page_list)
+{
+       DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
+                       "migrate failure");
+       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
+                       alloc_contig_ratelimit()) {
+               struct page *page;
+
+               WARN(1, "failed callstack");
+               list_for_each_entry(page, page_list, lru)
+                       dump_page(page, "migration failure");
+       }
+}
+#else
+static inline void dump_migrate_failure_pages(struct list_head *page_list)
+{
+}
+#endif
+
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
                                        unsigned long start, unsigned long end)
@@ -8496,6 +8522,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
                                NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
        }
        if (ret < 0) {
+               dump_migrate_failure_pages(&cc->migratepages);
                putback_movable_pages(&cc->migratepages);
                return ret;
        }


