Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B02361EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhDPLaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:30:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53028 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240846AbhDPLaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:30:10 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMfN-0003Kt-Dg; Fri, 16 Apr 2021 21:29:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:29:41 +1000
Date:   Fri, 16 Apr 2021 21:29:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Huang Guobin <huangguobin4@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: ixp4xx -: use DEFINE_SPINLOCK() for
 spinlock
Message-ID: <20210416112941.GC16633@gondor.apana.org.au>
References: <1617710577-48660-1-git-send-email-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617710577-48660-1-git-send-email-huangguobin4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 08:02:57PM +0800, Huang Guobin wrote:
> From: Guobin Huang <huangguobin4@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
> ---
>  drivers/crypto/ixp4xx_crypto.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
