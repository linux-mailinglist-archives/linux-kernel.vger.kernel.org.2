Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557B032D94E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhCDSM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhCDSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:12:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E81C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:11:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t29so19504635pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SvoG8PH6dFacNFIYLiSSp4aCzcuSGoW8XP7i139LeKE=;
        b=RhMBTJO7wwKdRPvYiCjrVMyO9I4FmWrIsLlUGIu9mc/tHqdN9miLpof0Gu6ZHfySPF
         +RaVuaa8vvwjEp5Be80jlEiGIkkdnrc0WxpG4qNHM3i1R8tqMZse2lMtQ78bZGJxAWHX
         62868iG/7zBLZNvw1/7izUu7tssTkR7DIIUhCpFLOR49XD0J4WLmlOxAoUHRw9H09WKH
         PryaSYvAb+Qkj46mMbHj3fGhhBRWV68sUNrbauUM9QN7FlnH/yGq9528/pzWffY4w1sx
         FFexn3oqShC2mxFpQS6bYkDUALT57scwUxA4bfFvnO0MwA3zdkXxl7NZLEhRXGjZPyme
         nZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SvoG8PH6dFacNFIYLiSSp4aCzcuSGoW8XP7i139LeKE=;
        b=OznLLTaUxyXJCLjWawRzd1UnqAV+cYotgk3GR2do2LqPk/PGKey4+n8LidWSMvu/dK
         9Hhy0wYlzhMvHdwyHVzVpGocksMcedRUkkhcU4odsnAm3u5wLgSmF/33oBPzkEykE4mq
         k1LbdPn95XOAFvHFuD3CFJCCUVpiWob6IybiuHm7mKiBYF4actS6yo5W9d0ysAZPM54q
         NbY8b4NOEw8YNYhEIs6LOQ9afzX/hKiW5hLNV7uzmzTgdeWy/pV+0nLFy+rh+BjCXNkn
         6+k7IC07JlbqK6aAA8+c2t/itA56/SQXFbdGNbgc9uUWBtMZ/jGcdeEYogeo9lsEaebI
         J5Kg==
X-Gm-Message-State: AOAM5336EEfxCOhtKU6ZhI+vBfS7zLA8FL14hM3/2X+k9W4V3xsnIvNk
        T3qd7EPIPCbPdtnL/XrK0szTf/umEHA=
X-Google-Smtp-Source: ABdhPJwo/Eix2fryzn2tB7wHfS3UXP/mgLxvJ+tlAB2sCpzp+2XbmfUsjrHNJ9GwDr6Buqg8xFUOhw==
X-Received: by 2002:a63:c343:: with SMTP id e3mr4746948pgd.8.1614881498786;
        Thu, 04 Mar 2021 10:11:38 -0800 (PST)
Received: from google.com ([2620:15c:211:201:edb1:8010:5c27:a8cc])
        by smtp.gmail.com with ESMTPSA id j9sm10398865pjn.32.2021.03.04.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 10:11:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Mar 2021 10:11:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEEi1+TREGBElE5H@google.com>
References: <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com>
 <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com>
 <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 06:23:09PM +0100, David Hildenbrand wrote:
> > > You want to debug something, so you try triggering it and capturing debug
> > > data. There are not that many alloc_contig_range() users such that this
> > > would really be an issue to isolate ...
> > 
> > cma_alloc uses alloc_contig_range and cma_alloc has lots of users.
> > Even, it is expoerted by dmabuf so any userspace would trigger the
> > allocation by their own. Some of them could be tolerant for the failure,
> > rest of them could be critical. We should't expect it by limited kernel
> > usecase.
> 
> Assume you are debugging allocation failures. You either collect the data
> yourself or ask someone to send you that output. You care about any
> alloc_contig_range() allocation failures that shouldn't happen, don't you?
> 
> > 
> > > 
> > > Strictly speaking: any allocation failure on ZONE_MOVABLE or CMA is
> > > problematic (putting aside NORETRY logic and similar aside). So any such
> > > page you hit is worth investigating and, therefore, worth getting logged for
> > > debugging purposes.
> > 
> > If you believe the every alloc_contig_range failure is problematic
> 
> Every one where we should have guarantees I guess: ZONE_MOVABLE or
> MIGRAT_CMA. On ZONE_NORMAL, there are no guarantees.

Indeed.

> 
> > and there is no such realy example I menionted above in the world,
> > I am happy to put this chunk to support dynamic debugging.
> > Okay?
> > 
> > +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> > +        (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> > +static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
> > +               DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> > +int alloc_contig_ratelimit(void)
> > +{
> > +       return __ratelimit(&alloc_contig_ratelimit_state);
> > +}
> > +
> 
> ^ do we need ratelimiting with dynamic debugging enabled?

Main argument was debug message flooding. Even though we
play with dynamic debugging, the issue never disappear.

> 
> > +void dump_migrate_failure_pages(struct list_head *page_list)
> > +{
> > +       DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > +                       "migrate failure");
> > +       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> > +                       alloc_contig_ratelimit()) {
> > +               struct page *page;
> > +
> > +               WARN(1, "failed callstack");
> > +               list_for_each_entry(page, page_list, lru)
> > +                       dump_page(page, "migration failure");
> 
> Are all pages on the list guaranteed to be problematic, or only the first
> entry? I assume all.

All.

> 
> > +       }
> > +}
> > +#else
> > +static inline void dump_migrate_failure_pages(struct list_head *page_list)
> > +{
> > +}
> > +#endif
> > +
> >   /* [start, end) must belong to a single zone. */
> >   static int __alloc_contig_migrate_range(struct compact_control *cc,
> >                                          unsigned long start, unsigned long end)
> > @@ -8496,6 +8522,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
> >                                  NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> >          }
> >          if (ret < 0) {
> > +               dump_migrate_failure_pages(&cc->migratepages);
> >                  putback_movable_pages(&cc->migratepages);
> >                  return ret;
> >          }
> > 
> > 
> 
> If that's the way dynamic debugging is configured/enabled (still have to
> look into it) - yes, that goes into the right direction. As I said above,
> you should dump only where we have some kind of guarantees I assume.

Sure, let me wait for your review before sending next revision.
Thanks for the review!
