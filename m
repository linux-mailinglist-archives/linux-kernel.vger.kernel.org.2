Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA636B5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhDZPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhDZPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:41:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6098C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CoxNInOjZOCOyMvfvquIsyQ8wWfp8Kl8mw++g1dHGiY=; b=lEz+5hJKS15Nvyz9HeU2ArQu9t
        UJ7zK37zfzyvD+0OTzLyc/+EQkqOmNAPuuD3o2QCHAdlQYQJ0dajRGAXjXLBollfSE3nlQfIuPwG1
        Ev1rpoNR2mZfbKrsGhiGXT1WUCT9tWm6bzAzr/yk03Awz9EqOmP5Ez1QObzsINWV4xggzIuDn3okP
        KfGiRswsbsE2MiIGsxjFmSvyeDanc0jrrf47pcsLDsjFzonpFBFgQB8a5qLSNSpmvFQZ80lYKw3ag
        pyodFzxBicGEFlu6u5Wxy96Oxa+fRtNHjqy+bATLepP7JWWbUqnlbPB0ORTF7ICW4i9zvdK84iDN5
        AjmOCbFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb3LR-005msd-Lj; Mon, 26 Apr 2021 15:40:26 +0000
Date:   Mon, 26 Apr 2021 16:40:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [RFC PATCH] f2fs: restructure f2fs page.private layout
Message-ID: <20210426154021.GN235567@casper.infradead.org>
References: <20210426100908.109435-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426100908.109435-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 06:09:08PM +0800, Chao Yu wrote:
> Restruct f2fs page private layout for below reasons:
> 
> There are some cases that f2fs wants to set a flag in a page to
> indicate a specified status of page:
> a) page is in transaction list for atomic write
> b) page contains dummy data for aligned write
> c) page is migrating for GC
> d) page contains inline data for inline inode flush
> e) page is verified in merkle tree for fsverity

hm, why do you need to record that?  I would have thought that if a file
is marked as being protected by the merkle tree then any pages read in
would be !uptodate until the merkle tree verification had happened.

> f) page is dirty and has filesystem/inode reference count for writeback
> g) page is temporary and has decompress io context reference for compression
> 
> There are existed places in page structure we can use to store
> f2fs private status/data:
> - page.flags: PG_checked, PG_private
> - page.private
> 
> However it was a mess when we using them, which may cause potential
> confliction:
> 		page.private	PG_private	PG_checked
> a)		-1		set
> b)		-2
> c), d), e)					set
> f)		0		set
> g)		pointer		set
> 
> The other problem is page.flags has no free slot, if we can avoid set
> zero to page.private and set PG_private flag, then we use non-zero value
> to indicate PG_private status, so that we may have chance to reclaim
> PG_private slot for other usage. [1]
> 
> So in this patch let's restructure f2fs' page.private as below:
> 
> Layout A: lowest bit should be 1
> | bit0 = 1 | bit1 | bit2 | ... | bit MAX | private data .... |
>  bit 0	PAGE_PRIVATE_NOT_POINTER
>  bit 1	PAGE_PRIVATE_ATOMIC_WRITE
>  bit 2	PAGE_PRIVATE_DUMMY_WRITE
>  bit 3	PAGE_PRIVATE_ONGOING_MIGRATION
>  bit 4	PAGE_PRIVATE_INLINE_INODE
>  bit 5	PAGE_PRIVATE_REF_RESOURCE
>  bit 6-	f2fs private data
> 
> Layout B: lowest bit should be 0
>  page.private is a wrapped pointer.
> 
> After the change:
> 		page.private	PG_private	PG_checked
> a)		11		set
> b)		101
> c)		1001
> d)		10001
> e)						set
> f)		100001		set
> g)		pointer		set

Mmm ... this isn't enough to let us remove PG_private.  We'd need PG_private
to be set for b,c,d as well.

> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 817d0bcb5c67..e393a67a023c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -444,7 +444,11 @@ static int f2fs_set_meta_page_dirty(struct page *page)
>  	if (!PageDirty(page)) {
>  		__set_page_dirty_nobuffers(page);
>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
> -		f2fs_set_page_private(page, 0);
> +		set_page_private_reference(page);
> +		if (!PagePrivate(page)) {
> +			SetPagePrivate(page);
> +			get_page(page);
> +		}

I'm not a big fan of this pattern (which seems to be repeated quite often)
I think it should be buried within set_page_private_reference().  Also,
are the states abcdf all mutually exclusive, or can a page be in states
(eg) b and d at the same time?

> -		if (IS_DUMMY_WRITTEN_PAGE(page)) {
> -			set_page_private(page, (unsigned long)NULL);
> +		if (page_private_dummy(page)) {
> +			clear_page_private_dummy(page);
>  			ClearPagePrivate(page);

I think the ClearPagePrivate should be buried in the page_private_dummy()
macro too ... and shouldn't there be a put_page() for this too?

