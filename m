Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA80640F05E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbhIQDWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:22:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55256 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243917AbhIQDWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:22:45 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4RF-0006Fg-B6; Fri, 17 Sep 2021 11:21:21 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4RF-0001mY-8H; Fri, 17 Sep 2021 11:21:21 +0800
Date:   Fri, 17 Sep 2021 11:21:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: drbg - Fix unused value warning in
 drbg_healthcheck_sanity()
Message-ID: <20210917032121.GH6559@gondor.apana.org.au>
References: <20210910190117.24882-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910190117.24882-1-tim.gardner@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 01:01:17PM -0600, Tim Gardner wrote:
> Coverity warns uf an unused value:
> 
> CID 44865 (#2 of 2): Unused value (UNUSED_VALUE)
> assigned_value: Assigning value -14 to ret here, but that stored value is
> overwritten before it can be used.
> 2006        int ret = -EFAULT;
> ...
> value_overwrite: Overwriting previous write to ret with value from drbg_seed(drbg, &addtl, false).
> 2052        ret = drbg_seed(drbg, &addtl, false);
> 
> Fix this by removing the variable initializer.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  crypto/drbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
