Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0640B3548FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbhDEWu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhDEWuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:50:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C60B610F7;
        Mon,  5 Apr 2021 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617663018;
        bh=jwG/SVA70p3cCFjxeo1Cc4nwxlx4YQ4mgj/uqTiKhzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyXg+H61jDxehfGJrvMJx/iqfyWBFXFGaOqH4c5vN189apZMeIoT5+41PIVQm0dS8
         Unby9nu9GA98/c5cj/jWidXatuzD3LD62GhBs/5IPlvmmsdVEks00LDkFBnex5XvAc
         /kHrrmUDzJ3X6Nldye06AaEkYkCV24HvD/fx5OietwSDrdcAmf3z2zU+S3cd4mLL7x
         WJrUszXA9v1O6A76lCzXthNWQ2rUAx/sEK2zXLe0F/n9Pd3o8pfTNINiWY5oVSeGNu
         OLXoIn1oIHh3S1GSyx48+fgRAjw9ErWxbrirP67W11/goPiiCkg3pYhR+ye2B52KH5
         C7+7BCNiaLhPg==
Date:   Mon, 5 Apr 2021 15:50:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, fazilyildiran@gmail.com
Subject: Re: [PATCH] crypto: fix CRYPTO_LIB_* dependencies on CRYPTO
Message-ID: <YGuUKBPHRqjmjdQd@gmail.com>
References: <20210405150438.177783-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405150438.177783-1-julianbraha@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:04:38AM -0400, Julian Braha wrote:
> Currently, when a config option selects a
> CRYPTO_LIB_* option while CRYPTO is disabled,
> Kbuild gives an unmet dependency. However,
> these config options do not actually need to
> depend on CRYPTO.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 5809cc198fa7..fb7eca5cb8c6 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1870,9 +1870,9 @@ config CRYPTO_STATS
>  config CRYPTO_HASH_INFO
>  	bool
>  
> -source "lib/crypto/Kconfig"
>  source "drivers/crypto/Kconfig"
>  source "crypto/asymmetric_keys/Kconfig"
>  source "certs/Kconfig"
>  
>  endif	# if CRYPTO
> +source "lib/crypto/Kconfig"
> -- 

Actually some of the files in lib/crypto/ do depend on CRYPTO.  For example,
there are calls to crypto_xor_cpy() and crypto_memneq(), which call functions
defined in crypto/algapi.c and crypto/memneq.c.  These helper functions would
need to be moved into lib/crypto/ for this to work.

- Eric
