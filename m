Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09FF31E436
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBRCHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:07:51 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34530 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhBRCHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:07:49 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lCYiN-0006Z3-Cy; Thu, 18 Feb 2021 13:06:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Feb 2021 13:06:47 +1100
Date:   Thu, 18 Feb 2021 13:06:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     liulongfang <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, xuzaibo@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/sec - fixes shash test error
Message-ID: <20210218020647.GB30659@gondor.apana.org.au>
References: <1612692280-11386-1-git-send-email-liulongfang@huawei.com>
 <1612692280-11386-4-git-send-email-liulongfang@huawei.com>
 <20210210064328.GA15849@gondor.apana.org.au>
 <0afaed85-eeb0-236c-817f-a0f9cf02c65a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afaed85-eeb0-236c-817f-a0f9cf02c65a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:01:58AM +0800, liulongfang wrote:
>
> >> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> >> index d2c4a2c..988faf7 100644
> >> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
> >> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> >> @@ -7,6 +7,7 @@
> >>  #include <crypto/des.h>
> >>  #include <crypto/hash.h>
> >>  #include <crypto/internal/aead.h>
> >> +#include <crypto/internal/hash.h>
> > 
> > Please explain what exactly in this file needs this header file.
> > 
> > As it stands you could just be hiding real bugs.
> > 
> > Thanks,
> > 
> The crypto_alloc_shash() interface in the header file
> will be used in the function sec_aead_ctx_init(),
> If this header file is not added, calling the interface
> crypto_alloc_shash() during the initialization of the
> aead algorithm will return an error.

This makes no sense whatsoever as crypto_alloc_shash is defiend
by crypto/hash.h and you've already included that.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
