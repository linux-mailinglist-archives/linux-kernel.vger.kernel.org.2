Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5231EEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhBRSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhBRQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:50:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE099C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:47:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so1832663pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLD/Vci8BmjI88mYbyEPyheGKG0KNpyI0nkYViJLyO4=;
        b=YHDVGz9Wm9nKaEw67Tpa9tyNwVeX/OK3qzLTbNPaILkqjBy4kTvgggy2iLcv+k2EwG
         rqsngVVMewnsiMnAkATXJ/l4pEhdkMFH/KDvGkToe1C9is3KG9QFm8ouC/d9Dc1cP27V
         PWYss9F4yORor9Bf9/0aLD9HJp+m3eQRs2GRZ6Di182fy2nceb4R8xMFB7cnUtwjOAvd
         RNUt2ZB3DR7CkCm3Dafk8OVP485zHB42AUkzr8wOc9lvHMDZJUpTUVhEVDT1hiTRelUc
         8iAfN7qgX98vRzGubsqrwfuZnUEnbt7U1iLHbWDmvAY3ZNiaWwUaZrw2vzG8WRfjHR1E
         KGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QLD/Vci8BmjI88mYbyEPyheGKG0KNpyI0nkYViJLyO4=;
        b=trlF147Zy9iPmnFyAw3YfEI3I1BT3OwODeedeG0PU8QFImQ6sTGhbDFFzYhj0JdXhz
         toxrBxXrpFjZAYBT8kzE0jC0XMaI7hpnkdcZzODE91hN7jZ1qdD/DkbLkkSDN/YG5nQ9
         leFZzYPTSfAmnkmpFPW6AiVfXdTFpPSz3+t9SDvdzfitPDFAX0A3pEzjnQ4BE7uRIlb8
         /7IvDCRms4aF8TRan908rtUJ7RYg5AR0HzlQQViqg+NElTMjQMXUsvUzqL3imjuOkgrb
         y0Ga05EWnvae6PeX3VDBigYdBh7sju98FBglqtp1yRnAZK91gSdJ2vko4Om9CsRW5pLn
         4a2A==
X-Gm-Message-State: AOAM533/FB/PPcjd3W74ecRWnA77bsOkPTodN+EEQVd4vmCAt3zWfuQ8
        BbLZgsixQ3z8vQETpN82OqY=
X-Google-Smtp-Source: ABdhPJwoZfClDSLYCjn0A9YHv8diVsM02fTK00Xfw2+4RfmSwoJwROlZgiTYngLZZrqjzVcRE3H7DA==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr4780789pjb.35.1613666851454;
        Thu, 18 Feb 2021 08:47:31 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id v9sm6014020pju.33.2021.02.18.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:47:30 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 18 Feb 2021 08:47:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC6aIL67PaYlmeYq@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <dc534e7b-3992-eb37-8399-67258ff03067@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc534e7b-3992-eb37-8399-67258ff03067@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:26:08PM +0100, David Hildenbrand wrote:
> On 18.02.21 17:19, Minchan Kim wrote:
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
> 
> I am not 100% sure it does.

Oh, it should. Otherwise, let's fix either of caller or
alloc_contig_range since we have a customer.

```
    ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
            GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0))
```

> 
> > Why shouldn't people use it if they don't care the failure?
> 
> Because flooding the log with noise maybe a handful of people on this planet
> care about is absolutely useless. With the warnings in warn_alloc() people
> can at least conclude something reasonable.
> 
> > Semantically, it makes sense to me.
> > 
> > About the messeage flooding, shouldn't we go with ratelimiting?
> 
> At least that (see warn_alloc()). But I'd even want to see some other
> trigger to enable this explicitly on demand.

No objection.

How about adding verbose knob under CONFIG_CMA_DEBUGFS with
alloc_contig_range(..., bool verbose) like start_isolate_page_range?

If admin turns on the verbose mode under CONFIG_CMA_DEBUGFS,
cma_alloc will pass alloc_contig_range(...., true).
