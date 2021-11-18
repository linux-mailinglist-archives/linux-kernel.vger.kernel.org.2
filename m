Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA24562F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhKRS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:58:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:55:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so31716732edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRA2y0JHDK8DAc43I1/dXHZPQMaXoj74aSpqH8gaufA=;
        b=p6y0iYcR0F2Ir6S50IYnxHBNUFoyV4R/iDMsCFUyRM/NX4aUxNqBKOBUOcrVKknY7M
         gfUn2gCdI7sziE3m2IIiG8LXOtG6jZ4mvEdDTiOK27tvB9WIE9aiNpNlFrTwpwvIG4UV
         dH/EoU3sH4EL2i3JRbcsvjdaJdjR2Bcq5wJKHckDEdQOfj1St9oCrEhZRjXbMQQsBHTW
         63VMusHsAsnSCzeR9abiOwaV4lLhgwKjY7yGhIDKM0xtSiKLNJ29vWSOicvYugnF14SM
         KVMueTbHy4XV0dk52z9UhKlAz8OCKFMsvot+3q1Ks7AhVgZ3lta8b1qgVrnYxocAxG6B
         C0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRA2y0JHDK8DAc43I1/dXHZPQMaXoj74aSpqH8gaufA=;
        b=wr6qPHUNTodfOhNfrcuHfGUu0YEuNZhrCadvzhGQcfEUEJkWFm/2UJHr3/eoQ1yTlF
         rIVeHAekKNZLA+q9/qmbwxvGn0XtF+Zgg4dO3B55vYRPT3b4pKxRSe3+euMcVTnx4VtR
         i43fjQzugRf+XEvbD96B+c5WmDTqSyN2+W02HIxafjWesATRqV/b3nIHOz5xyxhAlqWY
         RJdA7ET4X9plFCYHFyeYZ508zr88sGIdCAWXjspvdAzZFv9gl9EVusi2MmkvXhv77rlm
         PBpLD7IWGs4TElpLK7uD4vinXTjVgvM9J9uuYX2rb5kkSP9iU73OdNOSsGF92yzlObkL
         VzyQ==
X-Gm-Message-State: AOAM53392sUZxDjM3bBghNAeLFfwuxI8/mrx345MPBOscBG6TzjMOTwn
        1WcsgT+l7zfr7HmIoT3/NvQX4bYUzqPUWLPN5io=
X-Google-Smtp-Source: ABdhPJx5EhW1wdRMQo6gaVKfe5Q9JpXREVnFZ1P5aY49OtjbJJJQh4U4rdmMTuAYDfDgS9rjoISXVSQBdsDuHYpcd9Y=
X-Received: by 2002:a05:6402:1a4d:: with SMTP id bf13mr14654034edb.101.1637261706338;
 Thu, 18 Nov 2021 10:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20211116193247.21102-1-shy828301@gmail.com>
In-Reply-To: <20211116193247.21102-1-shy828301@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 18 Nov 2021 10:54:54 -0800
Message-ID: <CAHbLzkooDg-KbtBxofBYFvNF8nN=vTCwb6+srYZOHqqBLH58Zg@mail.gmail.com>
Subject: Re: [v2 UPDATE PATCH] mm: shmem: don't truncate page if memory
 failure happens
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Does this version look good to you? Would you please consider to apply
this to -rc2? Or you prefer to get it from Andrew?

Thanks,
Yang

