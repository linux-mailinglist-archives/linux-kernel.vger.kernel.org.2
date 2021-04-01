Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FDC350E46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 06:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhDAE44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 00:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAE4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:56:43 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144ACC0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 21:56:43 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d2so1011714ilm.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7SLQO3Ok64tMY0jVST2p67zAs5hiN1eckYi4HSFlxw=;
        b=IY4ucmt2w0wCGubldflas8o0drp6KCF5+tHz8qix+Y7GhdYp+Iwt641JmcieUXRL9Y
         Q2YI964uX1n67MbNcJ9yz0amTiM9jVTEPEgNEcIkimBrsn0d/jJtQVyFCCEaCUdxpzrg
         MM/iMCLZY4gWaKoIt1bB/54Rb2I0BJ3cnxsltETP3Ex3p1UeNo6l7T9RI/l+H7ewTGTV
         /3eLRYcLSaC+d7sOKMWYenWDMx5DICOyOOFoDKR1nUCNUIUN2vlhF4/wqhT7V40yzW/i
         yc0KgTriQyO+CM0Uie/4pRdfSbnCDSB6VfWssoVSDKpS6B/Z+b/apnPphvOddl1JIezq
         C1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7SLQO3Ok64tMY0jVST2p67zAs5hiN1eckYi4HSFlxw=;
        b=D6eNIZAxK3m+/aiNKlHEJwqyfhNuO4avr6OL+6mQoKTCJZ45v5iyPTwNQZcXrAg0Jc
         nbM0bJL4jdSjd+pkashq8x0Lfw/htd1DekMV/hUfG+QtV4DDrWc+0lCxF9TF74wynkpt
         HwTyuV4NmWckgqvoHmoIfD3ItU65uD1uHjwFYR5mQBG2t9mPe0e/auYB/2zfu0XBK252
         qQWC+Fn+DmtKC9OWQnW0DOOHufpscG+C4MiphnR+Wxm4ev1d5iCWRCPvCC+c4UOjwv5y
         r/qwLL0oc7nFnqz2uK/DJLQXg8bDPZuu3W5Z1eEpWQJqgw92uwp4uG0tpkEtIkfMnEx4
         jlbA==
X-Gm-Message-State: AOAM530UQI8gGFBSLUlKZkUe6Ko0IvH4YkVxKZvxhHdRMbW97pwSCK7n
        MAHSwBRvQDsnUD6ddLHZbtNvzfdtvmzLdO0sHDQ=
X-Google-Smtp-Source: ABdhPJyjUvoCdhEDl1VlMFjSR7LXfTYc+Ew8zg5IxALbQCAbEcF5rOKFwZblg8ZVnu4Lxe8kxnHv5LMZDTzmilsBqiw=
X-Received: by 2002:a92:ccd0:: with SMTP id u16mr5343881ilq.6.1617253002405;
 Wed, 31 Mar 2021 21:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210326012035.3853-1-apopple@nvidia.com>
In-Reply-To: <20210326012035.3853-1-apopple@nvidia.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Thu, 1 Apr 2021 12:56:05 +0800
Message-ID: <CAPSr9jGNQ+cVMW12CDt3xTT4HJXDkxeqCTv5Gv=y4G-iRKEi=g@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/resource: Fix locking in request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jhubbard@nvidia.com, jglisse@redhat.com, linux-mm@kvack.org,
        songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 9:22 AM Alistair Popple <apopple@nvidia.com> wrote:
