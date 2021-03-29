Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77034D84A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhC2Tcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhC2TcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:32:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB92C061574;
        Mon, 29 Mar 2021 12:32:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b14so20150681lfv.8;
        Mon, 29 Mar 2021 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=95kh5SpigsiYFCPpdp/oq1Ev/SueOTCbLK84aNGGJrE=;
        b=PRz/rYoB7sXNPzH/aSQ9NrISTs67V/HYeePvNPCaY0OBrWLGXFFShibdS9GvgSKOT8
         bXJF30qRp8Pr1P4+jpewVwJ8RyZbm1f156SUxrKtZt9Y4ahoZZCkF2DJtZaQlrmfvsi/
         3Pa8pCDzDmUXDZfWP6YwcaUV9u6079ZyY/Qrpjm3iTBdjipFSbXWBo2HmgIojOr0t3E0
         4pxGZEp9rfIr6ToIc1ZPt/8XMtOMOFoTD3MzTNi7leSn2BVl//HY4lpAFUXF0EdQZw11
         sRTFa1ztJ8TFzU7aFwFH7ULViR1xGIXa6KaVz65YMxyWVd2WWehIgrHnWQ3ct8gX6xoG
         e8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=95kh5SpigsiYFCPpdp/oq1Ev/SueOTCbLK84aNGGJrE=;
        b=prks3BEACN03AqHjc6ChqQPmoNUosxqVy1LUHcgl1CLCUb5GJnaFv1ndEkcosv1Msv
         TDmVoLyDL9yADoVPBwFanui6g9YoZUrEZCUqyjbEOYUgYEgcoGTfwv4KP214NZwt/wcL
         fFMkPf+sYGCDCQnRXQQxTexBdMI5SLC192sF/oihpE5QsN2JCrTic0T5fhx8lmbbfTs/
         xXA5TOlU9JRFiyLCdAkFpAMraooXITiXjHNQIo6edBrh+mnBNCXqnwcmN9W01TYqGHqv
         CcjN1o+uNTbfixt42dCV5eYUDU5bvW52r3jue8Wmh59LEv5MMr7iBoYGaCqeU6a4TCph
         Iq2A==
X-Gm-Message-State: AOAM531KHeqWt6PpAopaB/HtqzCG3rAZ5whvdCjCcYQjk58MGFRCQLND
        Wtyhb6f5pGgvDL/b0YOzaInkeQ/mU1Q=
X-Google-Smtp-Source: ABdhPJzJAoua3FRaGMlVWTpwb4GWVB4Wbcz16Runx47ygk4+lsqd1MITQtmz0SSJyhJaQ+xevkXhnA==
X-Received: by 2002:a05:6512:31cf:: with SMTP id j15mr17399289lfe.14.1617046336864;
        Mon, 29 Mar 2021 12:32:16 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z28sm2618579ljn.117.2021.03.29.12.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 12:32:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 29 Mar 2021 21:32:14 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/vmalloc: Fix read of pointer area after it has
 been free'd
Message-ID: <20210329193214.GA28602@pc638.lan>
References: <20210329170730.121943-1-colin.king@canonical.com>
 <20210329171434.GH351017@casper.infradead.org>
 <20210329174029.GA457@pc638.lan>
 <20210329181453.GA13467@pc638.lan>
 <20210329183036.GA22667@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329183036.GA22667@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 29, 2021 at 08:14:53PM +0200, Uladzislau Rezki wrote:
> > On Mon, Mar 29, 2021 at 07:40:29PM +0200, Uladzislau Rezki wrote:
> > > On Mon, Mar 29, 2021 at 06:14:34PM +0100, Matthew Wilcox wrote:
> > > > On Mon, Mar 29, 2021 at 06:07:30PM +0100, Colin King wrote:
> > > > > From: Colin Ian King <colin.king@canonical.com>
> > > > > 
> > > > > Currently the memory pointed to by area is being freed by the
> > > > > free_vm_area call and then area->nr_pages is referencing the
> > > > > free'd object. Fix this swapping the order of the warn_alloc
> > > > > message and the free.
> > > > > 
> > > > > Addresses-Coverity: ("Read from pointer after free")
> > > > > Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")
> > > > 
> > > > i don't have this git sha.  if this is -next, the sha ids aren't stable
> > > > and shouldn't be referenced in commit logs, because these fixes should
> > > > just be squashed into the not-yet-upstream commits.
> > > > 
> > > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index b73e4e715e0d..7936405749e4 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2790,11 +2790,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > > >  	}
> > > > >  
> > > > >  	if (!pages) {
> > > > > -		free_vm_area(area);
> > > > >  		warn_alloc(gfp_mask, NULL,
> > > > >  			   "vmalloc size %lu allocation failure: "
> > > > >  			   "page array size %lu allocation failed",
> > > > >  			   area->nr_pages * PAGE_SIZE, array_size);
> > > > > +		free_vm_area(area);
> > > > >  		return NULL;
> > > > 
> > > > this fix looks right to me.
> > > > 
> > > That is from the linux-next. Same to me.
> > > 
> > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > --
> > > Vlad Rezki
> > Is the linux-next(next-20210329) broken?
> > 
> Please ignore my previous email. That was due to my local "stashed" change.
> 
Hello, Andrew.

Could you please squash below patch with the one that is in question?
Or should i send out it as separate patch?

From 6d1c221fec4718094c6e825e3879a76ad70dba93 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Mon, 29 Mar 2021 21:12:47 +0200
Subject: [PATCH] mm/vmalloc: print correct vmalloc allocation size

On entry the area->nr_pages is not set yet and is zero, thus
when an allocation of the page-table array fails the vmalloc
size will not be reflected correctly in a error message.

Replace area->nr_pages by the nr_small_pages.

Fixes: 014ccf9b888d ("mm/vmalloc: improve allocation failure error messages")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b73e4e715e0d..8b564f91a610 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2794,7 +2794,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "page array size %lu allocation failed",
-			   area->nr_pages * PAGE_SIZE, array_size);
+			   nr_small_pages * PAGE_SIZE, array_size);
 		return NULL;
 	}
 
-- 
2.20.1

--
Vlad Rezki
