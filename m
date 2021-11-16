Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD854452916
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbhKPEZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343880AbhKPEYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:24:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7955761B30;
        Tue, 16 Nov 2021 04:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637036509;
        bh=wwMatGyZhfNZCPaF2wvkt3Y+SqGCuP8mHGMgs8mAL/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T2x+VpryqG7dLunHOg0FxA+cB/ng41qGTKGrA388DL79Mj3eHRBK1hI0sYQ8hwGz1
         +UtyE5qGG9t/Go2NA7CkTZ1dbsPVzkUffu1jQVSE6vQ9r5Ybs5QQIqScZ/fj4rZPkt
         jLW6Ea+GFqIT/+zaXGcWVPpiRxyANwq4LFHzMopM=
Date:   Mon, 15 Nov 2021 20:21:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
Message-Id: <20211115202146.473fff2404d7fb200dd48bd3@linux-foundation.org>
In-Reply-To: <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
        <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Nov 2021 16:57:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Correct the migration stats for hugetlb with using compound_nr() instead
> of thp_nr_pages(),

It would be helpful to explain why using thp_nr_pages() was wrong.
And to explain the end user visible effects of this bug so we can
decide whether -stable backporting is desirable.

> meanwhile change 'nr_failed_pages' to record the
> number of normal pages failed to migrate, including THP and hugetlb,
> and 'nr_succeeded' will record the number of normal pages migrated
> successfully.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9aafdab..756190b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1436,9 +1436,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   * It is caller's responsibility to call putback_movable_pages() to return pages
>   * to the LRU or free list only if ret != 0.
>   *
> - * Returns the number of {normal page, THP} that were not migrated, or an error code.
> - * The number of THP splits will be considered as the number of non-migrated THP,
> - * no matter how many subpages of the THP are migrated successfully.
> + * Returns the number of {normal page, THP, hugetlb} that were not migrated, or

This is a bit confusing.

If migrate_pages() failed to migrate one 4k pages then it returns 1,
yes?

But if migrate_pages() fails to migrate one 2MB hugepage then will it
return 1 or will it return 512?

And how can the caller actually _use_ this return value without knowing
the above information?

In other words, perhaps this function should simply return pass/fail?


