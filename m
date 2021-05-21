Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D638C1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEUIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:25:03 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56124 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhEUIZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:25:02 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lk0RR-00055o-HX; Fri, 21 May 2021 16:23:33 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lk0RM-0007Xf-Ps; Fri, 21 May 2021 16:23:28 +0800
Date:   Fri, 21 May 2021 16:23:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     thomas.lendacky@amd.com, john.allen@amd.com, davem@davemloft.net,
        gary.hook@amd.com, brijesh.singh@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Fix a resource leak in an error handling
 path
Message-ID: <20210521082328.ftdnzvztmqmnxu5r@gondor.apana.org.au>
References: <4af832b7e75b729ebfb0f07fe039dc47712512c2.1621146079.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af832b7e75b729ebfb0f07fe039dc47712512c2.1621146079.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 08:58:04AM +0200, Christophe JAILLET wrote:
> If an error occurs after calling 'sp_get_irqs()', 'sp_free_irqs()' must be
> called as already done in the error handling path.
> 
> Fixes: f4d18d656f88 ("crypto: ccp - Abstract interrupt registeration")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/ccp/sp-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
