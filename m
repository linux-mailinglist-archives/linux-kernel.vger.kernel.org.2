Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF045D014
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 23:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbhKXWbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 17:31:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243729AbhKXWbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:31:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B424A6104F;
        Wed, 24 Nov 2021 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637792872;
        bh=BKz9QA9JFTJnccEGqHOogfldMgA6v13NFeRxPimPlLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=woHezK0AN+uT+ToPYnLfy98/iij0DyElM/2RoJrTntUaLhX+bcelCGpi/e9uUMKK4
         SPEwWzOrEemU5eGIExvHugkjtdrsNnwt/qyNhVxvUHwYXA8Olh/IwGdd64nRU9tq80
         CvqT+9Vzc7U1G6PGEOmhHEMv6ivqOI9P1KX2tNE8=
Date:   Wed, 24 Nov 2021 14:27:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Message-Id: <20211124142751.e48cdcc3aea9e0ef899f4347@linux-foundation.org>
In-Reply-To: <YZ483gwnwTysPt0G@casper.infradead.org>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
        <YZ483gwnwTysPt0G@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 13:23:42 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Nov 24, 2021 at 03:08:49AM +0000, cgel.zte@gmail.com wrote:
> > From: chiminghao <chi.minghao@zte.com.cn>
> > 
> > Fix the following coccinelle report:
> > ./mm/memory_hotplug.c:2210:2-5:
> > WARNING  Use BUG_ON instead of if condition followed by BUG.
> 
> What coccinelle script is reporting this?
> 
> > -	if (try_remove_memory(start, size))
> > -		BUG();
> > +	BUG_ON(try_remove_memory(start, size));
> 
> I really, really, really do not like this.  For functions with
> side-effects, this is bad style.  If it's a pure predicate, then
> sure, but this is bad.

I don't like it either.  Yes, BUG() is special but it's such dangerous
practice.  I'd vote to change coccinelle.
