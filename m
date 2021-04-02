Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED120352F75
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhDBS4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:56:22 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00BC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:56:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id o15so1207199ilf.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+eFaqoFME1FyXzmGHxsf81vH06wb7Em+Y+ljMR5pEY=;
        b=UipdgRPrzvbDu1L9/8EGWjHQ4v5KoQhrYkKYluDaJWCXbvWv7iiU5/ZzRUioLrm3a5
         KQ39YaLNdtWLD6pW9zCHOBs9wcHRAsETiAptzfVF1mKmQESHOiKmKsIGqYxwAvKLCiMn
         UbzL9c4BoNMpWWaiOBAT8K2WUj9GGBJREbljvuQhDFCdeXxBwQawFeoyvtjRKSmtfSQS
         PMWFxpPYXgRPwzgXeF/VFQPrH405VHYc5FnoqFLgherg4tJg3QEMa8ZBPzsn9Rssz5A1
         QItFmUh4AW5IbZPec2U8gcE90lEXDyMWcTtfmuw8MLXHNsXtFSCmeqfbGse4gPK/+T4k
         Wu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+eFaqoFME1FyXzmGHxsf81vH06wb7Em+Y+ljMR5pEY=;
        b=QHbwC0LoMw6i322yc0fSL6YfjzSCLxwG4MP8ZO2SX1o29TIIfqCVNudKtBexbk5Ygn
         irZI04PbeuMgjt5QaHe0oUykUF1Rt6+feD9BuvkUsbPDwATo6XWQyarXx5iYoDK94F0F
         j9wLU8AObpappnWt/4xVKlLKtxSIXXRywneC+dLr2vLFacOVsN1VoBeWGRJFbLiX68dg
         bJD/lBcTQC+tF1b8OMxDrr90h6Hn9KLLSQ2RWajlApGkNGEUNwjHRouik2AEFo6eBJq2
         h7TgQ73v0anTR/ECUOcC+1JLQSk8z6ySM8HiPL78EkRZdOlmvujZTpSNxFhJIhpvKEpS
         ZDDw==
X-Gm-Message-State: AOAM533ERpjhoyE7hyRW5sF53AN1cBFIFfFD36Je1dVUOv0rlpckMXET
        hGacpH7CD+lewA3tJZRP/xK4ZRGkzSQCP+xDW18=
X-Google-Smtp-Source: ABdhPJxzpK4kwlEcjTsAHpsDCC1gjnqikEMvYZXMwcE3vMr3s0/FPGmZ+LvsDDS+DhMcRw1NorgNTyEOZ2fpJHlfrAA=
X-Received: by 2002:a05:6e02:13e8:: with SMTP id w8mr12040341ilj.237.1617389778805;
 Fri, 02 Apr 2021 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com> <1616751898-58393-3-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1616751898-58393-3-git-send-email-xlpang@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 2 Apr 2021 11:56:07 -0700
Message-ID: <CAKgT0Ud872rkrHrn8kaweL83Lg0Uo6cxwRpZUg-5TM9kUyjgSQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/page_reporting: Introduce free page reporting factor
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
> Add new "/sys/kernel/mm/page_reporting/reporting_factor"
> within [0, 100], and stop page reporting when it reaches
> the configured threshold. Default is 100 which means no
> limitation is imposed. Percentile is adopted to reflect
> the fact that it reports on the per-zone basis.
>
> We can control the total number of reporting pages via
> this knob to avoid EPT violations which may affect the
> performance of the business, imagine the guest memory
> allocation burst or host long-tail memory reclaiming
> really hurt.

I'm not a fan of the concept as I don't think it really does what it
was meant to do. The way page reporting was meant to work is that when
we have enough free pages we will cycle through memory a few pages at
a time reporting what is unused to the hypervisor. It was meant to be
a scan more than something that just would stop once it touched a
certain part of the memory.

If you are wanting to truly reserve some amount of memory so that it
is always left held by the guest then it might make more sense to make
the value a fixed amount of memory rather than trying to do it as a
percentage.

Also we may need to look at adding some sort of
linearization/defragmentation logic for the reported pages. One issue
is that there are several things that will add pages to the end of the
free page lists. One of the reasons why I was processing the entire
list when I was processing reported pages was because the page freeing
functions will normally cause pages to be interleaved with the
reported pages on the end of the list. So if you are wanting to
reserve some pages as being non-reported we may need to add something
sort the lists periodically.

> This knob can help make customized control policies according
> to VM priority, it is also useful for testing, gray-release, etc.

As far as the knob itself it would make sense to combine this with
patch 3 since they are just different versions of the same control

