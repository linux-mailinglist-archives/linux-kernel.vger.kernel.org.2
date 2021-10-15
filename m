Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D195C42F106
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhJOMjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhJOMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:39:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA8C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bLMlIGZRWtJG5pdz8uzZaobV5511jJzZGIeS5RrEQlA=; b=dTvSQqRlNUuDdupsVJe/26lTrb
        sqieoyjQM+BFfZ2yQhFU/HiRNOpjWcaiFp4nb7+h/qFQ0Jun5nCI9Pcp1v78/KHTwt51ZAuMpNHsV
        R9LT5vv4gWpbM1KSLNtxXbOJsoM2XCi/1N/uQG2En82V8smzln0tV8pH4Fnlxl2c9WKumeDEqoYuY
        OCn92q7gM2EFnBSMZzGFFT3TiGPROBJS+9zTgVT9JO51NfQeG3DvrwhrFW2n3F8/Ia/YAdZhhWgfk
        qNrcwTOfu1PRElsZtS8Y6pzt5tE9y1efVwpHSiM661d+htuXZ+GsuMz7QwL5wUeiV3LCEQh+g/jsD
        MqXlJQWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbMRJ-0090ze-0Z; Fri, 15 Oct 2021 12:36:11 +0000
Date:   Fri, 15 Oct 2021 13:35:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     hch@infradead.org, akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] mm: backing-dev: use kfree_rcu() instead of
 synchronize_rcu_expedited()
Message-ID: <YWl1rDO6gCFJE4hp@casper.infradead.org>
References: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
 <YWgTZjDtZik/9l4J@casper.infradead.org>
 <CALm+0cUt7iD5zex4-hRv=i1wPd66tz3JYGHz8P8ZFTZcyOCD1A@mail.gmail.com>
 <d697d61e-27a2-a25c-3ae1-e41457d08705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d697d61e-27a2-a25c-3ae1-e41457d08705@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:06:02PM +0800, Zqiang wrote:
> 
> On 2021/10/15 上午10:57, Qiang Zhang wrote:
> > 
> > 
> > Matthew Wilcox <willy@infradead.org <mailto:willy@infradead.org>>
> > 于2021年10月14日周四 下午7:26写道：
> > 
> >     On Thu, Oct 14, 2021 at 04:24:33PM +0800, Zqiang wrote:
> >     > The bdi_remove_from_list() is called in RCU softirq, however the
> >     > synchronize_rcu_expedited() will produce sleep action, use
> >     kfree_rcu()
> >     > instead of it.
> >     >
> >     > Reported-by: Hao Sun <sunhao.th@gmail.com
> >     <mailto:sunhao.th@gmail.com>>
> >     > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com
> >     <mailto:qiang.zhang1211@gmail.com>>
> >     > ---
> >     >  include/linux/backing-dev-defs.h | 1 +
> >     >  mm/backing-dev.c                 | 4 +---
> >     >  2 files changed, 2 insertions(+), 3 deletions(-)
> >     >
> >     > diff --git a/include/linux/backing-dev-defs.h
> >     b/include/linux/backing-dev-defs.h
> >     > index 33207004cfde..35a093384518 100644
> >     > --- a/include/linux/backing-dev-defs.h
> >     > +++ b/include/linux/backing-dev-defs.h
> >     > @@ -202,6 +202,7 @@ struct backing_dev_info {
> >     >  #ifdef CONFIG_DEBUG_FS
> >     >       struct dentry *debug_dir;
> >     >  #endif
> >     > +     struct rcu_head rcu;
> >     >  };
> > 
> >     >Instead of growing struct backing_dev_info, it seems to me this
> >     rcu_head
> >     >could be placed in a union with rb_node, since it will have been
> >     removed
> >     >from the bdi_tree by this point and the tree is never walked under
> >     >RCU protection?
> > 
> > 
> > Thanks for your advice, I find this bdi_tree is traversed under the
> > protection of a spin lock, not under the protection of RCU.
> > I find this modification does not avoid the problem described in patch,
> > the flush_delayed_work() may be called in release_bdi()
> > The same will cause problems.
> > may be  we can replace queue_rcu_work() of call_rcu(&inode->i_rcu,
> > i_callback) or do you have any better suggestions?

What?  All I was suggesting was:

+++ b/include/linux/backing-dev-defs.h
@@ -168,7 +168,10 @@ struct bdi_writeback {
 
 struct backing_dev_info {
        u64 id;
-       struct rb_node rb_node; /* keyed by ->id */
+       union {
+               struct rb_node rb_node; /* keyed by ->id */
+               struct rcu_head rcu;
+       };
        struct list_head bdi_list;
        unsigned long ra_pages; /* max readahead in PAGE_SIZE units */
        unsigned long io_pages; /* max allowed IO size */


Christoph, independent of the inode lifetime problem, this actually seems
like a good approach to take.  I don't see why we should synchronize_rcu()
here?  Adding Jens (original introducer of the synchronize_rcu()), Mikulas
(converted it to use _expedited) and Tejun (worked around a problem when
using _expedited).
