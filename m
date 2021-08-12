Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5323EA33E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhHLLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:05:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52728 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235696AbhHLLFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:05:07 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mE8Vt-0003C0-9C; Thu, 12 Aug 2021 19:04:41 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mE8Vs-0001bk-91; Thu, 12 Aug 2021 19:04:40 +0800
Date:   Thu, 12 Aug 2021 19:04:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 2/2] crypto: hisilicon/sec - modify the hardware endian
 configuration
Message-ID: <20210812110440.GB5890@gondor.apana.org.au>
References: <1628243914-33224-1-git-send-email-yekai13@huawei.com>
 <1628243914-33224-3-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628243914-33224-3-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 05:58:34PM +0800, Kai Ye wrote:
>
> +	reg &= ~(BIT(1) | BIT(0));
> +#ifndef CONFIG_64BIT
> +	reg |= BIT(1);
> +#endif
> +
> +#ifndef CONFIG_CPU_LITTLE_ENDIAN
> +	reg |= BIT(0);
> +#endif

Please rewrite these without ifdefs.  For example,

	if (!IS_ENABLED(CONFIG_64BIT))
		reg |= BIT(1);
	if (!IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
		reg |= BIT(0);

I can't vouch for the logic here so please double-check.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
