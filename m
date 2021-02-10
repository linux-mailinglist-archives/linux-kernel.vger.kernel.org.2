Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC931600D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhBJH07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:26:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50354 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhBJHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:25:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jr5-0001Ii-En; Wed, 10 Feb 2021 18:24:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:24:07 +1100
Date:   Wed, 10 Feb 2021 18:24:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Suheil Chandran <schandran@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] crypto: octeontx2 - fix -Wpointer-bool-conversion
 warning
Message-ID: <20210210072407.GM4493@gondor.apana.org.au>
References: <20210204154230.1702563-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204154230.1702563-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:42:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_CPUMASK_OFFSTACK is disabled, clang reports a warning
> about a bogus condition:
> 
> drivers/crypto/marvell/octeontx2/otx2_cptlf.c:334:21: error: address of array 'lfs->lf[slot].affinity_mask' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>                 if (lfs->lf[slot].affinity_mask)
>                 ~~  ~~~~~~~~~~~~~~^~~~~~~~~~~~~
> 
> In this configuration, the free_cpumask_var() function does nothing,
> so the condition could be skipped.
> 
> When the option is enabled, there is no warning, but the check
> is also redundant because free_cpumask_var() falls back to kfree(),
> which is documented as ignoring NULL pointers.
> 
> Remove the check to avoid the warning.
> 
> Fixes: 64506017030d ("crypto: octeontx2 - add LF framework")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/marvell/octeontx2/otx2_cptlf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
