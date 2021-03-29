Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676A434C315
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhC2Fkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC2Fj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:39:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53406C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 22:39:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so9203075pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HB5D+Df4b92NNL5INPCl0u4uegAPqn3yCpFmre75IO0=;
        b=QsTCJsUtenWu7m/lcgk7/D6dS4/RxSsCneiEugMUPmFXoVB/w/hCEriKd2d23TIc42
         cCUpYqRiWqPgXSD9UhFPbQxiFBFD+mOEXuq6WhSoi1E1QUmBpvQ0cCvW+bvP1fjDspOi
         6hb+1SdbsoztenyIBR5SobwC2RqfxNyvFW83YYXXJhPvm2ZAM2yFjPKRJoIAHIgwpbhi
         m5DHWxkeMt1ISXDQjppfjxdQbB7TrWFJy2//nGuDP0tdpsTNP8Lec4hPSKOkWb9Nhhrk
         Cch+QWbJ1S0IED2XGD6QqGBjEW4cHPenFkDCJg49tDLFss1WvZEr/sW5fNB7CSeTslFh
         9wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HB5D+Df4b92NNL5INPCl0u4uegAPqn3yCpFmre75IO0=;
        b=flv2b1b/u1LQA2h7aAaWa4cC9lhIZdSBVXFhDfGWe4ZUQtNaZ8440XUFeeMsZCFk49
         Ms+HpXcrcH3lleglucUqFYy0s/q0/2ljQT2JKbi5IlXkf307nSqajbtmtzROTeZr1OPV
         Nfep/BhUN63Mx2+aa1Yerp8+LDwcK0Mnxi/7bnX8rmGIYSLMg9IIFFr0+mQodH4iQihd
         1RTg9K2+DWgxEgiXXvXUM6K0y459sQj7hhot4/JgMVSZmk4c9iWnl5M6njBGfFWgWwH5
         zpnz0sYsFXVtbNTMvzm980mYuoVRhI9gbo5noWSasGvWQ8zS3sPpGiiXDgvayPO9G47m
         ZKUw==
X-Gm-Message-State: AOAM530MU9Ausbf3F7srzN1C9Wp4fARX0o8fTpwaW1g4LAt7R/+fCPvN
        qfbQw+wrpfNb+a2S0e7iM00=
X-Google-Smtp-Source: ABdhPJzieiUatqy4kDTmGo4BEBtkcDUxcyobC6MDD8OCAPaeAKvD8V8dXANtDM5fll9ZJ5H37sIh8w==
X-Received: by 2002:a05:6a00:2345:b029:20b:c007:f9a4 with SMTP id j5-20020a056a002345b029020bc007f9a4mr23756778pfj.42.1616996383238;
        Sun, 28 Mar 2021 22:39:43 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id a22sm16663404pgw.52.2021.03.28.22.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:39:41 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:39:38 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        david@redhat.com, daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] kernel/resource: Fix locking in
 request_free_mem_region
Message-ID: <20210329053938.GP77072@balbir-desktop>
References: <20210326012035.3853-1-apopple@nvidia.com>
 <20210326051536.GN77072@balbir-desktop>
 <2574877.iCKU5I5uxK@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2574877.iCKU5I5uxK@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 12:55:15PM +1100, Alistair Popple wrote:
