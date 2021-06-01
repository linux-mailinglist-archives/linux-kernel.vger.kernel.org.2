Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B8393D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhE1HHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:07:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49854 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhE1HHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:07:10 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWYc-0003HJ-5Y; Fri, 28 May 2021 15:05:22 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWYR-0005t1-99; Fri, 28 May 2021 15:05:11 +0800
Date:   Fri, 28 May 2021 15:05:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linus.walleij@linaro.org,
        linux@armlinux.org.uk, robh+dt@kernel.org,
        ulli.kroll@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] crypto: Add sl3516 crypto engine
Message-ID: <20210528070511.GA22601@gondor.apana.org.au>
References: <20210518151655.125153-1-clabbe@baylibre.com>
 <20210518151655.125153-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518151655.125153-3-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:16:52PM +0000, Corentin Labbe wrote:
>
> +static int sl3516_ce_cipher_fallback(struct skcipher_request *areq)
> +{
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
> +	struct sl3516_ce_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> +	struct sl3516_ce_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
> +	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
> +	struct sl3516_ce_alg_template *algt;
> +	int err;
> +
> +	algt = container_of(alg, struct sl3516_ce_alg_template, alg.skcipher);
> +	algt->stat_fb++;

This fails to build if CRYPTO_DEV_SL3516_DEBUG is off.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
