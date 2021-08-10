Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB93E2625
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhHFIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:31:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51744 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhHFIbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:31:49 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mBvGO-0007NM-Sh; Fri, 06 Aug 2021 16:31:32 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mBvGM-0003QS-Dv; Fri, 06 Aug 2021 16:31:30 +0800
Date:   Fri, 6 Aug 2021 16:31:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 2/5] crypto: hisilicon/sec - delete the print of fallback
 tfm application failure
Message-ID: <20210806083130.GA13132@gondor.apana.org.au>
References: <1627701996-4589-1-git-send-email-yekai13@huawei.com>
 <1627701996-4589-3-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627701996-4589-3-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 11:26:33AM +0800, Kai Ye wrote:
> Modify the print of information that might lead to user misunderstanding.
> Currently only XTS mode need the fallback tfm when using 192bit key.
> Others algs not need soft fallback tfm. So others algs can return
> directly.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

I don't think this is a good change.

> @@ -2032,13 +2032,12 @@ static int sec_skcipher_soft_crypto(struct sec_ctx *ctx,
>  				    struct skcipher_request *sreq, bool encrypt)
>  {
>  	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
> +	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, c_ctx->fbtfm);
>  	struct device *dev = ctx->dev;
>  	int ret;
>  
> -	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, c_ctx->fbtfm);
> -
>  	if (!c_ctx->fbtfm) {
> -		dev_err(dev, "failed to check fallback tfm\n");
> +		dev_err(dev, "the soft tfm isn't supported in the current system.\n");

If we end up in this code path you'll be spamming the printk buffer
on every single request.  This is not acceptable.  At least rate limit
these messages.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