> On Friday, 26 March 2021 4:15:36 PM AEDT Balbir Singh wrote:
> > On Fri, Mar 26, 2021 at 12:20:35PM +1100, Alistair Popple wrote:
> > > +static int __region_intersects(resource_size_t start, size_t size,
> > > +                            unsigned long flags, unsigned long desc)
> > > +{
> > > +     struct resource res;
> > > +     int type = 0; int other = 0;
> > > +     struct resource *p;
> > > +
> > > +     res.start = start;
> > > +     res.end = start + size - 1;
> > > +
> > > +     for (p = iomem_resource.child; p ; p = p->sibling) {
> > > +             bool is_type = (((p->flags & flags) == flags) &&
> > > +                             ((desc == IORES_DESC_NONE) ||
> > > +                              (desc == p->desc)));
> > 
> > is_type is a bad name, are we saying "is" as in boolean question?
> > Or is it short for something like intersection_type? I know you've
> > just moved the code over :)
> 
> Yeah, I'm not a fan of that name either but I was just moving code over and 
> couldn't come up with anything better :)
> 
> It is a boolean question though - it is checking to see if resource *p is the 
> same type (flags+desc) of region as what is being checked for intersection.
>
> > > +
> > > +             if (resource_overlaps(p, &res))
> > > +                     is_type ? type++ : other++;
> > > +     }
> > > +
> > > +     if (type == 0)
> > > +             return REGION_DISJOINT;
> > > +
> > > +     if (other == 0)
> > > +             return REGION_INTERSECTS;
> > > +
> > > +     return REGION_MIXED;
> > > +}
> > > +
> > >  /**
> > >   * region_intersects() - determine intersection of region with known 
> resources
> > >   * @start: region start address
> > > @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
> > >  int region_intersects(resource_size_t start, size_t size, unsigned long 
> flags,
> > >                     unsigned long desc)
> > >  {
> > > -     struct resource res;
> > > -     int type = 0; int other = 0;
> > > -     struct resource *p;
> > > -
> > > -     res.start = start;
> > > -     res.end = start + size - 1;
> > > +     int rc;
> > >
> > >       read_lock(&resource_lock);
> > > -     for (p = iomem_resource.child; p ; p = p->sibling) {
> > > -             bool is_type = (((p->flags & flags) == flags) &&
> > > -                             ((desc == IORES_DESC_NONE) ||
> > > -                              (desc == p->desc)));
> > > -
> > > -             if (resource_overlaps(p, &res))
> > > -                     is_type ? type++ : other++;
> > > -     }
> > > +     rc = __region_intersects(start, size, flags, desc);
> > >       read_unlock(&resource_lock);
> > > -
> > > -     if (type == 0)
> > > -             return REGION_DISJOINT;
> > > -
> > > -     if (other == 0)
> > > -             return REGION_INTERSECTS;
> > > -
> > > -     return REGION_MIXED;
> > > +     return rc;
> > >  }
> > >  EXPORT_SYMBOL_GPL(region_intersects);
> > >
> > > @@ -1171,31 +1180,17 @@ struct address_space *iomem_get_mapping(void)
> > >       return smp_load_acquire(&iomem_inode)->i_mapping;
> > >  }
> > >
> > > -/**
> > > - * __request_region - create a new busy resource region
> > > - * @parent: parent resource descriptor
> > > - * @start: resource start address
> > > - * @n: resource region size
> > > - * @name: reserving caller's ID string
> > > - * @flags: IO resource flags
> > > - */
> > > -struct resource * __request_region(struct resource *parent,
> > > -                                resource_size_t start, resource_size_t n,
> > > -                                const char *name, int flags)
> > > +static bool request_region_locked(struct resource *parent,
> > > +                                 struct resource *res, resource_size_t 
> start,
> > > +                                 resource_size_t n, const char *name, int 
> flags)
> > >  {
> > > -     DECLARE_WAITQUEUE(wait, current);
> > > -     struct resource *res = alloc_resource(GFP_KERNEL);
> > >       struct resource *orig_parent = parent;
> > > -
> > > -     if (!res)
> > > -             return NULL;
> > > +     DECLARE_WAITQUEUE(wait, current);
> > 
> > This part of the diff looks confusing, do we have a waitqueue and we call
> > schedule() within a function called with the lock held?
> 
> Good point. schedule() does get called but the lock is dropped first:
> 
> 		if (conflict->flags & flags & IORESOURCE_MUXED) {
> 			add_wait_queue(&muxed_resource_wait, &wait);
> 			write_unlock(&resource_lock);
> 			set_current_state(TASK_UNINTERRUPTIBLE);
> 			schedule();
> 			remove_wait_queue(&muxed_resource_wait, &wait);
> 			write_lock(&resource_lock);
> 			continue;
> 		}
> 
> This isn't an issue though as it's only used for request_muxed_region() which 
> isn't used for the ZONE_DEVICE allocation and by design doesn't search for 
> free space. Ie. IORESOURCE_MUXED will never be set for 
> request_free_mem_region().
> 
> > >
> > >       res->name = name;
> > >       res->start = start;
> > >       res->end = start + n - 1;
> > >
> > > -     write_lock(&resource_lock);
> > > -
> > >       for (;;) {
> > >               struct resource *conflict;
> > >
> > > @@ -1230,16 +1225,39 @@ struct resource * __request_region(struct resource 
> *parent,
> > >                       write_lock(&resource_lock);
> > >                       continue;
> > >               }
> > > -             /* Uhhuh, that didn't work out.. */
> > > -             free_resource(res);
> > > -             res = NULL;
> > > -             break;
> > > +             return false;
> > >       }
> > > -     write_unlock(&resource_lock);
> > >
> > >       if (res && orig_parent == &iomem_resource)
> > >               revoke_iomem(res);
> > >
> > > +     return true;
> > > +}
> > > +
> > > +/**
> > > + * __request_region - create a new busy resource region
> > > + * @parent: parent resource descriptor
> > > + * @start: resource start address
> > > + * @n: resource region size
> > > + * @name: reserving caller's ID string
> > > + * @flags: IO resource flags
> > > + */
> > > +struct resource *__request_region(struct resource *parent,
> > > +                               resource_size_t start, resource_size_t n,
> > > +                               const char *name, int flags)
> > > +{
> > > +     struct resource *res = alloc_resource(GFP_KERNEL);
> > > +
> > > +     if (!res)
> > > +             return NULL;
> > > +
> > > +     write_lock(&resource_lock);
> > > +     if (!request_region_locked(parent, res, start, n, name, flags)) {
> > > +             /* Uhhuh, that didn't work out.. */
> > > +             free_resource(res);
> > > +             res = NULL;
> > > +     }
> > > +     write_unlock(&resource_lock);
> > 
> > Should the function be called __request_region_locked?
> 
> This is the name of original function, so this is just maintaining the 
> original behaviour by taking the lock and calling the inner function 
> (request_region_locked) rather than having it coded directly there.
> 
> __request_region() is rarely called directly and is mostly called via macros:
> 
> include/linux/ioport.h:#define request_region(start,n,name)             
> __request_region(&ioport_resource, (start), (n), (name), 0)
> include/linux/ioport.h:#define request_muxed_region(start,n,name)       
> __request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
> include/linux/ioport.h:#define __request_mem_region(start,n,name, excl) 
> __request_region(&iomem_resource, (start), (n), (name), excl)
> include/linux/ioport.h:#define request_mem_region(start,n,name) 
> __request_region(&iomem_resource, (start), (n), (name), 0)
>

Makes sense, I guess this takes away from the caller having to call
the API again in the case of a conflict (a caller might never succeed
deterministically in the worst case)?

Acked-by: Balbir Singh <bsingharora@gmail.com>
 