>
> request_free_mem_region() is used to find an empty range of physical
> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> over the range of possible addresses using region_intersects() to see if
> the range is free.
>
> region_intersects() obtains a read lock before walking the resource tree
> to protect against concurrent changes. However it drops the lock prior
> to returning. This means by the time request_mem_region() is called in
> request_free_mem_region() another thread may have already reserved the
> requested region resulting in unexpected failures and a message in the
> kernel log from hitting this condition:
>
>         /*
>          * mm/hmm.c reserves physical addresses which then
>          * become unavailable to other users.  Conflicts are
>          * not expected.  Warn to aid debugging if encountered.
>          */
>         if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>                 pr_warn("Unaddressable device %s %pR conflicts with %pR",
>                         conflict->name, conflict, res);
>
> To fix this create versions of region_intersects() and
> request_mem_region() that allow the caller to take the appropriate lock
> such that it may be held over the required calls.
>
> Instead of creating another version of devm_request_mem_region() that
> doesn't take the lock open-code it to allow the caller to pre-allocate
> the required memory prior to taking the lock.
>
> Fixes: 0c385190392d8 ("resource: add a not device managed request_free_mem_region variant")
> Fixes: 0092908d16c60 ("mm: factor out a devm_request_free_mem_region helper")
> Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using ZONE_DEVICE")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

+cc my email (songmuchun@bytedance.com).

Hi Alistair,

Thanks for your patch. But there is a deadlock that should be fixed.
Please see the following scenario.

__request_region
    write_lock(&resource_lock)
        request_region_locked
            revoke_iomem
                devmem_is_allowed (arch/x86/mm/init.c)
                    region_intersects
                        read_lock(&resource_lock)   // deadlock


