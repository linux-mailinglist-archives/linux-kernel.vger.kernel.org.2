Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF5310053
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBDWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhBDWve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:51:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3964164DF2;
        Thu,  4 Feb 2021 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612479053;
        bh=b7/DOj8yTlW6Ki/g1Nc/XJAKb54ufx8aB1nPTSLqICE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzRCGR/cnuI3jleZl+vzmr2fvdF5hwb1L6+HFRotP9Lu9fxtmlk//iL9GG23sX57C
         oCH5OzkdwoZ32vLUd1fhYkGcKCvzc+GeoHnp3AS7U9b10cIeDMgypRxRhdHRZVW1CJ
         SSHiSyDb0az5L6Z0os5cvwvECm117Mc9jkqOg7Gb8nJYgIO4+O5KF8XoagiwE3JFdZ
         uqet2yZl03S+QF/DBOqsUnEx8OYNZ1WEzACB+JVI3vWJ4r17Aqbo4ZuYNrt2P0au70
         uOh0nGTtiy78Fmt+O2acdrNlm6YmgNpi4HcpFm9ULA1OjvKULnyUkJh+2lmctdNMUW
         S2FoeLYxz1z3w==
Date:   Thu, 4 Feb 2021 14:50:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org, ardb@kernel.org,
        sivaprak@codeaurora.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/11] crypto: qce: skcipher: Return error for
 non-blocksize data(ECB/CBC algorithms)
Message-ID: <YBx6S+up7YD2eCuU@gmail.com>
References: <20210204214359.1993065-1-thara.gopinath@linaro.org>
 <20210204214359.1993065-7-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204214359.1993065-7-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:43:54PM -0500, Thara Gopinath wrote:
> +	/*
> +	 * ECB and CBC algorithms require message lengths to be
> +	 * multiples of block size.
> +	 * TODO: The spec says AES CBC mode for certain versions
> +	 * of crypto engine can handle partial blocks as well.
> +	 * Test and enable such messages.
> +	 */
> +	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
> +		if (!IS_ALIGNED(req->cryptlen, blocksize))
> +			return -EINVAL;

CBC by definition only operates on full blocks, so the TODO doesn't make sense.
Is the partial block support really CTS-CBC?

- Eric
