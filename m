Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B639D248
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFXuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhFFXuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:50:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB3FC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 16:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vkNTV2WeUSVaEup2PBPBJRTe4qCytaDLfd5dqhSeEt8=; b=gj2zkwltqgfjB5pnEKQkDeApUu
        Pc5uu+1AaAyfCfTBmH2CYIYZLwgw/HlxVcmCl8ML6mJfIzjIKY6qiNpZSIP99+OlnpUIFgbers3Yp
        ZYAtug230AlFfbXNHUJxkIUKchXkY/3ToKRKZA9S0sCYWBdUHjj4m1sAJ3BY8cahEGLJ+bP+IzR2v
        kzwx0mrWk741TQEFFUXQeKS9aaDJcurIVPVZKV79jcFWacRH4uRfwgqebudBPunFW6G+VcsSfTUwK
        XZDcMuljsEt1lERb4TUNzyU7Pk4CJ/JSxo6nUcIs4VJ4EQEGZskdyJLlEBzddXH4t/+JANfqDzFqo
        LNxM+Jrw==;
Received: from [2601:1c0:6280:3f0::bd57]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lq2TA-0013gA-CU; Sun, 06 Jun 2021 23:46:16 +0000
Subject: Re: [PATCH] riscv: sifive: fix Kconfig errata warning
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
References: <20210522212036.5513-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <990a9263-dc33-e616-12eb-173e6872c93a@infradead.org>
Date:   Sun, 6 Jun 2021 16:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522212036.5513-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping. anyone?
thanks.

On 5/22/21 2:20 PM, Randy Dunlap wrote:
> The SOC_SIFIVE Kconfig entry unconditionally selects ERRATA_SIFIVE.
> However, ERRATA_SIFIVE depends on RISCV_ERRATA_ALTERNATIVE, which is
> not set, so SOC_SIFIVE should either depend on or select
> RISCV_ERRATA_ALTERNATIVE. Use 'select' here to quieten the Kconfig
> warning.
> 
> WARNING: unmet direct dependencies detected for ERRATA_SIFIVE
>   Depends on [n]: RISCV_ERRATA_ALTERNATIVE [=n]
>   Selected by [y]:
>   - SOC_SIFIVE [=y]
> 
> Fixes: 1a0e5dbd3723 ("riscv: sifive: Add SiFive alternative ports")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/Kconfig.socs |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210521.orig/arch/riscv/Kconfig.socs
> +++ linux-next-20210521/arch/riscv/Kconfig.socs
> @@ -14,6 +14,7 @@ config SOC_SIFIVE
>  	select CLK_SIFIVE
>  	select CLK_SIFIVE_PRCI
>  	select SIFIVE_PLIC
> +	select RISCV_ERRATA_ALTERNATIVE
>  	select ERRATA_SIFIVE
>  	help
>  	  This enables support for SiFive SoC platform hardware.
> 


-- 
~Randy

