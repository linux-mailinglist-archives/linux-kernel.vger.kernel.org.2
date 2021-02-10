Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D529315FED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhBJHWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:22:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50174 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhBJHW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:22:28 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9joV-0001En-JY; Wed, 10 Feb 2021 18:21:28 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:21:27 +1100
Date:   Wed, 10 Feb 2021 18:21:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Srujana Challa <schalla@marvell.com>,
        Suheil Chandran <schandran@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell - CRYPTO_DEV_OCTEONTX2_CPT should depend
 on ARCH_THUNDER2
Message-ID: <20210210072127.GA4493@gondor.apana.org.au>
References: <20210201134431.699419-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201134431.699419-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 02:44:31PM +0100, Geert Uytterhoeven wrote:
> The Marvell OcteonTX2 CPT physical function PCI device is present only
> on OcteonTx2 SoC, and not available as an independent PCIe endpoint.
> Hence add a dependency on ARCH_THUNDER2, to prevent asking the user
> about this driver when configuring a kernel without OcteonTx2 platform
> support.
> 
> Fixes: 5e8ce8334734c5f2 ("crypto: marvell - add Marvell OcteonTX2 CPT PF driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/crypto/marvell/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
