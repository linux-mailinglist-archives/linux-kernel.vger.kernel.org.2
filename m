Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241793DB1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhG3DLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:11:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51574 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhG3DLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:11:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1m9IvS-0000gw-Sc; Fri, 30 Jul 2021 11:11:06 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1m9IvQ-0003C0-1E; Fri, 30 Jul 2021 11:11:04 +0800
Date:   Fri, 30 Jul 2021 11:11:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, davem@davemloft.net, tiwai@suse.de,
        guillaume.gardet@arm.com
Subject: Re: [PATCH] crypto: ecc: handle unaligned input buffer in
 ecc_swap_digits
Message-ID: <20210730031103.GE12121@gondor.apana.org.au>
References: <20210721083905.15144-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210721083905.15144-1-ykaukab@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:39:05AM +0200, Mian Yousaf Kaukab wrote:
> ecdsa_set_pub_key() makes an u64 pointer at 1 byte offset of the key.
> This results in an unaligned u64 pointer. This pointer is passed to
> ecc_swap_digits() which assumes natural alignment.
> 
> This causes a kernel crash on an armv7 platform:
> [    0.409022] Unhandled fault: alignment exception (0x001) at 0xc2a0a6a9
> ...
> [    0.416982] PC is at ecdsa_set_pub_key+0xdc/0x120
> ...
> [    0.491492] Backtrace:
> [    0.492059] [<c07c266c>] (ecdsa_set_pub_key) from [<c07c75d4>] (test_akcipher_one+0xf4/0x6c0)
> 
> Handle unaligned input buffer in ecc_swap_digits() by replacing
> be64_to_cpu() to get_unaligned_be64(). Change type of in pointer to
> void to reflect it doesn’t necessarily need to be aligned.
> 
> Fixes: 4e6602916bc6 ("crypto: ecdsa - Add support for ECDSA signature verification")
> Reported-by: Guillaume Gardet <guillaume.gardet@arm.com>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  crypto/ecc.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
