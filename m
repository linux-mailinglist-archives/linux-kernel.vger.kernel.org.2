Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609F944F8B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 16:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhKNPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 10:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 10:31:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44469C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E/Bl7CXqwUF/cWYj/ZAt0H/eac5hQHkzocJWz7wDRFI=; b=h1vn6lOwqFNP6Ym+XERGzxu1iW
        MEgr6t75Yxw0zHIvuHkAJgrU0sJeZtadqRiMPR36JvWELDHqWfqN74IpXK2cs9YxetTV5dvfx61mc
        kiJUooezW9RdT1O1MWWxb7fl47oiRI2cIQejqD+nJUyLtyPngFmnVuPdlG91FanGtXn4EMPmu+LTh
        kN6sHhBGuxRYZ5ERcToJK9FTb9QynqzYcC+8Lf4ZLO5Yy9e4JXd6EVVG/HakqQG1wDSc96LzQJ0gY
        QVNMK1UZb+jLJSroVeqyT7kbgSigohCXWT9sJ1kJnlS/09B+hgMNhpaw15iUpoS3FfCcukE6v7F9g
        dQHuq5gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmHQO-0052q9-7F; Sun, 14 Nov 2021 15:28:08 +0000
Date:   Sun, 14 Nov 2021 15:28:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     torvalds@linux-foundation.org, arnd@arndb.de, hughd@google.com,
        kirill.shutemov@linux.intel.com, naoya.horiguchi@nec.com,
        osalvador@suse.de, peterx@redhat.com, ajaygargnsit@gmail.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <YZErCLzSixIwTr6C@casper.infradead.org>
References: <20211114053221.315753-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114053221.315753-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 09:32:21PM -0800, Yang Shi wrote:
> @@ -2466,7 +2467,18 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  			return -EPERM;
>  	}
>  
> -	return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (*pagep && PageHWPoison(*pagep)) {
> +		unlock_page(*pagep);
> +		put_page(*pagep);
> +		ret = -EIO;

You definitely need to add:

		*pagep = NULL;

I'm not entirely convinced that you need the conditional on '*pagep'.
If we returned 0, there had better be a page at pagep!

I also think this would be clearer if written as:

	if (PageHWPoison(*pagep)) {
		unlock_page(*pagep);
		put_page(*pagep);
		*pagep = NULL;
		return -EIO;
	}

	return 0;

instead of re-using ret.  Sometimes that can make the code flow clearer,
but here, I don't think it does.

> @@ -4168,9 +4201,12 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  	error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
>  				  gfp, NULL, NULL, NULL);
>  	if (error)
> -		page = ERR_PTR(error);
> -	else
> -		unlock_page(page);
> +		return ERR_PTR(error);
> +
> +	unlock_page(page);
> +	if (PageHWPoison(page))
> +		return ERR_PTR(-EIO);

Do we need to put_page() the page in this error case?

