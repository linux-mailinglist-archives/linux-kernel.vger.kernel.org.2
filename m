Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DA390ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhEZDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhEZDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:21:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:19:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so14417321pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+H2pDGWEKuBFdY6ChyAya4zIt6sBYmEXl2erhR5ofE=;
        b=OriOIyeg9pc73YkFlgtCpnpDR7K9qibVy6dqFv/Vj3uXtxskI6DVzaCd1FWiVlowTe
         UBKPd+zsAp+lDJZTqjLN9UbwuuPZouwv/UAjstcAw+Z4nYNP67hVfiJI/lSPpL5PaspH
         nlk9rOVBCOqFIGEDM0g1af4n2WRqqgW3gu6RmmSI5BuKkjjfIzyJ4/sTnHjarvggzLZQ
         rrLJERs7sWzJdeCEHXVQ9l0MRc+FpSBLq3Ukr4QHyJRVwrCllWjXuK9uAZO7pfBvhp5i
         QNsinnl0EltmRgJ+EqJVypm+d8xjpd7NWu3lhIw6exfFbdpmj/W8COYkoYEWcRSZZ1tk
         aGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+H2pDGWEKuBFdY6ChyAya4zIt6sBYmEXl2erhR5ofE=;
        b=VKKg/Wds9fUHkXvExUqIpGGDmst0xwqwxneZAPYaopRPM9SFgOolame7sh0tlBbZFL
         hQQ5tLpoX7Qp727dt+FaIO69AeWSQ3h2pQujxlC+SYtr2JMIeZgNwh9Rk5cYfTQFPlOh
         rFv/AxJzhUmQDqDII8Np++3dRLYy9FY/R+Fe/ioXIIQ5pwhHJr3640MmrI+8TWekWQ4L
         N4KCBNi8SUv4B8DV61diE4Oo7tnYOAzIOOyuP3C7UCqPtwzlMVBN3szxReJevpByIP7/
         HOmO/mLfbp4MKGOeJ3s/U+Rh96BgM1CNM6vLprdG4MBJsxOvqpgUG4XsxZQVHq4cfARI
         CbRw==
X-Gm-Message-State: AOAM530X+hGouxP4BayAr8A50MxBRqrQkWb/4LuLJQje3tmJuSC/uiav
        ZXvIIYdjzpd4k5sPKaFk+5emAtC78keO7mQx0QS7Zg==
X-Google-Smtp-Source: ABdhPJxNMYe56WEowG8StlDp6sujKEGUeTaH+nLVbzQzcuXRJaJG8lkhaP3gvNuM7Em3+UQD9kpBuDzNGNmvuUhKsZA=
X-Received: by 2002:a17:90a:bd05:: with SMTP id y5mr33612908pjr.229.1621999196385;
 Tue, 25 May 2021 20:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com> <20210525233134.246444-1-mike.kravetz@oracle.com>
In-Reply-To: <20210525233134.246444-1-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 11:19:20 +0800
Message-ID: <CAMZfGtVUvtCCEHN_V8iE4m9FAmiz9e5Z1CNNvnetXsrEwAVzgQ@mail.gmail.com>
Subject: Re: [External] [PATCH 0/2] Track reserve map changes to restore on error
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 7:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Here is a modification to the reservation tracking for fixup on errors.
> It is a more general change, but should work for the hugetlb_mcopy_pte_atomic
> case as well.
>
> Perhaps use this as a prerequisite for your fix(es)?  Pretty sure this
> will eliminate the need for the call to hugetlb_unreserve_pages.

Hi Mike,

It seems like someone is fixing a bug, right? Maybe a link should be
placed in the cover letter so that someone can know what issue
we are facing.

Thanks.

>
> Mike Kravetz (2):
>   hugetlb: rename HPageRestoreReserve flag to HPageRestoreRsvCnt
>   hugetlb: add new hugetlb specific flag HPG_restore_rsv_map
>
>  fs/hugetlbfs/inode.c    |   3 +-
>  include/linux/hugetlb.h |  17 +++++--
>  mm/hugetlb.c            | 108 ++++++++++++++++++++++++++++------------
>  mm/userfaultfd.c        |  14 +++---
>  4 files changed, 99 insertions(+), 43 deletions(-)
>
> --
> 2.31.1
>
