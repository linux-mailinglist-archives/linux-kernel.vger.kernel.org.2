Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9F352F44
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhDBS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:29:53 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7CC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:29:50 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c18so1434687iln.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgAx+4lfEKiBJ1k2Wv3oAa2fGZrNLPzNERoCzjmBo/s=;
        b=gBYDjHWZwyl3dfkvuLrQVknVoJCpCbAutxmjxeQ+nfJgjYIHOW+SUCnE0F4TXDto2g
         cOeK8/97dq/IMnn2f+kgw7FsJz/5tx8pfgJTbTstC/Ypflz1iP+ZTzoh3nEC0oK0we54
         KiwAKBn56tmiYIp1EpI2ZNNtjvWt9gBzQf8upai86In7Nd1LLlyQTIz+eNUpIHhFeeRr
         moTVuiT3RDnBCyKtUO9Ps0rjbqpXl13CCBx/0vlG31CDsl7A6GV9W3c1uyMz7Q6uFFpB
         eVBqasbIgDc4ZWfO9toxemnA0kaD0AhvcGQHnj5/a4kq8P3JW42xGpgaBTjZwIevQyr1
         Cx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgAx+4lfEKiBJ1k2Wv3oAa2fGZrNLPzNERoCzjmBo/s=;
        b=shhUVHeCahKiAE5TbCkp1EW1on9vzgvOl0oGeytpWSfIm52bppAD+qMip+5XrNRnw6
         28DeF/isRCsW10TJ4OsaMl69+ba2WvW/JFETCOZcGw2tTN+V3IQV+mBhjmUTdYumcyFO
         WBWuk6APEuiFnLaxZFfsSNZrkHPfpKyzYRPd3TJxc3Gprc77RfuGDwVf4SkdTKyZtAxM
         onx6ikwyQ7yUkektziXDclScqz4x7Mrw51oGZ9Lp2qCKqcUvaA0GwNKyaJwnZ8TQ++wS
         ir373DqcxMrmhXaJhRkksKbNZFVCdszOAqxvIRBHxf6fzdz2J7UyYAzyLZG5ALM8dD0Z
         uBug==
X-Gm-Message-State: AOAM5314Ow2wm1vJ8CJAGobiddywy/j9YE3BuPLjBwExS783sFoNDXaT
        rIXv9M8aSgcE1Mm139qkJfOng2r5wXAfojNv1v4=
X-Google-Smtp-Source: ABdhPJzhvXOFAhnGwN7ccq4DF0OeCcbJwsMPs5m9gZuvgMjks27+xIEX0l+NvyGH7ZsgCGmEGRGOuL+A0YPg7clrJxg=
X-Received: by 2002:a05:6e02:965:: with SMTP id q5mr10956779ilt.95.1617388189299;
 Fri, 02 Apr 2021 11:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com> <1616751898-58393-2-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1616751898-58393-2-git-send-email-xlpang@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 2 Apr 2021 11:29:38 -0700
