Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C72E3807AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhENKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:49:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37060 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhENKt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:49:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1lhVMf-0002Gq-0k; Fri, 14 May 2021 18:48:17 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lhVMb-0006XD-CF; Fri, 14 May 2021 18:48:13 +0800
Date:   Fri, 14 May 2021 18:48:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] poly1305: Make prototypes match
Message-ID: <20210514104813.wvdvviyoyo6pqbhw@gondor.apana.org.au>
References: <20210425211325.3157769-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425211325.3157769-1-ak@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 02:13:25PM -0700, Andi Kleen wrote:
> From: Andi Kleen <andi@firstfloor.org>
> 
> gcc 11 complains when arrays in prototypes do not match the function.
> Fix this here.
> 
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Andi Kleen <andi@firstfloor.org>
> ---
>  include/crypto/internal/poly1305.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Just noticed that this wasn't cc'ed to linux-crypto.  Andi, could
you please resend with a cc to the list?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