On Tue, Nov 16, 2021 at 11:32 AM Yang Shi <shy828301@gmail.com> wrote:
>
> The current behavior of memory failure is to truncate the page cache
> regardless of dirty or clean.  If the page is dirty the later access
> will get the obsolete data from disk without any notification to the
> users.  This may cause silent data loss.  It is even worse for shmem
> since shmem is in-memory filesystem, truncating page cache means
> discarding data blocks.  The later read would return all zero.
>
> The right approach is to keep the corrupted page in page cache, any
> later access would return error for syscalls or SIGBUS for page fault,
> until the file is truncated, hole punched or removed.  The regular
> storage backed filesystems would be more complicated so this patch is
> focused on shmem.  This also unblock the support for soft offlining
> shmem THP.
>
> [arnd@arndb.de: fix uninitialized variable use in me_pagecache_clean()]
>   Link: https://lkml.kernel.org/r/20211022064748.4173718-1-arnd@kernel.org
> [Fix invalid pointer dereference in shmem_read_mapping_page_gfp() with a
>  slight different implementation from what Ajay Garg <ajaygargnsit@gmail.com>
>  and Muchun Song <songmuchun@bytedance.com> proposed and reworked the
>  error handling of shmem_write_begin() suggested by Linus]
>   Link: https://lore.kernel.org/linux-mm/20211111084617.6746-1-ajaygargnsit@gmail.com/
>
> Link: https://lkml.kernel.org/r/20211020210755.23964-6-shy828301@gmail.com
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ajay Garg <ajaygargnsit@gmail.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> ---
> v2: Incorporated the suggestions from Willy.
> v1: Fixed pointer dereference oops reported by Ajay Garg and reworked the
>     error handling of shmem_write_begin() suggested by Linus.
>
>  mm/memory-failure.c | 14 ++++++++++---
>  mm/shmem.c          | 51 +++++++++++++++++++++++++++++++++++++++------
>  mm/userfaultfd.c    |  5 +++++
>  3 files changed, 61 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 07c875fdeaf0..f64ebb6226cb 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -58,6 +58,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/page-isolation.h>
>  #include <linux/pagewalk.h>
> +#include <linux/shmem_fs.h>
>  #include "internal.h"
>  #include "ras/ras_event.h"
>
> @@ -867,6 +868,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  {
>         int ret;
>         struct address_space *mapping;
> +       bool extra_pins;
>
>         delete_from_lru_cache(p);
>
> @@ -895,18 +897,24 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>                 goto out;
>         }
>
> +       /*
> +        * The shmem page is kept in page cache instead of truncating
> +        * so is expected to have an extra refcount after error-handling.
> +        */
> +       extra_pins = shmem_mapping(mapping);
> +
>         /*
>          * Truncation is a bit tricky. Enable it per file system for now.
>          *
>          * Open: to take i_rwsem or not for this? Right now we don't.
>          */
>         ret = truncate_error_page(p, page_to_pfn(p), mapping);
> +       if (has_extra_refcount(ps, p, extra_pins))
> +               ret = MF_FAILED;
> +
>  out:
>         unlock_page(p);
>
> -       if (has_extra_refcount(ps, p, false))
> -               ret = MF_FAILED;
> -
>         return ret;
>  }
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index dc038ce78700..2ba64918132b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>         struct inode *inode = mapping->host;
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         pgoff_t index = pos >> PAGE_SHIFT;
> +       int ret = 0;
>
>         /* i_rwsem is held by caller */
>         if (unlikely(info->seals & (F_SEAL_GROW |
> @@ -2466,7 +2467,19 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>                         return -EPERM;
>         }
>
> -       return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +       ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (PageHWPoison(*pagep)) {
> +               unlock_page(*pagep);
> +               put_page(*pagep);
> +               *pagep = NULL;
> +               return -EIO;
> +       }
> +
> +       return 0;
>  }
>
>  static int
> @@ -2553,6 +2566,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>                         if (sgp == SGP_CACHE)
>                                 set_page_dirty(page);
>                         unlock_page(page);
> +
> +                       if (PageHWPoison(page)) {
> +                               put_page(page);
> +                               error = -EIO;
> +                               break;
> +                       }
>                 }
>
>                 /*
> @@ -3092,7 +3111,8 @@ static const char *shmem_get_link(struct dentry *dentry,
>                 page = find_get_page(inode->i_mapping, 0);
>                 if (!page)
>                         return ERR_PTR(-ECHILD);
> -               if (!PageUptodate(page)) {
> +               if (PageHWPoison(page) ||
> +                   !PageUptodate(page)) {
>                         put_page(page);
>                         return ERR_PTR(-ECHILD);
>                 }
> @@ -3100,6 +3120,13 @@ static const char *shmem_get_link(struct dentry *dentry,
>                 error = shmem_getpage(inode, 0, &page, SGP_READ);
>                 if (error)
>                         return ERR_PTR(error);
> +               if (!page)
> +                      return ERR_PTR(-ECHILD);
> +               if (PageHWPoison(page)) {
> +                       unlock_page(page);
> +                       put_page(page);
> +                       return ERR_PTR(-ECHILD);
> +               }
>                 unlock_page(page);
>         }
>         set_delayed_call(done, shmem_put_link, page);
> @@ -3750,6 +3777,13 @@ static void shmem_destroy_inodecache(void)
>         kmem_cache_destroy(shmem_inode_cachep);
>  }
>
> +/* Keep the page in page cache instead of truncating it */
> +static int shmem_error_remove_page(struct address_space *mapping,
> +                                  struct page *page)
> +{
> +       return 0;
> +}
> +
>  const struct address_space_operations shmem_aops = {
>         .writepage      = shmem_writepage,
>         .set_page_dirty = __set_page_dirty_no_writeback,
> @@ -3760,7 +3794,7 @@ const struct address_space_operations shmem_aops = {
>  #ifdef CONFIG_MIGRATION
>         .migratepage    = migrate_page,
>  #endif
> -       .error_remove_page = generic_error_remove_page,
> +       .error_remove_page = shmem_error_remove_page,
>  };
>  EXPORT_SYMBOL(shmem_aops);
>
> @@ -4168,9 +4202,14 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>         error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
>                                   gfp, NULL, NULL, NULL);
>         if (error)
> -               page = ERR_PTR(error);
> -       else
> -               unlock_page(page);
> +               return ERR_PTR(error);
> +
> +       unlock_page(page);
> +       if (PageHWPoison(page)) {
> +               put_page(page);
> +               return ERR_PTR(-EIO);
> +       }
> +
>         return page;
>  #else
>         /*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index ac6f036298cd..0780c2a57ff1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -232,6 +232,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
>                 goto out;
>         }
>
> +       if (PageHWPoison(page)) {
> +               ret = -EIO;
> +               goto out_release;
> +       }
> +
>         ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
>                                        page, false, wp_copy);
>         if (ret)
> --
> 2.26.2
>
