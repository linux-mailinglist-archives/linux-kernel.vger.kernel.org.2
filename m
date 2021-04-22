Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1904367B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhDVHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:47:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48730 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhDVHq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:46:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZU2R-0002yV-Rq; Thu, 22 Apr 2021 17:46:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 17:46:15 +1000
Date:   Thu, 22 Apr 2021 17:46:15 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] crypto: ux500: cryp: Remove duplicate argument
Message-ID: <20210422074615.GE14354@gondor.apana.org.au>
References: <20210414113910.10651-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414113910.10651-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:38:59PM +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/crypto/ux500/cryp/cryp_p.h:84:6-27:duplicated argument to |
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/crypto/ux500/cryp/cryp_p.h | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
