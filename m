Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621F7393DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhE1H2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:28:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50246 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234430AbhE1H2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:28:03 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWsu-0003bo-Sd; Fri, 28 May 2021 15:26:21 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWsj-0001yG-VK; Fri, 28 May 2021 15:26:10 +0800
Date:   Fri, 28 May 2021 15:26:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Gary R Hook <gary.hook@amd.com>,
        George Cherian <gcherian@marvell.com>,
        Haren Myneni <haren@us.ibm.com>,
        John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Robert Jennings <rcj@linux.vnet.ibm.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 0/3] Rid W=1 warnings from Crypto
Message-ID: <20210528072609.GG7392@gondor.apana.org.au>
References: <20210520092733.3434378-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520092733.3434378-1-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:27:30AM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (3):
>   crypto: cavium: Fix a bunch of kernel-doc related issues
>   crypto: nx: nx-aes-gcm: Kernel-doc formatting should not be used for
>     headers
>   crypto: ccp: ccp-dev: Fix a little doc-rot
> 
>  drivers/crypto/cavium/cpt/cptpf_main.c        |  2 +-
>  drivers/crypto/cavium/cpt/cptvf_reqmanager.c  |  4 ++--
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |  4 ++--
>  drivers/crypto/cavium/nitrox/nitrox_mbx.c     |  4 ++--
>  drivers/crypto/cavium/nitrox/nitrox_reqmgr.c  | 12 ++++++----
>  .../crypto/cavium/nitrox/nitrox_skcipher.c    |  2 +-
>  drivers/crypto/ccp/ccp-dev.c                  |  2 +-
>  drivers/crypto/nx/nx-842-pseries.c            | 24 +++++++++----------
>  8 files changed, 27 insertions(+), 27 deletions(-)
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Gary R Hook <gary.hook@amd.com>
> Cc: George Cherian <gcherian@marvell.com>
> Cc: Haren Myneni <haren@us.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: John Allen <john.allen@amd.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
> Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> -- 
> 2.31.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
