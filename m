Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8012537B8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhELI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:56:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:49360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhELI4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:56:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B65EAF65;
        Wed, 12 May 2021 08:55:26 +0000 (UTC)
Date:   Wed, 12 May 2021 10:55:22 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm,hwpoison: make get_hwpoison_page call
 get_any_page()
Message-ID: <20210512085522.GB14726@linux>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
 <20210511151016.2310627-3-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511151016.2310627-3-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 12:10:16AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Now __get_hwpoison_page() could return -EBUSY in a race condition,
> so it's helpful to handle it by retrying.  We already have retry
> logic, so make get_hwpoison_page() call get_any_page() when called
> from memory_failure().

As I stated in your previous patch, I think you should start returning -EBUSY
from this patch onwards.

>  static int get_any_page(struct page *p, unsigned long flags)
>  {
>  	int ret = 0, pass = 0;
> @@ -1152,50 +1136,76 @@ static int get_any_page(struct page *p, unsigned long flags)
>  		count_increased = true;
>  
>  try_again:
> -	if (!count_increased && !__get_hwpoison_page(p)) {
> -		if (page_count(p)) {
> -			/* We raced with an allocation, retry. */
> -			if (pass++ < 3)
> -				goto try_again;
> -			ret = -EBUSY;
> -		} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
> -			/* We raced with put_page, retry. */
> -			if (pass++ < 3)
> -				goto try_again;
> -			ret = -EIO;
> +	if (!count_increased) {
> +		ret = __get_hwpoison_page(p);
> +		if (!ret) {
> +			if (page_count(p)) {
> +				/* We raced with an allocation, retry. */
> +				if (pass++ < 3)
> +					goto try_again;
> +				ret = -EBUSY;
> +			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
> +				/* We raced with put_page, retry. */
> +				if (pass++ < 3)
> +					goto try_again;
> +				ret = -EIO;
> +			}
> +			goto out;
>  		}
> +	}

I think this can be improved.

We cannot have -EBUSY unless we come from __get_hwpoison_page() (!count_increased),
so I think a much more natural approach would be to stuff the hunk below in there,
and then place the other stuff in an else, so something like:

        if (!count_increased) {
                ret = __get_hwpoison_page(p);
                if (!ret) {
                        if (page_count(p)) {
                                /* We raced with an allocation, retry. */
                                if (pass++ < 3)
                                        goto try_again;
                                ret = -EBUSY;
                        } else if (!PageHuge(p) && !is_free_buddy_page(p)) {
                                /* We raced with put_page, retry. */
                                if (pass++ < 3)
                                        goto try_again;
                                ret = -EIO;
                        }
                        goto out;
                } else if (ret == -EBUSY) {
			/* We raced with freeing huge page to buddy, retry. */
			if (pass++ < 3)
				goto try_again;
		}
        } else {
		/* We do already have a refcount for this page, see if we can
		 * handle it.
		 */
		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
			ret = 1;
		} else {
			/* A page we cannot handle. Check...
		}
	}

Other than that, looks good to me.

> +
> +	if (ret == -EBUSY) {
> +		/* We raced with freeing huge page to buddy, retry. */
> +		if (pass++ < 3)
> +			goto try_again;

-- 
Oscar Salvador
SUSE L3
