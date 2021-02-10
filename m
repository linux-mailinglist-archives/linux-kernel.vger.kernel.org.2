Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21FB316A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBJP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhBJP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:59:32 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A93C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:58:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c11so1517035pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1A2lhIKvKlS4fQMuHUtKegN4NAsMUDtsHg94t+brQEQ=;
        b=fZxQazPUhZs9+BFdJj9CbxH0PeQgY68peDCuNO5Mu/dzJ+swkj2/ojoJMtuLnaW/2m
         XofRSvc8KoONaWfgXnR62zjiOc31KCWmJkP8AhzLH2NB11cVQpZ1D7VN37HslidVC8V1
         SGVlqvgsf0OlVvOBaejkjd/EXyL1v61QDZdRe+d6pMCVTcFvLlv3IrdaKPoI8DmKuD1b
         x7KmU5MlRPlezmXMOmrn/OD+V18+neit6xmafnfgEEEDQ20N5Abivp8eHVmCV9DDgxwP
         SLp7Y0OgMd/c/Mx+ZsD3IDzlXl2PJS5OQHrPuJBPrQTbRdwSeQ6GhpjchkKs1FcqU9Sb
         kVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1A2lhIKvKlS4fQMuHUtKegN4NAsMUDtsHg94t+brQEQ=;
        b=nz+y1g6EHlYJoosAJLhpTCdqMvYKdXN6qncEcqbX0D2SqnRjGor65Uksy8BrMfjjN5
         9ZwW7x79Rfp44TlLwZir8pm/evd7NYJcAbCowfUMnjoqjXUKDFSabxjCEjVEoAHUd9Wv
         sxrbsYJJJpsxXGZ5Mduu0ma21kkQBgMXgBf2tydckjMayL+8CdnxeWu0kNDKGRmUJoih
         uvRslpbTEZQbKunk9jXuQu3BYergS5dJgSGnV9Uwk5KurzjfA9k4+xtpNPrk0FV/JMGj
         IhPx3PZ4/lJK6Sg/u2WoazPWXs8srkK1cH+DuJPCpz4KLmxLPYBjt+IMG++BWGL8pc5A
         dGJg==
X-Gm-Message-State: AOAM533i5cU7wsgFQrZgzVfwCDOzA3cocH/rCfRVS5rDvUBz3M2rjGkC
        JzYrhonhc17h8EyCNHrJ474=
X-Google-Smtp-Source: ABdhPJwhBFqQ0/l2Rds/W6FK0eJuRZmRnVHZ1WS6rH3ONPiLKneNGesm0Z3TZZHWOXq6D1HfJuxFOw==
X-Received: by 2002:a62:a214:0:b029:1d8:d104:6a2 with SMTP id m20-20020a62a2140000b02901d8d10406a2mr3689377pff.36.1612972731396;
        Wed, 10 Feb 2021 07:58:51 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id q2sm2431299pfu.215.2021.02.10.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:58:50 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Feb 2021 07:58:48 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
Message-ID: <YCQCuHwnSdEygp5F@google.com>
References: <20210209175048.361638-1-minchan@kernel.org>
 <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
 <20210209190332.GA3363@localhost.localdomain>
 <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:17:33PM +0100, Vlastimil Babka wrote:
> On 2/9/21 8:03 PM, Oscar Salvador wrote:
> > On Tue, Feb 09, 2021 at 07:17:59PM +0100, David Hildenbrand wrote:
> >> I was expecting some magical reason why this is still required but I am not
> >> able to find a compelling one. Maybe this is really some historical
> >> artifact.
> >> 
> >> Let's see if other people know why this call here still exists.
> > 
> > I also stumbled upon this while working on adding hugetlb support for
> > alloc_acontig_range [1].
> > I have to confess I puzzled me a bit.
> > 
> > I saw it going back to when the function was first introduced by 
> > 
> > commit 041d3a8cdc18dc375a128d90bbb753949a81b1fb
> > Author: Michal Nazarewicz <mina86@mina86.com>
> > Date:   Thu Dec 29 13:09:50 2011 +0100
> > 
> >     mm: page_alloc: introduce alloc_contig_range()
> > 
> > 
> > It does not make much sense to me. At this point our pages are free, so
> > we do not care about LRU handling here.
> > But I might be missing something.
> 
> AFAICS, at the time page migration used putback_lru_page() to release the
> migration source page. This would put the page on lru pvec even if it was in
> fact not mapped anywhere anymore, and only the drain would actually free it.
> Seems Minchan optimized this in 2016 by c6c919eb90e0 ("mm: use put_page() to
> free page instead of putback_lru_page()")
> 
> > [1] https://lore.kernel.org/linux-mm/20210208103935.GA32103@linux/T/#md651fc6e73c656105179382f92f8b2d6073051d1

Thanks for digging history, Vlastimil!
