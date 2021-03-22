Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8A34378F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVDor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVDoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:44:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=teEkGkhYqZXqR+Kb7GaOCqK+oZmBR9vOVPu2Qz26xEg=; b=YJ/TWknT8Q2Bwh+xX5hKJy5/mw
        1gMBkSb2zx/tK6pl4PX7QPaapmRgdl29v+XdzPy0arZK+XRla3hl2mIEFFyaIzLy1mmUcaE4heu/B
        u9eocXFz6Zo71S90K58yQevtjqAtF0ebjK66ue8IYVumwrmlXznvvyZrfFQLSd7airqfr860FEVXY
        7pILm+EJjr6qQa6Mmu9TMZvbtn1/RyZLDvUd6sVGszpR1cROs/83vfOM216g4bAiC686TTwKBqr5x
        eCZB5xpA1K3S5x96zKMTP7SmEm7i4qra6Z/5bCGvIuSU5M19mEDOc5JZ4jyWORFeIRUk6/ZStrLeY
        ByR88p+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOBU8-007wcg-SF; Mon, 22 Mar 2021 03:44:11 +0000
Date:   Mon, 22 Mar 2021 03:44:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] mm: Fix typos in comments
Message-ID: <20210322034408.GD1719932@casper.infradead.org>
References: <20210322025152.GA1922846@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322025152.GA1922846@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:51:52AM +0100, Ingo Molnar wrote:
> +++ b/mm/huge_memory.c
> @@ -1794,7 +1794,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  /*
>   * Returns
>   *  - 0 if PMD could not be locked
> - *  - 1 if PMD was locked but protections unchange and TLB flush unnecessary
> + *  - 1 if PMD was locked but protections unchanged and TLB flush unnecessary
>   *  - HPAGE_PMD_NR is protections changed and TLB flush necessary

s/is/if/

> @@ -5306,7 +5306,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  
>  	/*
>  	 * vma need span at least one aligned PUD size and the start,end range
> -	 * must at least partialy within it.
> +	 * must at least partially within it.

	 * vma needs to span at least one aligned PUD size, and the range
	 * must be at least partially within in.

>  /*
>   * swapon tell device that all the old swap contents can be discarded,
> - * to allow the swap device to optimize its wear-levelling.
> + * to allow the swap device to optimize its wear-leveling.
>   */

Levelling is british english, leveling is american english.  we don't
usually "correct" one into the other.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
