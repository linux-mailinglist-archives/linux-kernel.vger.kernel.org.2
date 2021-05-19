Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0009388426
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhESAx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:53:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47070 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233529AbhESAwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:52:37 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ljAQZ-0003Xg-8I; Wed, 19 May 2021 08:51:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ljAQV-0003j5-RH; Wed, 19 May 2021 08:51:07 +0800
Date:   Wed, 19 May 2021 08:51:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>, chohnstaedt@innominate.com,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] crypto: start to fix ixp4xx
Message-ID: <20210519005107.m44dknz4ih233pbc@gondor.apana.org.au>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
 <CACRpkdbR9mt-X-Dt9uR9vGtg_EDJCk3H5Umuh2eUX-PGZ7VBfQ@mail.gmail.com>
 <20210518011930.nywtcgualmsrx35v@gondor.apana.org.au>
 <CACRpkdbi+1tVL04HQ5Uufpw3-ORp3W4Cs1AyHrjQwJ149T8MMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbi+1tVL04HQ5Uufpw3-ORp3W4Cs1AyHrjQwJ149T8MMQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:36:01PM +0200, Linus Walleij wrote:
>
> Sadly they do, it's these:
> https://lore.kernel.org/linux-crypto/20210510213634.600866-1-linus.walleij@linaro.org/
> https://lore.kernel.org/linux-crypto/20210510213634.600866-2-linus.walleij@linaro.org/
> https://lore.kernel.org/linux-crypto/20210510213634.600866-3-linus.walleij@linaro.org/
> 
> I guess we could turn it around: I see if I can apply these two
> on top of the crypto tree and resend then we hope there is no
> collision in the ARM SoC tree instead.
> 
> I need to respin the series anyway so shall we try this?

Yes I think those changes are probably best routed through crypto
as the code changes are quite extensive so the potential for non-
trivial conflicts is high.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
