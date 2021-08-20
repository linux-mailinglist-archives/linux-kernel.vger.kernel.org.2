Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D13F2871
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhHTIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:32:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53678 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhHTIcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:32:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mGzvp-00022Y-UW; Fri, 20 Aug 2021 16:31:17 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mGzvj-0007Py-39; Fri, 20 Aug 2021 16:31:11 +0800
Date:   Fri, 20 Aug 2021 16:31:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
Subject: Re: [PATCH] crypto: xts_crypt() return if walk.nbytes is 0
Message-ID: <20210820083111.GA28484@gondor.apana.org.au>
References: <YQ0Qm+Xs1g/7Eant@fedora>
 <20210809141027.860850-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141027.860850-1-chouhan.shreyansh630@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 07:40:27PM +0530, Shreyansh Chouhan wrote:
> xts_crypt() code doesn't call kernel_fpu_end() after calling
> kernel_fpu_begin() if walk.nbytes is 0. The correct behavior should be
> not calling kernel_fpu_begin() if walk.nbytes is 0.
> 
> Reported-by: syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> ---
>  arch/x86/crypto/aesni-intel_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
> index 388643ca2177..ec6eac57c493 100644
> --- a/arch/x86/crypto/aesni-intel_glue.c
> +++ b/arch/x86/crypto/aesni-intel_glue.c
> @@ -849,7 +849,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
>  		return -EINVAL;
>  
>  	err = skcipher_walk_virt(&walk, req, false);
> -	if (err)
> +	if (err || !walk.nbytes)
>  		return err;

The err check is now redundant because when there is an error
nbytes is always zero.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
