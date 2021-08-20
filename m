Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58293F2C84
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhHTMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:54:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53704 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237996AbhHTMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:54:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mH41R-0007H8-An; Fri, 20 Aug 2021 20:53:21 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mH41L-0007bK-II; Fri, 20 Aug 2021 20:53:15 +0800
Date:   Fri, 20 Aug 2021 20:53:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
Subject: Re: [PATCH] crypto: xts_crypt() return if walk.nbytes is 0
Message-ID: <20210820125315.GB28484@gondor.apana.org.au>
References: <YQ0Qm+Xs1g/7Eant@fedora>
 <20210809141027.860850-1-chouhan.shreyansh630@gmail.com>
 <20210820083111.GA28484@gondor.apana.org.au>
 <CAMj1kXGMPimX0_dR_kLuzZjuJK9rM=uCpRDtoJq0UjWq12M10A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGMPimX0_dR_kLuzZjuJK9rM=uCpRDtoJq0UjWq12M10A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 01:14:52PM +0200, Ard Biesheuvel wrote:
>
> In spite of that, I have a slight preference for this version, given
> that it makes it obvious that we bail on two separate conditions:
> - an error has occurred
> - no error has occurred but the resulting walk is empty
> 
> Testing walk.nbytes only needlessly obfuscates the code, as we need to
> return 'err' in the end anyway.

I disagree, this is how most skcipher walkers are structured, they
never explicitly test on err and only terminate the loop when
walk->nbytes hits zero, in which case err is returned as is.

I don't see why this particular skcipher walker should deviate
from that paradigm.  In fact it is exactly that deviation that
caused the bug in the first instance.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
