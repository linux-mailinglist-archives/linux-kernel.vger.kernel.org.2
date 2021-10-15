Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92442F203
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhJONV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhJONV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:21:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A9C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xLRSIGsUfzGiK6WuxdgtdmvcVSjUeO6E6oJeq4OnRs0=; b=h2XBkXF8LeeKfvMCtxOY2LWz1O
        PwtQgKj1fcUO67xpNiI+6qoPqGj81MgQN6fBwGiIf9OXLpvpxtRrL+yrjULODmqnQdoD+u4ksVtTE
        I+eBkEC7SLHAJ5vnIAVHNBeIFUr8jiqQG0J8a7OYwiqw7qGf66e0ouuEomqkSwOG7kTJYVdk+ox2t
        w3lQdFrNQWFxCSdGi4I5P02SOkYK4Fs8LjOjNpeymKBvPNomKkU4GwPxD3STaelLb1QA6vjiRe2XN
        eJLscyae/TmjoTp069tZiQ/rn+MMi0j64iKYP1uPN+69rcH2RobmXuwo38/euYO3cCLNcEhTBtekr
        2FJIpibQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbN7G-007B1X-1j; Fri, 15 Oct 2021 13:19:18 +0000
Date:   Fri, 15 Oct 2021 06:19:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zqiang <qiang.zhang1211@gmail.com>, hch@infradead.org,
        akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] mm: backing-dev: use kfree_rcu() instead of
 synchronize_rcu_expedited()
Message-ID: <YWl/1gI+O2+PnKhz@infradead.org>
References: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
 <YWgTZjDtZik/9l4J@casper.infradead.org>
 <CALm+0cUt7iD5zex4-hRv=i1wPd66tz3JYGHz8P8ZFTZcyOCD1A@mail.gmail.com>
 <d697d61e-27a2-a25c-3ae1-e41457d08705@gmail.com>
 <YWl1rDO6gCFJE4hp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWl1rDO6gCFJE4hp@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:35:56PM +0100, Matthew Wilcox wrote:
>  struct backing_dev_info {
>         u64 id;
> -       struct rb_node rb_node; /* keyed by ->id */
> +       union {
> +               struct rb_node rb_node; /* keyed by ->id */
> +               struct rcu_head rcu;
> +       };
>         struct list_head bdi_list;
>         unsigned long ra_pages; /* max readahead in PAGE_SIZE units */
>         unsigned long io_pages; /* max allowed IO size */
> 
> 
> Christoph, independent of the inode lifetime problem, this actually seems
> like a good approach to take.  I don't see why we should synchronize_rcu()
> here?  Adding Jens (original introducer of the synchronize_rcu()), Mikulas
> (converted it to use _expedited) and Tejun (worked around a problem when
> using _expedited).

The kfree+rcu + your suggestion does seem like a good idea in general to
me.  But I'd still like to fix the actual bug being reported before
optimizing the area in a way that papers over the bug.
