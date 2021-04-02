Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6C3526DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhDBHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:12:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51434 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhDBHMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:12:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSDyk-0001JW-7X; Fri, 02 Apr 2021 18:12:27 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 18:12:26 +1100
Date:   Fri, 2 Apr 2021 18:12:26 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meng Yu <yumeng18@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org, shenyang39@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/hpre - rsa key should not be empty
Message-ID: <20210402071225.GA10423@gondor.apana.org.au>
References: <1616739212-7751-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616739212-7751-1-git-send-email-yumeng18@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:13:32PM +0800, Meng Yu wrote:
> We should ensure key is not empty before we set key.
> 
> Signed-off-by: Meng Yu <yumeng18@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
> index 53068d2..7cf7d80 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
> @@ -1093,6 +1093,9 @@ static int hpre_rsa_setpubkey(struct crypto_akcipher *tfm, const void *key,
>  	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
>  	int ret;
>  
> +	if (!key || !keylen)
> +		return -EINVAL;
> +
>  	ret = crypto_akcipher_set_pub_key(ctx->rsa.soft_tfm, key, keylen);

Does this fix a real bug? Wouldn't the soft fallback setkey catch
this anyhow?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
