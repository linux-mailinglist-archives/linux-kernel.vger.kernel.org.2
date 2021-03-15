Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074E133C9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhCOXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:10:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50430 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCOXKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:10:08 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lLwLP-00061Y-RR; Tue, 16 Mar 2021 10:09:52 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 16 Mar 2021 10:09:51 +1100
Date:   Tue, 16 Mar 2021 10:09:51 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size
 mismatch
Message-ID: <20210315230951.GA17229@gondor.apana.org.au>
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com>
 <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com>
 <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
 <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com>
 <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
 <YE/ERLHBdjJ19TYT@audible.transient.net>
 <CAHk-=wj6OiV_sSZbqz-ZPnL7=NboN-3VQYM6brVCfq2px0EAqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6OiV_sSZbqz-ZPnL7=NboN-3VQYM6brVCfq2px0EAqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:57:58PM -0700, Linus Torvalds wrote:
>
>     $ [ "!"  = ".size" -a "b" = ".LPBX0," ]
> 
> causes
> 
>     dash: 6: [: =: unexpected operator
> 
> because for some reason that "-a" ends up (wild handwaving here about
> what is going on) re-parsing the first expression, and ignoring the
> quoting around "!" when it does so.

The quoting on "!" doesn't help I'm afraid.  Even though [ is a
built-in it is not allowed to look at the quoting because it's
supposed to behave in the same way whether you get the builtin [
or the one from /usr/bin.

So when it gets the expression the quoting on the "!" has already
been removed.

IOW this expression is ambiguous and may or may not fail depending
on how it's parsed.

Note that when you have a simple expression like

	[ "!" = ".size" ]

special rules come into play on how it is parsed:

https://pubs.opengroup.org/onlinepubs/009604499/utilities/test.html

But this does not apply when you construct more complex ones with
-a.

There are two ways around this when writing scripts, you either
add something to ensure that "!" cannot occur, e.g.,

	[ "X$a" = "X$b" -a ... ]

or you break it down into a simpler expression that is guaranteed
by POSIX:

	[ "$a" = "$b" ] && [ ... ]

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
