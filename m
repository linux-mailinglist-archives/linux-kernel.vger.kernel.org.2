Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F83380891
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhENLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:37:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37272 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232269AbhENLhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:37:06 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1lhW6g-00030h-9L; Fri, 14 May 2021 19:35:50 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lhW6e-0002Yc-J1; Fri, 14 May 2021 19:35:48 +0800
Date:   Fri, 14 May 2021 19:35:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     chohnstaedt@innominate.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] crypto: start to fix ixp4xx
Message-ID: <20210514113548.bd6lslfjyqxkwyiy@gondor.apana.org.au>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 08:26:07PM +0000, Corentin Labbe wrote:
> Hello
> 
> Loading the ixp4xx crypto driver exhibits lots of error.
> All algorithm fail selftests with different reasons.
> This series start to fixes some of thoses problem.
> 
> Corentin Labbe (11):
>   crypto: ixp4xx: dma_unmap the correct address
>   crypto: ixp4xx: update IV after requests
>   crypto: ixp4xx: fallback when having more than one SG
>   crypto: ixp4xx: convert unsigned to unsigned int
>   crypto: ixp4xx: convert all printk to dev_xxx
>   crypto: ixp4xx: whitespace fixes
>   crypto: ixp4xx: Do not initialize static to NULL
>   crypto: ixp4xx: remove brackets from single statement
>   crypto: ixp4xx: Correct functions alignment
>   MAINTAINERS: add ixp4xx_crypto to the right arch list
>   MAINTAINERS: add myself as maintainer of ixp4xx_crypto
> 
>  MAINTAINERS                    |   7 +
>  drivers/crypto/Kconfig         |   5 +
>  drivers/crypto/ixp4xx_crypto.c | 277 +++++++++++++++++++++------------
>  3 files changed, 188 insertions(+), 101 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
