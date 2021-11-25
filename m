Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CC45D179
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbhKYAD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 19:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbhKYAD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:03:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E41C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N9H59bh7/GXkQevh/ImLSYPupHbGEmC2H8FOJaNSSS0=; b=rwnSfONc0LNW3VywsmOQ9cSyA4
        1VnyVJ/TmEB+yaXtOs4FfH4wV2waVVDzG+3pIxik0sf6giKqmmsEAuD5LTFnKurJ2ZerG4B1Wlnpm
        l2n31bKzXnzBZeclw+8XBn/MCeIpjgv+N68PrIkyvL3VhltnXZb6npM5h13B5RHJks9JWQGfKI9mb
        nJFe6DiQmTqJo/W4ukdaaggCmrgu6NLIGcVfwjd3+eU1O+nKLZXfqpOek59pW4Sg/almtBbgHXNy6
        2sOqu2Av+sz5XtbdbX79StoJYC4d55UKhEWkqj4C3FUQo++krpoq74LksG+ko5QrU2nD66zO7p22E
        y8tXn5/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq2Br-003vyo-7v; Thu, 25 Nov 2021 00:00:39 +0000
Date:   Thu, 25 Nov 2021 00:00:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Message-ID: <YZ7SJ8sXtXF4lZ4L@casper.infradead.org>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
 <YZ483gwnwTysPt0G@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ483gwnwTysPt0G@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 01:23:42PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 24, 2021 at 03:08:49AM +0000, cgel.zte@gmail.com wrote:
> > From: chiminghao <chi.minghao@zte.com.cn>
> > 
> > Fix the following coccinelle report:
> > ./mm/memory_hotplug.c:2210:2-5:
> > WARNING  Use BUG_ON instead of if condition followed by BUG.
> 
> What coccinelle script is reporting this?

Maybe I found it?

scripts/coccinelle/misc/bugon.cocci:msg="WARNING: Use BUG_ON instead of if condition followed by BUG.\nPlease make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)"

Julia, Michal, can we delete this script, please?  It's being abused.

> > -	if (try_remove_memory(start, size))
> > -		BUG();
> > +	BUG_ON(try_remove_memory(start, size));
> 
> I really, really, really do not like this.  For functions with
> side-effects, this is bad style.  If it's a pure predicate, then
> sure, but this is bad.
> 
