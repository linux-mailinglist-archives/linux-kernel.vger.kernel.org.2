Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F298635290F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhDBJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:49:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33796 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234217AbhDBJs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:48:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSGQ6-0003Xl-3Q; Fri, 02 Apr 2021 20:48:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 20:48:49 +1100
Date:   Fri, 2 Apr 2021 20:48:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - fix PASID setting on kunpeng 920
Message-ID: <20210402094849.GI24509@gondor.apana.org.au>
References: <1616833784-5489-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616833784-5489-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 04:29:44PM +0800, Hui Tang wrote:
> We must confirm the PASID is disabled before using no-sva mode.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 43 +++++++++++++------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
