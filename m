Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0432AB4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836536AbhCBUUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442205AbhCBRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD5C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:23:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so14247077pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5b+Mo2wT+srZZ4GY87uavN/sz1cfhkln9hKeIpvVEdU=;
        b=qG7VN9KfYqdG6eKmBtEOInhSxWgaQpPGspuqkrByhk2nX0ck6oFXmj9sXwIwcFDqNN
         qe3HQ3pc6+uNiMJTL7y1S0MSxqgz9A6e9FgtcqDmPh/x8J/CHcU9XGrEpdR/mkWPucJf
         CFWtNuJRnHV5I/4z2qpJyubgQCI/qPxyAuofrzgTlqAjfx6+1DRXWcACNV7KzZ/FOfGl
         Phj5cjwYmvA4ktvYv5d7dqUHN98y5QPcGq/8VQ7I/1H5ybFnq4tzmea8k5pamE1lXxkx
         TuY7RKJ8dpAJJheHHcqzw2UdawZgwvkTE7eAJLOyHOYsRNhaXHclxtoBh0HBHKf5jxZx
         2gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5b+Mo2wT+srZZ4GY87uavN/sz1cfhkln9hKeIpvVEdU=;
        b=irK4K0qz6lPVeFXp0G0iy8381oFAPN4sNg4usKZlO4aVc3GURwNiL1eNAtwLys3BzD
         a16tsNT1Xj3/Kd3IbTa/dOzTyk4Z2nXheN3VOJ4PBPoD9Ro4ymJvmJEptwxnBqiOwE5D
         XWUz2AseTJcoZhC9OugWBLfDOg//WrtwWmHndAj/Vy1q+tEF2eZIiJSzYL2b8pcOVyWy
         L6nBGO2tB756HQ+J1/sDacrZsCN5Cv/A3YFbHStwwocL80Yce+1Q4Mhf7lrT3Jl5RfhH
         CW+/XVsYPv6/j0OuUsDwVqK/C00PXcz7vFHKOCAyp60v8v0abmiWjK5GlFwy2eJx9fI9
         RNuQ==
X-Gm-Message-State: AOAM533Y3ISZqjG5o+I7U+DY4aWELAtaWXDsCT+PEIxcQr3DCg6OHpwg
        8Lb7HI98wO7E4XsziKhkJds=
X-Google-Smtp-Source: ABdhPJzWNcv72XYKyiqTkPG7hNOeRloVhaWXmLG3elA4tUMd0MLzO5p0rLGeoCceILbbHb7LzEAmfA==
X-Received: by 2002:a63:546:: with SMTP id 67mr18532533pgf.173.1614705833122;
        Tue, 02 Mar 2021 09:23:53 -0800 (PST)
Received: from google.com ([2620:15c:211:201:297a:af1:8ccf:6094])
        by smtp.gmail.com with ESMTPSA id h6sm20479418pfv.84.2021.03.02.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:23:51 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 2 Mar 2021 09:23:49 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YD50pcPuwV456vwm@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 10:28:12AM +0100, Michal Hocko wrote:
> On Thu 18-02-21 08:19:50, Minchan Kim wrote:
> > On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
> > > On 18.02.21 10:35, Michal Hocko wrote:
> > > > On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> > > > > On 18.02.21 09:56, Michal Hocko wrote:
> > > > > > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > > > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > > > > It's critical if the page migration fails on those areas so
> > > > > > > dump more debugging message like memory_hotplug unless user
> > > > > > > specifiy __GFP_NOWARN.
> > > > > > 
> > > > > > I agree with David that this has a potential to generate a lot of output
> > > > > > and it is not really clear whether it is worth it. Page isolation code
> > > > > > already has REPORT_FAILURE mode which currently used only for the memory
> > > > > > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > > > > > ("mm: only report isolation failures when offlining memory").
> > > > > > 
> > > > > > Maybe migration failures are less likely to fail but still.
> > > > > 
> > > > > Side note: I really dislike that uncontrolled error reporting on memory
> > > > > offlining path we have enabled as default. Yeah, it might be useful for
> > > > > ZONE_MOVABLE in some cases, but otherwise it's just noise.
> > > > > 
> > > > > Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
> > > > 
> > > > Anyway we can discuss this in a separate thread but I think this is not
> > > > a representative workload.
> > > 
> > > Sure, but the essence is "this is noise", and we'll have more noise on
> > > alloc_contig_range() as we see these calls more frequently. There should be
> > > an explicit way to enable such *debug* messages.
> > 
> > alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
> > Why shouldn't people use it if they don't care the failure?
> > Semantically, it makes sense to me.

Sorry for the late response.

> 
> Well, alloc_contig_range doesn't really have to implement all the gfp
> flags. This is a matter of practicality. alloc_contig_range is quite
> different from the page allocator because it is to be expected that it
> can fail the request. This is avery optimistic allocation request. That
> would suggest that complaining about allocation failures is rather
> noisy.

That was why I'd like to approach for per-call site indicator with
__GFP_NOWARN. Even though it was allocation from CMA, some of them
wouldn't be critical for the failure so those wouldn't care of
the failure. cma_alloc already has carried on "bool no_warn"
which was changed into gfp_t recently. What alloc_contig_range
should do is to take care of the request.

> 
> Now I do understand that some users would like to see why those
> allocations have failed. The question is whether that information is
> generally useful or it is more of a debugging aid. The amount of
> information is also an important aspect. It would be rather unfortunate
> to dump thousands of pages just because they cannot be migrated.

Totally, agree dumping thounds of pages as debugging aid are bad.
Couldn't we simply ratelimit them like other places?

> 
> I do not have a strong opinion here. We can make all alloc_contig_range
> users use GFP_NOWARN by default and only skip the flag from the cma
> allocator but I am slowly leaning towards (ab)using dynamic debugging

I agree the rest of the places are GFP_NOWARN by default except CMA
if they expect alloc_contig_range are optimistic allocation request.
However, I'd like to tweak it for CMA - accept gfp_t from cma_alloc
and take care of the __GFP_NOWARN since some sites of CMA could be
fault tolerant so no need to get the warning.

> infrastructure for this.

dynamic debugging is system wide flag so how to deal with if we
want to see specific alloation faliure, not whole callsites?
That's why I'd like to go with per-call site approach, still.
