Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F0D32D745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhCDQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhCDQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:01:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74765C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:01:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w18so19245687pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNYbl2ZQxAUCwx1UDZA1x4v7XRVAyy2y3jZZIg4N0BM=;
        b=jXkTfDaudzcAnSqyPxFJdH1BQHBe5/w4PIH3CJJfmoKE/xB4J1e4ZFr5gWmsfk9ovL
         HfQoN8HCj0RS3DiOz7XhKuT7WHt3e9m4QkbGmjwoSEcBzMcXGFi0N03xd5y6+yTYRBQo
         eSUc7gb3Ls3lPI8tDqsnzCB9r7qa7pbtIAg+qOt82N0ETS+dl2J4BpfN/uUKvl9UKDnr
         OHInGmCGFnvH3GYLXUy9EnU7QI90bmk2DaC+w5WRBA0NxP/Mc8lfMpHPCheT2mmeauXC
         XdSQSQTIJ4L1iUqii2qHzPw+YRanng58Tka46lST6GC7iS71+KYwXpuKvGx6EquTkTrZ
         KBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zNYbl2ZQxAUCwx1UDZA1x4v7XRVAyy2y3jZZIg4N0BM=;
        b=OUUhSmcfKvULdTWtUMD7W3dYfgoxtWi2JYpEdbvFLJk/aVmQ7grmnwp9PyhT93PMyH
         A6Hp0FTgREMKV67B67eG1MT8ZOm6P6JzjJcxE5Ez4B5FeuqopP5qMYiuE3P6pWBUEo9v
         u67csALgLHY7t6KEE2MLS7+Xh9VJLX23K9bGReTq4cW81IDtid25iIA68sPCDObPL5Yi
         VymiPohnoXnD3JCM9S3gGOPjCIi1HtVdpN/6OiBzRFQT1GJdW9qAH3uBFDrct6aOG89E
         v3HAsUnsJA8e2p4uuFok4uySwt1Pvoe+t/hzrAjE6+0t7DatmL5ZuN7REkOSnmjSceeH
         FajQ==
X-Gm-Message-State: AOAM530zfrICbtn79wwOUUHXS9fM9MOPpg9h1BVmitdTndhopv1tO4v6
        bDUDKREc0oWyGxOA4Bv6eim11dZRqFU=
X-Google-Smtp-Source: ABdhPJz2u1omg5Mc/f/J5FaHXPx0QsV6wQ1ecmy2qc/a00jiIND+7kNmOJ21NUWrovUnD8p6fSSaxg==
X-Received: by 2002:aa7:98c9:0:b029:1ee:309c:6552 with SMTP id e9-20020aa798c90000b02901ee309c6552mr4329034pfm.71.1614873677964;
        Thu, 04 Mar 2021 08:01:17 -0800 (PST)
Received: from google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id q4sm27838853pfs.134.2021.03.04.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:01:16 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Mar 2021 08:01:15 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEEES/K8cNi8qOJe@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD50pcPuwV456vwm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:23:49AM -0800, Minchan Kim wrote:
> On Fri, Feb 19, 2021 at 10:28:12AM +0100, Michal Hocko wrote:
> > On Thu 18-02-21 08:19:50, Minchan Kim wrote:
> > > On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
> > > > On 18.02.21 10:35, Michal Hocko wrote:
> > > > > On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> > > > > > On 18.02.21 09:56, Michal Hocko wrote:
> > > > > > > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > > > > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > > > > > It's critical if the page migration fails on those areas so
> > > > > > > > dump more debugging message like memory_hotplug unless user
> > > > > > > > specifiy __GFP_NOWARN.
> > > > > > > 
> > > > > > > I agree with David that this has a potential to generate a lot of output
> > > > > > > and it is not really clear whether it is worth it. Page isolation code
> > > > > > > already has REPORT_FAILURE mode which currently used only for the memory
> > > > > > > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > > > > > > ("mm: only report isolation failures when offlining memory").
> > > > > > > 
> > > > > > > Maybe migration failures are less likely to fail but still.
> > > > > > 
> > > > > > Side note: I really dislike that uncontrolled error reporting on memory
> > > > > > offlining path we have enabled as default. Yeah, it might be useful for
> > > > > > ZONE_MOVABLE in some cases, but otherwise it's just noise.
> > > > > > 
> > > > > > Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
> > > > > 
> > > > > Anyway we can discuss this in a separate thread but I think this is not
> > > > > a representative workload.
> > > > 
> > > > Sure, but the essence is "this is noise", and we'll have more noise on
> > > > alloc_contig_range() as we see these calls more frequently. There should be
> > > > an explicit way to enable such *debug* messages.
> > > 
> > > alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
> > > Why shouldn't people use it if they don't care the failure?
> > > Semantically, it makes sense to me.
> 
> Sorry for the late response.
> 
> > 
> > Well, alloc_contig_range doesn't really have to implement all the gfp
> > flags. This is a matter of practicality. alloc_contig_range is quite
> > different from the page allocator because it is to be expected that it
> > can fail the request. This is avery optimistic allocation request. That
> > would suggest that complaining about allocation failures is rather
> > noisy.
> 
> That was why I'd like to approach for per-call site indicator with
> __GFP_NOWARN. Even though it was allocation from CMA, some of them
> wouldn't be critical for the failure so those wouldn't care of
> the failure. cma_alloc already has carried on "bool no_warn"
> which was changed into gfp_t recently. What alloc_contig_range
> should do is to take care of the request.
> 
> > 
> > Now I do understand that some users would like to see why those
> > allocations have failed. The question is whether that information is
> > generally useful or it is more of a debugging aid. The amount of
> > information is also an important aspect. It would be rather unfortunate
> > to dump thousands of pages just because they cannot be migrated.
> 
> Totally, agree dumping thounds of pages as debugging aid are bad.
> Couldn't we simply ratelimit them like other places?
> 
> > 
> > I do not have a strong opinion here. We can make all alloc_contig_range
> > users use GFP_NOWARN by default and only skip the flag from the cma
> > allocator but I am slowly leaning towards (ab)using dynamic debugging
> 
> I agree the rest of the places are GFP_NOWARN by default except CMA
> if they expect alloc_contig_range are optimistic allocation request.
> However, I'd like to tweak it for CMA - accept gfp_t from cma_alloc
> and take care of the __GFP_NOWARN since some sites of CMA could be
> fault tolerant so no need to get the warning.

Any thought to proceed?

> 
> > infrastructure for this.
> 
> dynamic debugging is system wide flag so how to deal with if we
> want to see specific alloation faliure, not whole callsites?
> That's why I'd like to go with per-call site approach, still.
