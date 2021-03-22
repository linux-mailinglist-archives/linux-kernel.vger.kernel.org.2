Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1683A3450A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhCVUUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhCVUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:20:33 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC329C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:20:28 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z9so16059730ilb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g19ekQhwWPSUVgeDRJ0qV8y1izdmXO7LuQ/4SsoZHq0=;
        b=ejKUkIApjaWRL7dUZPBW3gdjkQxA0z+5LeJYdtHdOcPvTHkv6dxcYuQs/T9Eb549L2
         JScgJ7XI1WwOwMqtzTcgqD2YkkvkhoyUx7XbQd2WEziLlKNurf/V2PssbH7Z0pYUk9Xc
         AfuyvCVCu87UqeDab3IMz2K5LcAmHfd2Gj1U0b1SW3/USf84H2jS/h68st6GKZ/a0Dpd
         kAvRpJOh1tzto7ukWq9t2ntk/DJ70L2EKrjb4YjTDoqAEnmmYitvwov1m8ogzr2becKU
         IDClAL/p18aqeNvZXUviMX//5bqgYdGV6bK4wymFOe3DTdgdnmEOLjQsDUSEd3ccK8Hs
         l27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g19ekQhwWPSUVgeDRJ0qV8y1izdmXO7LuQ/4SsoZHq0=;
        b=Cd6bPkaZNW2bokonsXPoGGiWmdwJCTKgbSezFmVq5SP1Vf5KMnWsJQVXkWw6cXFFm/
         itA2+wJuG1QzjIwXvw1oBidAoQp6fGGTSf9l+FMcUi13u7E3JJ7q1XU2O8hfK1gmeu3t
         1/7/e8iLysUd4CbIgXZqSFdwYpRVlwYxxSlVULUDyDr6y9ZK6qegCAgDGDhV1tHj/2vH
         SRIK1VkFWMq2IoVLWMmizm1rkNEHE3llBKa4TzZFNtXH6OdM9j1GqwEoKGHVCNEXjabQ
         viRXoDKkycvZFK6jvIB9uASmYOL+MEHtmrwEy81BushZFzl47dddavdya3K6UJrErQia
         9twA==
X-Gm-Message-State: AOAM532HlzcPizygcMUkpOCEOwdvaP8qXOJmBpIpSkCMqJtk+QOlYpwB
        XzrNWZeBh0GOIb4XBzDJa6jkarvcYL5y89zRovMCAQ==
X-Google-Smtp-Source: ABdhPJyDgPKhS2+tkfjzlXTtW3qCalDvZvWrOxXVsbJUcAbzzVu6aTdx240urDCi4J5764OzK5M9/G1/tTXR4uoFGBk=
X-Received: by 2002:a92:c561:: with SMTP id b1mr1542272ilj.165.1616444428175;
 Mon, 22 Mar 2021 13:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210322175132.36659-1-peterx@redhat.com>
In-Reply-To: <20210322175132.36659-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 22 Mar 2021 13:19:50 -0700
Message-ID: <CAJHvVcjAqv3S1CTr4MrFVgLSQzsL-4HK69w77aQ_J989oQ5+=w@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd/hugetlbfs: Fix minor fault page leak
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:51 AM Peter Xu <peterx@redhat.com> wrote:
>
> When uffd-minor enabled, we need to put the page cache before handling the
> userfault in hugetlb_no_page(), otherwise the page refcount got leaked.
>
> This can be reproduced by running userfaultfd selftest with hugetlb_shared
> mode, then cat /proc/meminfo.
>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Fixes: f2bf15fb0969 ("userfaultfd: add minor fault registration mode")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 408dbc08298a..56b78a206913 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4449,6 +4449,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>                 /* Check for page in userfault range. */
>                 if (userfaultfd_minor(vma)) {
>                         unlock_page(page);
> +                       put_page(page);
>                         ret = hugetlb_handle_userfault(vma, mapping, idx,
>                                                        flags, haddr,
>                                                        VM_UFFD_MINOR);
> --
> 2.26.2
>

Thanks for the fix, Peter! I applied the patch and verified it does
indeed fix the issue.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