> ---
>  mm/page_reporting.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index ba195ea..86c6479 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,6 +11,8 @@
>  #include "page_reporting.h"
>  #include "internal.h"
>
> +static int reporting_factor = 100;
> +
>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>
> @@ -134,6 +136,7 @@ void __page_reporting_notify(void)
>         struct list_head *list = &area->free_list[mt];
>         unsigned int page_len = PAGE_SIZE << order;
>         struct page *page, *next;
> +       unsigned long threshold;
>         long budget;
>         int err = 0;
>
> @@ -144,6 +147,7 @@ void __page_reporting_notify(void)
>         if (list_empty(list))
>                 return err;
>
> +       threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;

So at 0 you are setting this threshold to 0, however based on the code
below you are still pulling at least one page.

>         spin_lock_irq(&zone->lock);
>
>         /*
> @@ -181,6 +185,8 @@ void __page_reporting_notify(void)
>
>                 /* Attempt to pull page from list and place in scatterlist */
>                 if (*offset) {
> +                       unsigned long nr_pages;
> +
>                         if (!__isolate_free_page(page, order)) {
>                                 next = page;
>                                 break;
> @@ -190,6 +196,12 @@ void __page_reporting_notify(void)
>                         --(*offset);
>                         sg_set_page(&sgl[*offset], page, page_len, 0);
>
> +                       nr_pages = (PAGE_REPORTING_CAPACITY - *offset) << order;
> +                       if (zone->reported_pages + nr_pages >= threshold) {
> +                               err = 1;
> +                               break;
> +                       }
> +

So here we are checking the threshold after we have already pulled the
page. With this being the case it might make more sense to either
allow for the full capacity of pages to be pulled and then check this
after they have been reported, or to move this check up to somewhere
before you start processing the pages. What you want to avoid is
having to perform this check for every individual page.

>                         continue;
>                 }
>
> @@ -244,9 +256,13 @@ void __page_reporting_notify(void)
>                             struct scatterlist *sgl, struct zone *zone)
>  {
>         unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
> -       unsigned long watermark;
> +       unsigned long watermark, threshold;
>         int err = 0;
>
> +       threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
> +       if (zone->reported_pages >= threshold)
> +               return err;
> +

Rather than having to calculate the threshold in multiple spots it
might make more sense to move this to the start of
page_reporting_cycle and have it performed again before we reacquire
the spinlock and run page_reporting_drain.

>         /* Generate minimum watermark to be able to guarantee progress */
>         watermark = low_wmark_pages(zone) +
>                     (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
> @@ -267,11 +283,18 @@ void __page_reporting_notify(void)
>
>                         err = page_reporting_cycle(prdev, zone, order, mt,
>                                                    sgl, &offset);
> +                       /* Exceed threshold go to report leftover */
> +                       if (err > 0) {
> +                               err = 0;
> +                               goto leftover;
> +                       }
> +
>                         if (err)
>                                 return err;
>                 }
>         }
>
> +leftover:
>         /* report the leftover pages before going idle */
>         leftover = PAGE_REPORTING_CAPACITY - offset;
>         if (leftover) {

You should optimize for processing full batches rather than chopping
things up into smaller groupings.

> @@ -435,9 +458,44 @@ static ssize_t refault_kbytes_store(struct kobject *kobj,
>  }
>  REPORTING_ATTR(refault_kbytes);
>
> +static ssize_t reporting_factor_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%u\n", reporting_factor);
> +}
> +
> +static ssize_t reporting_factor_store(struct kobject *kobj,
> +               struct kobj_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       int new, old, err;
> +       struct page *page;
> +
> +       err = kstrtoint(buf, 10, &new);
> +       if (err || (new < 0 || new > 100))
> +               return -EINVAL;
> +
> +       old = reporting_factor;
> +       reporting_factor = new;
> +
> +       if (new <= old)
> +               goto out;
> +
> +       /* Trigger reporting with new larger reporting_factor */
> +       page = alloc_pages(__GFP_HIGHMEM | __GFP_NOWARN,
> +                       PAGE_REPORTING_MIN_ORDER);
> +       if (page)
> +               __free_pages(page, PAGE_REPORTING_MIN_ORDER);
> +
> +out:
> +       return count;
> +}
> +REPORTING_ATTR(reporting_factor);
> +
>  static struct attribute *reporting_attrs[] = {
>         &reported_kbytes_attr.attr,
>         &refault_kbytes_attr.attr,
> +       &reporting_factor_attr.attr,
>         NULL,
>  };
>
> --
> 1.8.3.1
>
>
