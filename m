Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010C3526E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhDBHTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:19:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51480 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhDBHTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:19:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSE5U-0001PR-RY; Fri, 02 Apr 2021 18:19:25 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 18:19:24 +1100
Date:   Fri, 2 Apr 2021 18:19:24 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - delete redundant log
Message-ID: <20210402071924.GA10482@gondor.apana.org.au>
References: <1616833946-9682-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616833946-9682-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 04:32:26PM +0800, Hui Tang wrote:
> 'hpre_cfg_by_dsm' has checked and printed error path, so it is not
> necessary at all.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
> index 8aae921..73ee997 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> @@ -384,10 +384,7 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
>  
>  	/* This setting is only needed by Kunpeng 920. */
>  	if (qm->ver == QM_HW_V2) {
> -		ret = hpre_cfg_by_dsm(qm);
> -		if (ret)
> -			dev_err(dev, "acpi_evaluate_dsm err.\n");
> -
> +		hpre_cfg_by_dsm(qm);
>  		disable_flr_of_bme(qm);
>  	}

If the return value is non-zero you've just changed what this code
does from returning non-zero to returning zero.  Are you sure about
this?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
