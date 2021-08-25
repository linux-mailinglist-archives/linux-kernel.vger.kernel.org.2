Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D13F7514
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbhHYMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhHYMbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:31:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cVCsEvgpuB30/YwS0B7Aw8ATSnSu86nG7aMoMbq848o=; b=D+aNhA8YVeSLjPat8xKgb4eoGE
        vn8ohz7NkmFYuTPmSsvLjSfJ30uPe0kUhfj+rs2pFx/yvPkt7+4zR4QK7ts+v+weRgA/H81wvwKzM
        MYxqxxtuZNQQ1Ogkal4SZC+X2rZ2EbdZh9S8pbMdnvwg4SePbCAgD2QPGXkZB/bQ2c1/1fltM6gzj
        FgF+kzAxUI8jTxS7hcZz7lXVAyXlarq50R4DJRHFZeZJDkWaQ5nP+AzlQwJe8ec2nuQHVtjPyrGn7
        h4Bi6HPoyrcBZZJd+Mu2fMh2P2X2ZCxSIWCdRROGGJKQHw5WADkrCH7fL5hIeOWeBXP0n8bqSGsFW
        KUlNMG7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIs1w-00CI3p-5w; Wed, 25 Aug 2021 12:29:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA476300593;
        Wed, 25 Aug 2021 14:29:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74F462D86274A; Wed, 25 Aug 2021 14:29:19 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:29:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Li RongQing <lirongqing@baidu.com>, dbueso@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: stop iteration early in rb_find_first
Message-ID: <YSY3nwCY/IDl1hpj@hirez.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825115332.GA4645@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:53:32AM -0700, Michel Lespinasse wrote:
> On Wed, Aug 25, 2021 at 01:39:26PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 25, 2021 at 05:59:48PM +0800, Li RongQing wrote:
> > > stop iteration if match is not NULL and result of cmp is
> > > not zero, this means the matched node has been found, and
> > > the node with same key has been passed
> > > 
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  include/linux/rbtree.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> > > index d31ecaf4fdd3..2689771df9bb 100644
> > > --- a/include/linux/rbtree.h
> > > +++ b/include/linux/rbtree.h
> > > @@ -324,6 +324,9 @@ rb_find_first(const void *key, const struct rb_root *tree,
> > >  		} else if (c > 0) {
> > >  			node = node->rb_right;
> > >  		}
> > > +
> > > +		if (match && c)
> > > +			break;
> > >  	}
> > >  
> > >  	return match;
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> NAK. This looked slightly wrong before, and is more wrong after.
> 
> Before:
> there was this weird condition  if (c <= 0) {} else if (c > 0) {} ,
> making you wonder what the third possibility may be. Easy fix would be
> to remove the second condition.
> 
> After:
> say the key is equal the root, so the code sets match=root and goes left.
> Then it stops searching because match is set and c<0.
> This doesn't work, the code needs to keep searching for the leftmost match.

I'm not following you. If c!=0 the key didn't match. If c<0 the key is
less than the one we're looking for, meaning we've already found the
left-most matching key, idem for c>0.

More specifically, can you draw me a (binary) tree with elements: A B B
B C, such that a search for B might have match set, hit c!=1 and not
have found the leftmost B ?
