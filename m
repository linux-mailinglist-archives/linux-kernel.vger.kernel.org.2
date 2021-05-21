Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD74A38C1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEUIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:24:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56058 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhEUIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:23:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lk0QN-0004zX-2F; Fri, 21 May 2021 16:22:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lk0QL-0007W2-11; Fri, 21 May 2021 16:22:25 +0800
Date:   Fri, 21 May 2021 16:22:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - fix initialization of 'secret_size'
Message-ID: <20210521082224.dzarrsqzxygschlw@gondor.apana.org.au>
References: <1620636848-38909-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620636848-38909-1-git-send-email-tanghui20@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:54:08PM +0800, Hui Tang wrote:
> Actual data length of the 'secret' is not equal to the 'secret_size'.
> 
> Since the 'curve_id' has removed in the 'secret', the 'secret_size'
> should subtract the length of the 'curve_id'.
> 
> Fixes: 6763f5ea2d9a(crypto: ecdh - move curve_id of ECDH from ...)
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  crypto/testmgr.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
