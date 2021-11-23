Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245C045A395
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhKWNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhKWNW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:22:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EC7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8Lcq3ciu3667/Au2jyAismeBvkNUg7x0FQx5wyUwZU=; b=D0kvGtgoq1mzIow25vCHqjNTzR
        rlcpRav/4ALzGsUNMgD4ji4Xpq9njQEmbx58zzVxlcb8aNiF3yN6v/cv2niKpYnn5Z1vvcrkmp0gm
        a/1WusN7LOg2JkVCwzINcKuWzmOGBkmPToF9oleSyWcRo/zLF3lJvkmN2gduo+I5lmnlO95X8RjND
        +lcwHzwZeD3C6Pan57egRd8EnmtRg5dpLYP3pQBulohByzT7zQfhUthRRV2yu7ljN+umwgpMwwruB
        wgY+t/WKXKeUJa43hrOi7AnoKN87UbEcbYNOORxZv+qngwijtyL1+WM3//ovWsKHqvpV1Qj6ZRjKP
        UXyNFQVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpVhn-00EumM-GD; Tue, 23 Nov 2021 13:19:27 +0000
Date:   Tue, 23 Nov 2021 13:19:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] mm: protect free_pgtables with mmap_lock write lock
 in exit_mmap
Message-ID: <YZzqX0PjxNmhJSvm@casper.infradead.org>
References: <20211116215715.645231-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116215715.645231-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 01:57:14PM -0800, Suren Baghdasaryan wrote:
> @@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
>  	unmap_vmas(&tlb, vma, 0, -1);
>  	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
>  	tlb_finish_mmu(&tlb);
> +	mmap_write_unlock(mm);
>  
>  	/*
>  	 * Walk the list again, actually closing and freeing it,

Is there a reason to unlock here instead of after the remove_vma loop?
We'll need the mmap sem held during that loop when VMAs are stored in
the maple tree.
