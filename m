Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECAC389C87
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhETEZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhETEZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3465611AE;
        Thu, 20 May 2021 04:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621484653;
        bh=JoxyRJJwbOn3mXrx2lcm9umyQMZiiPwjRQjRRVKvdUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fokKf/7PfCLFsDxCBhflqYTPoEkrWFG9H8aAShNgQr6vjbKGLenqS5sOyPP/Ligby
         424sJirtq+eJkSf8j43iWnXHtyT+Wsu/8JdtWNCFPPKtmImJsiF40dk/wVn3NlMsBL
         n8HsahBnh5KWsCK7/6+kntMmHN+46mQwBDTm4NvE=
Date:   Wed, 19 May 2021 21:24:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     osalvador@suse.de, mike.kravetz@oracle.com, mhocko@suse.com,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        zhengqi.arch@bytedance.com, fam.zheng@bytedance.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: migrate: fix missing update page_private to
 hugetlb_page_subpool
Message-Id: <20210519212412.5653163f94904b141d5d74ce@linux-foundation.org>
In-Reply-To: <20210520025949.1866-1-songmuchun@bytedance.com>
References: <20210520025949.1866-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 10:59:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
> page flags") converts page.private for hugetlb specific page flags. We
> should use hugetlb_page_subpool() to get the subpool pointer instead of
> page_private(). The commit forgot to update it in the page migration
> routine. So fix it.
> 
> ...
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  	 * page_mapping() set, hugetlbfs specific move page routine will not
>  	 * be called and we could leak usage counts for subpools.
>  	 */
> -	if (page_private(hpage) && !page_mapping(hpage)) {
> +	if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
>  		rc = -EBUSY;
>  		goto out_unlock;
>  	}

So it uses the wrong page*, so this isn't just a cosmetic fix.  One
cannot tell from this changelog.

Please describe the runtime effects of this bug.  Please always include
this information when fixing bugs.  And when adding them.
