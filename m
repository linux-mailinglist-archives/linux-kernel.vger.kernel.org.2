Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912BC43C06D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhJ0C62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:58:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56350 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238838AbhJ0C6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:58:25 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mfZ6U-0000zs-Ty; Wed, 27 Oct 2021 10:55:51 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mfZ6P-0006NJ-9Z; Wed, 27 Oct 2021 10:55:45 +0800
Date:   Wed, 27 Oct 2021 10:55:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/crypto: suspected null-pointer dereference at
 atmel_sha_init
Message-ID: <20211027025545.GA24480@gondor.apana.org.au>
References: <TYCP286MB1188BC12CA1BEF68F5E90A7A8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB1188BC12CA1BEF68F5E90A7A8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 09:07:43AM +0000, YE Chengfeng wrote:
> Hi,
> 
> https://github.com/torvalds/linux/blob/master/drivers/crypto/atmel-sha.c#L431
> 
> We notice that the return pointer of atmel_sha_find_dev could be null, and it seems that null-check is missing at #line 431. If it returns null pointer, there will be a null pointer dereference problem at #line 437. We check that other call sites of this interface perform null-check, while this doesn't, so we suspect that this could be a problem.
> 
> This is detected by our experimental static analysis tool, it could be false positive, so we manually check and report those we think may be true bugs. Would you like to have a look at them?

It could be a real issue when the device is hot unplugged.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
