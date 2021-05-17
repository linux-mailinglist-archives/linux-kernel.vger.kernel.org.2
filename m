Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4457382CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhEQNAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:00:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhEQNAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:00:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51850AEF5;
        Mon, 17 May 2021 12:59:07 +0000 (UTC)
Date:   Mon, 17 May 2021 14:59:03 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm,hwpoison: make get_hwpoison_page call
 get_any_page()
Message-ID: <20210517125859.GA25228@linux>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
 <20210517045401.2506032-3-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517045401.2506032-3-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:54:01PM +0900, Naoya Horiguchi wrote:
>  static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
> @@ -1098,7 +1091,9 @@ static int __get_hwpoison_page(struct page *page)
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  	spin_lock(&hugetlb_lock);
> -	if (PageHuge(head) && (HPageFreed(head) || HPageMigratable(head)))
> +	if (!PageHuge(head))
> +		ret = -EBUSY;

Unless I'm missing something, we will be returning -EBUSY for any non-hugetlb
page, which is not right.
I think what you want is to return -EBUSY in case the page is a hugetlb page
but we cannot grab a refcount because the page is in a floating state, meaning
!HPageFreed && !HPageMigratable.

Right?

-- 
Oscar Salvador
SUSE L3
