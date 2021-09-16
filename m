Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC840D4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhIPIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:36:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54498 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhIPIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:36:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9B9881FEB2;
        Thu, 16 Sep 2021 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631781310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XohSGbOhJnp4vglMn1D3IB8biBQdodV80lSwfv+I84=;
        b=1CauoTFBFQFg7BF844YSkm6XOAhpnNCHkSQD9tvtbMEAcmDRuqoPaodYdZZgMXsICXWmxZ
        uqSZy4qnbeCmdtTMjhWon6nKkLX0nrVPs1yE8FO/sTwap/v5SXiaabNEdxWFtStbh1t5yI
        oj6uCmJyMs7XzEQIwgAskFUnBK6Hbtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631781310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XohSGbOhJnp4vglMn1D3IB8biBQdodV80lSwfv+I84=;
        b=fdn+2u1+9/iCrT3BVTDvKF5VjcOgIY04oaLpo5SnJcWu8aS4vwSa37uTXGClRK4XiQPHRd
        emeUAySK5rM1i4DA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 86EC3A3BA6;
        Thu, 16 Sep 2021 08:35:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B9D181E0C04; Thu, 16 Sep 2021 10:35:09 +0200 (CEST)
Date:   Thu, 16 Sep 2021 10:35:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/gup: further simplify __gup_device_huge()
Message-ID: <20210916083509.GB10610@quack2.suse.cz>
References: <20210904004224.86391-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904004224.86391-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-09-21 17:42:24, John Hubbard wrote:
> commit 6401c4eb57f9 ("mm: gup: fix potential pgmap refcnt leak in
> __gup_device_huge()") simplified the return paths, but didn't go quite
> far enough, as discussed in [1].
> 
> Remove the "ret" variable entirely, because there is enough information
> already available to provide the return value.
> 
> [1] https://lore.kernel.org/r/CAHk-=wgQTRX=5SkCmS+zfmpqubGHGJvXX_HgnPG8JSpHKHBMeg@mail.gmail.com
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks sane. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 9935a4480710..6e62f1518c1f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2241,7 +2241,6 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  {
>  	int nr_start = *nr;
>  	struct dev_pagemap *pgmap = NULL;
> -	int ret = 1;
>  
>  	do {
>  		struct page *page = pfn_to_page(pfn);
> @@ -2249,14 +2248,12 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  		pgmap = get_dev_pagemap(pfn, pgmap);
>  		if (unlikely(!pgmap)) {
>  			undo_dev_pagemap(nr, nr_start, flags, pages);
> -			ret = 0;
>  			break;
>  		}
>  		SetPageReferenced(page);
>  		pages[*nr] = page;
>  		if (unlikely(!try_grab_page(page, flags))) {
>  			undo_dev_pagemap(nr, nr_start, flags, pages);
> -			ret = 0;
>  			break;
>  		}
>  		(*nr)++;
> @@ -2264,7 +2261,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  	} while (addr += PAGE_SIZE, addr != end);
>  
>  	put_dev_pagemap(pgmap);
> -	return ret;
> +	return addr == end;
>  }
>  
>  static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
