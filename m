Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4838F53F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhEXV7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhEXV7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0139161403;
        Mon, 24 May 2021 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621893472;
        bh=mT2xSuaz7GfCwIuGVfSy11J/JNH1BcBFokdxMEzAXCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5HWxNpaLfusJXb1UsoaR1Ao6nLHxOw108FYU8AyYlZ99PhyTvL8wygw7Mf7FtTw/
         IuIvU8amvov34lCweXLN6Qo3+StJncqYsSu+i648fRZtO7lcl7DU6sJgDxEydUcO+6
         rfuaLxBM8/rDotVM3/S9fYrZs+/V26b931rtkU43Fwq7RhCOLIxcGlwishI5RiZ7sy
         0LZCWnfm1ekNDri6+Nn2HcfNfAaVzFDmCAtv6TgD1ZO/YtYb4+Pc9DHCD9fEL14oFj
         Wa9oHGRP2Lbre+3vN6dYrAgHoGBU7/Z06yRB73PisdPLjSBldLdqrHRixmuXx18nmj
         z3dRqG7lgwCJA==
Date:   Mon, 24 May 2021 14:57:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: algboss - Replaced simple_strtol() with
 kstrtouint()
Message-ID: <YKwhXlrJzdOjS9lJ@gmail.com>
References: <20210524120834.1580343-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524120834.1580343-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:08:34PM +0800, Liu Shixin wrote:
> The simple_strtol() function is deprecated in some situation since
> it does not check for the range overflow. Use kstrtouint() instead.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  crypto/algboss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/algboss.c b/crypto/algboss.c
> index 5ebccbd6b74e..64bb8dab9584 100644
> --- a/crypto/algboss.c
> +++ b/crypto/algboss.c
> @@ -140,8 +140,8 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
>  			param->attrs[i].nu32.attr.rta_len =
>  				sizeof(param->attrs[i].nu32);
>  			param->attrs[i].nu32.attr.rta_type = CRYPTOA_U32;
> -			param->attrs[i].nu32.data.num =
> -				simple_strtol(name, NULL, 0);
> +			if (unlikely(kstrtouint(name, 0, &param->attrs[i].nu32.data.num)))
> +				goto err_free_param;

It would be better to just remove all the code related to CRYPTOA_U32 and
crypto_attr_u32, as it is never used.

- Eric
