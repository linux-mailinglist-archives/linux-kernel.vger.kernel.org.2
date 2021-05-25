Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84138FD76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhEYJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:11:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231429AbhEYJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:10:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621933762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMjceT9vwzkrZQiya/elFoq1dJf0z/5I+bdC8ntYH9k=;
        b=GIHsAw35IfIvEt+YIwJgiYqbOh/kgsUbhe4zaENhaJJXa9qlBhRfYhMUTJM1pgx5N91Qpm
        W6eq2qhWpMmMFIFA8pB82aZWBFk+PYravQWcDYoojfgLK5jWD6w8hCDhqFUbJGL77ywahF
        A6uPQGS152jqRyf/M7Iut5ZzPWSfZes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621933762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMjceT9vwzkrZQiya/elFoq1dJf0z/5I+bdC8ntYH9k=;
        b=Z1Q27/swwWOpfYBUeRbZC9peLa+e8OjWlTBG8TKTY6KBfMqh6QY3SO7uUUdnF7DXFHCpKm
        t/xJpL94eLELjkBA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F739AE1F;
        Tue, 25 May 2021 09:09:22 +0000 (UTC)
Date:   Tue, 25 May 2021 11:09:18 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page allocation
Message-ID: <20210525090918.GE3300@linux>
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
 <20210518231259.2553203-2-nao.horiguchi@gmail.com>
 <d78f430c-2390-2a5f-564a-e20e0ba6b26a@oracle.com>
 <20210520071717.GA2641190@hori.linux.bs1.fc.nec.co.jp>
 <20210525073559.GA844@linux>
 <20210525080707.GA3325050@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525080707.GA3325050@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 08:07:07AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> OK, here's the current draft.
> 
> Thanks,
> Naoya Horiguchi
> 
> ---
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Tue, 18 May 2021 23:49:18 +0900
> Subject: [PATCH] mm,hwpoison: fix race with hugetlb page allocation
> 
> When hugetlb page fault (under overcommitting situation) and
> memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
> 
>     CPU0:                           CPU1:
> 
>                                     gather_surplus_pages()
>                                       page = alloc_surplus_huge_page()
>     memory_failure_hugetlb()
>       get_hwpoison_page(page)
>         __get_hwpoison_page(page)
>           get_page_unless_zero(page)
>                                       zero = put_page_testzero(page)
>                                       VM_BUG_ON_PAGE(!zero, page)
>                                       enqueue_huge_page(h, page)
>       put_page(page)
> 
> __get_hwpoison_page() only checks the page refcount before taking an
> additional one for memory error handling, which is wrong because there's
> a time window where compound pages have non-zero refcount during
> initialization.  So make __get_hwpoison_page() check page status a bit
> more for hugetlb pages.

I think that this changelog would benefit from some information about the new
!PageLRU && !__PageMovable check.

>  static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
> +	int ret = 0;
> +	bool hugetlb = false;
> +
> +	ret = get_hwpoison_huge_page(head, &hugetlb);
> +	if (hugetlb)
> +		return ret;
> +
> +	if (!PageLRU(head) && !__PageMovable(head))
> +		return 0;

This definitely needs a comment hinting the reader why we need to check for this.
AFAICS, this is to close the race where a page is about to be a hugetlb page soon,
so we do not go for get_page_unless_zero(), right?

From soft_offline_page's POV I __guess__ that's fine because we only deal with
pages we know about.
But what about memory_failure()? I think memory_failure() is less picky about that,
so it is okay to not take a refcount on that case?

-- 
Oscar Salvador
SUSE L3
