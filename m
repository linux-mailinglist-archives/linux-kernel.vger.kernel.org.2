Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D23FBCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhH3Sux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhH3Suw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:50:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF19C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:49:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d6so23111615edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcLn/lA+0vt3yEjpcyei6Ga9RUqEfGIrdug6AmWLYok=;
        b=S0NTBfxrVSJ52rUxc2Krkl6krfjaLJC7yYgZtVGtY9YTZ4jh89AlslVDIMjR9zEEYE
         MTp5wKt0e+APa0RjMzqlzF5wawZogGI7g8xwpa+z/p/VggaeEwa867WBH3mZmS5kKUnI
         THTfZqbWvLxB/kDNTqeUqxDB47kr4ekVhWGIHiScxXNLRetzG3B2sKkRycj5Nb1hq4bo
         M7RypetTKSPdhsAClxCr90X+3UmU5xGV86JFBUTSk8AylK/naG1ZIUR77CQct+HCZRz/
         xiKnA9fT8Q4Kv58LYCzRlUfjVmSbNPvc+/74IDamTqpkPOmF4G7By0yKekYJ2egn5C0E
         psyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcLn/lA+0vt3yEjpcyei6Ga9RUqEfGIrdug6AmWLYok=;
        b=A63Kc1mBCJbRnh4z8XKhmdFlVDZ5RJ5E1HRTAiKmro/yWINm0KASg3fu3LutJKLZYZ
         kaY9o3O06Xv9yMv+nXswzk6SN7LF5t3u+crNv/7rysHb6t8L8t4M/7s3bUlMD9QFBg4T
         6Dm7cW0bNNiOj0KQKTwUwfAfdJ65xuXPJSQNYxEGVHXJkRnbGhkOlD59vjRDPQw9rR5i
         pzaO6cS/U0xQRhf3aujkaTfOn6mVRtKV83HCFEgycCglCg9AZ4cKr5qU/NxvwhFSwVlL
         BSA+lTYTgn452QncDnAyESP2LwGMCE8oXPCx8d/qMuB9g6IMp16mwO3f93Fd1s8bP+9+
         kL5g==
X-Gm-Message-State: AOAM5313yh3PQ3kZ7AZaJobrPWqpTaC7gKNDrSKHSw8NDyl7sdmL8yPs
        WQGvRJXiMJC9Ge1UvmKg4jUVa1adSGt1xd+73X0TVGLM
X-Google-Smtp-Source: ABdhPJxWhQWlCZvR2SyldzpMgjJeWeH3GK0l/Hr5FC4iqxd8/KPO8N2wHbksC6OFXg74i0d4Yu8MfvgP2IHxSt8jJj8=
X-Received: by 2002:a05:6402:2751:: with SMTP id z17mr25309393edd.290.1630349396387;
 Mon, 30 Aug 2021 11:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210817202146.3218-1-shy828301@gmail.com>
In-Reply-To: <20210817202146.3218-1-shy828301@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Aug 2021 11:49:43 -0700
Message-ID: <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
To:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gently ping...

Does this patch make sense? BTW, I have a couple of other khugepaged
related patches in my queue. I plan to send them with this patch
together. It would be great to hear some feedback before resending
this one.

Thank,
Yang

On Tue, Aug 17, 2021 at 1:21 PM Yang Shi <shy828301@gmail.com> wrote:
>
> The khugepaged has optimization to reduce huge page allocation calls for
> !CONFIG_NUMA by carrying the allocated but failed to collapse huge page to
> the next loop.  CONFIG_NUMA doesn't do so since the next loop may try to
> collapse huge page from a different node, so it doesn't make too much sense
> to carry it.
>
> But when NUMA=n, the huge page is allocated by khugepaged_prealloc_page()
> before scanning the address space, so it means huge page may be allocated
> even though there is no suitable range for collapsing.  Then the page would
> be just freed if khugepaged already made enough progress.  This could make
> NUMA=n run have 5 times as much thp_collapse_alloc as NUMA=y run.  This
> problem actually makes things worse due to the way more pointless THP
> allocations and makes the optimization pointless.
>
> This could be fixed by carrying the huge page across scans, but it will
> complicate the code further and the huge page may be carried
> indefinitely.  But if we take one step back,  the optimization itself seems
> not worth keeping nowadays since:
>   * Not too many users build NUMA=n kernel nowadays even though the kernel is
>     actually running on a non-NUMA machine. Some small devices may run NUMA=n
>     kernel, but I don't think they actually use THP.
>   * Since commit 44042b449872 ("mm/page_alloc: allow high-order pages to be
>     stored on the per-cpu lists"), THP could be cached by pcp.  This actually
>     somehow does the job done by the optimization.
>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 74 ++++---------------------------------------------
>  1 file changed, 6 insertions(+), 68 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6b9c98ddcd09..d6beb10e29e2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -855,6 +855,12 @@ static int khugepaged_find_target_node(void)
>         last_khugepaged_target_node = target_node;
>         return target_node;
>  }
> +#else
> +static inline int khugepaged_find_target_node(void)
> +{
> +       return 0;
> +}
> +#endif
>
>  static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
>  {
> @@ -889,74 +895,6 @@ khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
>         count_vm_event(THP_COLLAPSE_ALLOC);
>         return *hpage;
>  }
> -#else
> -static int khugepaged_find_target_node(void)
> -{
> -       return 0;
> -}
> -
> -static inline struct page *alloc_khugepaged_hugepage(void)
> -{
> -       struct page *page;
> -
> -       page = alloc_pages(alloc_hugepage_khugepaged_gfpmask(),
> -                          HPAGE_PMD_ORDER);
> -       if (page)
> -               prep_transhuge_page(page);
> -       return page;
> -}
> -
> -static struct page *khugepaged_alloc_hugepage(bool *wait)
> -{
> -       struct page *hpage;
> -
> -       do {
> -               hpage = alloc_khugepaged_hugepage();
> -               if (!hpage) {
> -                       count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> -                       if (!*wait)
> -                               return NULL;
> -
> -                       *wait = false;
> -                       khugepaged_alloc_sleep();
> -               } else
> -                       count_vm_event(THP_COLLAPSE_ALLOC);
> -       } while (unlikely(!hpage) && likely(khugepaged_enabled()));
> -
> -       return hpage;
> -}
> -
> -static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
> -{
> -       /*
> -        * If the hpage allocated earlier was briefly exposed in page cache
> -        * before collapse_file() failed, it is possible that racing lookups
> -        * have not yet completed, and would then be unpleasantly surprised by
> -        * finding the hpage reused for the same mapping at a different offset.
> -        * Just release the previous allocation if there is any danger of that.
> -        */
> -       if (*hpage && page_count(*hpage) > 1) {
> -               put_page(*hpage);
> -               *hpage = NULL;
> -       }
> -
> -       if (!*hpage)
> -               *hpage = khugepaged_alloc_hugepage(wait);
> -
> -       if (unlikely(!*hpage))
> -               return false;
> -
> -       return true;
> -}
> -
> -static struct page *
> -khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
> -{
> -       VM_BUG_ON(!*hpage);
> -
> -       return  *hpage;
> -}
> -#endif
>
>  /*
>   * If mmap_lock temporarily dropped, revalidate vma
> --
> 2.26.2
>
