Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008953E3DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhHIBmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhHIBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:42:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD952C061757
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 18:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1D7dya4yNEJGvVPgKcmZOdRIp21tqqrRzKcYvvkpGJg=; b=M/HyrZHVc9XfP9qdeuLvEqoq5w
        APIm4ybWwEqN1SoqlL5aOCqnbyBsBFSIQeAquWa/0ExCObM50+5u6/ZBxT7dMKRyowmvcSd83L8v0
        CgtJcFk3a0CpY3ca8fOAkAqnbAmB/yPJ2YcR7f4G45GvMVBMg2GhD7wAfWo2dcksnkL4isP9en4ZD
        zANHuy/KNXBAi/8KWzXuxo7UAAhk3B5VHW1mjjxCc3GcT5ePwKETo4zO/vjN4K3fcXyeIpxlhGlOY
        DdXmXGJUOLqwIyrbsN+cpprQ06EwFqEGfMAWTc0gs1ysIwnWGfa09fdjZPs/g925m+MfuJPnZsFS6
        OUM+vhLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCuGa-00ATUq-38; Mon, 09 Aug 2021 01:40:00 +0000
Date:   Mon, 9 Aug 2021 02:39:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/gup: documentation corrections for gup/pup
Message-ID: <YRCHZObkj/BJgCmR@casper.infradead.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808235018.1924918-2-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 04:50:16PM -0700, John Hubbard wrote:
> @@ -103,8 +103,14 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>   * same time. (That's true throughout the get_user_pages*() and
>   * pin_user_pages*() APIs.) Cases:
>   *
> - *    FOLL_GET: page's refcount will be incremented by 1.
> - *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
> + *    FOLL_GET: page's refcount will be incremented by refs.

I think this would read more clearly if it said @refs (throughout).

> + *
> + *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
> + *        be incremented by refs, and page[2].hpage_pinned_refcount will be
> + *        incremented by refs * GUP_PIN_COUNTING_BIAS.
> + *
> + *    FOLL_PIN on normal pages, or compound pages that are two pages long:
> + *        page's refcount will be incremented by refs * GUP_PIN_COUNTING_BIAS.
>   *
>   * Return: head page (with refcount appropriately incremented) for success, or
>   * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's

Did you run 'make htmldocs' and see how it renders?  I haven't looked,
but this might work better as an rst list?

