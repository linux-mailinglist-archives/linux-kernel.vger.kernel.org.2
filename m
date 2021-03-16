Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEDB33D12A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhCPJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:51:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56064 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236346AbhCPJvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:51:46 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lM6MN-0007c3-NU; Tue, 16 Mar 2021 20:51:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 16 Mar 2021 20:51:31 +1100
Date:   Tue, 16 Mar 2021 20:51:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rong.a.chen@intel.com, lkp@intel.com, oberpar@linux.ibm.com,
        akpm@linux-foundation.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size
 mismatch
Message-ID: <20210316095131.GA18709@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> See:
> 
>   [torvalds@ryzen ~]$ a="!" [ "$a" = ".size" ]
> 
> is fine, but
> 
>   [torvalds@ryzen ~]$ a="!" [ $a = ".size" ]
>   -bash: [: =: unary operator expected

This isn't doing what you think it's doing.  The first assignment
to a is not in effect when the shell is expanding $a so what you're
actually running is

	a="!" [ = .size ]

Which is why it bombs out.

To get the desired result you need a semicolon:

$ a="!"; [ $a = ".size" ]
$ 

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
