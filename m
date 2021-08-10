Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81BA3DB1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhG3DLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:11:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51576 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhG3DL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:11:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1m9Ivd-0000j2-EI; Fri, 30 Jul 2021 11:11:17 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1m9Ivc-0003CR-Ix; Fri, 30 Jul 2021 11:11:16 +0800
Date:   Fri, 30 Jul 2021 11:11:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] crypto: atmel-aes: use swap()
Message-ID: <20210730031116.GF12121@gondor.apana.org.au>
References: <20210722170827.GA4362@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722170827.GA4362@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:08:27PM +0100, Salah Triki wrote:
> Use swap() instead of implementing it in order to make code more clean.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/crypto/atmel-aes.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
