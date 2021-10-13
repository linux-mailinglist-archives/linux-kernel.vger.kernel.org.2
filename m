Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE642CD05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJMVqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJMVqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:46:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:44:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so15895226edx.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk8GKkcOqsh8NbVVxDMP6EmYX30y4RorCwUqRpcQJZw=;
        b=jGNy5AfFzluinxS/yvYE78vK+Bygmcpe8TdHgSVyd0+EuwnNnGz0RYDW5HoYBP6Qo7
         pQblATlsYSOMLbFHsr0WqaR9x3CuYlmRd1gR9nQeUOW0aRhp5Nv35Jn7yOqA6j0ISNrB
         z4XeghKVlwIqnBIztpqOgz1aEfYZHoGELYL5+FQyV1Fd5KYK1XjnqOQBgemmb5SlejEZ
         0snlhhbgJGGXWaVn3eN1wDvmHyeEGiyqodIZpcVT3EXVkdm5OczwxpfJrRXV1NW7t/aN
         pQ0gl1BU+AKLFz4e9NU+Nvf6kx7vGgHkoj9WSXgh68cvmfbL/tP0164WHltLyAd5Jqdn
         xvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk8GKkcOqsh8NbVVxDMP6EmYX30y4RorCwUqRpcQJZw=;
        b=Ke70lqGY/u34HidwxX/A2JJPKofY7UOw5W7DzMz5KVm0l0b0sJledJY5w4MO/rABAo
         TDZDtcCI+16vC6SF3hzCK7sWgxlB2pm0pHKI/pORjBJVymo122jDDmsU5QMDJ+Ur1NfQ
         O7rmAdX7jm0NKL5CsFc6DJ/0eOZ2j7MNb+7aZdXqJrA4kBYnF67n+2enNTk370joCyNS
         92noxPVVcKQFrnB6yTWusXNtClMqbyD8RmvJ4u2Bb7N5xk3dwZIhwkS/D+FHv4d9hx+k
         EkY9SVMgJ3CNlo+pPEgKJsfWW07iFhmjOChyiBB3wCBxJzU0rBtLh/EmGT7LHm5Ur15Z
         4LqQ==
X-Gm-Message-State: AOAM531DucQX1sUBPVrJmBekidfn+eKcko0RwYc9lOnDugi82yiQnlkk
        3WFf/kTZVq+vkv9Ns8GPCMzic579BSzkB14djjY=
X-Google-Smtp-Source: ABdhPJxCcYL2+MSwx6a/45e05xAfocinRDO0byZIknVz5MhYeq+wQFc+mm+OF4OPgY7Pz5GtyzRrsV03Ub7MvvfuR+4=
X-Received: by 2002:a17:906:3f83:: with SMTP id b3mr2091456ejj.233.1634161477394;
 Wed, 13 Oct 2021 14:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8@eucas1p1.samsung.com>
 <20211012120237.2600-1-m.szyprowski@samsung.com>
In-Reply-To: <20211012120237.2600-1-m.szyprowski@samsung.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 13 Oct 2021 14:44:25 -0700
Message-ID: <CAHbLzkrjkpFZ1D7EnhLqa2xX4G_aXZYh5+ungF6ESAsYmewsCw@mail.gmail.com>
Subject: Re: [PATCH] mm/thp: decrease nr_thps in file's mapping on THP split
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?6rmA7ISx7ZuI?= <sfoon.kim@samsung.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 5:03 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Decrease nr_thps counter in file's mapping to ensure that the page cache
> won't be dropped excessively on file write access if page has been
> already splitted.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 09d91cda0e82 ("mm,thp: avoid writes to file with THP in pagecache")
> Fixes: 06d3eff62d9d ("mm/thp: fix node page state in split_huge_page_to_list()")

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> I've analyzed the code a few times but either I missed something or the
> nr_thps counter is not decremented during the THP split on non-shmem file
> pages.
> ---
>  mm/huge_memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ec2bb93f7431..a6c2ba59abcd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2709,10 +2709,12 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>                 }
>                 spin_unlock(&ds_queue->split_queue_lock);
>                 if (mapping) {
> -                       if (PageSwapBacked(head))
> +                       if (PageSwapBacked(head)) {
>                                 __dec_node_page_state(head, NR_SHMEM_THPS);
> -                       else
> +                       } else {
>                                 __dec_node_page_state(head, NR_FILE_THPS);
> +                               filemap_nr_thps_dec(mapping);
> +                       }
>                 }
>
>                 __split_huge_page(page, list, end, flags);
> --
> 2.17.1
>
>
