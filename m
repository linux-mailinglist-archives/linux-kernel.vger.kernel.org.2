Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3103EA2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhHLKam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:30:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52720 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235297AbhHLKai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:30:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mE7yG-00031a-56; Thu, 12 Aug 2021 18:29:56 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mE7yE-0001SJ-C5; Thu, 12 Aug 2021 18:29:54 +0800
Date:   Thu, 12 Aug 2021 18:29:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] crypto: sun8i-ce: fix multiple memory leaks in
 sun8i_ce_hash_run
Message-ID: <20210812102954.GA5569@gondor.apana.org.au>
References: <20210803063149.2821093-1-mudongliangabcd@gmail.com>
 <20210812100437.GA5055@gondor.apana.org.au>
 <CAD-N9QWGgBBddi5kwTNANKVVdWaQRwagMHvaH592B5GDALpBrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QWGgBBddi5kwTNANKVVdWaQRwagMHvaH592B5GDALpBrg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 06:24:25PM +0800, Dongliang Mu wrote:
> On Thu, Aug 12, 2021 at 6:05 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Tue, Aug 03, 2021 at 02:31:38PM +0800, Dongliang Mu wrote:
> > >
> > > -theend:
> > > -     kfree(buf);
> > > +err_result:
> > >       kfree(result);
> > > -     crypto_finalize_hash_request(engine, breq, err);
> > > +err_buf:
> > > +     kfree(buf);
> > > +out:
> > > +     if (!err)
> > > +             crypto_finalize_hash_request(engine, breq, err);
> > >       return 0;
> >
> > This does not look right.  You're returning zero in case of an error
> 
> Hi Herbert,
> 
> Corentin Labbe said,
> 
> For the error code, I am not sure it is needed, error code is already
> given to user via crypto_finalize_hash_request().

Yes but your patch changes this.  You're now skipping the finalize
call and thus throwing away err if it's not zero.

If it's supposed to do this you need to explain it in your patch
submission.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
