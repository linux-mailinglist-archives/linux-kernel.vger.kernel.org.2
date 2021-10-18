Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB743282A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhJRUKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRUKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F535C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7i+8tzdlX15v2uc/1AFeD1pxJKxbaEOuZd11PWxgJ0=; b=r8m9DNRZ9bpPh5Pa1MuG37G/gw
        drH1gEgJXmKfOAzbmRG3HoShsLYeztQeGkgiEsTfCZRVSFI/+WEOgCjVr2W9N/yj7cjs0P2y9s+8T
        VIE80Lz4L+xIRtqdk+UmamesQ4q2XmB0Ke+5/HESdI8Ul7BL1/rYvV+ZKtmmEX+ru4rD+A+aNoKcS
        /zWylxAHha5ARTcXO/wYi9QqK4f0Z5NLc8Rg85yrhi9Q4vcNZX5Wms9NZ0YExkVuEryu3ig4+KLUn
        ISSIaCj5/JZDj+SemvuQgVLdKrHelFTRQRA+fBwnVMZA3kqV5NZ9J+pEk6BmzvY7WnzT2ZyXIwC/n
        rjs5VrWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcYto-00BEba-Il; Mon, 18 Oct 2021 20:06:35 +0000
Date:   Mon, 18 Oct 2021 21:06:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XArray: Fix xa_to_node by adding xa_is_node
Message-ID: <YW3TvBMSwYmbMPdD@casper.infradead.org>
References: <1634028170-1753612-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634028170-1753612-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:42:50AM +0000, Jiasheng Jiang wrote:
> Directly using xa_to_node may lead to the compulsory type
> conversion of unknown type,which is unsafe.
> So it might be better that adding xa_is_node before.

No.  This is test code, and it knows what it's doing.
I suppose we could add an XA_BUG_ON(xa, !xa_is_node(xa_head(xa)));
but that seems pointless.  This patch is definitely wrong.

> Fixes: 58d6ea3 ("xarray: Add XArray unconditional store operations")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  lib/test_xarray.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
> index 8b1c318..7ad3d51 100644
> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -606,8 +606,10 @@ static noinline void check_multi_store(struct xarray *xa)
>  	XA_BUG_ON(xa, xa_load(xa, 1) != xa_mk_value(0));
>  	XA_BUG_ON(xa, xa_load(xa, 2) != NULL);
>  	rcu_read_lock();
> -	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 2);
> -	XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 2);
> +	if (xa_is_node(xa_head(xa))) {
> +		XA_BUG_ON(xa, xa_to_node(xa_head(xa))->count != 2);
> +		XA_BUG_ON(xa, xa_to_node(xa_head(xa))->nr_values != 2);
> +	}
>  	rcu_read_unlock();
>  
>  	/* Storing adjacent to the value does not alter the value */
> -- 
> 2.7.4
> 
