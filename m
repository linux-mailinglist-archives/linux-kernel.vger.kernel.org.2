Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83B38B8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhETUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhETUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:52:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:51:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so6127534pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1J1NDW9wLnXiZc7FkTHB0M7yewdKrRpuKTdgXkg6FJs=;
        b=nDLQLS++V3ws3vlncUZ2ERGKbCvhyzFuD/5um4yuejg4dTa58eP5RaeSBuqsamXvsM
         +rBPRBfL5AgOeXJQjBkLZMrfAdKs/dSVw+FUPyTtY2WvE4xA1ZfcVMF9RTBBsXgn2YZd
         QVGxyOPMDb3dX+44RZ5AYwPEWwKd5lytsj+PmNPmcKZL/FJfuUUFyrlzGojvOVcLeZij
         7dNYPAXOfMMVwGVCKLSXDZwLfRjuellzQ5PlmqnBiRgApiuRm3kjc/M//ceAaEvK3CII
         S9SXx9txbs7ZnEoe0Pga+cDXutqUhHENQH8Uj2lhZGzJzFcqucjXJnWAvLFwsJTvYe9r
         mx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=1J1NDW9wLnXiZc7FkTHB0M7yewdKrRpuKTdgXkg6FJs=;
        b=q6lhM4nwNkbm9n8fcTXhueVTTauG9iPjfIKF//tXbmGHIkTKP8zhA4AC95f7YmCAko
         Qe/WU04qhSjgc6/r2lAPDXfpDN8pWvTj82tzBlHL3OJqOhpd/hHOD/KLVs2b3zQ2Uu74
         KY5piTJjD0qY27JP75a25A3FpP1qdkCsX+d2gT5/01B+JudgXkOfPWq8ykQZ5aLIPuIe
         OIA7drZF0PQaoD8EZ1RiD4bpbFndUOUlkSYriW+PsIQHhIrVDsxg5qGmPZid9kRdFGZT
         tMyVmCce0/9aimmQ+6tE9FPUKYKarPt0Biauo24bUbEVQWaTnZ/yzHOrccEcp4YCiJ7/
         GHyg==
X-Gm-Message-State: AOAM5321K0+0PHdwmDZ/+JA/halT9+1nhySU8a6SoGAnhHoUWovR7OuK
        NGvE0TPHrs+R3VxgUOGnZXg=
X-Google-Smtp-Source: ABdhPJxF/LBzvkDguzqsDvK2KTTSPNLhh9YFbQIBPAjcLQejwZW0ObLtoaxDDnXyoGgsE3fUbk4y5w==
X-Received: by 2002:a17:90a:5649:: with SMTP id d9mr6715794pji.163.1621543864493;
        Thu, 20 May 2021 13:51:04 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f248:e9e3:9874:9116])
        by smtp.gmail.com with ESMTPSA id 204sm2570381pfy.56.2021.05.20.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 13:51:03 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 20 May 2021 13:51:02 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
Message-ID: <YKbLtsUY2xg9QrYz@google.com>
References: <20210519213341.2620708-1-minchan@kernel.org>
 <YKa2Wyo9xqIErpfa@google.com>
 <CADFyXm6jY1nbBsQ4nVXqJksNZKi1rDBw5igFSOLsVzw5sra6Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADFyXm6jY1nbBsQ4nVXqJksNZKi1rDBw5igFSOLsVzw5sra6Tw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 09:28:09PM +0200, David Hildenbrand wrote:
> Minchan Kim <minchan@kernel.org> schrieb am Do. 20. Mai 2021 um 21:20:
> 
> > On Wed, May 19, 2021 at 02:33:41PM -0700, Minchan Kim wrote:
> > > alloc_contig_dump_pages aims for helping debugging page migration
> > > failure by page refcount mismatch or something else of page itself
> > > from migration handler function. However, in -ENOMEM case, there is
> > > nothing to get clue from page descriptor information so just
> > > dump pages only when -EBUSY happens.
> > >
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  mm/page_alloc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 3100fcb08500..c0a2971dc755 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct
> > compact_control *cc,
> > >
> > >       lru_cache_enable();
> > >       if (ret < 0) {
> > > -             alloc_contig_dump_pages(&cc->migratepages);
> > > +             if (ret == -EBUSY)
> > > +                     alloc_contig_dump_pages(&cc->migratepages);
> > >               putback_movable_pages(&cc->migratepages);
> > >               return ret;
> > >       }
> > > --
> > > 2.31.1.751.gd2f1c929bd-goog
> > >
> >
> > Resend with a little modifying description.
> >
> > From c5a2fea291cf46079b87cc9ac9a25fc7f819d0fd Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Wed, 19 May 2021 14:22:18 -0700
> > Subject: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
> >
> > alloc_contig_dump_pages aims for helping debugging page migration
> > failure by elevated page refcount compared to expected_count.
> > (for the detail, please look at migrate_page_move_mapping)
> >
> > However, -ENOMEM is just the case that system is under memory
> > pressure state, not relevant with page refcount at all. Thus,
> > the dumping page list is not helpful for the debugging point of view.
> >
> 
> what about -ENOMEM when migrating empty/free huge pages? I think there is
> value in having the pages dumped to identify something like that. And it
> doesn‘t require heavy memory pressure to fail allocating a huge page.
> 

-ENOMEM means there is no memory to alloate destination page.
How could it help dumping source pages in those case from dump_page
content point of view?
