Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3D3663E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 05:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhDUDLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 23:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhDUDLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:11:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 20:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GBQ0Smm8mdFKrkAGvpD/jxSPjc9gT7AqBW1h5E5t9V8=; b=f4nKLJY7BiD/O7OPYWGbEvaO11
        dQifrrQ/3lAJxNEXQnNoiJBh7GVRQ+SpcjY+VXBoW+pwziMgZzV5yhcNXKFnCnQAoDzwDXXg+zGwL
        1kC4kWNS98BbjtIn8fD9uWJCc0D5PVc1EYyVVTk9leaJ5nSOBz7NPuVjFRcUhpAIxaouubbUIPUfr
        rjjcz8TMgoojom3AkvZFcgUfaYWOEe2NCGUWRMb9KWMOkoXaA+ShYf7c0NYhb1y9WknJXglSyGPp0
        wsKX56br5dvPm1e1q+MfNVFOxMIQJTuEPZ3UvgL52IkYkjuaZAvluYUW34O5Ctph7tUDqvNlRau2s
        1FIl5K9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ3Fr-00FyyG-W8; Wed, 21 Apr 2021 03:10:23 +0000
Date:   Wed, 21 Apr 2021 04:10:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c: use 'ac' from the caller
Message-ID: <20210421031019.GF3596236@casper.infradead.org>
References: <20210421022518.67451-1-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421022518.67451-1-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:25:17AM +0800, Yejune Deng wrote:
> @@ -3045,12 +3044,7 @@ static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
>  	}
>  
>  	STATS_INC_ALLOCMISS(cachep);
> -	objp = cache_alloc_refill(cachep, flags);
> -	/*
> -	 * the 'ac' may be updated by cache_alloc_refill(),
> -	 * and kmemleak_erase() requires its correct value.
> -	 */
> -	ac = cpu_cache_get(cachep);
> +	objp = cache_alloc_refill(cachep, ac, flags);

I think passing 'ac' in is fine (probably?  I don't know this code
deeply), but deleting this call to 'ac' is clearly wrong.  The comment
even tells you that!  I just verified the code, and the comment is
correct.
