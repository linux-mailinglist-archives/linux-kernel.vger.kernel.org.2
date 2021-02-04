Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13030FD37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbhBDTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:48:51 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52792 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237778AbhBDTsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:48:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7kbT-0002p1-LE; Fri, 05 Feb 2021 06:47:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Feb 2021 06:47:47 +1100
Date:   Fri, 5 Feb 2021 06:47:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Suheil Chandran <schandran@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: marvell - fix ethernet driver dependency
Message-ID: <20210204194747.GA10054@gondor.apana.org.au>
References: <20210204154230.1702563-1-arnd@kernel.org>
 <20210204154230.1702563-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204154230.1702563-2-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:42:16PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The OcteonTX2 CPT driver force-enables the OCTEONTX2_MBOX symbol,
> which fails when network drivers are disabled globally
> 
> WARNING: unmet direct dependencies detected for OCTEONTX2_MBOX
>   Depends on [n]: NETDEVICES [=n] && ETHERNET [=n] && NET_VENDOR_MARVELL [=n]
>   Selected by [y]:
>   - CRYPTO_DEV_OCTEONTX2_CPT [=y] && CRYPTO [=y] && CRYPTO_HW [=y] && (ARM64 [=y] || COMPILE_TEST [=y]) && PCI_MSI [=y] && 64BIT [=y] && CRYPTO_LIB_AES [=y]
> 
> The crypto driver actually fails to link without the ethernet side,
> so this is a hard dependency. Change the 'select' into 'depends on'
> to make it build reliably without warnings.
> 
> Fixes: 5e8ce8334734 ("crypto: marvell - add Marvell OcteonTX2 CPT PF driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/marvell/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There is already a patch for this:

https://patchwork.kernel.org/project/linux-crypto/patch/20210129054856.GA20020@gondor.apana.org.au/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
