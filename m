Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C26316010
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhBJH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:27:33 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50348 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232501AbhBJHZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:25:01 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jrG-0001Iq-DD; Wed, 10 Feb 2021 18:24:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:24:18 +1100
Date:   Wed, 10 Feb 2021 18:24:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/6] crypto: hisilicon/qm - misc fixes
Message-ID: <20210210072418.GN4493@gondor.apana.org.au>
References: <1612519978-33340-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612519978-33340-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:12:52PM +0800, Weili Qian wrote:
> This patchset fixes some bugs:
> 1. Removing the waiting reset's completion logic of driver.
> 2. In order to prevent request missing,
>    call user's callback before device resetting.
> 3. Fix the value of 'QM_SQC_VFT_BASE_MASK_V2'.
> 4. Update irqflag.
> 5. Do not reset when CE error occurs.
> 6. Fix printing format issue. 
> 
> Sihang Chen (1):
>   crypto: hisilicon/qm - update irqflag
> 
> Weili Qian (5):
>   crypto: hisilicon/qm - removing driver after reset
>   crypto: hisilicon/qm - fix request missing error
>   crypto: hisilicon/qm - fix the value of 'QM_SQC_VFT_BASE_MASK_V2'
>   crypto: hisilicon/qm - do not reset hardware when CE happens
>   crypto: hisilicon/qm - fix printing format issue
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c |   3 +-
>  drivers/crypto/hisilicon/qm.c             | 124 +++++++++++++++++++++---------
>  drivers/crypto/hisilicon/qm.h             |   5 +-
>  drivers/crypto/hisilicon/sec2/sec_main.c  |   3 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   |   7 +-
>  5 files changed, 101 insertions(+), 41 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
