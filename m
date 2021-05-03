Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B53715A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhECNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhECNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:06:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFDCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DQbTl//vIVjixreqgyC79VelysZYwDyEAMW8zdisDXw=; b=W4EEXWctgxJIuZ2hkxjABQERgY
        bAcezO4cT0j24kIpC7d20rwb1uvodIKem1j8LDWuScJE6IFiWF96BvXym/xw4eawjD94DktjmBMuq
        TIm9n9mY1sQXKq9AgeLwwt558ZyrkHBSZkcbrDLjdeBrwt0qT3WGdHF/9JRehkx7mBDhGWhgWWf3w
        z2SQDWPXBZe7yt3snPlKvEoTTPZMwGy3eRi2U0mzQ/OJZ+GA9T91HJiuRo6PBiNQmKRXffPTl+jsh
        P0P6f2hoexxoQbwS5vk3YJM/E1ZfiDBbPUHpdg6A4u2gEjDiDQmv1Hs+Wks0Gc+qYa7iG6V95jtoc
        Ovh7Q9MQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldYGC-00F6IW-7H; Mon, 03 May 2021 13:05:21 +0000
Date:   Mon, 3 May 2021 14:05:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Li <chenli@uniontech.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nommu: remove __GFP_HIGHMEM in vmalloc/vzalloc
Message-ID: <20210503130516.GB1847222@casper.infradead.org>
References: <875z00rnp8.wl-chenli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z00rnp8.wl-chenli@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 08:44:51PM +0800, Chen Li wrote:
> 
> From mm/nommu.c:
> void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> {
> 	/*
> 	 *  You can't specify __GFP_HIGHMEM with kmalloc() since kmalloc()
> 	 * returns only a logical address.
> 	 */
> 	return kmalloc(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
> }
> 
> nommu's __vmalloc just uses kmalloc internally and elimitates __GFP_HIGHMEM,
> so it makes no sense to add __GFP_HIGHMEM for nommu's vmalloc/vzalloc.

I think this was originally [1] a copy of vmalloc() from vmalloc.c,
but of course the two have drifted apart over time.  At the time,
vmalloc.c's vmalloc() looked like this:

+void * vmalloc (unsigned long size)
+{
+       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+}

[1] And I do mean originally; this was present in Alan Cox's original
submission of mm/nommu.c in 2002.

This patch makes sense to me, although I don't imagine it makes
much difference.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Chen Li <chenli@uniontech.com>
> ---
>  mm/nommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 5c9ab799c0e6..339a2f2eb1aa 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -233,7 +233,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
>   */
>  void *vmalloc(unsigned long size)
>  {
> -       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM);
> +       return __vmalloc(size, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL(vmalloc);
>  
> @@ -251,7 +251,7 @@ EXPORT_SYMBOL(vmalloc);
>   */
>  void *vzalloc(unsigned long size)
>  {
> -	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
> +	return __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
>  }
>  EXPORT_SYMBOL(vzalloc);
>  
> -- 
> 2.31.1
> 
> 
> 
> 