>
> ---
>
> v2:
>  - Added Fixes tag
>
> ---
>  kernel/resource.c | 146 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 94 insertions(+), 52 deletions(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 627e61b0c124..2d4652383dd2 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
>  }
>  EXPORT_SYMBOL_GPL(page_is_ram);
>
> +static int __region_intersects(resource_size_t start, size_t size,
> +                              unsigned long flags, unsigned long desc)
> +{
> +       struct resource res;
> +       int type = 0; int other = 0;
> +       struct resource *p;
> +
> +       res.start = start;
> +       res.end = start + size - 1;
> +
> +       for (p = iomem_resource.child; p ; p = p->sibling) {
> +               bool is_type = (((p->flags & flags) == flags) &&
> +                               ((desc == IORES_DESC_NONE) ||
> +                                (desc == p->desc)));
> +
> +               if (resource_overlaps(p, &res))
> +                       is_type ? type++ : other++;
> +       }
> +
> +       if (type == 0)
> +               return REGION_DISJOINT;
> +
> +       if (other == 0)
> +               return REGION_INTERSECTS;
> +
> +       return REGION_MIXED;
> +}
> +
>  /**
>   * region_intersects() - determine intersection of region with known resources
>   * @start: region start address
> @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
>  int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>                       unsigned long desc)
>  {
> -       struct resource res;
> -       int type = 0; int other = 0;
> -       struct resource *p;
> -
> -       res.start = start;
> -       res.end = start + size - 1;
> +       int rc;
>
>         read_lock(&resource_lock);
> -       for (p = iomem_resource.child; p ; p = p->sibling) {
> -               bool is_type = (((p->flags & flags) == flags) &&
> -                               ((desc == IORES_DESC_NONE) ||
> -                                (desc == p->desc)));
> -
> -               if (resource_overlaps(p, &res))
> -                       is_type ? type++ : other++;
> -       }
> +       rc = __region_intersects(start, size, flags, desc);
>         read_unlock(&resource_lock);
> -
> -       if (type == 0)
> -               return REGION_DISJOINT;
> -
> -       if (other == 0)
> -               return REGION_INTERSECTS;
> -
> -       return REGION_MIXED;
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(region_intersects);
>
> @@ -1171,31 +1180,17 @@ struct address_space *iomem_get_mapping(void)
>         return smp_load_acquire(&iomem_inode)->i_mapping;
>  }
>
> -/**
> - * __request_region - create a new busy resource region
> - * @parent: parent resource descriptor
> - * @start: resource start address
> - * @n: resource region size
> - * @name: reserving caller's ID string
> - * @flags: IO resource flags
> - */
> -struct resource * __request_region(struct resource *parent,
> -                                  resource_size_t start, resource_size_t n,
> -                                  const char *name, int flags)
> +static bool request_region_locked(struct resource *parent,
> +                                   struct resource *res, resource_size_t start,
> +                                   resource_size_t n, const char *name, int flags)
>  {
> -       DECLARE_WAITQUEUE(wait, current);
> -       struct resource *res = alloc_resource(GFP_KERNEL);
>         struct resource *orig_parent = parent;
> -
> -       if (!res)
> -               return NULL;
> +       DECLARE_WAITQUEUE(wait, current);
>
>         res->name = name;
>         res->start = start;
>         res->end = start + n - 1;
>
> -       write_lock(&resource_lock);
> -
>         for (;;) {
>                 struct resource *conflict;
>
> @@ -1230,16 +1225,39 @@ struct resource * __request_region(struct resource *parent,
>                         write_lock(&resource_lock);
>                         continue;
>                 }
> -               /* Uhhuh, that didn't work out.. */
> -               free_resource(res);
> -               res = NULL;
> -               break;
> +               return false;
>         }
> -       write_unlock(&resource_lock);
>
>         if (res && orig_parent == &iomem_resource)
>                 revoke_iomem(res);

What do you think of the fix below?

+       if (res && orig_parent == &iomem_resource) {
+               write_unlock(&resource_lock);
+               revoke_iomem(res);
+               write_lock(&resource_lock);
+       }

>
> +       return true;
> +}
> +
> +/**
> + * __request_region - create a new busy resource region
> + * @parent: parent resource descriptor
> + * @start: resource start address
> + * @n: resource region size
> + * @name: reserving caller's ID string
> + * @flags: IO resource flags
> + */
> +struct resource *__request_region(struct resource *parent,
> +                                 resource_size_t start, resource_size_t n,
> +                                 const char *name, int flags)
> +{
> +       struct resource *res = alloc_resource(GFP_KERNEL);
> +
> +       if (!res)
> +               return NULL;
> +
> +       write_lock(&resource_lock);
> +       if (!request_region_locked(parent, res, start, n, name, flags)) {
> +               /* Uhhuh, that didn't work out.. */
> +               free_resource(res);
> +               res = NULL;
> +       }
> +       write_unlock(&resource_lock);
>         return res;
>  }
>  EXPORT_SYMBOL(__request_region);
> @@ -1779,26 +1797,50 @@ static struct resource *__request_free_mem_region(struct device *dev,
>  {
>         resource_size_t end, addr;
>         struct resource *res;
> +       struct region_devres *dr = NULL;
> +
> +       res = alloc_resource(GFP_KERNEL);
> +       if (!res)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (dev) {
> +               dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
> +                                 GFP_KERNEL);
> +               if (!dr) {
> +                       free_resource(res);
> +                       return ERR_PTR(-ENOMEM);
> +               }
> +       }
>
>         size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
>         end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
>         addr = end - size + 1UL;
>
> +       write_lock(&resource_lock);
>         for (; addr > size && addr >= base->start; addr -= size) {
> -               if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> +               if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
>                                 REGION_DISJOINT)
>                         continue;
>
> -               if (dev)
> -                       res = devm_request_mem_region(dev, addr, size, name);
> -               else
> -                       res = request_mem_region(addr, size, name);
> -               if (!res)
> -                       return ERR_PTR(-ENOMEM);
> +               if (!request_region_locked(&iomem_resource, res, addr,
> +                                                  size, name, 0))
> +                       break;
> +
>                 res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> +               if (dev) {
> +                       dr->parent = &iomem_resource;
> +                       dr->start = addr;
> +                       dr->n = size;
> +                       devres_add(dev, dr);
> +               }
> +
> +               write_unlock(&resource_lock);
>                 return res;
>         }
>
> +       write_unlock(&resource_lock);
> +       free_resource(res);
> +
>         return ERR_PTR(-ERANGE);
>  }
>
> --
> 2.20.1
>
