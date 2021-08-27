Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09603F9653
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbhH0Ijl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:39:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54418 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244621AbhH0Ijk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:39:40 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mJXNr-0007cn-Cy; Fri, 27 Aug 2021 16:38:43 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mJXNq-0005ev-9D; Fri, 27 Aug 2021 16:38:42 +0800
Date:   Fri, 27 Aug 2021 16:38:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sha512: remove imaginary and mystifying clearing
 of variables
Message-ID: <20210827083842.GF21571@gondor.apana.org.au>
References: <20210822103107.28974-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822103107.28974-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 12:31:07PM +0200, Lukas Bulwahn wrote:
> The function sha512_transform() assigns all local variables to 0 before
> returning to its caller with the intent to erase sensitive data.
> 
> However, make clang-analyzer warns that all these assignments are dead
> stores, and as commit 7a4295f6c9d5 ("crypto: lib/sha256 - Don't clear
> temporary variables") already points out for sha256_transform():
> 
>   The assignments to clear a through h and t1/t2 are optimized out by the
>   compiler because they are unused after the assignments.
> 
>   Clearing individual scalar variables is unlikely to be useful, as they
>   may have been assigned to registers, and even if stack spilling was
>   required, there may be compiler-generated temporaries that are
>   impossible to clear in any case.
> 
> This applies here again as well. Drop meaningless clearing of local
> variables and avoid this way that the code suggests that data is erased,
> which simply does not happen.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  crypto/sha512_generic.c | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
