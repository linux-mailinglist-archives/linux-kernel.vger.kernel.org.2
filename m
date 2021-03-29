Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B597D34D8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhC2UNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhC2UMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:12:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C82C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 13:12:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w8so6557214pjf.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y+d/t03e3sX/iKjO1lc3uXhJRbYL34/AivFkYivWjD0=;
        b=HshjOCJr5Nhl19R9/SbR4nvIN+du4ihSRWbmtyKExkp0BkXMjUCzl2agZOl1LNvNDu
         RD6DzMgQOINdIe1V2h5v7Mbe9FnPkGJXqy59wF08o5XK5x+7HO/0P620fIMgbEzzup/n
         vmV+dFNALYDkZDNtWAtOICskIWvsdtXKb635nTmERHd/Qkd8HTA1JKvrcLaqRJfk2ZMS
         BsNm5ZIF2IyOEJXKx6lpvUSVr+3aOwfMm81qPvmvwFZstMd1OJAKyY67Zmwz7QEmX8Bl
         T50PlELaXbvbhK170wyKt6wkfZ0GAnh47lHNxNv1VCGDiv1apVF5D1Xsv/EZ7gU/NQM7
         7T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y+d/t03e3sX/iKjO1lc3uXhJRbYL34/AivFkYivWjD0=;
        b=DAhnQumU9hdqvn1us/2A7c3scBHXT2zrBDx5oPVDV0k+HUinDziwN2iiNqAGzrx7hJ
         qI1PBGHoeLZfsLqKSQ2er6HC2RVmNMmuakiQNpHyWmsERx5Kb+DXeuW7f0VUFWFdWyl9
         38ZELVUNfaKthoO5jOcTfP9h6xRA4jFVT5WD3JPWIUZPpznZIyfjlOvioqPHbAMGFBRL
         dXl3+njkS5KMmYaEqmmKLhhZiqd/RVg2cRps/stnEMCbVRFgCm1+04ZyHtf6a15b78WZ
         StTLPRB3OY9ezF6qtpLDJu5TsIiI3Zy5pHsxOtieqRul+HxvJfV1NwZPiz0LVvATfTSO
         tOlQ==
X-Gm-Message-State: AOAM5326KZR5v/OSQ0JOWO8o+iMJCKxiBn40pn4vAJKIm5N+PS4smwYW
        GDMwUoOucP+hJFooQvVnebQ=
X-Google-Smtp-Source: ABdhPJw2cBwLPRh/lll28/QMNz/rXZkFuhxx8d9Xu4lKgmYRWKaiR9X8DYk3s6nMn6YvzoRnDNxc2w==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr833995pjr.4.1617048755762;
        Mon, 29 Mar 2021 13:12:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:e9af:f14a:516c:eaef])
        by smtp.gmail.com with ESMTPSA id p25sm18257708pfe.100.2021.03.29.13.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 13:12:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 29 Mar 2021 13:12:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, david@redhat.com
Subject: Re: [PATCH] mm: change size_t to unsigned int for cma_alloc
Message-ID: <YGI0sThJjsshpPIR@google.com>
References: <20210329182553.3129234-1-minchan@kernel.org>
 <20210329184431.GJ351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329184431.GJ351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 07:44:31PM +0100, Matthew Wilcox wrote:
> On Mon, Mar 29, 2021 at 11:25:53AM -0700, Minchan Kim wrote:
> > size_t in cma_alloc is confusing since it makes people think
> > it's byte count, not pages. Fix it.
> 
> i think it has to be unsigned long.
> 
> 67a2e213e7e937c41c52ab5bc46bf3f4de469f6e

Thanks for the pinter. I wanted to have the smallest change.
The commit leads me to change cma_release, trace_cma_alloc,
cma_clear_bitmap and front_contig_range as well.(Not sure
we have more. Will check).

Ccing david@redhat.com for upcoming changing free_contig_range.

> 
> > Link: https://lore.kernel.org/linux-mm/20210324043434.GP1719932@casper.infradead.org/
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/linux/cma.h | 2 +-
> >  mm/cma.c            | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index 217999c8a762..a873edc20ca2 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -44,7 +44,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >  					unsigned int order_per_bit,
> >  					const char *name,
> >  					struct cma **res_cma);
> > -extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> > +extern struct page *cma_alloc(struct cma *cma, unsigned int count, unsigned int align,
> >  			      bool no_warn);
> >  extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
> >  
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 08c45157911a..24dc01e26d45 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -423,21 +423,21 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
> >   * This function allocates part of contiguous memory on specific
> >   * contiguous memory area.
> >   */
> > -struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> > +struct page *cma_alloc(struct cma *cma, unsigned int count, unsigned int align,
> >  		       bool no_warn)
> >  {
> >  	unsigned long mask, offset;
> >  	unsigned long pfn = -1;
> >  	unsigned long start = 0;
> >  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> > -	size_t i;
> > +	unsigned int i;
> >  	struct page *page = NULL;
> >  	int ret = -ENOMEM;
> >  
> >  	if (!cma || !cma->count || !cma->bitmap)
> >  		goto out;
> >  
> > -	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
> > +	pr_debug("%s(cma %p, count %u, align %d)\n", __func__, (void *)cma,
> >  		 count, align);
> >  
> >  	if (!count)
> > @@ -500,7 +500,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> >  	}
> >  
> >  	if (ret && !no_warn) {
> > -		pr_err_ratelimited("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> > +		pr_err_ratelimited("%s: %s: alloc failed, req-size: %u pages, ret: %d\n",
> >  				   __func__, cma->name, count, ret);
> >  		cma_debug_show_areas(cma);
> >  	}
> > -- 
> > 2.31.0.291.g576ba9dcdaf-goog
> > 
> > 
