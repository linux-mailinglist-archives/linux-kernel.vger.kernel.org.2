Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E473D4174
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWTmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhGWTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:42:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A15C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 13:23:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id d17so1886786qvn.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=45B60HJHaOgGcCdEHrn+NEtQnhZ8BJLwR64MKRSCcOw=;
        b=WOzGoY0UoRKQIR68vvCUm1gJHX56WcWzqPIivJlyGlU8Y9tUmbJxODyo9SLqeNnhLc
         uVpi3uSg01b+SdP4/8aRuWnI/+R30oNwh2f4psNJ5KXHNHm/u80EjLMziY3I+usVH2gM
         ZQpOCN3kIJvn0np7Ojs2dcE1ivGYcSu+zYt2gEAOWIhHi2l5ByTDXIM6VDwc1ZVcF+wy
         lCsD40BIocS+UqirAQxeUjkvR7RzRbH3D///u8nyX3SkUSCtDUFCzgkDJgnOrR3pXdf3
         7xCC4c/Gm2KgeqEXP7iTK/4DEjxCZjGiLxcCGaWYkckgCLjJ5/ITkqqMro/YzFrnraya
         Q3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=45B60HJHaOgGcCdEHrn+NEtQnhZ8BJLwR64MKRSCcOw=;
        b=c+2mmUh7GW1n73/aPVnWGWhhS8SVnRplmjnwRjETI9qC+bQtL+DskSZNYP4Hpc5xFV
         /MIoZZeBv0MxzsxYvbH0C2gb+wps55eX5dilpgv4nfyXQZ6FRxY/t338PURti76Z6hpI
         BjJi0RAVGorYckd+gO/F7qKNxGSoh/d1fD20vbw8PbZSJq3L4D9nTDFMTKW2II/JO04N
         MQ3aC+jNbicdtjBJMYN3/J6yhoUdwNX/eafSwfjWEGtiP9tTt1nHJL68zWud7AgPkYyd
         2orNM87o8sqF0RzF5YzL1qZxBmqOTppWzKcUJcvahtFWifwYK1ptuMVFAJLrQbAQgue6
         QjHA==
X-Gm-Message-State: AOAM531nm0c+GQcvpR3qUDcKGepcE5njP3v1x7s7HyKs/B0LGqoPVbsa
        uxSV7Fhf8MBAtOIf1zNSxahgxQ9QKS9WTg==
X-Google-Smtp-Source: ABdhPJzxXfgfsKEfYExH/jpMpAVKqAigNlFjNj7YR7djS8EdDsfMH34XFakeiM7ER4mIVIinVum//g==
X-Received: by 2002:a05:6214:da1:: with SMTP id h1mr6447709qvh.53.1627071801795;
        Fri, 23 Jul 2021 13:23:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c16sm12014765qtv.32.2021.07.23.13.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 13:23:21 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:23:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Huang Ying <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
In-Reply-To: <20210723080000.93953-1-ying.huang@intel.com>
Message-ID: <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
References: <20210723080000.93953-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021, Huang Ying wrote:

> "-" is missing before "EINVAL".
> 
> Fixes: 2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9af4b2173fe9..e201a3ba12fa 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1708,7 +1708,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	/* Prevent swapoff from happening to us. */
>  	si = get_swap_device(swap);
>  	if (!si) {
> -		error = EINVAL;
> +		error = -EINVAL;
>  		goto failed;
>  	}
>  	/* Look it up and read it in.. */
> -- 
> 2.30.2

Thanks for catching that; and as David says, it's worse than a typo.

But this is not the right fix:
2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
needs to be reverted.

It's been on my pile to look at for weeks: now I look at it and see
it's just a bad patch.  Over-enthusiastic stablehands already rushed
it out, I was wary, and reverts are already in -rc for 5.13 and 5.10,
phew, but 5.12.19 EOL is stuck with it unfortunately, oh well.

I was wary because, if the (never observed) race to be fixed is in
swap_cluster_readahead(), why was shmem_swapin_page() being patched?
Not explained in its commit message, probably a misunderstanding of
how mm/shmem.c already manages races (and prefers not to be involved
in swap_info_struct stuff).

But why do I now say it's bad?  Because even if you correct the EINVAL
to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
not surprising, -ENOSPC can need consideration, but -EIO and anything
else just end up as SIGBUS when faulting (or as error from syscall).
So, 2efa33fc7f6e converts a race with swapoff to SIGBUS: not good,
and I think much more likely than the race to be fixed (since
swapoff's percpu_ref_kill() rightly comes before synchronize_rcu()).

2efa33fc7f6e was intending to fix a race introduced by two-year-old
8fd2e0b505d1 ("mm: swap: check if swap backing device is congested
or not"), which added a call to inode_read_congested().  Certainly
relying on si->swap_file->f_mapping->host there was new territory:
whether actually racy I'm not sure offhand - I've forgotten whether
synchronize_rcu() waits for preempted tasks or not.

But if it is racy, then I wonder if the right fix might be to revert
8fd2e0b505d1 too. Convincing numbers were offered for it, but I'm
puzzled: because Matthew has in the past noted that the block layer
broke and further broke bdi congestion tracking (I don't know the
relevant release numbers), so I don't understand how checking
inode_read_congested() is actually useful there nowadays.

No need to hurry to a conclusion on 8fd2e0b505d1;
but 2efa33fc7f6e should definitely be reverted.

Thanks,
Hugh
