Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC43C834E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhGNLBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhGNLBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:01:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61421C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:58:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cu14so1340817pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xK2PN0jEfVdDDtiAjxshjV1gI46HAkaNE/QoRVQK5c0=;
        b=FM2oThHJUTJV7ROmR5//8EBZOl8RmJ0Vwx7fSfiPuLWaCYnup2pnb8IRR2M6b18uWl
         3sEF3hYzgdoZ5Fe6Yt12Mh2BOapQRcKt7wW/td0md1LWr+P7WQc8hNDYIRAHYj3U3KyQ
         HEn298y2Pd2e2L9dJ6Ke21EofSFFff+yZ4Ukocrs9BfG4sX54dd6aRmSyIAkggNQLtac
         SWLcCTJpsPbnW416L58rd2UMu4Y+8QpVDo+CCW5m8y8ql80L2kRN4EHaHHcnyumwzapF
         9C/XszBEl0iMhq8cC5DhKQzkuoIEtMJX3z2/hH+sIxVd8ndS1IQXjJ6dqYYm9PLE/yea
         eRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xK2PN0jEfVdDDtiAjxshjV1gI46HAkaNE/QoRVQK5c0=;
        b=AgJfVxsWdUl4oqYfw6+R0sL+gEnq/8sUSZJ77/z84KGtRV7hR6kG0As4Pk8wlNEcbt
         rLZrdU5T2Q/8dqcTGxhVGQU4Mv2JM+eFnVpobrbLfoz9O5Mr7vejbnm07MS7QQhZwlfM
         6UFyrwpGDFk7OszUZCz2rSBSag8DlhK57+Ch5piZ+UFWbSyN3e2KHyifuN2QMshrqNms
         Gy9QYIpF0lZygX4ofcf7F0Lh9twXlZYYoYMqMNhbvcQzGX25f4fV7MkzZMAg9T0rZMGx
         lWDOvZZIqp2Y80i/2chGVodA2WkWoNC6MQPCD9KFammJ3M5FOFGwcw7Srus9iE55hw+r
         sn+A==
X-Gm-Message-State: AOAM532HtRRQ9xVlrBJSPNrM8hov3DhGkjwdD1irJxFZ0ddQtJiBhgEo
        cwT4UhqgXHT1dthqkr0EVeX0M307cXq3DNDFUPoXog==
X-Google-Smtp-Source: ABdhPJzQpJxjseEkxgMgjYHaJmcM7dkEy4xFbsZNd3gc4oJf4ecA4j1V2KjLiR5YIdpDICCVwwWg9dggIyt0yc0coJU=
X-Received: by 2002:a17:90a:5204:: with SMTP id v4mr3199223pjh.147.1626260292966;
 Wed, 14 Jul 2021 03:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210710002441.167759-1-mike.kravetz@oracle.com> <20210710002441.167759-4-mike.kravetz@oracle.com>
In-Reply-To: <20210710002441.167759-4-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 14 Jul 2021 18:57:36 +0800
Message-ID: <CAMZfGtWvGZZ1VaPzZbEro7nYCHS6tGCL5kYm3ArSQ5b5E0-o5g@mail.gmail.com>
Subject: Re: [External] [PATCH 3/3] hugetlb: before freeing hugetlb page set
 dtor to appropriate value
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 8:25 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> When removing a hugetlb page from the pool the ref count is set to
> one (as the free page has no ref count) and compound page destructor
> is set to NULL_COMPOUND_DTOR.  Since a subsequent call to free the
> hugetlb page will call __free_pages for non-gigantic pages and
> free_gigantic_page for gigantic pages the destructor is not used.
>
> However, consider the following race with code taking a speculative
> reference on the page:
>
> Thread 0                                Thread 1
> --------                                --------
> remove_hugetlb_page
>   set_page_refcounted(page);
>   set_compound_page_dtor(page,
>            NULL_COMPOUND_DTOR);
>                                         get_page_unless_zero(page)
> __update_and_free_page
>   __free_pages(page,
>            huge_page_order(h));
>
>                 /* Note that __free_pages() will simply drop
>                    the reference to the page. */
>
>                                         put_page(page)
>                                           __put_compound_page()
>                                             destroy_compound_page
>                                               NULL_COMPOUND_DTOR
>                                                 BUG: kernel NULL pointer
>                                                 dereference, address:
>                                                 0000000000000000
>
> To address this race, set the dtor to the normal compound page dtor
> for non-gigantic pages.  The dtor for gigantic pages does not matter
> as gigantic pages are changed from a compound page to 'just a group of
> pages' before freeing.  Hence, the destructor is not used.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3132c7395743..fa8ec2072949 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1370,8 +1370,28 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>                 h->surplus_huge_pages_node[nid]--;
>         }
>
> +       /*
> +        * Very subtle
> +        *
> +        * For non-gigantic pages set the destructor to the normal compound
> +        * page dtor.  This is needed in case someone takes an additional
> +        * temporary ref to the page, and freeing is delayed until they drop
> +        * their reference.
> +        *
> +        * For gigantic pages set the destructor to the null dtor.  This
> +        * destructor will never be called.  Before freeing the gigantic
> +        * page destroy_compound_gigantic_page will turn the compound page
> +        * into a simple group of pages.  After this the destructor does not
> +        * apply.
> +        *
> +        * This handles the case where more than one ref is held when and
> +        * after update_and_free_page is called.
> +        */
>         set_page_refcounted(page);
> -       set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +       if (hstate_is_gigantic(h))
> +               set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +       else
> +               set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);

Hi Mike,

The race is really subtle. But we also should remove the WARN from
free_contig_range, right? Because the refcount of the head page of
the gigantic page can be greater than one, but free_contig_range has
the following warning.

WARN(count != 0, "%lu pages are still in use!\n", count);

Thanks.

>
>         h->nr_huge_pages--;
>         h->nr_huge_pages_node[nid]--;
> --
> 2.31.1
>
