Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8993940F04B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbhIQDUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:20:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55236 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhIQDUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:20:00 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4OT-00067x-Df; Fri, 17 Sep 2021 11:18:29 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4OP-0001iZ-VU; Fri, 17 Sep 2021 11:18:26 +0800
Date:   Fri, 17 Sep 2021 11:18:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        smueller@chronox.de, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: jitterentopy: drop kernel-doc notation
Message-ID: <20210917031825.GA6585@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824210513.25503-1-rdunlap@infradead.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Drop "begin kernel-doc (/**)" entries in jitterentropy.c
> since they are not in kernel-doc format and they cause
> many complaints (warnings) from scripts/kernel-doc.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephan Mueller <smueller@chronox.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
> crypto/jitterentropy.c |   24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
