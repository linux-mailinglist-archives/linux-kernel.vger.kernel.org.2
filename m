Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6AA3F0AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhHRSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:08:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98EC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:07:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w5so6859450ejq.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hx28tyUB9KiCFAY9cyuoD0VE1SUmiWqAmn6LZw6GdqM=;
        b=Ivn9I5XbRrwoplOFaspCCcybEySrshPBY5LxabeMfF9J3hA7yX5eyan+yPWWo9g6XN
         noZWJrVnjn7URoYnYqQy3wYsR2dHsm+QJu8YbPmMIfhs0FLeuxyR4WvWH+Z48HyqvMeQ
         SB7JJm4pmAHNx/mqZdmZEKcSshDKKvdvrIX8p35uQ5f4zTuYy7k3DvG2Gi+XD0oVoNAW
         4x64MBvq8UaYETvp1bMn4bKaHl4UWknwpBU+DAVIbfV1WYlXaMyYPwrufzaQ4t070Dey
         5xFFA7JYuQ17SmTGOmTYp98/dkRadf7WieyELBTLpe9o2kWxm09gvNrqNvJp+d3JHihM
         tPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hx28tyUB9KiCFAY9cyuoD0VE1SUmiWqAmn6LZw6GdqM=;
        b=oCOZW18iQccXdQa89h7mxHFvYkhaRFrIL8XypXjjqZ5/0i6IKrqCAd3kB/zJ114Ki4
         gJJQjU4nFPILQyA2mi35YW85puYCG1kA0XYJNGFKMr7W1bRDlJ3Xgro7vH5mgsL7SvD9
         wy4lCR2wNtUscakGVfdMnfI8yakjdpn0o5kGElBAyhy9cKt5NIs6PvUl4fu+yk47krHl
         yPDbZMG43jO2V2vyH5ETIwX3bkA8iX1CVklZOdcungLB+W1akLjh8nxMG8zf9zw6WKQS
         LUdg2tqaQ4lahygAJxDG14EsNMdmKkOWq7lskfzlXyXQbeUkgxT1cVUtj10thlJEvFD6
         zwSw==
X-Gm-Message-State: AOAM5326eClHRdhKKu0dEXIzobE6Sh6IzFF0EPm/nkZm0dmR6o2Edfpw
        6xco+kVKWNLft1l0/KVP4V6MwRPJ/HrO7rqtC6U=
X-Google-Smtp-Source: ABdhPJzZHmWsoIsqMYnWIZzdgtWZcINZycCty6LdqZp4YBnydV2udS6zRdbz6xic1TEqZ7wAu70biRsHMMIuwlPYLfo=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr11233299ejq.25.1629310075279;
 Wed, 18 Aug 2021 11:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210817053703.2267588-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20210817053703.2267588-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 Aug 2021 11:07:43 -0700
Message-ID: <CAHbLzkrHOHNRQU-TtR6cV9stV-c88jxg+LWbJBbBifh1n74FKw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/hwpoison: Retry with shake_page() for unhandlable pages
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:37 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> HWPoisonHandlable() sometimes returns false for typical user pages
> due to races with average memory events like transfers over LRU lists.
> This causes failures in hwpoison handling.
>
> There's retry code for such a case but does not work because the retry
> loop reaches the retry limit too quickly before the page settles down to
> handlable state. Let get_any_page() call shake_page() to fix it.
>
> Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
> Reported-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: stable@vger.kernel.org # 5.13
> ---
>  mm/memory-failure.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git v5.14-rc6/mm/memory-failure.c v5.14-rc6_patched/mm/memory-failure.c
> index eefd823deb67..aa6592540f17 100644
> --- v5.14-rc6/mm/memory-failure.c
> +++ v5.14-rc6_patched/mm/memory-failure.c
> @@ -1146,7 +1146,7 @@ static int __get_hwpoison_page(struct page *page)
>          * unexpected races caused by taking a page refcount.
>          */
>         if (!HWPoisonHandlable(head))
> -               return 0;
> +               return -EBUSY;
>
>         if (PageTransHuge(head)) {
>                 /*
> @@ -1199,9 +1199,14 @@ static int get_any_page(struct page *p, unsigned long flags)
>                         }
>                         goto out;
>                 } else if (ret == -EBUSY) {
> -                       /* We raced with freeing huge page to buddy, retry. */
> -                       if (pass++ < 3)
> +                       /*
> +                        * We raced with (possibly temporary) unhandlable
> +                        * page, retry.
> +                        */
> +                       if (pass++ < 3) {
> +                               shake_page(p, 1);
>                                 goto try_again;
> +                       }

I think the return value should be set to -EIO before jumping to out.
I'm supposed -EIO means this is really or very likely an unhandlable
page.

>                         goto out;
>                 }
>         }
> --
> 2.25.1
>
>
