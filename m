Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BED31EFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBRTfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhBRSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:55:33 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267ACC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:55:18 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id s17so3121789ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vIxghfEoCUvaPhBWJXuhAi7CMYaxeuzzYUrJNnMICk=;
        b=f/FifjIx9K0uw8mE7Uj/D1pb3YNguyyXh+x1HHBLvCJ3XiOTcjIRskx7DCWAXsbzUa
         kUDjIQdpjB7J6GQNRuA0uOicOtZJmlZ4AA2w6115thy7p9zzRnVXjj8lO7x3VKVXvZRj
         05bJzj/E/+FZ5TIj/RKOfDV4kh/bGUdk7355GdzZx4XnfrGVSzY/owsC3qtMjK9DflF+
         hql+nm2Xa8e5cAYK32f2ZxifRdyX0AyFPjrIWX2bq7e9TUFlx4AhILv5sHtPnLuldpLH
         lXVI3RTiqw4mL2q2x2cozxwV7cSHfhFWEepH1lv1C/CdfebO54gGaWsj9rkoOltzxsJS
         XJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vIxghfEoCUvaPhBWJXuhAi7CMYaxeuzzYUrJNnMICk=;
        b=TuFkrqiWOkx4op1qPYcwIBwiuyJMd2gIrKyiMXqtBLFtMvsm4RUwX17KyGoqaSo10F
         q5n6s1kQBGwJJvkBmZC2n4haRcLHnGPojF9Eu3UT7VlhKkg8FJWYcoxl/sM4zPkivmre
         RY3LRQsCrWXAA6Q93i+c8AqBPGNjYH28REz3cIGPHWDe/RhnMpDRT/2Yog8Lh8iGmmse
         pXG6q4qRU55CodztOpH0JlKlE4HWPRyKBPQZHXyA6GWjCoCwr8VSzUrx6HKNRpdUhi4H
         rEr3fis1NDaayMN97rqX/h8odLVyZC1yWx0WAHPZq4T4qAl/wen+/jMeRo5eUkn5OaY3
         jp+g==
X-Gm-Message-State: AOAM531EKG9jX0ICuTynbojb3omjAoHuLsuPiuciMU+pvNpQOSGOzt9/
        i7rDcO2bbsvpTCahzBkHgNhyoK1i4Pux3dd1HPQi4QnIYss=
X-Google-Smtp-Source: ABdhPJwEy6flv/s3qSiyuawZgPXP4p15wbLak0d20uK4imXtkBBTugAjAFKe2Ct8Rc+9g1oao2Edt/b5H7LrAeXn9LQ=
X-Received: by 2002:a02:3b29:: with SMTP id c41mr5921693jaa.4.1613674517424;
 Thu, 18 Feb 2021 10:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20210217204418.54259-1-peterx@redhat.com>
In-Reply-To: <20210217204418.54259-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 18 Feb 2021 10:54:41 -0800
Message-ID: <CAJHvVcjgAEk8ABkE0LC=OBsbQYACet7ui6ELqerx-v6KGB+tsg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] hugetlb: Disable huge pmd unshare for uffd-wp
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I reviewed these patches, rebased my minor fault handling series on
top of this series, and then ran some stress tests of minor fault
handling. Other than the one comment I left about !CONFIG_CMA, I
didn't spot any issues. So:

Tested-By: Axel Rasmussen <axelrasmussen@google.com>

(Or Reviewed-By: , if that makes more sense.)

On Wed, Feb 17, 2021 at 12:44 PM Peter Xu <peterx@redhat.com> wrote:
>
> v2:
> - patch 4: move hugetlb_unshare_all_pmds() into mm/hugetlb.c, so it can be used
>   even outside userfaultfd.c
>
> This series tries to disable huge pmd unshare of hugetlbfs backed memory for
> uffd-wp.  Although uffd-wp of hugetlbfs is still during rfc stage, the idea of
> this series may be needed for multiple tasks (Axel's uffd minor fault series,
> and Mike's soft dirty series), so I picked it out from the larger series.
>
> References works:
>
> Uffd shmem+hugetlbfs rfc:
> https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/
>
> Uffd minor mode for hugetlbfs:
> https://lore.kernel.org/lkml/20210212215403.3457686-1-axelrasmussen@google.com/
>
> Soft dirty for hugetlbfs:
> https://lore.kernel.org/lkml/20210211000322.159437-1-mike.kravetz@oracle.com/
>
> Please review, thanks.
>
> Peter Xu (4):
>   hugetlb: Pass vma into huge_pte_alloc() and huge_pmd_share()
>   hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
>   mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
>   hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
>
>  arch/arm64/mm/hugetlbpage.c   |  7 ++-
>  arch/ia64/mm/hugetlbpage.c    |  3 +-
>  arch/mips/mm/hugetlbpage.c    |  4 +-
>  arch/parisc/mm/hugetlbpage.c  |  2 +-
>  arch/powerpc/mm/hugetlbpage.c |  3 +-
>  arch/s390/mm/hugetlbpage.c    |  2 +-
>  arch/sh/mm/hugetlbpage.c      |  2 +-
>  arch/sparc/mm/hugetlbpage.c   |  1 +
>  fs/userfaultfd.c              |  4 ++
>  include/linux/hugetlb.h       | 16 +++++-
>  include/linux/userfaultfd_k.h |  9 ++++
>  mm/hugetlb.c                  | 94 +++++++++++++++++++++++++++--------
>  mm/userfaultfd.c              |  2 +-
>  13 files changed, 114 insertions(+), 35 deletions(-)
>
> --
> 2.26.2
>
>
