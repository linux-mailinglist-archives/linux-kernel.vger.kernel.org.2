Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B02397886
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhFAQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFAQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:57:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D443C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:56:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a7so7533021qvf.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C/GoBbxbbL1j3ZgEgqdllSBXYrRGp9vFh0BE3WavI/A=;
        b=ZUbP9CMDb5auLLc4hp9CECDW8oHfEsAPVdKYAaAoNncNvv8OT2rF9/4z9Cg9xn+g1o
         g79Lf792oGIoTVQRrRx/rxRvDDf/2599hBx40e8e3FU7d1rG+kEa+Kdg2CcRf3QfX2pw
         9wDqJzUtUi9faJ9H8Uh/VrpvxCXjRQO76lDYA1D51utb+EaTeRnswSHMDMPmpe3DAO9E
         XJun8OO7zcF5WEOzJEzPiXtTHZ49HjXKa+qRWEwngI2MHvq/5+QwW/ilpmFOLRS9ao50
         ArMp/2EkATuhnnq8Q3W1nERKyYC1hHROSgqSwlu1wQ1k+kNom5tDAbL5RfV3Sg1z9euS
         RDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C/GoBbxbbL1j3ZgEgqdllSBXYrRGp9vFh0BE3WavI/A=;
        b=Ni6bx6E4p16lrFQFNexyk/7hNOx12jfTDysHx15w3UL0RD8Dc3WZEB3GrLxSZtaxih
         iqC5cnHrffP+hxaOCoVxcaQyNoJKMcw2eP30vXPvOjSsmma+U2tUF5MzTmyBkQa/gfW5
         dr+w0UTuQjKMNiMCwtnZ/56zBt6KDOWsad8wCbWjiGgh8ViNkSZ2yyyvg0kT1tOlNp4k
         Ng4HLZCLMOreBprosURADlcvtz2viTV7bwOuZrZmRBVAv0ED3HlILul6shaVArah/+V3
         3Mtdpimsv+yiL5gnUQzyEp1YPusrXSFkgW6URQ/QU1k6yBBQ/qm4uZMj620VgfJtHT/W
         6JUA==
X-Gm-Message-State: AOAM533i5GdG+Gi9GArSIDa35P3qeMxr8uAfFdSdxurPxfKtHRlp8fd2
        unEd5S/2uhJpyqQdcA9Zc3KFsA==
X-Google-Smtp-Source: ABdhPJzzLpK1gGAZ35uLeax+6NhU8wKNmaMJjD6arKlXzE67y02SAjN9GcgdjT8p1u5ntIOJxGQa+w==
X-Received: by 2002:a0c:ee23:: with SMTP id l3mr23734537qvs.55.1622566568843;
        Tue, 01 Jun 2021 09:56:08 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d21sm2407258qke.29.2021.06.01.09.56.07
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 09:56:08 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:55:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Xu Yu <xuyu@linux.alibaba.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com,
        Greg Thelen <gthelen@google.com>, Wei Xu <weixugc@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
In-Reply-To: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021, Xu Yu wrote:

> We notice that hung task happens in a conner but practical scenario when
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
> copy_to_user, which will immediately fault again without rescheduling,
> and thus occupy the cpu fully.
> 
> When there are too many processes performing __migration_entry_wait on
> tail page, remap_page will never be done after cond_resched.
> 
> This relaxes __migration_entry_wait on tail page, thus gives remap_page
> a chance to complete.
> 
> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>

Well caught: you're absolutely right that there's a bug there.
But isn't cond_resched() just papering over the real bug, and
what it should do is a "page = compound_head(page);" before the
get_page_unless_zero()? How does that work out in your testing?

Hugh

> ---
>  mm/migrate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b234c3f3acb7..df2dc39fe566 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -301,8 +301,11 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
>  	 * is zero; but we must not call put_and_wait_on_page_locked() without
>  	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
>  	 */
> -	if (!get_page_unless_zero(page))
> -		goto out;
> +	if (!get_page_unless_zero(page)) {
> +		pte_unmap_unlock(ptep, ptl);
> +		cond_resched();
> +		return;
> +	}
>  	pte_unmap_unlock(ptep, ptl);
>  	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
>  	return;
> -- 
> 2.20.1.2432.ga663e714
> 
> 
> 
