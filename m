Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F263E36D1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhHGSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhHGSle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DDFD60F25;
        Sat,  7 Aug 2021 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628361675;
        bh=zvgjE7YTOv76OGelHU+WXD7jLMPH6Bf/LG1/8h+9tOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V+N1HZP2hATamgCS+x0xY8/o2PAoBFXVEcQWz6anC9aVDpHJv+A4HXCdNWsbjC5cS
         d8fj9BRGrIm6R9d0xeYoUSqYm58PB9FjWsbBVDu9kQ2MuZGE/lnlY4ND5bkvHLWZct
         hKRozVDKcIf6MvZvVTQYSnmShxfhHhfsfahDgtm0=
Date:   Sat, 7 Aug 2021 11:41:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm: gup: fix potential pgmap refcnt leak in
 __gup_device_huge()
Message-Id: <20210807114112.6e45b31c65dd62169fee8718@linux-foundation.org>
In-Reply-To: <20210807093620.21347-5-linmiaohe@huawei.com>
References: <20210807093620.21347-1-linmiaohe@huawei.com>
        <20210807093620.21347-5-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2021 17:36:19 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When failed to try_grab_page, put_dev_pagemap() is missed. So pgmap
> refcnt will leak in this case. Also we remove the check for pgmap
> against NULL as it's also checked inside the put_dev_pagemap().
> 
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2253,14 +2253,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  		pages[*nr] = page;
>  		if (unlikely(!try_grab_page(page, flags))) {
>  			undo_dev_pagemap(nr, nr_start, flags, pages);
> +			put_dev_pagemap(pgmap);
>  			return 0;
>  		}
>  		(*nr)++;
>  		pfn++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> -	if (pgmap)
> -		put_dev_pagemap(pgmap);
> +	put_dev_pagemap(pgmap);
>  	return 1;
>  }

We can simplify further, and remove the troublesome multiple return points?

--- a/mm/gup.c~mm-gup-fix-potential-pgmap-refcnt-leak-in-__gup_device_huge-fix
+++ a/mm/gup.c
@@ -2247,14 +2247,13 @@ static int __gup_device_huge(unsigned lo
 		pgmap = get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
-			return 0;
+			break;
 		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
-			put_dev_pagemap(pgmap);
-			return 0;
+			break;
 		}
 		(*nr)++;
 		pfn++;
_

