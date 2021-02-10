Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273F4315FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhBJHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:19:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50146 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhBJHTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:19:47 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jm1-0001Cj-GR; Wed, 10 Feb 2021 18:18:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:18:53 +1100
Date:   Wed, 10 Feb 2021 18:18:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/11] crypto: qce: skcipher: Return unsupported if
 any three keys are same for DES3 algorithms
Message-ID: <20210210071853.GA30831@gondor.apana.org.au>
References: <20210207143946.2099859-1-thara.gopinath@linaro.org>
 <20210207143946.2099859-5-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207143946.2099859-5-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 09:39:39AM -0500, Thara Gopinath wrote:
>
> +	/*
> +	 * The crypto engine does not support any two keys
> +	 * being the same for triple des algorithms. The
> +	 * verify_skcipher_des3_key does not check for all the
> +	 * below conditions. Return -ENOKEY in case any two keys
> +	 * are the same. Revisit to see if a fallback cipher
> +	 * is needed to handle this condition.
> +	 */
> +	memcpy(_key, key, DES3_EDE_KEY_SIZE);
> +	if (!((_key[0] ^ _key[2]) | (_key[1] ^ _key[3])) |
> +	    !((_key[2] ^ _key[4]) | (_key[3] ^ _key[5])) |
> +	    !((_key[0] ^ _key[4]) | (_key[1] ^ _key[5])))
> +		return -ENOKEY;

This introduces a sparse warning:

  CHECK   ../drivers/crypto/qce/skcipher.c
../drivers/crypto/qce/skcipher.c:241:58: warning: dubious: !x | !y
../drivers/crypto/qce/skcipher.c:242:58: warning: dubious: x | !y

Please make sure that you test your patches with C=1 so that
you don't introduce new sparse warnings.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
