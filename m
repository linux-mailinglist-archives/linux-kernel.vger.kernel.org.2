Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC75367B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhDVHs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:48:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48816 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235099AbhDVHsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:48:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZU4H-00038P-Vf; Thu, 22 Apr 2021 17:48:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 17:48:09 +1000
Date:   Thu, 22 Apr 2021 17:48:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Siewior <sebastian@breakpoint.cc>,
        Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: camellia: drop duplicate "depends on CRYPTO"
Message-ID: <20210422074809.GK14354@gondor.apana.org.au>
References: <20210418003929.5065-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418003929.5065-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 05:39:29PM -0700, Randy Dunlap wrote:
> All 5 CAMELLIA crypto driver Kconfig symbols have a duplicate
> "depends on CRYPTO" line but they are inside an
> "if CRYPTO"/"endif # if CRYPTO" block, so drop the duplicate "depends"
> lines.
> 
> These 5 symbols still depend on CRYPTO.
> 
> Fixes: 584fffc8b196 ("[CRYPTO] kconfig: Ordering cleanup")
> Fixes: 0b95ec56ae19 ("crypto: camellia - add assembler implementation for x86_64")
> Fixes: d9b1d2e7e10d ("crypto: camellia - add AES-NI/AVX/x86_64 assembler implementation of camellia cipher")
> Fixes: f3f935a76aa0 ("crypto: camellia - add AVX2/AES-NI/x86_64 assembler implementation of camellia cipher")
> Fixes: c5aac2df6577 ("sparc64: Add DES driver making use of the new des opcodes.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Siewior <sebastian@breakpoint.cc>
> Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
>  crypto/Kconfig |    5 -----
>  1 file changed, 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