Message-ID: <CAKgT0Ud1-XNw1Hkr0Q2vPOTAhvdj3726ZJA3QSVcmNqNOPZuyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/page_reporting: Introduce free page reported counters
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:45 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> It's useful to know how many memory has been actually reported,
> so add new zone::reported_pages to record that.
>
> Add "/sys/kernel/mm/page_reporting/reported_kbytes" for the
> actual memory has been reported.
>
> Add "/sys/kernel/mm/page_reporting/refault_kbytes" for the
> accumulated memory has refaulted in after been reported out.
>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  include/linux/mmzone.h |   3 ++
>  mm/page_alloc.c        |   4 +-
>  mm/page_reporting.c    | 112 +++++++++++++++++++++++++++++++++++++++++++++++--
>  mm/page_reporting.h    |   5 +++
>  4 files changed, 119 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 47946ce..ebd169f 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -530,6 +530,9 @@ struct zone {
>         atomic_long_t           managed_pages;
>         unsigned long           spanned_pages;
>         unsigned long           present_pages;
> +#ifdef CONFIG_PAGE_REPORTING
> +       unsigned long           reported_pages;
> +#endif
>  #ifdef CONFIG_CMA
>         unsigned long           cma_pages;
>  #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee..c2c5688 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -930,8 +930,10 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
>                                            unsigned int order)
>  {
>         /* clear reported state and update reported page count */
> -       if (page_reported(page))
> +       if (page_reported(page)) {
>                 __ClearPageReported(page);
> +               page_reporting_update_refault(zone, 1 << order);
> +       }
>
>         list_del(&page->lru);
>         __ClearPageBuddy(page);
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index c50d93f..ba195ea 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
>  #include <linux/page_reporting.h>
> @@ -19,6 +20,22 @@ enum {
>         PAGE_REPORTING_ACTIVE
>  };
>
> +#ifdef CONFIG_SYSFS
> +static struct percpu_counter refault_pages;
> +
> +void page_reporting_update_refault(struct zone *zone, unsigned int pages)
> +{
> +       zone->reported_pages -= pages;
> +       percpu_counter_add_batch(&refault_pages, pages, INT_MAX / 2);
> +}
> +#else
> +void page_reporting_update_refault(struct zone *zone, unsigned int pages)
> +{
> +       zone->reported_pages -= pages;
> +}
> +#endif
> +
> +

I don't see the value added from the refault_pages counter.
Essentially all it will tell you is how many reported pages were
allocated. If you are really wanting to track a value such as this it
might make more sense to just track the total number of reported pages
over the lifetime of the system. At least with that you would once
again be able to take advantage of batching so it isn't occurring as
often.

>  /* request page reporting */
>  static void
>  __page_reporting_request(struct page_reporting_dev_info *prdev)
> @@ -66,7 +83,8 @@ void __page_reporting_notify(void)
>
>  static void
>  page_reporting_drain(struct page_reporting_dev_info *prdev,
> -                    struct scatterlist *sgl, unsigned int nents, bool reported)
> +                    struct scatterlist *sgl, struct zone *zone,
> +                    unsigned int nents, bool reported)
>  {
>         struct scatterlist *sg = sgl;
>
> @@ -92,8 +110,10 @@ void __page_reporting_notify(void)
>                  * report on the new larger page when we make our way
>                  * up to that higher order.
>                  */
> -               if (PageBuddy(page) && buddy_order(page) == order)
> +               if (PageBuddy(page) && buddy_order(page) == order) {
>                         __SetPageReported(page);
> +                       zone->reported_pages += (1 << order);
> +               }

The parenthesis around "1 << order" is redundant.

>         } while ((sg = sg_next(sg)));
>
>         /* reinitialize scatterlist now that it is empty */
> @@ -197,7 +217,7 @@ void __page_reporting_notify(void)
>                 spin_lock_irq(&zone->lock);
>
>                 /* flush reported pages from the sg list */
> -               page_reporting_drain(prdev, sgl, PAGE_REPORTING_CAPACITY, !err);
> +               page_reporting_drain(prdev, sgl, zone, PAGE_REPORTING_CAPACITY, !err);
>
>                 /*
>                  * Reset next to first entry, the old next isn't valid
> @@ -260,7 +280,7 @@ void __page_reporting_notify(void)
>
>                 /* flush any remaining pages out from the last report */
>                 spin_lock_irq(&zone->lock);
> -               page_reporting_drain(prdev, sgl, leftover, !err);
> +               page_reporting_drain(prdev, sgl, zone, leftover, !err);
>                 spin_unlock_irq(&zone->lock);
>         }
>
> @@ -362,3 +382,87 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
>         mutex_unlock(&page_reporting_mutex);
>  }
>  EXPORT_SYMBOL_GPL(page_reporting_unregister);
> +
> +#ifdef CONFIG_SYSFS
> +#define REPORTING_ATTR(_name) \
> +       static struct kobj_attribute _name##_attr = \
> +               __ATTR(_name, 0644, _name##_show, _name##_store)
> +

You would be better off defining a read only attribute so you don't
have to define the dummy store functions.

> +static unsigned long get_reported_kbytes(void)
> +{
> +       struct zone *z;
> +       unsigned long nr_reported = 0;
> +
> +       for_each_populated_zone(z)
> +               nr_reported += z->reported_pages;
> +
> +       return nr_reported << (PAGE_SHIFT - 10);
> +}
> +
> +static ssize_t reported_kbytes_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%lu\n", get_reported_kbytes());
> +}
> +
> +static ssize_t reported_kbytes_store(struct kobject *kobj,
> +               struct kobj_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       return -EINVAL;
> +}

Get rid of this dummy store function.

> +REPORTING_ATTR(reported_kbytes);
> +
> +static u64 get_refault_kbytes(void)
> +{
> +       u64 sum;
> +
> +       sum = percpu_counter_sum_positive(&refault_pages);
> +       return sum << (PAGE_SHIFT - 10);
> +}
> +
> +static ssize_t refault_kbytes_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%llu\n", get_refault_kbytes());
> +}
> +
> +static ssize_t refault_kbytes_store(struct kobject *kobj,
> +               struct kobj_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       return -EINVAL;
> +}

Also, no need for this store function.

> +REPORTING_ATTR(refault_kbytes);
> +
> +static struct attribute *reporting_attrs[] = {
> +       &reported_kbytes_attr.attr,
> +       &refault_kbytes_attr.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group reporting_attr_group = {
> +       .attrs = reporting_attrs,
> +       .name = "page_reporting",
> +};
> +#endif
> +
> +static int __init page_reporting_init(void)
> +{
> +#ifdef CONFIG_SYSFS
> +       int err;
> +
> +       if (percpu_counter_init(&refault_pages, 0, GFP_KERNEL))
> +               panic("Failed to allocate refault_pages percpu counter\n");
> +
> +       err = sysfs_create_group(mm_kobj, &reporting_attr_group);
> +       if (err) {
> +               pr_err("%s: Unable to populate sysfs files\n", __func__);
> +               return err;
> +       }
> +#endif
> +
> +       return 0;
> +}
> +
> +module_init(page_reporting_init);
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 2c385dd..19549c7 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -44,11 +44,16 @@ static inline void page_reporting_notify_free(unsigned int order)
>         /* This will add a few cycles, but should be called infrequently */
>         __page_reporting_notify();
>  }
> +
> +void page_reporting_update_refault(struct zone *zone, unsigned int pages);
>  #else /* CONFIG_PAGE_REPORTING */
>  #define page_reported(_page)   false
>
>  static inline void page_reporting_notify_free(unsigned int order)
>  {
>  }
> +
> +static inline void
> +page_reporting_update_refault(struct zone *zone, unsigned int pages) { }
>  #endif /* CONFIG_PAGE_REPORTING */
>  #endif /*_MM_PAGE_REPORTING_H */
> --
> 1.8.3.1
>
>
