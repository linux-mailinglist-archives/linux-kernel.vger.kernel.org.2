Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF43E4046
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhHIGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhHIGkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:40:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD5C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UOfsezeh2Rb2IHtiMvyy621DrExWSUzedq6b1M16AvE=; b=uzvq4Qo0mtKVu0YIlmp1mW0eek
        X/hjctzSksRyyLoyzQveO6Yko4Obw+RfWgBi/ltcaxWjZ6/RTyRlKUBzx7+Tt8CafYWhMz9cU+Zft
        2LUQvkci7hUaizGb98YLijBrxYvPExZBLf+8Mw/peK9ipZqy7yvkYOojRYG0MsPlWp+sNAQhCRxHi
        mFvDlLHfozvD23UAYrLGhsrTLN7iTHkS38ZhObcEBmqweB1JJLWw4Keskwmrd3bQz8J7oxCaOwJq8
        DKuz4oFxslJT5LfLzWnnrynYtfLtCHZZEAewnEe15ap6ES6twT7waZ46QeG4W2YLOuMrbBLjJthUB
        nZ04TlAg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyvx-00AiNV-H2; Mon, 09 Aug 2021 06:38:56 +0000
Date:   Mon, 9 Aug 2021 07:38:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/gup: small refactoring: simplify try_grab_page()
Message-ID: <YRDNeZZQxUzbFxrQ@infradead.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808235018.1924918-3-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 04:50:17PM -0700, John Hubbard wrote:
> try_grab_page() does the same thing as try_grab_compound_head(...,
> refs=1, ...), just with a different API. So there is a lot of code
> duplication there.
> 
> Change try_grab_page() to call try_grab_compound_head(), while keeping
> the API contract identical for callers.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 5cb18b62921c..4be6f060fa0b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -203,33 +203,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>   */
>  bool __must_check try_grab_page(struct page *page, unsigned int flags)
>  {
> +	if (flags & (FOLL_GET | FOLL_PIN))
> +		return try_grab_compound_head(page, 1, flags) != NULL;
>  
>  	return true;

Nit: something like:

	if (!(flags & (FOLL_GET | FOLL_PIN)))
		return true;
	return try_grab_compound_head(page, 1, flags) != NULL;

would be a little easier to read.
