Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD44179D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbhIXRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbhIXRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:23:41 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6AFC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:22:08 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i13so11209326ilm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF6KMebTrcnE6ZDlGZIxVRvDYdCDvqX/Fd5kEH/etjc=;
        b=Q/BgLeJ/XyR2TTP/o2QVcP5SNne657H5JPm0IiO7gO6CCW/F3LoWtko68GXTn+9fXJ
         fjWl818E3xECobWQZd6PE3t3NCKFoUiBmJdcmuvwulTe5crlxKHvUesdwqJYnhjbhm9E
         bMgb1XsApuGY2gqrYEo/iGaEZ62GIu3K0WD7W/Sn/lH/DEJYs6LUEXFNIhigOv+zBrAK
         HvEYk3Il+ux4Bl8KlTKOvc36n1Y+4RvRl7GBVgoGBlrofdc9G+d0ARm7YvhXcFh1ZaaD
         CG48tHPwKFZBtce2YdZ2OyFFGfcHFH+tiK0DTHOu0ADPuuTUA3sNXxwVzMX1+jrHDZRE
         sLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF6KMebTrcnE6ZDlGZIxVRvDYdCDvqX/Fd5kEH/etjc=;
        b=Ja7uZk1X8Qp7zGc75I6dmIk5c7bfZmQBSs7fWu2uePWy+FjxyhxrQWoSnppDoFlUml
         MqAa7uesSyeTW3P9s3/Td3afdZ0ML6QkapUYEI9o9WIfedxO3KMsOE0GbCSb8QJtwEAo
         LGscH2QsCP43sut1+z846k5edj57gv+/HBrXzBPsP7Wtbgv40GAhDEuJoCed3uxX6SJx
         isC7//NDrBmqwfJFyFaDVrFhY6JA0eaNHiLdJ7llayGm+oFThOALSvpyoKd5zWwPOGtu
         x+jOMLRQ1NgMx6SQXSIVuMC5K/dmK6aG8I17CaUhu9AcJbd6n0shAYRqZdnPc14OyZpf
         vSEQ==
X-Gm-Message-State: AOAM531lxOUvileGDqTdW8Lv0Ym9odTziGZ5eKqRgx3F4aayxsxHeaK/
        C0ryzTi1koWiWDwtjbvthYi6wDiTM5ZId5JtMfeK5A==
X-Google-Smtp-Source: ABdhPJy2wtjGitvpd9vw+AdFGxitMROC+03E/OCri7/nbib4kFh9+M1zI/wb30Ym//Md/tQaoyDkS6S7q68N0TETXHI=
X-Received: by 2002:a05:6e02:13d4:: with SMTP id v20mr9413856ilj.247.1632504127283;
 Fri, 24 Sep 2021 10:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210923232512.210092-1-peterx@redhat.com>
In-Reply-To: <20210923232512.210092-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 24 Sep 2021 10:21:30 -0700
Message-ID: <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with thp enabled
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
>
> In RHEL's gating selftests we've encountered memory corruption in the uffd
> event test even with upstream kernel:
>
>         # ./userfaultfd anon 128 4
>         nr_pages: 32768, nr_pages_per_cpu: 32768
>         bounces: 3, mode: rnd racing read, userfaults: 6240 missing (6240) 14729 wp (14729)
>         bounces: 2, mode: racing read, userfaults: 1444 missing (1444) 28877 wp (28877)
>         bounces: 1, mode: rnd read, userfaults: 6055 missing (6055) 14699 wp (14699)
>         bounces: 0, mode: read, userfaults: 82 missing (82) 25196 wp (25196)
>         testing uffd-wp with pagemap (pgsize=4096): done
>         testing uffd-wp with pagemap (pgsize=2097152): done
>         testing events (fork, remap, remove): ERROR: nr 32427 memory corruption 0 1 (errno=0, line=963)
>         ERROR: faulting process failed (errno=0, line=1117)
>
> It can be easily reproduced when global thp enabled, which is the default for
> RHEL.
>
> It's also known as a side effect of commit 0db282ba2c12 ("selftest: use mmap
> instead of posix_memalign to allocate memory", 2021-07-23), which is imho right
> itself on using mmap() to make sure the addresses will be untagged even on arm.
>
> The problem is, for each test we allocate buffers using two allocate_area()
> calls.  We assumed these two buffers won't affect each other, however they
> could, because mmap() could have found that the two buffers are near each other
> and having the same VMA flags, so they got merged into one VMA.
>
> It won't be a big problem if thp is not enabled, but when thp is agressively
> enabled it means when initializing the src buffer it could accidentally setup
> part of the dest buffer too when there's a shared THP that overlaps the two
> regions.  Then some of the dest buffer won't be able to be trapped by
> userfaultfd missing mode, then it'll cause memory corruption as described.
>
> To fix it, do release_pages() after initializing the src buffer.

