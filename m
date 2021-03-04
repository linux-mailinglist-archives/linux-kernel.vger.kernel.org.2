Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE632D7B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhCDQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbhCDQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7829C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:23:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q204so18239785pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnV5xh27yXeZ4eD0NfKduGmV3dmdCvMkiedYReyJGMA=;
        b=BPlF8iIERigTBaVyE76361mJ2TFY40HPNF1YC/AYP64fCsRzFPYiN5tFdwOf90a+QG
         erbUI9t9cLfeCBAUqByVfGhhQP9IftqW66Sv8Q4bJ7hTtHGr7ReXC2FNm35yHNnspP9+
         aXRuA0hSbRQJbXWKNAM/7eNKVp77csBgWgB94oHbHwkApiay4GlXiXbnLgxMIuiJlm8e
         0V5hqkUvhRIOR7bgijnmydI4PENNsdCQmYEu7RSBDe6JR3ZrcB83urJkq8XtwCgXN4pI
         /5n2/+/Z9p/foHgCRe1Fs+8eq/guwm+vNrmSETsFmjjdBZHTQnmKUFVrpWybfHkb6HHL
         FRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TnV5xh27yXeZ4eD0NfKduGmV3dmdCvMkiedYReyJGMA=;
        b=rR7VyFIzKeQy/9O8G8aTE0+eHo+ktZjDl95xZvBR6VRLRhYcNArJBqRRQ1f0Vj9JZU
         MRU/fSnEbafVOiYoemIh5vtaz5QMFKjjSXQ33PIjSkkmSHv3v7c79OeCz99xKLhP4aaw
         PPqzHytVdQznoT703GkJQEZb0OnNClmM46UbGTbsFhr4vhzMyvFiT71onwhsD1h2jgN7
         LEGS5n+6IwCr1NEPFjEyg78oHTGw4CZN3f7ACh+OUWBdde2CYMqQ2NpVNWKnLdeWyZLV
         u3Xy81afNpaO/t6lZ2GCkzO5rN1WCmKE50qSrli12PRelVBRJEdQPFxBw2uBL+SJfCHT
         10TA==
X-Gm-Message-State: AOAM533tLPYbLDEAcZ8cMaI7CccZeyQXBYrypCF5fRWCSzl4KlzQatBI
        v00+075EofHm35FjNMWSHYsBQ2I6AHI=
X-Google-Smtp-Source: ABdhPJyzhgLCrmXNVbPtrQKAC+jWQrzbWipOAiofwKzxYQvN2olIHaz/xXVbKE8ojz/EfRKAbFCYIA==
X-Received: by 2002:a62:7a52:0:b029:1ee:ee21:50f with SMTP id v79-20020a627a520000b02901eeee21050fmr4357651pfc.14.1614875010402;
        Thu, 04 Mar 2021 08:23:30 -0800 (PST)
Received: from google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id il6sm7894107pjb.56.2021.03.04.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:23:29 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Mar 2021 08:23:27 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEEJf0itS/8vn8Iy@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com>
 <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 05:10:52PM +0100, David Hildenbrand wrote:
> On 04.03.21 17:01, Minchan Kim wrote:
> > On Tue, Mar 02, 2021 at 09:23:49AM -0800, Minchan Kim wrote:
> > > On Fri, Feb 19, 2021 at 10:28:12AM +0100, Michal Hocko wrote:
> > > > On Thu 18-02-21 08:19:50, Minchan Kim wrote:
> > > > > On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
> > > > > > On 18.02.21 10:35, Michal Hocko wrote:
> > > > > > > On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> > > > > > > > On 18.02.21 09:56, Michal Hocko wrote:
> > > > > > > > > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > > > > > > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > > > > > > > It's critical if the page migration fails on those areas so
> > > > > > > > > > dump more debugging message like memory_hotplug unless user
> > > > > > > > > > specifiy __GFP_NOWARN.
> > > > > > > > > 
> > > > > > > > > I agree with David that this has a potential to generate a lot of output
> > > > > > > > > and it is not really clear whether it is worth it. Page isolation code
> > > > > > > > > already has REPORT_FAILURE mode which currently used only for the memory
> > > > > > > > > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > > > > > > > > ("mm: only report isolation failures when offlining memory").
> > > > > > > > > 
> > > > > > > > > Maybe migration failures are less likely to fail but still.
> > > > > > > > 
> > > > > > > > Side note: I really dislike that uncontrolled error reporting on memory
> > > > > > > > offlining path we have enabled as default. Yeah, it might be useful for
> > > > > > > > ZONE_MOVABLE in some cases, but otherwise it's just noise.
> > > > > > > > 
> > > > > > > > Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
> > > > > > > 
> > > > > > > Anyway we can discuss this in a separate thread but I think this is not
> > > > > > > a representative workload.
> > > > > > 
> > > > > > Sure, but the essence is "this is noise", and we'll have more noise on
> > > > > > alloc_contig_range() as we see these calls more frequently. There should be
> > > > > > an explicit way to enable such *debug* messages.
> > > > > 
> > > > > alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
> > > > > Why shouldn't people use it if they don't care the failure?
> > > > > Semantically, it makes sense to me.
> > > 
> > > Sorry for the late response.
> > > 
> > > > 
> > > > Well, alloc_contig_range doesn't really have to implement all the gfp
> > > > flags. This is a matter of practicality. alloc_contig_range is quite
> > > > different from the page allocator because it is to be expected that it
> > > > can fail the request. This is avery optimistic allocation request. That
> > > > would suggest that complaining about allocation failures is rather
> > > > noisy.
> > > 
> > > That was why I'd like to approach for per-call site indicator with
> > > __GFP_NOWARN. Even though it was allocation from CMA, some of them
> > > wouldn't be critical for the failure so those wouldn't care of
> > > the failure. cma_alloc already has carried on "bool no_warn"
> > > which was changed into gfp_t recently. What alloc_contig_range
> > > should do is to take care of the request.
> > > 
> > > > 
> > > > Now I do understand that some users would like to see why those
> > > > allocations have failed. The question is whether that information is
> > > > generally useful or it is more of a debugging aid. The amount of
> > > > information is also an important aspect. It would be rather unfortunate
> > > > to dump thousands of pages just because they cannot be migrated.
> > > 
> > > Totally, agree dumping thounds of pages as debugging aid are bad.
> > > Couldn't we simply ratelimit them like other places?
> > > 
> > > > 
> > > > I do not have a strong opinion here. We can make all alloc_contig_range
> > > > users use GFP_NOWARN by default and only skip the flag from the cma
> > > > allocator but I am slowly leaning towards (ab)using dynamic debugging
> > > 
> > > I agree the rest of the places are GFP_NOWARN by default except CMA
> > > if they expect alloc_contig_range are optimistic allocation request.
> > > However, I'd like to tweak it for CMA - accept gfp_t from cma_alloc
> > > and take care of the __GFP_NOWARN since some sites of CMA could be
> > > fault tolerant so no need to get the warning.
> > 
> > Any thought to proceed?
> 
> IMHO, add some proper debug mechanisms and don't try squeezing debug
> messages into "WARN" semantics.
> 
> Any alloc_contig_range() user can benefit from that.

So the point is how we could add proper debug mechanism here.
Think about call site A is not critical for the failure but
called very frquently. Call site B is critical for the failure
but called very rarely so turns on system wide dynamic debugging.
You could see a lot of debug message from A even though we
dont't want it. Even, it could hide B's debugging message
by ratelimiting.
