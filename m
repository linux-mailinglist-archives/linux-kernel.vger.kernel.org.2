Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C83A04E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhFHUDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:03:11 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43883 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhFHUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:03:08 -0400
Received: by mail-oi1-f172.google.com with SMTP id x196so22373823oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=U2RZsNcVZF/A9WKl6Syv2dkkUcnD6gzrLpGwOG0uKBA=;
        b=Gcss2X89Z24QxoWCjkupZcyQxvltOXMO4xu2KRzWl4m/MCCqbHJF8VvBG0VTYAZFT7
         3jxLHfmb4iAgb1VYTuP5B1tTWtSEDdw0aNpVfa1a4PK8GeFkdXPb3/Pm752zx0easOd7
         /sjz2kw9KjVACzn+/2sWikMn28VWH3xDeqx7O5G0WA802vWNbt4ej0kqt2C5bRtI4lHG
         tEZS9QMz20qwOU1nAp2j4l8xtDz4iAubzKejqziWNFiwfCWIxyHAlx9MmRMc2gFeuQvd
         4+M0uXn/CCeqUNqXU9DfNxeBUAtu9ZoW0tZ2R6EEKllkAcinFYujaSU/VEA4p6Hpeye+
         0oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=U2RZsNcVZF/A9WKl6Syv2dkkUcnD6gzrLpGwOG0uKBA=;
        b=lRVQfnVqEXzkBFVb1mE5yl3EUnUkA3yiiIyrGxrPn8YndbZdU3Zb4B0HdjokofF9A/
         Z84M9yOvDYL0N0TlSZD/1d5Akqr8ARF4SMKcUs0Fnr0uy459DCKPIRYhncopZucr3Nj/
         w5KlmHFH1ymy3xU3prmvGBO5pBKnCmxz5xTqh5BJTatX2WVT4eDQfTYUJNK2EppRtyx5
         rJc9ty3fTpyMziQpmVSTe1Y0/P8mVUBIKcMU9TI8Y55ZRnjRVzWh8kneI4LPPz7NDQCd
         lve6g0YaQD7PDXh8IjwgHRangJJehtl8Z/fwPukIVTzpjEf6cM/cxz6GjjalG5Tj/bkc
         33tA==
X-Gm-Message-State: AOAM532EV/gL9ngA9Sz15ZfLnr6CI26MRiRQ9anR7IXsVlDYWaz0K08d
        psZ7YRP8wTSp16hjNdBRYr7A+8yAcUVpEQ==
X-Google-Smtp-Source: ABdhPJyEF1rs/MChREJFdaK9w/jVyCBBz3xtW5SQvXfvT1iUhSMvf2YYQxqoEcH3Dh1Qz/WSzh7KwQ==
X-Received: by 2002:a05:6808:1146:: with SMTP id u6mr3998862oiu.130.1623182414747;
        Tue, 08 Jun 2021 13:00:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d8sm1988140oom.37.2021.06.08.13.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:00:14 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:00:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Xu Yu <xuyu@linux.alibaba.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
In-Reply-To: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
Message-ID: <ab645ebd-6ba4-fbf4-1e3-5e2a2378d06c@google.com>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021, Xu Yu wrote:

> We notice that hung task happens in a conner but practical scenario when

But I still don't understand what you mean by "conner":
common, corner, something else? Maybe just delete "conner but ".

> CONFIG_PREEMPT_NONE is enabled, as follows.
> 
> Process 0                       Process 1                     Process 2..Inf
> split_huge_page_to_list
>     unmap_page
>         split_huge_pmd_address
>                                 __migration_entry_wait(head)
>                                                               __migration_entry_wait(tail)
>     remap_page (roll back)
>         remove_migration_ptes
>             rmap_walk_anon
>                 cond_resched
> 
> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> copy_to_user in fstat, which will immediately fault again without
> rescheduling, and thus occupy the cpu fully.
> 
> When there are too many processes performing __migration_entry_wait on
> tail page, remap_page will never be done after cond_resched.
> 
> This makes __migration_entry_wait operate on the compound head page,
> thus waits for remap_page to complete, whether the THP is split
> successfully or roll back.
> 
> Note that put_and_wait_on_page_locked helps to drop the page reference
> acquired with get_page_unless_zero, as soon as the page is on the wait
> queue, before actually waiting. So splitting the THP is only prevented
> for a brief interval.
> 
> Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>

Thanks:
Acked-by: Hugh Dickins <hughd@google.com>

And I hope Andrew will add Cc stable when it goes into his tree.

I'll leave the (independent) discussion of optimal wakeup strategy
to Kirill and Matthew: no strong opinion from me, it works as it is.

> ---
>  mm/migrate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b234c3f3acb7..41ff2c9896c4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -295,6 +295,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  		goto out;
>  
>  	page = migration_entry_to_page(entry);
> +	page = compound_head(page);
>  
>  	/*
>  	 * Once page cache replacement of page migration started, page_count
> -- 
> 2.20.1.2432.ga663e714
> 
> 
