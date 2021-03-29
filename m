Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962B434D62F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhC2Rkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhC2Rkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:40:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0FC061574;
        Mon, 29 Mar 2021 10:40:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m12so19662512lfq.10;
        Mon, 29 Mar 2021 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dG/fDVlRANUKzxqs96ttVjSvp1RnJE01JtgwpiYp5OQ=;
        b=e0jLrdsbKxVG48pYt7iAQGZucoca/DINeaYlEkj1ohC0O4iX6NSzuwcnGbwUIqf78t
         +5aKfrFTW496gMzjemxHCEQU25vVyEDmHCdI3pj+LmUlVQLhHJQh+TmSCUyR2YtqIMFo
         gs5fwJseylaM9kFxNqEyWa4z+1bPYXBBJiORajXTgLmAdIiOr73wZL9pM36KT70l51p/
         E+5YtfTdF5eb3WBCy7Tb+WsrTu5WQX3Sg5xMpE5cnr5ou/xIKtDKcq7S6pZBIysWwdjh
         qN9GKGe5+IZyLLU2rG/v1NnLZMZs8nLxJPlq9QKabt8s4xaN7aOLHEyZ8Ya3rvK9uROw
         9pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dG/fDVlRANUKzxqs96ttVjSvp1RnJE01JtgwpiYp5OQ=;
        b=RQ3nGfR2AChpoDWa6DuTy1hGwa7l2rw4oVbaZU57GqO+4aPIgTKA+jG/XpDt32vrfJ
         XfaATS5ijdUVAJWa8ihxilgSuePnErzywCGaJV5hdkDv+186lBK2UwGlp2fB/p7k8khN
         ITQ4MhDEx3UFSjdCkXezu2BWGbEeRIOYdTWtwr4f4FteCCks7EK5D5IIFwQWXQkYGCbm
         VFdHT9Ds76fXrhzlKSiXs9tInmiEl4ZJWtFRWRMiwvchRpeI+aMgkhG20Piu10/alv4m
         AclOkZXVEpt5+H3TfmWjhBNu8JV6rSop/nEwBMjWPVXLp+CgNVoD56K1DOs4qeQCFt9R
         K2rA==
X-Gm-Message-State: AOAM5335BFFRkebZBJktBtOCYS7fGWtWdyXYcWZjt6boOBhRoXcfmMyh
        Anni6qUzwo3gH72iNqHNmnE=
X-Google-Smtp-Source: ABdhPJy2nwSd+qCv4LF8DeImyrM1BZPFbgWtI0tyhbrjbzPP4T/D2coD0TOYb2y+8jICMEOFWqs5bQ==
X-Received: by 2002:a05:6512:2016:: with SMTP id a22mr17198967lfb.645.1617039631530;
        Mon, 29 Mar 2021 10:40:31 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f15sm1902605lfr.51.2021.03.29.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 10:40:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 29 Mar 2021 19:40:29 +0200
To:     Matthew Wilcox <willy@infradead.org>,
        Colin King <colin.king@canonical.com>
Cc:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/vmalloc: Fix read of pointer area after it has
 been free'd
Message-ID: <20210329174029.GA457@pc638.lan>
References: <20210329170730.121943-1-colin.king@canonical.com>
 <20210329171434.GH351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329171434.GH351017@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 06:14:34PM +0100, Matthew Wilcox wrote:
> On Mon, Mar 29, 2021 at 06:07:30PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the memory pointed to by area is being freed by the
> > free_vm_area call and then area->nr_pages is referencing the
> > free'd object. Fix this swapping the order of the warn_alloc
> > message and the free.
> > 
> > Addresses-Coverity: ("Read from pointer after free")
> > Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")
> 
> i don't have this git sha.  if this is -next, the sha ids aren't stable
> and shouldn't be referenced in commit logs, because these fixes should
> just be squashed into the not-yet-upstream commits.
> 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index b73e4e715e0d..7936405749e4 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2790,11 +2790,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	}
> >  
> >  	if (!pages) {
> > -		free_vm_area(area);
> >  		warn_alloc(gfp_mask, NULL,
> >  			   "vmalloc size %lu allocation failure: "
> >  			   "page array size %lu allocation failed",
> >  			   area->nr_pages * PAGE_SIZE, array_size);
> > +		free_vm_area(area);
> >  		return NULL;
> 
> this fix looks right to me.
> 
That is from the linux-next. Same to me.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
