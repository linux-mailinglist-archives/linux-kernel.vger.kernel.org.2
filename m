Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6A38CC67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbhEURlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbhEURlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:41:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45356C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:39:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso7572806pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2t/VTlmdX7MCzosuH7B8AIXN75QL5Hs7N47wBxLop0k=;
        b=DE9GpRFMHtRsn4UCEx1NOlYgGeJWwXqUgwQc9CdGdlrdtrJEwsxa9h+VZb3kFX++6V
         Xf610fLpqT7B/nKxVTKcTL0ecCm1Gzg5fX21hQ7/i+DObpYMjFpJ1pq8ky5EhbuPFVny
         ya1uutDNPm4V1hymCIVuKcTCfkH8X2jHtZFiR1xDzXoQHUBozntnfJz+PDCOiTWlmJTu
         xUsDSOWVKaDaz85ERq+6+rAmI/HGBmOTHDc3G6imsOu0dNKJbAiZYWWDLLTXSTXZ4xtM
         UA5EqE7975MLZObeSv36Ff9/qHFJFTrtqALahsJ1BMHkOuRxEJZclsgIklRmJNElcP6E
         verQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2t/VTlmdX7MCzosuH7B8AIXN75QL5Hs7N47wBxLop0k=;
        b=EStffmD9AhknK/20w/0y8tsY7ISc2mSUKILx5gXfYot3YdEGzyn/EHt726wFNlbuPV
         lZbToqeK1KwiRo8V/+DJ2hWh+ZZmdUXpxiMX06TBaGRtH/j2kGbaqzlKG5HbaN4pLIxS
         PECSEGQFbD7BjwfsXtM6/dsZFwT3WLop6KApLkGc1sPwSUjHM9GzqtL+C8bnTXN38dbR
         grllVOOe0H1XVxc6GA5OYwfCn2+ND8j62gB2lwldyCzeV5q/UbtcdCFXBB+hP8kKD8+A
         bmPPxQqDI5GW0bBlscau9hyz5eqKDE9xLR0f3AKwnKOP1cDu45oYrQOJwamgTEkqaaGy
         AngQ==
X-Gm-Message-State: AOAM5333dKr0PgUHLBbRrj4clJRGdlke7L3q7RZOkBNxwFENPJy2WtoI
        VOS2xn/bBMGo1SBJOxodQW0=
X-Google-Smtp-Source: ABdhPJwmUB8Thmjk4ox/YbEzRl3z4Y/TojQ1uKfnW81tv/KSC/gHxjJI/T16WkYKH92Ia+srmLPTmg==
X-Received: by 2002:a17:902:d386:b029:f3:fa6:84a6 with SMTP id e6-20020a170902d386b02900f30fa684a6mr13436889pld.31.1621618785658;
        Fri, 21 May 2021 10:39:45 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:2a07:5416:42d3:6c55])
        by smtp.gmail.com with ESMTPSA id z23sm4525590pjh.44.2021.05.21.10.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:39:45 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 21 May 2021 10:39:42 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
Message-ID: <YKfwXtx7v/tuJQxc@google.com>
References: <20210519213341.2620708-1-minchan@kernel.org>
 <YKa2Wyo9xqIErpfa@google.com>
 <CADFyXm6jY1nbBsQ4nVXqJksNZKi1rDBw5igFSOLsVzw5sra6Tw@mail.gmail.com>
 <YKbLtsUY2xg9QrYz@google.com>
 <4c7104bc-6950-9334-a066-c01b92577b57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7104bc-6950-9334-a066-c01b92577b57@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:08:15AM +0200, David Hildenbrand wrote:
> On 20.05.21 22:51, Minchan Kim wrote:
> > On Thu, May 20, 2021 at 09:28:09PM +0200, David Hildenbrand wrote:
> > > Minchan Kim <minchan@kernel.org> schrieb am Do. 20. Mai 2021 um 21:20:
> > > 
> > > > On Wed, May 19, 2021 at 02:33:41PM -0700, Minchan Kim wrote:
> > > > > alloc_contig_dump_pages aims for helping debugging page migration
> > > > > failure by page refcount mismatch or something else of page itself
> > > > > from migration handler function. However, in -ENOMEM case, there is
> > > > > nothing to get clue from page descriptor information so just
> > > > > dump pages only when -EBUSY happens.
> > > > > 
> > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > ---
> > > > >   mm/page_alloc.c | 3 ++-
> > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > index 3100fcb08500..c0a2971dc755 100644
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct
> > > > compact_control *cc,
> > > > > 
> > > > >        lru_cache_enable();
> > > > >        if (ret < 0) {
> > > > > -             alloc_contig_dump_pages(&cc->migratepages);
> > > > > +             if (ret == -EBUSY)
> > > > > +                     alloc_contig_dump_pages(&cc->migratepages);
> > > > >                putback_movable_pages(&cc->migratepages);
> > > > >                return ret;
> > > > >        }
> > > > > --
> > > > > 2.31.1.751.gd2f1c929bd-goog
> > > > > 
> > > > 
> > > > Resend with a little modifying description.
> > > > 
> > > >  From c5a2fea291cf46079b87cc9ac9a25fc7f819d0fd Mon Sep 17 00:00:00 2001
> > > > From: Minchan Kim <minchan@kernel.org>
> > > > Date: Wed, 19 May 2021 14:22:18 -0700
> > > > Subject: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
> > > > 
> > > > alloc_contig_dump_pages aims for helping debugging page migration
> > > > failure by elevated page refcount compared to expected_count.
> > > > (for the detail, please look at migrate_page_move_mapping)
> > > > 
> > > > However, -ENOMEM is just the case that system is under memory
> > > > pressure state, not relevant with page refcount at all. Thus,
> > > > the dumping page list is not helpful for the debugging point of view.
> > > > 
> > > 
> > > what about -ENOMEM when migrating empty/free huge pages? I think there is
> > > value in having the pages dumped to identify something like that. And it
> > > doesn‘t require heavy memory pressure to fail allocating a huge page.
> > > 
> > 
> > -ENOMEM means there is no memory to alloate destination page.
> > How could it help dumping source pages in those case from dump_page
> > content point of view?
> 
> You would spot a huge page in the source list (usually at first position)
> without any obvious migration blockers I assume?

It was not a huge page case.

> 
> I'm wondering, did you actually run into this being suboptimal? If it's a
> real problem dumping too many stuff when running into -ENOMEM, fine with me.
> If it's a theoretical issue, I'd prefer to just keep it simple as is.

That's exactly what I encountered. With -ENOMEM, it dumped bunch of
pages on migratepages list. It was just useless with just consuming
logbuffer since there are nothing much to investigate with dumping
source pages.
