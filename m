Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968EF3EA3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhHLLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:36:47 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52732 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhHLLgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:36:45 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mE90J-0003L0-S9; Thu, 12 Aug 2021 19:36:07 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mE90H-00009T-7U; Thu, 12 Aug 2021 19:36:05 +0800
Date:   Thu, 12 Aug 2021 19:36:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     clabbe.montjoie@gmail.com, davem@davemloft.net, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, mchehab+huawei@kernel.org,
        corbet@lwn.net, baijiaju1990@gmail.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ce - use kfree_sensitive to clear and free
 sensitive data
Message-ID: <20210812113605.GA561@gondor.apana.org.au>
References: <20210803125525.72603-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803125525.72603-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 12:55:25PM +0000, Jason Wang wrote:
> The kfree_sensitive is a kernel API to clear sensitive information
> that should not be leaked to other future users of the same memory
> objects and free the memory. Its function is the same as the
> combination  of memzero_explicit and kfree. Thus, we can replace the
> combination APIs with the single kfree_sensitive API.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 9 +++------
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 3 +--
>  2 files changed, 4 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
