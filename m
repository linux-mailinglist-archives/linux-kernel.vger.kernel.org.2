Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83FD3ADA12
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhFSNEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhFSNEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 09:04:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5AEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 06:02:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f30so21687004lfj.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HUeqKt3RtgMevbE/ABbBGv3TkFoWafk2RAOPNGWgrN4=;
        b=gAsCSsWa6GubxCWdKd9Q3GyoCCuZ7QGqRu45NyFq5pLKuat5VEBAgHWkar7MLfYAzr
         7IudI9XdtQUQ+0v1Mz6VtEzb7gO2ClzBjv+W/BdjOdjWDkF7qc13DqzKsTLavJ9p2YGF
         EDhi5KeE+GNdrWde7rlkgBcv1QWHVOxkptKjI1l4UZwL2gXOmzY0gSjSJBaSy9As0gv9
         7ZYAUkP5WvKk9UyRBmVlZAZVSKVMpAlvwGGj21zjpK7n8u08yga5xYKsOsZ0roY/jLDm
         PX1b4upSbMzodfOZ2Z5SRRD3asUSxDRe9sv4HmMrbTd0fRXz7Q9ddHMVv5YNtwZasCUq
         4jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUeqKt3RtgMevbE/ABbBGv3TkFoWafk2RAOPNGWgrN4=;
        b=Yy6yp9gYHzWHCZ4vB1q/S3xCw9cwObtNMMeNSBTCaBNarC/JE0vsTqBaMgtlm+l8V4
         oPqyz8K/Sg9bBUMP/FY70GGa0I9IV+2jcZxYx8gGOIuCH8S775eJpsWDKySKlG/sqYVo
         CTHbKkTuW2ccZ0Xpw9EPP9sUzu6Fq31NPacYKDw/jrTXiF8tIqIbVB6f6KvJ5uVK3Cgm
         F3c4rf9+SJosTyOTCtn6SxE5OO+A2qTS9Mp7p+dgP9GDqQ5wxjeaglOFOF7chvmcRfD2
         gUPPFD+Pdl6JRZxymkCVmZF/KeSVCz6eBamIGKQaiUWYO+f3IO3N/KYQcczOjtU+7gVU
         dalA==
X-Gm-Message-State: AOAM5320ZZUfI4ODs0UzecZSKSzZ4n2Htz5I/eDruvBWOmfD3x3d4TDO
        22UYfTQAVBlMB0Axu28hLw0=
X-Google-Smtp-Source: ABdhPJzMpjJ+d5bloX8ZVg5ldjSzC/g9D1/RwMDPpA+UOtFW6NOgjo1K8n0+Z6zl9oF6M7+XVMJcaA==
X-Received: by 2002:a19:6902:: with SMTP id e2mr6999176lfc.326.1624107741056;
        Sat, 19 Jun 2021 06:02:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id g28sm1223273lfv.142.2021.06.19.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 06:02:20 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 19 Jun 2021 15:02:17 +0200
To:     Daniel Axtens <dja@axtens.net>
Cc:     akpm@linux-foundation.org, Daniel Axtens <dja@axtens.net>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: unbreak kasan vmalloc support
Message-ID: <20210619130217.GA1915@pc638.lan>
References: <20210617081330.98629-1-dja@axtens.net>
 <1623922742.sam09kpmhp.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623922742.sam09kpmhp.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:40:49PM +1000, Nicholas Piggin wrote:
> Excerpts from Daniel Axtens's message of June 17, 2021 6:13 pm:
> > In commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> > __vmalloc_node_range was changed such that __get_vm_area_node was no
> > longer called with the requested/real size of the vmalloc allocation, but
> > rather with a rounded-up size.
> > 
> > This means that __get_vm_area_node called kasan_unpoision_vmalloc() with
> > a rounded up size rather than the real size. This led to it allowing
> > access to too much memory and so missing vmalloc OOBs and failing the
> > kasan kunit tests.
> > 
> > Pass the real size and the desired shift into __get_vm_area_node. This
> > allows it to round up the size for the underlying allocators while
> > still unpoisioning the correct quantity of shadow memory.
> > 
> > Adjust the other call-sites to pass in PAGE_SHIFT for the shift value.
> > 
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=213335
> > Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> 
> Thanks Daniel, good debugging.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > ---
> >  mm/vmalloc.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index aaad569e8963..3471cbeb083c 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2362,15 +2362,16 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
> >  }
> >  
> >  static struct vm_struct *__get_vm_area_node(unsigned long size,
> > -		unsigned long align, unsigned long flags, unsigned long start,
> > -		unsigned long end, int node, gfp_t gfp_mask, const void *caller)
> > +		unsigned long align, unsigned long shift, unsigned long flags,
> > +		unsigned long start, unsigned long end, int node,
> > +		gfp_t gfp_mask, const void *caller)
> >  {
> >  	struct vmap_area *va;
> >  	struct vm_struct *area;
> >  	unsigned long requested_size = size;
> >  
> >  	BUG_ON(in_interrupt());
> > -	size = PAGE_ALIGN(size);
> > +	size = ALIGN(size, 1ul << shift);
> >  	if (unlikely(!size))
> >  		return NULL;
> >  
> > @@ -2402,8 +2403,8 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
> >  				       unsigned long start, unsigned long end,
> >  				       const void *caller)
> >  {
> > -	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
> > -				  GFP_KERNEL, caller);
> > +	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags, start, end,
> > +				  NUMA_NO_NODE, GFP_KERNEL, caller);
> >  }
> >  
> >  /**
> > @@ -2419,7 +2420,8 @@ struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
> >   */
> >  struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
> >  {
> > -	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
> > +	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> > +				  VMALLOC_START, VMALLOC_END,
> >  				  NUMA_NO_NODE, GFP_KERNEL,
> >  				  __builtin_return_address(0));
> >  }
> > @@ -2427,7 +2429,8 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
> >  struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
> >  				const void *caller)
> >  {
> > -	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
> > +	return __get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> > +				  VMALLOC_START, VMALLOC_END,
> >  				  NUMA_NO_NODE, GFP_KERNEL, caller);
> >  }
> >  
> > @@ -2949,9 +2952,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >  	}
> >  
> >  again:
> > -	size = PAGE_ALIGN(size);
> > -	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
> > -				vm_flags, start, end, node, gfp_mask, caller);
> > +	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> > +				  VM_UNINITIALIZED | vm_flags, start, end, node,
> > +				  gfp_mask, caller);
> >  	if (!area) {
> >  		warn_alloc(gfp_mask, NULL,
> >  			"vmalloc error: size %lu, vm_struct allocation failed",
> > @@ -2970,6 +2973,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >  	 */
> >  	clear_vm_uninitialized_flag(area);
> >  
> > +	size = PAGE_ALIGN(size);
> >  	kmemleak_vmalloc(area, size, gfp_mask);
> >  
> >  	return addr;
> > -- 
> > 2.30.2
> > 
> > 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Indeed hugepage mapping was broken in regard to KASAN. 

Thanks!

--
Vlad Rezki
