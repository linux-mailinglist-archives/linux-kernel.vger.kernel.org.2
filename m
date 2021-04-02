Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37E1352918
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhDBJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:49:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33834 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBJtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:49:41 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSGQp-0003cb-1L; Fri, 02 Apr 2021 20:49:36 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 20:49:34 +1100
Date:   Fri, 2 Apr 2021 20:49:34 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/sec - Fixes AES algorithm mode
 parameter problem
Message-ID: <20210402094934.GM24509@gondor.apana.org.au>
References: <1616840910-12727-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616840910-12727-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 06:28:30PM +0800, Longfang Liu wrote:
> The input data of the ECB (AES) algorithm needs to be aligned
> with 16 bytes, and the input data of the XTS (AES) algorithm is
> at least 16 bytes. Otherwise the SEC hardware will go wrong.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 37 ++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
