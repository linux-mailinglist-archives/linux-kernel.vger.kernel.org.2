Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA440F055
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbhIQDVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:21:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55248 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243767AbhIQDVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:21:03 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4Pd-0006AD-Kj; Fri, 17 Sep 2021 11:19:41 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4Pa-0001kX-TV; Fri, 17 Sep 2021 11:19:38 +0800
Date:   Fri, 17 Sep 2021 11:19:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com
Subject: Re: [PATCH 0/4] crypto: qat - replace deprecated MSI API
Message-ID: <20210917031938.GE6559@gondor.apana.org.au>
References: <20210901173608.16777-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901173608.16777-1-wojciech.ziemba@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 06:36:04PM +0100, Wojciech Ziemba wrote:
> This set of patches replaces deprecated MSI API.
> It also fixes handling of freeing IRQs in case of failure of probing of
> modules by tracking which IRQs were allocated.
> 
> Maksim Lukoshkov (1):
>   crypto: qat - free irqs only if allocated
> 
> Wojciech Ziemba (3):
>   crypto: qat - replace deprecated MSI API
>   crypto: qat - remove unmatched CPU affinity to cluster IRQ
>   crypto: qat - free irq in case of failure
> 
>  .../crypto/qat/qat_common/adf_accel_devices.h |  11 +-
>  drivers/crypto/qat/qat_common/adf_isr.c       | 170 +++++++++---------
>  drivers/crypto/qat/qat_common/adf_vf_isr.c    |  24 ++-
>  3 files changed, 101 insertions(+), 104 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
