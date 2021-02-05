Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325533103C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBEDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:39:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54524 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhBEDjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:39:44 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7rxH-0002aV-CJ; Fri, 05 Feb 2021 14:38:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Feb 2021 14:38:47 +1100
Date:   Fri, 5 Feb 2021 14:38:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, arndb@kernel.org,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 2/2] crypto: crypto4xx - Avoid linking failure with
 HW_RANDOM=m
Message-ID: <20210205033847.GB14594@gondor.apana.org.au>
References: <20210130225540.1639-1-f.fainelli@gmail.com>
 <20210130225540.1639-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130225540.1639-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 02:55:38PM -0800, Florian Fainelli wrote:
> It is currently possible to build CONFIG_HW_RANDOM_PPC4XX=y with
> CONFIG_HW_RANDOM=m which would lead to the inability of linking with
> devm_hwrng_{register,unregister}. We cannot have the framework modular
> and the consumer of that framework built-in, so make that dependency
> explicit.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
