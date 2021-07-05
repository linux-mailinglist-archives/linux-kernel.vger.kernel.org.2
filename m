Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905B03BB9AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhGEI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGEI7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:59:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 765A1613C2;
        Mon,  5 Jul 2021 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625475420;
        bh=ZqjV6RrWkA7theMbsvZ8YZrCke0QXHtvRo3wcNk+Upk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDMrGP9js/MZtQ/Ho77/c6GRBbjraVZgGhojOtutaYSGt24I4xbHtiq1lif8985y9
         XFWGS7NOy5jhd8Ot4wjbzr9tWMk8qrleglrNJ/64p3/DDMB+05wlcmIXbsJ+eJAOkT
         sv6KEaC2gujt5FpQCFWRUp2t1+OLRgP0XKZk8ZrqrtQsbna8/f1UPK+6ZWjUBaFT4B
         bNMbqjxNUSWacN04vI3t/lt4l0zLx4ZUwygD1usCRyMkVNeWLkvpOcsg7LLJl3sGs9
         mAnQNtddAWQyjQNOdcAPCe0j71nwQzvi0o0t/uVdc+6nfc71Na0r0rQeOFKQG8QXPe
         DVrsLbBs3zfiw==
Date:   Mon, 5 Jul 2021 01:56:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <YOLJW0IgCagMk2tF@google.com>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05, Chao Yu wrote:
> On 2021/7/5 13:22, Jaegeuk Kim wrote:
> > We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
> > operations.
> 
> Oops, I didn't get the point, shouldn't .private be zero after page was
> just allocated by filesystem? What's the case we will encounter stall
> private data left in page?

I'm seeing f2fs_migrate_page() has the newpage with some value without Private
flag. That causes a kernel panic later due to wrong private flag used in f2fs.

> 
> Cc Matthew Wilcox.
> 
> Thanks,
> 
> > 
> > Fixes: b763f3bedc2d ("f2fs: restructure f2fs page.private layout")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/data.c | 2 ++
> >   fs/f2fs/f2fs.h | 5 ++++-
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 3a01a1b50104..d2cf48c5a2e4 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3819,6 +3819,8 @@ int f2fs_migrate_page(struct address_space *mapping,
> >   		get_page(newpage);
> >   	}
> > +	/* guarantee to start from no stale private field */
> > +	set_page_private(newpage, 0);
> >   	if (PagePrivate(page)) {
> >   		set_page_private(newpage, page_private(page));
> >   		SetPagePrivate(newpage);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 65befc68d88e..ee8eb33e2c25 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1331,7 +1331,8 @@ enum {
> >   #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
> >   static inline bool page_private_##name(struct page *page) \
> >   { \
> > -	return test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
> > +	return PagePrivate(page) && \
> > +		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
> >   		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> >   }
> > @@ -1341,6 +1342,7 @@ static inline void set_page_private_##name(struct page *page) \
> >   	if (!PagePrivate(page)) { \
> >   		get_page(page); \
> >   		SetPagePrivate(page); \
> > +		set_page_private(page, 0); \
> >   	} \
> >   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
> >   	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> > @@ -1392,6 +1394,7 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
> >   	if (!PagePrivate(page)) {
> >   		get_page(page);
> >   		SetPagePrivate(page);
> > +		set_page_private(page, 0);
> >   	}
> >   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
> >   	page_private(page) |= data << PAGE_PRIVATE_MAX;
> > 
