Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE1407421
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhIKAJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIKAJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:09:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2840E61153;
        Sat, 11 Sep 2021 00:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631318873;
        bh=Q/iD1S0/iT+IxBBe9kh++hPn6RGB3OaQo3wV+nIuWMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5fL1NBQ6U99jc9jT5zb+Ul3+BzhTOeCewF4MQ5AuB5c8HzcccxsqCMM39euaK+Ud
         nMvavOOjY7D2XcF2zLVqoRU7TjFKRRbl8YiLvO9mA0kpKOqHIfrFwevhInMP3niflE
         XlrEzsA/HjhfmiVkyBrtz5XuehXu5ktO3TRbEagqqxDSfyjQMCR9uCrIx7ljrIjZ90
         KuHpJVUTkst2IeZZyzdmS5mCR+gueB5Su3+tyK1vbnVFePmik44ytxjmFM1w9WQYID
         V05Hy4L5opr0wz4cw33NNPsi9p3GnMGG+dTcyvMOKKPr/DckAFffRftt0s5cwPrxV6
         j0s1SHisqngrw==
Date:   Fri, 10 Sep 2021 17:07:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] mm/ksm: remove old GCC 4.9+ check
Message-ID: <YTvzU9qe6vV2Dwpp@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-4-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:40PM -0700, Nick Desaulniers wrote:
> The minimum supported version of GCC has been raised to GCC 5.1.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

This is technically new for clang but arm64 allmodconfig does not
complain.

> ---
>  mm/ksm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 025338128cd9..a5716fdec1aa 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -651,10 +651,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>  	 * from &migrate_nodes. This will verify that future list.h changes
>  	 * don't break STABLE_NODE_DUP_HEAD. Only recent gcc can handle it.

Probably worth removing the recent GCC comment.

>  	 */
> -#if defined(GCC_VERSION) && GCC_VERSION >= 40903
>  	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <= &migrate_nodes);
>  	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >= &migrate_nodes + 1);
> -#endif
>  
>  	if (stable_node->head == &migrate_nodes)
>  		list_del(&stable_node->list);
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
