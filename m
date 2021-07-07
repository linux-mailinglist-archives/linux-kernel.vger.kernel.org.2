Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49B3BE60D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhGGJ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:59:51 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:37755 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231181AbhGGJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:59:49 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 5B9BACACEA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:57:08 +0100 (IST)
Received: (qmail 30476 invoked from network); 7 Jul 2021 09:57:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jul 2021 09:57:08 -0000
Date:   Wed, 7 Jul 2021 10:57:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chao Yu <chao@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <20210707095706.GT3840@techsingularity.net>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
 <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
 <20210706091211.GR3840@techsingularity.net>
 <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 08:48:28AM +0800, Chao Yu wrote:
> On 2021/7/6 17:12, Mel Gorman wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d6e94cc8066c..be87c4be481f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3515,8 +3515,13 @@ void split_page(struct page *page, unsigned int order)
>  	VM_BUG_ON_PAGE(PageCompound(page), page);
>  	VM_BUG_ON_PAGE(!page_count(page), page);
> 
> -	for (i = 1; i < (1 << order); i++)
> -		set_page_refcounted(page + i);
> +	for (i = 1; i < (1 << order); i++) {
> +		struct page *tail_page = page + i;
> +
> +		set_page_refcounted(tail_page);
> +		if (WARN_ON_ONCE(tail_page->private))
> +			pr_info("order:%x, tailpage.private:%x", order, tail_page->private);
> +	}
>  	split_page_owner(page, 1 << order);
>  	split_page_memcg(page, 1 << order);
>  }
> -- 
> 2.22.1
> 
> With above diff, I got this:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 57 at mm/page_alloc.c:3363 split_page.cold+0x8/0x3b
> CPU: 3 PID: 57 Comm: kcompactd0 Tainted: G           O      5.13.0-rc1+ #67
> <SNIP>
> order:7, tailpage.private:d0000
> order:7, tailpage.private:d0000
> order:7, tailpage.private:d0000
> order:7, tailpage.private:200000
> order:7, tailpage.private:d0000
> order:7, tailpage.private:d0000
> order:7, tailpage.private:d0000
> 
> So how about adding set_page_private(page, 0) in split_page() to clear
> stall data left in tailpages' private field?
> 

I think it would work but it would be preferable to find out why the
tail page has an order set in the first place. I've looked over
mm/page_alloc.c and mm/compaction.c a few times and did not spot where
set_private_page(page, 0) is missed when it should be covered by
clear_page_guard or del_page_from_free_list :(

-- 
Mel Gorman
SUSE Labs
