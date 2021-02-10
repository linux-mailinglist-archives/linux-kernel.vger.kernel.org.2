Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD3315FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhBJHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:22:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50194 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232346AbhBJHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:22:47 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jou-0001Ez-Sb; Wed, 10 Feb 2021 18:21:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:21:52 +1100
Date:   Wed, 10 Feb 2021 18:21:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     mpm@selenic.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random/timeriomem-rng: Fix cooldown period calculation
Message-ID: <20210210072152.GB4493@gondor.apana.org.au>
References: <947aa0ab-1f0c-44d6-943a-cf83a56ac5b8@rwthex-s2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <947aa0ab-1f0c-44d6-943a-cf83a56ac5b8@rwthex-s2-a.rwth-ad.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:14:59PM +0100, Jan Henrik Weinstock wrote:
> Ensure cooldown period tolerance of 1% is actually accounted for.
> 
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
> 
> Before patch, if period_us was less than 100us, no extra sleep time was
> added. If it was more than 100us, only 1us extra time (and not 1%) is slept.
> 
>  drivers/char/hw_random/timeriomem-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.

BTW your patch was space corrupted so I had to apply it by hand.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
