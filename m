Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6391838C1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhEUIYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:24:38 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56100 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhEUIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:24:36 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lk0R2-00053Y-Mj; Fri, 21 May 2021 16:23:08 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lk0R0-0007Wx-HV; Fri, 21 May 2021 16:23:06 +0800
Date:   Fri, 21 May 2021 16:23:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Suman Anna <s-anna@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Deepak Saxena <dsaxena@plexity.net>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Gowtham Tammana <g-tammana@ti.com>,
        Vaibhav Gupta <v_gupta@ti.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Misc. SA2UL fixes/cleanups
Message-ID: <20210521082306.qrajanulcq37piny@gondor.apana.org.au>
References: <20210514161246.22517-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514161246.22517-1-s-anna@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:12:40AM -0500, Suman Anna wrote:
> Hi All,
> 
> The following series includes various fixes for multiple minor
> cleanup issues on failure paths in the TI K3 SA2UL Crypto driver.
> The patches are all based on top of 5.13-rc1.
> 
> Patch 1 is the only non SA2UL patch, and allows the OMAP RNG driver
> to be built for K3 platforms and probed properly when SA2UL is
> selected, and the SA2UL driver is probed (the rng device is a child
> of the sa2ul device).
> 
> regards
> Suman
> 
> Suman Anna (6):
>   hwrng: omap - Enable driver for TI K3 family
>   crypto: sa2ul - Fix leaks on failure paths with sa_dma_init()
>   crypto: sa2ul - Fix pm_runtime enable in sa_ul_probe()
>   crypto: sa2ul - Use of_device_get_match_data() helper
>   crypto: sa2ul - Use devm_platform_ioremap_resource()
>   crypto: sa2ul - Remove child devices in remove
> 
>  drivers/char/hw_random/Kconfig |  2 +-
>  drivers/crypto/sa2ul.c         | 46 ++++++++++++++++++----------------
>  2 files changed, 25 insertions(+), 23 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
