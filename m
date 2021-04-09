Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB8359656
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhDIH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:27:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51698 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhDIH1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:27:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlY8-0005s2-Uv; Fri, 09 Apr 2021 17:27:30 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:27:28 +1000
Date:   Fri, 9 Apr 2021 17:27:28 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhiqi Song <songzhiqi1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        fanghao11@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH] crypto: api - fix coding style
Message-ID: <20210409072728.GA23134@gondor.apana.org.au>
References: <1617261649-35947-1-git-send-email-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617261649-35947-1-git-send-email-songzhiqi1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:20:49PM +0800, Zhiqi Song wrote:
> Fixed following checkpatch error:
> - do not use assignment in if condition
> Fixed following checkpatch warning:
> - prefer strscpy over strlcpy
> - delete repeated word
> 
> Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
> ---
>  crypto/api.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Please don't mix unrelated changes in a single patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
