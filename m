Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADD63F7474
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhHYLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhHYLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:40:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bc1KbfnaTqDrF8y48kYjRemdc6677tvooRZyXgt+vD0=; b=re2VTTA9IZibuCbSCWgnTiZmYp
        PfzcoldWjFgZGHHZ+DK9xpOpb3zk79sBN8ewrSVj7qD7dHyXfAn2lkcYr3tmA24oEy7fdCspH53Nq
        zk/OJhFyeUgsQNX8XwxxPw5FTIZ/9b3ZqlUKivYa7+1CUb5jF10CM0nfOJU+tf1Zcq4p63DVTBDvS
        sy+WSEuVDJqbFvopnxJeubL37UlgqqJJ9+azXOpQP9KzkmIBYqTXNXljF2mo2stu+dCLuJfJDryKE
        UbDxl5MB/RjvEeukKeRsAqH/ivYRic6ZYKlX+WItLRfyy/vNjzxyce67+Qa7qnf3DDnzypXjxRuLc
        ifKSC+oQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIrFg-00CtXY-Lh; Wed, 25 Aug 2021 11:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D72A63005AD;
        Wed, 25 Aug 2021 13:39:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C40562D862728; Wed, 25 Aug 2021 13:39:26 +0200 (CEST)
Date:   Wed, 25 Aug 2021 13:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     dbueso@suse.de, mingo@kernel.org, michel@lespinasse.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: stop iteration early in rb_find_first
Message-ID: <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:59:48PM +0800, Li RongQing wrote:
> stop iteration if match is not NULL and result of cmp is
> not zero, this means the matched node has been found, and
> the node with same key has been passed
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/linux/rbtree.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> index d31ecaf4fdd3..2689771df9bb 100644
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -324,6 +324,9 @@ rb_find_first(const void *key, const struct rb_root *tree,
>  		} else if (c > 0) {
>  			node = node->rb_right;
>  		}
> +
> +		if (match && c)
> +			break;
>  	}
>  
>  	return match;

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
