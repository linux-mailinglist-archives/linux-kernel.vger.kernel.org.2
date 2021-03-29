Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC034D731
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhC2Sav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhC2Sak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:30:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61180C061574;
        Mon, 29 Mar 2021 11:30:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u10so17039381lju.7;
        Mon, 29 Mar 2021 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tw0qQGq7Y7V2cr6GjDpHoqPiUZnt8Vu2HK+6wSVLMYM=;
        b=Af/YuY0vHbMsgf/+K7qVpTKP3JnjH5rSPhQtypD0vi6D+LY546t6TPEqiHYPSWv4um
         UHEmCkBKq9v6iE0pZ3DBsenEfkuHKtg66cqdrmj46ZGzWTWHay59iOPgcjFOkC4FaVR/
         Tb3EtfGUrdl5tJsHXDFeG5ZzVi0Y+Z3ytpVrs6sA0G99BRlzAx04D77C6RkD9UR+EdtK
         T9LJCQ0Gv/b0eqCyDFrQsJxiXNztZ48c0luk5L3dthTiALjZqeLN0+7/DSZ3TXqzu5my
         YVFV+5U6LvSqAzeJiEkzQR0V2mcZWdQZ45hExOnXElFQi/WQs9BZreyn2/p7fjeMRvZq
         X5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tw0qQGq7Y7V2cr6GjDpHoqPiUZnt8Vu2HK+6wSVLMYM=;
        b=o+DXmQo7cVJfZyMFYWWsFB6DDvi6yOZBFImdcvCPmW+6YaAiuTbcm7RZRh0kLQBKOy
         ndTs34Q9k5gsqGfJulvtZLjJd4enr9xf9wT+jWFcC+iIOlah/1CN2kTRSfw7PP5ZUDUG
         CBPpgpu8EnCHD1j8iyyLwrK0x55Bq59YNmC74nV9L1hOy8/WsS3EC5vfCcCQPNmndk4+
         dhfMOgMQz+rJfVFYjKsSNJp6fEADGS3c00IG1wSj+lBKBWFQ8pXule68+6G8sXFFPOpY
         oey9BFd2VuEJFtBC8TRnILMC5/xTV2IhSQyyMy9/dwEP8b/N3Ov+EzbCbLNpZ5gL+3lF
         FqxQ==
X-Gm-Message-State: AOAM530witA2o6enXK7KJHz5s7N4lNn6fWveyc5OAUP8lNReUkQG3yBr
        Au8l9hkVjSev2NRmINIGHjw=
X-Google-Smtp-Source: ABdhPJzH2z6bJ2EKXy2/FBzTLgdZrX37heTSLI7aj3L+MucUrmSoZ1lBMOeJ1Nlegi/RyzYnvEri0g==
X-Received: by 2002:a2e:917:: with SMTP id 23mr17846634ljj.476.1617042638917;
        Mon, 29 Mar 2021 11:30:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o16sm1911348lfu.228.2021.03.29.11.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:30:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 29 Mar 2021 20:30:36 +0200
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/vmalloc: Fix read of pointer area after it has
 been free'd
Message-ID: <20210329183036.GA22667@pc638.lan>
References: <20210329170730.121943-1-colin.king@canonical.com>
 <20210329171434.GH351017@casper.infradead.org>
 <20210329174029.GA457@pc638.lan>
 <20210329181453.GA13467@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329181453.GA13467@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 08:14:53PM +0200, Uladzislau Rezki wrote:
> On Mon, Mar 29, 2021 at 07:40:29PM +0200, Uladzislau Rezki wrote:
> > On Mon, Mar 29, 2021 at 06:14:34PM +0100, Matthew Wilcox wrote:
> > > On Mon, Mar 29, 2021 at 06:07:30PM +0100, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > Currently the memory pointed to by area is being freed by the
> > > > free_vm_area call and then area->nr_pages is referencing the
> > > > free'd object. Fix this swapping the order of the warn_alloc
> > > > message and the free.
> > > > 
> > > > Addresses-Coverity: ("Read from pointer after free")
> > > > Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")
> > > 
> > > i don't have this git sha.  if this is -next, the sha ids aren't stable
> > > and shouldn't be referenced in commit logs, because these fixes should
> > > just be squashed into the not-yet-upstream commits.
> > > 
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > ---
> > > >  mm/vmalloc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index b73e4e715e0d..7936405749e4 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2790,11 +2790,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >  	}
> > > >  
> > > >  	if (!pages) {
> > > > -		free_vm_area(area);
> > > >  		warn_alloc(gfp_mask, NULL,
> > > >  			   "vmalloc size %lu allocation failure: "
> > > >  			   "page array size %lu allocation failed",
> > > >  			   area->nr_pages * PAGE_SIZE, array_size);
> > > > +		free_vm_area(area);
> > > >  		return NULL;
> > > 
> > > this fix looks right to me.
> > > 
> > That is from the linux-next. Same to me.
> > 
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > --
> > Vlad Rezki
> Is the linux-next(next-20210329) broken?
> 
Please ignore my previous email. That was due to my local "stashed" change.

--
Vlad Rezki
