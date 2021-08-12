Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370A3EA699
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhHLOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhHLO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:29:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C599C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZVlaG0VhFeaxj1oc0FY8djObF9gqSjLqICcYP5GRnbM=; b=1Gk0kr3psO5NWcrSbK7GzBLDIt
        9hzXcKxUb+6rqJOv2eglhQasz+z2GG5pubDdfQvGvQxdOwUPcyFdgxctotxEGdhaeS1cln4YuxYfG
        7uQvG8LmBAd7G2Eg/21s0TRM8ML54Go94LV/Gmop1DeAMhWouCAnEm5bVB3Tk+smKQQssEpkbCz4a
        ZPa0+9dIaVqYjbu0O2h/gmkGB4uz1x0xC661739j/RmjvN3iICLpxE+vEMHmwNCofMDFxztl7SWeb
        97b486zbmE9z7lh/IUp4p1smpq0mXoxUo3TVSJqjm/gDK/GMtEXVl0vNX19+WQJq/168z1whpOvxZ
        ZAcCDpyg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEBi7-00ASH1-CO; Thu, 12 Aug 2021 14:29:31 +0000
Subject: Re: [PATCH] riscv: add rv32 and rv64 randconfig build targets
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
References: <20210717044424.17478-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25894c79-120f-8885-34cd-2e9dec0017ba@infradead.org>
Date:   Thu, 12 Aug 2021 07:29:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210717044424.17478-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Any comments on this patch?
thanks.

On 7/16/21 9:44 PM, Randy Dunlap wrote:
> Add the ability to do randconfig build targets for both
> rv32 and rv64.
> 
> Based on a similar patch by Michael Ellerman for PowerPC.
> 
> Usage:
>    make ARCH=riscv rv32_randconfig
> or
>    make ARCH=riscv rv64_randconfig
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> 
>   arch/riscv/Makefile              |   10 ++++++++++
>   arch/riscv/configs/32-bit.config |    2 ++
>   arch/riscv/configs/64-bit.config |    2 ++
>   3 files changed, 14 insertions(+)
> 
> --- linux-next-20210715.orig/arch/riscv/Makefile
> +++ linux-next-20210715/arch/riscv/Makefile
> @@ -132,3 +132,13 @@ zinstall install:
>   
>   archclean:
>   	$(Q)$(MAKE) $(clean)=$(boot)
> +
> +PHONY += rv32_randconfig
> +rv32_randconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/32-bit.config \
> +		-f $(srctree)/Makefile randconfig
> +
> +PHONY += rv64_randconfig
> +rv64_randconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
> +		-f $(srctree)/Makefile randconfig
> --- /dev/null
> +++ linux-next-20210715/arch/riscv/configs/32-bit.config
> @@ -0,0 +1,2 @@
> +CONFIG_ARCH_RV32I=y
> +CONFIG_32BIT=y
> --- /dev/null
> +++ linux-next-20210715/arch/riscv/configs/64-bit.config
> @@ -0,0 +1,2 @@
> +CONFIG_ARCH_RV64I=y
> +CONFIG_64BIT=y
> 


-- 
~Randy

