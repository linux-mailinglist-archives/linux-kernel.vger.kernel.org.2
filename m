Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12F13EC9F8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhHOPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhHOPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 11:31:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEEC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BqtZWyHni8kDbNBmf64slxfsIzFkikJ2OnJFjbTuna0=; b=Ga8dm3CR4BjqMKW8kRCtDnhubs
        j5ghsILEkYuURH62d+47K5M/te9L9fz/CRdIKFEKEITjyxHwwgIa5OW4g0k+gTHRCSmtt0lizVEQP
        DLP69r6KUQA4IXgHdeSv9u182WlA352C5JM68gKn84lFmuctxdGHV/fDiQF6DJQfGIDrZwlXRkiOX
        yQoLfV+kVv497QkVbphHZBTUJFf8dkSdS811vGE+eomz2rGaDZLX/gq3Rio+LaLp25KjwdqGQZR8l
        iWXYaHo7bHXJEPKX/ceeOqRntknxxu69kwuUyTVX8AhnI993qWB+ti0RIKjU4tOdvCIZ5OG9A3quV
        ONWt7kCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFI65-000Nwd-Ff; Sun, 15 Aug 2021 15:30:55 +0000
Date:   Sun, 15 Aug 2021 16:30:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH -next v2] include/linux/mm.h: move nr_free_buffer_pages
 from swap.h to mm.h
Message-ID: <YRkzKZ7yvKlCehR9@casper.infradead.org>
References: <20210815115057.1511-1-liumh1@shanghaitech.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815115057.1511-1-liumh1@shanghaitech.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 07:50:57PM +0800, Mianhan Liu wrote:
> nr_free_buffer_pages could be exposed through mm.h instead of swap.h.
> The advantage of this change is that it can reduce the obsolete includes.
> For example, net/ipv4/tcp.c wouldn't need swap.h any more since it has
> already included mm.h.
> Moreover, after preprocessing all the files that use nr_free_buffer_pages,
> it turns out that those files have already included mm.h.
> Thus, we can move nr_free_buffer_pages from swap.h to mm.h safely. This change
> will not affect the compilation of other files.

In general, we're trying to move in the other direction; move things out
of mm.h and reduce the number of files which include mm.h.  That said,
I don't see what nr_free_buffer_pages() has to do with the rest of
swap.h, so I'm OK with moving this over.

That said, there are a number of other files which should have swap.h
removed.  eg:

drivers/mmc/core/mmc_test.c:#include <linux/swap.h>             /* For nr_free_buffer_pages() */

and it would be good to check the other files which use
nr_free_buffer_pages() to see if they can have swap.h removed too.

> +++ b/include/linux/mm.h
> @@ -871,6 +871,7 @@ void put_pages_list(struct list_head *pages);
>  void split_page(struct page *page, unsigned int order);
>  void folio_copy(struct folio *dst, struct folio *src);
>  
> +extern unsigned long nr_free_buffer_pages(void);

Please remove the 'extern' while you're moving this.

> +++ b/net/ipv4/tcp.c

If you're interested in cleaning up the headers, it'd be nice if less
of the networking code depended on pagemap.h ...