But, if I understand correctly, release_pages() will just free the
physical pages, but not touch the VMA(s). So, with the right
max_ptes_none setting, why couldn't khugepaged just decide to
re-collapse (with zero pages) immediately after we release the pages,
causing the same problem? It seems to me this change just
significantly narrows the race window (which explains why we see less
of the issue), but doesn't fix it fundamentally.

>
> Since the previous two release_pages() calls are after uffd_test_ctx_clear()
> which will unmap all the buffers anyway (which is stronger than release pages;
> as unmap() also tear town pgtables), drop them as they shouldn't really be
> anything useful.
>
> We can mark the Fixes tag upon 0db282ba2c12 as it's reported to only happen
> there, however the real "Fixes" IMHO should be 8ba6e8640844, as before that
> commit we'll always do explicit release_pages() before registration of uffd,
> and 8ba6e8640844 changed that logic by adding extra unmap/map and we didn't
> release the pages at the right place.  Meanwhile I don't have a solid glue
> anyway on whether posix_memalign() could always avoid triggering this bug,
> hence it's safer to attach this fix to commit 8ba6e8640844.
>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1994931
> Fixes: 8ba6e8640844 ("userfaultfd/selftests: reinitialize test context in each test")
> Reported-by: Li Wang <liwan@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 10ab56c2484a..60aa1a4fc69b 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -414,9 +414,6 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
>         uffd_test_ops->allocate_area((void **)&area_src);
>         uffd_test_ops->allocate_area((void **)&area_dst);
>
> -       uffd_test_ops->release_pages(area_src);
> -       uffd_test_ops->release_pages(area_dst);
> -
>         userfaultfd_open(features);
>
>         count_verify = malloc(nr_pages * sizeof(unsigned long long));
> @@ -437,6 +434,26 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
>                 *(area_count(area_src, nr) + 1) = 1;
>         }
>
> +       /*
> +        * After initialization of area_src, we must explicitly release pages
> +        * for area_dst to make sure it's fully empty.  Otherwise we could have
> +        * some area_dst pages be errornously initialized with zero pages,
> +        * hence we could hit memory corruption later in the test.
> +        *
> +        * One example is when THP is globally enabled, above allocate_area()
> +        * calls could have the two areas merged into a single VMA (as they
> +        * will have the same VMA flags so they're mergeable).  When we
> +        * initialize the area_src above, it's possible that some part of
> +        * area_dst could have been faulted in via one huge THP that will be
> +        * shared between area_src and area_dst.  It could cause some of the
> +        * area_dst won't be trapped by missing userfaults.
> +        *
> +        * This release_pages() will guarantee even if that happened, we'll
> +        * proactively split the thp and drop any accidentally initialized
> +        * pages within area_dst.
> +        */
> +       uffd_test_ops->release_pages(area_dst);
> +
>         pipefd = malloc(sizeof(int) * nr_cpus * 2);
>         if (!pipefd)
>                 err("pipefd");
> --
> 2.31.1
>
