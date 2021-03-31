Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9134A482
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCZJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:33:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35490 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhCZJdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:33:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPiq3-0003Zp-Ox; Fri, 26 Mar 2021 20:33:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:33:07 +1100
Date:   Fri, 26 Mar 2021 20:33:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - fix the check on dma address
Message-ID: <20210326093307.GL12658@gondor.apana.org.au>
References: <1616150705-11516-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616150705-11516-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 06:45:05PM +0800, Hui Tang wrote:
> System may be able to get physical address of zero if not reserved by
> firmware.
> 
> The dma address obtained by 'dma_alloc_coherent' is valid, since already
> checking cpu va before, so do not check again.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 12 ------------
>  drivers/crypto/hisilicon/qm.c               |  2 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c  |  6 ------
>  3 files changed, 1 insertion(+), 19 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
