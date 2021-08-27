Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0623F963F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbhH0IgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:36:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54410 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244471AbhH0IgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:36:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mJXKh-0007ZQ-Dr; Fri, 27 Aug 2021 16:35:27 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mJXKf-0005dG-Bx; Fri, 27 Aug 2021 16:35:25 +0800
Date:   Fri, 27 Aug 2021 16:35:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     John Allen <john.allen@amd.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, davem@davemloft.net
Subject: Re: [PATCH] crypto: ccp - Add support for new CCP/PSP device ID
Message-ID: <20210827083525.GC21571@gondor.apana.org.au>
References: <20210820145621.185866-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820145621.185866-1-john.allen@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 02:56:21PM +0000, John Allen wrote:
> Add a new CCP/PSP PCI device ID and corresponding entry in the dev_vdata
> struct.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  drivers/crypto/ccp/sp-pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
