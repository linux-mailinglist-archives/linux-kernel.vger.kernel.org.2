Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054AC3F749E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHYLyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbhHYLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:54:19 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE8C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-30-ed;
 t=1629892412; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=F52fen2ss8GLg3DqmHwQUgF1KeZ9yP3yjDp0L7IYMzA=;
 b=cCzKgH+ETPVMW8IvDXAajwFev9kHvEnBserO0HqSXr+WkGyVjngBwEl9xKzBGXChv7EF9
 qdXP5Iw6xciYfeQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-30-rsa; t=1629892412; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=F52fen2ss8GLg3DqmHwQUgF1KeZ9yP3yjDp0L7IYMzA=;
 b=I6UGMBHWVdxSlFMi9DGx8Mt+//KROxs0BqUv7KCyjDDeKf7htPZZIH0ZYOuerKXKdvwTc
 ovotaDdVCVJDxWU6QOf8yQ4iQQblAa5iD/eiuYs1+JPCPOHpYePtxPf74ePkJDPERY+njT3
 xKbmsTOghq1QkSJZaxAqDdSX3LdxJ+7y3oJzMhGLhFYrl8wkMYa648nzuliouSb2y6FGdcU
 Wj2LmdQ2L4znC2he0DntiLFySyYx+j2mTPnnbuVY9w1j7dzlgugFS0S2Du9/HHOeq0u793E
 KdRDN2odw3A9JnwpZOUgNwoRlO2raKMYkODM636j6nimwsCJi75FqbRfvInA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id A48EE16099D; Wed, 25 Aug 2021 04:53:32 -0700 (PDT)
Date:   Wed, 25 Aug 2021 04:53:32 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Li RongQing <lirongqing@baidu.com>, dbueso@suse.de,
        mingo@kernel.org, michel@lespinasse.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: stop iteration early in rb_find_first
Message-ID: <20210825115332.GA4645@lespinasse.org>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:39:26PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 25, 2021 at 05:59:48PM +0800, Li RongQing wrote:
> > stop iteration if match is not NULL and result of cmp is
> > not zero, this means the matched node has been found, and
> > the node with same key has been passed
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  include/linux/rbtree.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> > index d31ecaf4fdd3..2689771df9bb 100644
> > --- a/include/linux/rbtree.h
> > +++ b/include/linux/rbtree.h
> > @@ -324,6 +324,9 @@ rb_find_first(const void *key, const struct rb_root *tree,
> >  		} else if (c > 0) {
> >  			node = node->rb_right;
> >  		}
> > +
> > +		if (match && c)
> > +			break;
> >  	}
> >  
> >  	return match;
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

NAK. This looked slightly wrong before, and is more wrong after.

Before:
there was this weird condition  if (c <= 0) {} else if (c > 0) {} ,
making you wonder what the third possibility may be. Easy fix would be
to remove the second condition.

After:
say the key is equal the root, so the code sets match=root and goes left.
Then it stops searching because match is set and c<0.
This doesn't work, the code needs to keep searching for the leftmost match.

--
Michel "walken" Lespinasse
