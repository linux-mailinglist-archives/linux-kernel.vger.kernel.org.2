Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7CD45C773
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355929AbhKXOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355877AbhKXOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:36:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7468C1A3ACD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0eagjiyWCr9C4dEKHRNrT4y4jf0mBVFU+63E9nRYUe0=; b=THFW9Tv08DBQtBHJscFmYp7Us0
        SKgkmP9zJz7RBriYOL61HWtIoJJJuW1OO9NcyhorSAqmoo2m22XSEL/J8AMPYGGHujAq3BbXGbpYU
        4PdA/nobgD8myLFL32K95AytL1KGAgmO6OT4EdsdjWNpQ92TAEBtEoQpJkfFppJVk3LvCAy8b9sEh
        JS0/9wYoQ6tPdBOl8yMPmEF7KbDHQTooF+5gJzHfuKZVgbN70OmkAcrrl1VODUGdht3BayWDh1A6S
        l/SV26/Ib/VFiED1mcJUXYVLIFRkOSK8athcf2pDvggrD4W9+3EW5dDe9wlyVc+GPiRnxLr4D3cHx
        hNNNVI/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpsFS-001tWA-PY; Wed, 24 Nov 2021 13:23:42 +0000
Date:   Wed, 24 Nov 2021 13:23:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Message-ID: <YZ483gwnwTysPt0G@casper.infradead.org>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124030849.34998-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 03:08:49AM +0000, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
> 
> Fix the following coccinelle report:
> ./mm/memory_hotplug.c:2210:2-5:
> WARNING  Use BUG_ON instead of if condition followed by BUG.

What coccinelle script is reporting this?

> -	if (try_remove_memory(start, size))
> -		BUG();
> +	BUG_ON(try_remove_memory(start, size));

I really, really, really do not like this.  For functions with
side-effects, this is bad style.  If it's a pure predicate, then
sure, but this is bad.
