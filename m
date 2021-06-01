Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975D7393DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhE1H31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:29:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50342 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236035AbhE1H3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:29:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWuD-0003j5-5U; Fri, 28 May 2021 15:27:41 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWuC-00021F-OI; Fri, 28 May 2021 15:27:40 +0800
Date:   Fri, 28 May 2021 15:27:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qce - Fix inconsistent indenting
Message-ID: <20210528072740.GN7392@gondor.apana.org.au>
References: <1621590292-71009-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621590292-71009-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 05:44:52PM +0800, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/crypto/qce/aead.c:85 qce_aead_done() warn: inconsistent
> indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/crypto/qce/aead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
