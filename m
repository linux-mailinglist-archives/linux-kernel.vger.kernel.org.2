Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F432B724
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357481AbhCCKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbhCBX4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:56:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DACD64F18;
        Tue,  2 Mar 2021 23:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614729335;
        bh=zWac9cnIz9laoxFW85MyWgw2aqumRTdkZfT7OXGdHyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bkgAstw4SxlWP3Cxm/Te8Q8pKFapVg3IsYz1ONK5o1n8THhzzPmvMT/8M18o1H2kB
         TOyUqfrcz8YDMDH2oMaeb5QhbDJy9ihtsfKRdJ42k+3jKztE39oZhRQWSIukPQ+ezD
         NLuSj1RQZ4UiPIT+4DX5E7okKS8q6MD7/r6AoGuA=
Date:   Tue, 2 Mar 2021 15:55:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: delete bool "migrated"
Message-Id: <20210302155534.34fa737060e1f29ebfe2fe52@linux-foundation.org>
In-Reply-To: <1614603421-2681-1-git-send-email-wangqing@vivo.com>
References: <1614603421-2681-1-git-send-email-wangqing@vivo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Mar 2021 20:57:01 +0800 Wang Qing <wangqing@vivo.com> wrote:

> Smatch gives the warning:
> 	do_numa_page() warn: assigning (-11) to unsigned variable 'migrated'
> 
> ...
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4102,7 +4102,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	int page_nid = NUMA_NO_NODE;
>  	int last_cpupid;
>  	int target_nid;
> -	bool migrated = false;
>  	pte_t pte, old_pte;
>  	bool was_writable = pte_savedwrite(vmf->orig_pte);
>  	int flags = 0;
> @@ -4172,8 +4171,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	}
>  
>  	/* Migrate to the requested node */
> -	migrated = migrate_misplaced_page(page, vma, target_nid);
> -	if (migrated) {
> +	if (migrate_misplaced_page(page, vma, target_nid)) {
>  		page_nid = target_nid;
>  		flags |= TNF_MIGRATED;
>  	} else

Looks right.

Methinks both migrate_misplaced_page() and numamigrate_isolate_page()
should return bools.  (And that their return values should be documented!)
