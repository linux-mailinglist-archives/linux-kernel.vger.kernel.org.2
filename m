Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05693E2606
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244565AbhHFIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:25:23 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51742 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244184AbhHFIYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:24:04 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mBv8a-00072w-9c; Fri, 06 Aug 2021 16:23:28 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mBv8S-0003PT-Tn; Fri, 06 Aug 2021 16:23:20 +0800
Date:   Fri, 6 Aug 2021 16:23:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
Subject: Re: [PATCH] crypto: add missing kernel_fpu_end() call
Message-ID: <20210806082320.GA12731@gondor.apana.org.au>
References: <20210730134155.1005358-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730134155.1005358-1-chouhan.shreyansh630@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:11:55PM +0530, Shreyansh Chouhan wrote:
> xts_crypt() code doesn't call kernel_fpu_end() after calling
> kernel_fpu_begin() if walk.nbytes is 0. Add a call to kernel_fpu_end()
> for this case.
> 
> Reported-by: syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> ---
>  arch/x86/crypto/aesni-intel_glue.c | 3 +++
>  1 file changed, 3 insertions(+)

Ard?

> diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
> index 2144e54a6c89..bd55a0cd7bde 100644
> --- a/arch/x86/crypto/aesni-intel_glue.c
> +++ b/arch/x86/crypto/aesni-intel_glue.c
> @@ -894,6 +894,9 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
>  			kernel_fpu_begin();
>  	}
>  
> +	if (walk.nbytes == 0)
> +		kernel_fpu_end();
> +
>  	if (unlikely(tail > 0 && !err)) {
>  		struct scatterlist sg_src[2], sg_dst[2];
>  		struct scatterlist *src, *dst;
> -- 
> 2.31.1

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
