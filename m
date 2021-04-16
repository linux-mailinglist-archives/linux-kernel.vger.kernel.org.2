Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7209B361ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbhDPLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:34:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53162 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242812AbhDPLeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:34:00 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMj1-0003YU-2f; Fri, 16 Apr 2021 21:33:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:33:26 +1000
Date:   Fri, 16 Apr 2021 21:33:26 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] crypto: hisilicon/hpre - delete redundant log and
 return in advance
Message-ID: <20210416113326.GO16633@gondor.apana.org.au>
References: <1618048232-12634-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618048232-12634-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 05:50:32PM +0800, Hui Tang wrote:
> 'hpre_cfg_by_dsm' has checked and printed error path internally. It is not
> necessary to do it here, so remove it.
> 
> It should return error immediately when return value of 'hpre_cfg_by_dsm'
> is non-zero, and no need to execute the remaining sentences.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> 
> ---
> v1 -> v2:
>    - Return immediately when return value of 'hpre_cfg_by_dsm' is
>      non-zero.
> v2 -> v3:
>    - Add description for return if function fails.
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
