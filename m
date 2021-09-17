Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9140F061
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbhIQDXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:23:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55258 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243767AbhIQDXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:23:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4RW-0006Fs-ON; Fri, 17 Sep 2021 11:21:38 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4RT-0001mt-5Z; Fri, 17 Sep 2021 11:21:35 +0800
Date:   Fri, 17 Sep 2021 11:21:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] crypto: x86/aes-ni - check walk.nbytes instead of err
Message-ID: <20210917032135.GI6559@gondor.apana.org.au>
References: <20210911110759.40911-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911110759.40911-1-chouhan.shreyansh630@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 04:37:59PM +0530, Shreyansh Chouhan wrote:
> In the code for xts_crypt(), we check for the err value returned by
> skcipher_walk_virt() and return from the function if it is non zero.
> However, skcipher_walk_virt() can set walk.nbytes to 0, which would cause
> us to call kernel_fpu_begin(), and then skip the kernel_fpu_end() call.
> 
> This patch checks for the walk.nbytes value instead, and returns if
> walk.nbytes is 0. This prevents us from calling kernel_fpu_begin() in
> the first place and also covers the case of having a non zero err value
> returned from skcipher_walk_virt().
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> ---
>  arch/x86/crypto/aesni-intel_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
