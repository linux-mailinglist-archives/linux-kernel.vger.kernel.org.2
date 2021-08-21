Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69293F3968
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhHUHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:51:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53812 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232469AbhHUHvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:51:02 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mHLli-0006GF-GY; Sat, 21 Aug 2021 15:50:18 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mHLlh-0000ud-2n; Sat, 21 Aug 2021 15:50:17 +0800
Date:   Sat, 21 Aug 2021 15:50:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH v2 0/3] support test GCM/CCM mode for SM4
Message-ID: <20210821075017.GE3392@gondor.apana.org.au>
References: <20210813075508.98854-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813075508.98854-1-tianjia.zhang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 03:55:05PM +0800, Tianjia Zhang wrote:
> The GCM/CCM mode of SM4 is defined in the RFC 8998 specification:
> https://datatracker.ietf.org/doc/html/rfc8998
> 
> There are several places where the return value check of crypto_aead_setkey
> and crypto_aead_setauthsize were lost. It is necessary to add these checks.
> 
> At the same time, move the crypto_aead_setauthsize() call out of the loop,
> and only need to call it once after load transform.
> 
> ---
> v2 changes:
>   - check the crypto_aead_setauthsize() return value
>   - move crypto_aead_setauthsize out of loop
>   - update commit message
> 
> Tianjia Zhang (3):
>   crypto: tcrypt - Fix missing return value check
>   crypto: testmgr - Add GCM/CCM mode test of SM4 algorithm
>   crypto: tcrypt: add GCM/CCM mode test for SM4 algorithm
> 
>  crypto/tcrypt.c  |  74 ++++++++++++++++++++----
>  crypto/testmgr.c |  29 ++++++++++
>  crypto/testmgr.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 241 insertions(+), 10 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
