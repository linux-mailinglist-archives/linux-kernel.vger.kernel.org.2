Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6760D31E139
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhBQVUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhBQVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:20:07 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1120C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:19:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so9286151pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hdfte6859K4H28Potw2xMsDUKaSnL8kHSeZpJtB9aBQ=;
        b=VTJrGc+I2OYjOLy0h17IahPi6ZQYjBp0LBYRgedbumbhvM4iNM5QE6qr65jyyCAo8y
         1dla0zVEm68iki5zLY3D232Ln0WqlObkpcBLTm3bIP+GrE+eblDozC/jtwaLrCqf8dpi
         WHrVR5/6bo81yZ6bS4FSe2yA8cB+8vQz9WsgkMTcWBvMrj+9Jz98cZvHsc12pDFRoySP
         /6Fh46S5rfaqgsHouUjn3rcv8UWPhLo72XjBnW0chq6Ee0ZrXlHi4GswyKsw1C4pXoxx
         +uxQGKzcWI8GbXc7ZLwxJCMrSNAthsavJu9b+ALyATxin6rLPyYoWAYHKQkO2NrRnZQe
         QTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Hdfte6859K4H28Potw2xMsDUKaSnL8kHSeZpJtB9aBQ=;
        b=RdFnRK6sDN6B75NauMOZ1YvnlXfcpsFhi8lC+9Kan2SVyj4hvX0y6Q1KawdY9Skqvw
         Fp0ulb1g5qheLEAqFtM61o0kn3O6SXBL/4nNJcjinlSGrdNha64hGujhQPGppsn7QWni
         WUzJxBOmXyPsgdrJkEaunWJzTcS58NR4izei5TOy76IhZ7Ph2XIMo9HR+xUwy0f6XyVF
         BJ2vCYhm/BxLRC1gQSSugklWLkEcc/UPyRq5qH46Gp6nDtom6zUfFwObkJicpmm7B8CW
         wD1QJ6l73omgPiKNN2r5j8F0S1o9egzFQ79YTcrs1yuqAtA4KdjVTzf9zrMxv11WeLuN
         RMJQ==
X-Gm-Message-State: AOAM5311vVkCNpAv49KIKRxgR/3jQCuz7WqICKeN0aeog9tScApTwiOe
        c9/IH2IGy769qxoFpmyCihM=
X-Google-Smtp-Source: ABdhPJyixckF078hxEEj7ezuKuE6z1m4Hw7ROqPDMlNVdcs+ufQxpdBhzNQ4Yo4HyM7luIxb1K/H5Q==
X-Received: by 2002:a63:4e08:: with SMTP id c8mr1080362pgb.87.1613596766489;
        Wed, 17 Feb 2021 13:19:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id b10sm1736339pgm.76.2021.02.17.13.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:19:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 13:19:23 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com
Subject: Re: [PATCH] mm: vmstat: add cma statistics
Message-ID: <YC2IW+Isx1wplT6/@google.com>
References: <20210217170025.512704-1-minchan@kernel.org>
 <8036d8e6-8e96-7b4e-91c0-e1ae91b637e1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8036d8e6-8e96-7b4e-91c0-e1ae91b637e1@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 12:57:25PM -0800, John Hubbard wrote:
> On 2/17/21 9:00 AM, Minchan Kim wrote:
> > Since CMA is used more widely, it's worth to have CMA
> > allocation statistics into vmstat. With it, we could
> > know how agressively system uses cma allocation and
> > how often it fails.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >   include/linux/vm_event_item.h |  3 +++
> >   mm/cma.c                      | 12 +++++++++---
> >   mm/vmstat.c                   |  4 ++++
> >   3 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > index 18e75974d4e3..0c567014ce82 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -70,6 +70,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >   #endif
> >   #ifdef CONFIG_HUGETLB_PAGE
> >   		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
> > +#endif
> > +#ifdef CONFIG_CMA
> > +		CMA_ALLOC, CMA_ALLOC_FAIL,
> 
> This seems wrong: here it's called "alloc", but in the output it's
> called "alloc success", and in the implementation it's clearly
> "alloc attempt" that is being counted.

Argh, I wanted to introduce CMA_ALLOC, not ALLOC_ATTEMPTS.
Let me fix.

> 
> Once these are all made consistent, then the bug should naturally
> go away as part of that.
> 
> nit: I think the multiple items per line is a weak idea at best, even
> though it's used here already. Each item is important and needs to be
> visually compared to it's output item later. So one per line might
> have helped avoid mismatches, and I think we should change to that to
> encourage that trend.

No problem.
Thanks for the review, John.
