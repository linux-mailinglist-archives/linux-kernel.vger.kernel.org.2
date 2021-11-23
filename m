Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F545ACF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhKWUDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKWUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:03:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:00:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r25so60041547edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLIu6dOhjs4vufgSpnksyOeHKMHxKx4U/q0KpSn1TzQ=;
        b=LbeTL942XWZEuXwaE+lfkR5hT8RLhRTix2/UbYTfTJQ7M7lWyzt/ZXwGiumtoCUW+e
         1hOIXOn9jK0zUrXfyma9qVp0XHZFTrNoJBwajRiR8XrXu9GWaWtzy2DPRWyeLd2xnX94
         oAFICe7pBHzAcZBKtRMbay0jvUEPt1Xh/ZsSTACgntbCA/C3OtsQTxKJ/kPS6+iE4yaa
         pSwiKRZYOnvtxOAjWom+25QCH6eslPvTTENHLz04dvU7W7lN2v10ffFlugNv87l6jAGh
         q+KEmX28RFSS8ZS6mZGUyWPBrLVpt8HdoRekmpU8ymomMCcpi7csSIT4Aj0svE7GOOkF
         aTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLIu6dOhjs4vufgSpnksyOeHKMHxKx4U/q0KpSn1TzQ=;
        b=Vm1GFdnVd/jjTVwgIg/Xz8DzvSWFeDL3sTDhESsGDX0pU53OJ71rw9t4r3VeffLSGT
         LZdLZ0zmw1j9yRQhEX0L0Xja4JCNnM53gW1ga28WkCt3Nqwx0tgABQxZgdDDQTP2DQEU
         zW4ZVMccniDfuplUgu9teK/KFGjEyDEKNO1lqB6gL7jKJ/knLW3sPg5lvBs+GUuUmUwA
         MhThZ8pkeSxHJlXBb6S13CyeiwPVl/hzLeydDsfFqJPGqJ7dirgllXrwvt12aojpI5Tc
         XhhRntKDu5lSm8X7UvTMrPA3UQDtnPQ2dyH2ar709xinDu1y1lgLK7LEkfCG91Xtt0lq
         12AQ==
X-Gm-Message-State: AOAM532xzKngzUrfuUVQkOxR/UtkX2L2UoCUUY1B4R3qFVrIr7RG5hh7
        Bbncw5GhMNZqu4es6Z/muUeYBOBKA/mICaouQls=
X-Google-Smtp-Source: ABdhPJxGYJqFC7AvC31S9S38mojNSaXY0eQIavmTz6Qa3fAIaf5JamesroypEO91N4hGDq2TSg0wVUgrgR9d0SrR8PU=
X-Received: by 2002:a50:a6ca:: with SMTP id f10mr13427258edc.81.1637697631969;
 Tue, 23 Nov 2021 12:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20211123190916.1738458-1-shakeelb@google.com>
In-Reply-To: <20211123190916.1738458-1-shakeelb@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Nov 2021 12:00:19 -0800
Message-ID: <CAHbLzkp7RVGrwrCL3+joEZbKxRQkC=-madvdKwL=xgwR8dhLhA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: update split_queue_len correctly
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:09 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> The deferred THPs are split on memory pressure through shrinker
> callback and splitting of THP during reclaim can fail for several
> reasons like unable to lock the THP, under writeback or unexpected
> number of pins on the THP. Such pages are put back on the deferred split
> list for consideration later. However kernel does not update the
> deferred queue size on putting back the pages whose split was failed.
> This patch fixes that.
>
> Without this patch the split_queue_len can underflow. Shrinker will
> always get that there are some THPs to split even if there are not and
> waste some cpu to scan the empty list.
>
> Fixes: 364c1eebe453 ("mm: thp: extract split_queue_* into a struct")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - updated commit message
> - incorporated Yang Shi's suggestion

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
>  mm/huge_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5483347291c..d393028681e2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2809,7 +2809,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>         unsigned long flags;
>         LIST_HEAD(list), *pos, *next;
>         struct page *page;
> -       int split = 0;
> +       unsigned long split = 0;
>
>  #ifdef CONFIG_MEMCG
>         if (sc->memcg)
> @@ -2847,6 +2847,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         list_splice_tail(&list, &ds_queue->split_queue);
> +       ds_queue->split_queue_len -= split;
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>
>         /*
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
