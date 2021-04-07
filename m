Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD335615B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbhDGCQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhDGCQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:16:48 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Apr 2021 19:16:39 PDT
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617761205; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=XhXKF/HlNkEF5SYDx8u8tz5N9qQXfiAGL0LdiGpNeCM=;
 b=I/g7Gvfz5ftyUgHqNBuPnWTqjssHQ5Xq0vHwEGXlfrdpbRwbuAXpzOPgBeS229wZV8ANB
 E1zDNGu4gI4arXGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617761205; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=XhXKF/HlNkEF5SYDx8u8tz5N9qQXfiAGL0LdiGpNeCM=;
 b=UDp6TQ0bdsuQQeSHsak7IJ4F9fN5evSiGjUg+WKdiZ/q/i+AxGfP56Nhfb71m6v6HB2Zd
 uUKW8BiQmOAGAEMHaWrfjy5S1iRoGDD/E3eQoUa9wUD9Q2rucFxLhHnjdngsiq0N3v5cBwT
 waUMT54SQedejYGhWNwrt/6IB8iQaKMPtVH2jrOT1y6gbe5GSVy0djgbApXcZf4aM3rBrsi
 dx1erw8y3PKFkpfAEV9T0LSbm3rnG4dH2A1qS19BKMEZQn6+gb2M52n8myZbtZR49+dXH+4
 X3X2qbdb+P2clEw8L+nftPMUJX/iWWiSljuelQcex6KCzc0CaUZRtl3LI5FQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id CDE541601D1; Tue,  6 Apr 2021 19:06:45 -0700 (PDT)
Date:   Tue, 6 Apr 2021 19:06:45 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/37] do_anonymous_page: use update_mmu_tlb()
Message-ID: <20210407020645.GA19721@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-4-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-4-michel@lespinasse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibo,

You introduced this code in commit 7df676974359f back in May.
Could you check that the change is correct ?

Thanks,

On Tue, Apr 06, 2021 at 06:44:28PM -0700, Michel Lespinasse wrote:
> update_mmu_tlb() can be used instead of update_mmu_cache() when the
> page fault handler detects that it lost the race to another page fault.
> 
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 5efa07fb6cdc..8ee4bd239303 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3567,7 +3567,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>  			&vmf->ptl);
>  	if (!pte_none(*vmf->pte)) {
> -		update_mmu_cache(vma, vmf->address, vmf->pte);
> +		update_mmu_tlb(vma, vmf->address, vmf->pte);
>  		goto release;
>  	}
>  
> -- 
> 2.20.1
> 
