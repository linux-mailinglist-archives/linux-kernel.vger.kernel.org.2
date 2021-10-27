Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05FF43BF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhJ0BfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbhJ0BfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:35:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95AC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:32:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h7so3834640ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiF02oyJyNSKjjF+SviMCoaPH4YrjeDtKStxXgTA/Os=;
        b=En4HPJgUIBhmzDo9CavHXJFsU8XXcMsoXq3yWDDfXIsQdDkSgPZ/wNYvgu5gEhtUQB
         ffyvSfopGGxj2ZoGNwHgQLgFPVpntbj/W1DZl0kw4QsSan1LxR/ozm3e7VUK89mygkZf
         qmh/ggU48k2WREFkXjGMU8s4D+WcIRrYYvpG2c3E8lV5D4CK+r8wfpd9p1RC1fymtwTo
         8BYianIrddXZ4uHp5bFRU+RwUQIl3szeXvz5OFvd/Vj36RISKx1vgsHVVZhOkXVG6YQ3
         Dez8Yb6A6pu6hakHf8CRoCGD5rBeMpeH3Q102ri5c3IRoFWzpSfVau8XhJOy3VkB777h
         F29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiF02oyJyNSKjjF+SviMCoaPH4YrjeDtKStxXgTA/Os=;
        b=EDTraj2leKNDV64GAJuIY4GfylMKPZIMxA4xQPOGniouH/MbryMfgbgl8Y5VUVk7lR
         o3AXhifACb1cgmzY5tA8LOz9bM23CqrRuIIUS9BITOI+pBV1sw/7tGUF0iNpDkvHj8gj
         wEEwrLH/E/VdfgQQssn52si9lBU1G+v/af/9vpD3IComv2tXvWm+zyMPP11eeomMGexs
         jKFb6KO+AaJFHiKxV1awDqazoyYdFlL2QK0qMd3dVOsY+dgXQHkL5QmvH83rEVdutiXZ
         aiZxTYp2PNZTLPn6hA/5bv2N9N61y3KTWLkDPUyh0JW5TuBNPj4lnQoMBwdcqFtfhc1s
         gq7g==
X-Gm-Message-State: AOAM532vVvBktOMAKJYR9O/265nrP7ydqhDhWojR+CgoCr8dSRpRm1TN
        F9S8qD+cdgtEvhaJ9ClT1KemFr1S7JDOmqpg518=
X-Google-Smtp-Source: ABdhPJxnzJSIHBNIPi5OmZ/qi1DLwq4Vbq4+QCpleUGhYj5NcrO8iMsXgSxYodLnXz9Z9dxZW2HCVcZ+yQZ6QgVZsbo=
X-Received: by 2002:aa7:cf96:: with SMTP id z22mr30422393edx.81.1635298368017;
 Tue, 26 Oct 2021 18:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev> <20211025230503.2650970-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20211025230503.2650970-2-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 26 Oct 2021 18:32:36 -0700
Message-ID: <CAHbLzkoZXPZBkAR0CcLa6DpJuFZDxt1P5TvwsYidG0XmK5WTtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/hwpoison: mf_mutex for soft offline and unpoison
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 4:06 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> Originally mf_mutex is introduced to serialize multiple MCE events, but
> it's also helpful to exclude races among  soft_offline_page() and
> unpoison_memory().  So apply mf_mutex to them.

My understanding is it is not that useful to make unpoison run
parallel with memory_failure() and soft offline, so they can be
serialized by mf_mutex and we could make the memory failure handler
and soft offline simpler.

If the above statement is correct, could you please tweak this commit
log to reflect it with patch #2 squashed into this patch?

> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v2:
> - add mutex_unlock() in "page already poisoned" path in soft_offline_page().
>   (Thanks to Ding Hui)
> ---
>  mm/memory-failure.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fa9dda95a2a2..97297edfbd8e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1628,6 +1628,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>         return rc;
>  }
>
> +static DEFINE_MUTEX(mf_mutex);
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -1654,7 +1656,6 @@ int memory_failure(unsigned long pfn, int flags)
>         int res = 0;
>         unsigned long page_flags;
>         bool retry = true;
> -       static DEFINE_MUTEX(mf_mutex);
>
>         if (!sysctl_memory_failure_recovery)
>                 panic("Memory failure on page %lx", pfn);
> @@ -1978,6 +1979,7 @@ int unpoison_memory(unsigned long pfn)
>         struct page *page;
>         struct page *p;
>         int freeit = 0;
> +       int ret = 0;
>         unsigned long flags = 0;
>         static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>                                         DEFAULT_RATELIMIT_BURST);
> @@ -1988,28 +1990,30 @@ int unpoison_memory(unsigned long pfn)
>         p = pfn_to_page(pfn);
>         page = compound_head(p);
>
> +       mutex_lock(&mf_mutex);
> +
>         if (!PageHWPoison(p)) {
>                 unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (page_count(page) > 1) {
>                 unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (page_mapped(page)) {
>                 unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (page_mapping(page)) {
>                 unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         /*
> @@ -2020,7 +2024,7 @@ int unpoison_memory(unsigned long pfn)
>         if (!PageHuge(page) && PageTransHuge(page)) {
>                 unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (!get_hwpoison_page(p, flags)) {
> @@ -2028,7 +2032,7 @@ int unpoison_memory(unsigned long pfn)
>                         num_poisoned_pages_dec();
>                 unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         lock_page(page);
> @@ -2050,7 +2054,9 @@ int unpoison_memory(unsigned long pfn)
>         if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
>                 put_page(page);
>
> -       return 0;
> +unlock_mutex:
> +       mutex_unlock(&mf_mutex);
> +       return ret;
>  }
>  EXPORT_SYMBOL(unpoison_memory);
>
> @@ -2231,9 +2237,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>                 return -EIO;
>         }
>
> +       mutex_lock(&mf_mutex);
> +
>         if (PageHWPoison(page)) {
>                 pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
>                 put_ref_page(ref_page);
> +               mutex_unlock(&mf_mutex);
>                 return 0;
>         }
>
> @@ -2251,5 +2260,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>                 }
>         }
>
> +       mutex_unlock(&mf_mutex);
> +
>         return ret;
>  }
> --
> 2.25.1
>
