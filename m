Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B560A36761E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbhDVAPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:15:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:45926 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhDVAPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:15:08 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZMzG-0006L1-Bl; Thu, 22 Apr 2021 10:14:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 10:14:30 +1000
Date:   Thu, 22 Apr 2021 10:14:30 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     linux-crypto@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: cortina/gemini: hwrng: what is its quality ?
Message-ID: <20210422001430.GA4246@gondor.apana.org.au>
References: <YICFBQ8mQRJ4zSh9@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YICFBQ8mQRJ4zSh9@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:03:17PM +0200, Corentin Labbe wrote:
> hello
> 
> I work on the crypto part of the cortina/gemini SL3516 SoC.
> The datasheet mention a HWRNG in its IP but really briefly:
> """
> The implementation is a 32-bit Hardware Random Number Generator that has a uniformed
> distribution between 0 and 2^32 -1. The hardware randomness is created by sampling data from
> different clock domains, and feeding it as input to the 32-bit maximum length LFSR (Linear Feedback
> Shift Register)
> """
> 
> Piping its output to rngtest give:
> dd if=/dev/hwrng count=2000 bs=2048 | rngtest
> rngtest 6.11
> rngtest: starting FIPS tests...
> rngtest: entropy source drained
> rngtest: bits received from input: 32768000
> rngtest: FIPS 140-2 successes: 1191
> rngtest: FIPS 140-2 failures: 447
> rngtest: FIPS 140-2(2001-10-10) Monobit: 183
> rngtest: FIPS 140-2(2001-10-10) Poker: 116
> rngtest: FIPS 140-2(2001-10-10) Runs: 346
> 2000+0 records in
> 2000+0 records out
> rngtest: FIPS 140-2(2001-10-10) Long run: 0
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=303.606; avg=3143.352; max=9712.208)Kibits/s
> rngtest: FIPS tests speed: (min=7.104; avg=10.332; max=10.638)Mibits/s
> rngtest: Program run time: 13303224 microseconds
> 
> That's a quite number of failure.
> Can the hwrng still be used with some "hwrng->quality" setting ?
> Or it is just too many failure to be used ?

If in doubt just leave it zero and the admin can override it if
necessary.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
