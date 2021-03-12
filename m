Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E0338E22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhCLNCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:02:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54378 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhCLNCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:02:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhQM-000605-HG; Sat, 13 Mar 2021 00:01:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:01:50 +1100
Date:   Sat, 13 Mar 2021 00:01:50 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] crypto: qce: Add support for AEAD algorithms
Message-ID: <20210312130150.GA17238@gondor.apana.org.au>
References: <20210225182716.1402449-1-thara.gopinath@linaro.org>
 <20210225182716.1402449-5-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225182716.1402449-5-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:27:13PM -0500, Thara Gopinath wrote:
>
> +static int
> +qce_aead_async_req_handle(struct crypto_async_request *async_req)
> +{
> +	struct aead_request *req = aead_request_cast(async_req);
> +	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
> +	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
> +	struct qce_aead_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
> +	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
> +	struct qce_device *qce = tmpl->qce;
> +	enum dma_data_direction dir_src, dir_dst;
> +	unsigned int totallen;
> +	bool diff_dst;
> +	int ret;
> +
> +	if (IS_CCM_RFC4309(rctx->flags)) {
> +		memset(rctx->ccm_rfc4309_iv, 0, QCE_MAX_IV_SIZE);
> +		rctx->ccm_rfc4309_iv[0] = 3;
> +		memcpy(&rctx->ccm_rfc4309_iv[1], ctx->ccm4309_salt, QCE_CCM4309_SALT_SIZE);
> +		memcpy(&rctx->ccm_rfc4309_iv[4], req->iv, 8);
> +		rctx->iv = rctx->ccm_rfc4309_iv;
> +		rctx->ivsize = AES_BLOCK_SIZE;
> +	} else {
> +		rctx->iv = req->iv;
> +		rctx->ivsize = crypto_aead_ivsize(tfm);
> +	}
> +	if (IS_CCM_RFC4309(rctx->flags))
> +		rctx->assoclen = req->assoclen - 8;
> +	else
> +		rctx->assoclen = req->assoclen;
> +
> +	totallen = rctx->cryptlen + rctx->assoclen;

This triggers a warning on totallen not being used.  Please fix.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
