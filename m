Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D600326767
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBZTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:24:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA3C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:23:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w11so9612373wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OsztXS2pxF0mqVb9NZgLRR6d9O9wIrx2e3naQfnixyw=;
        b=mvJeaORv08NO8JFv6YX3OR8eF2mGEPxZfE4KvPhccDkBqlM+vFrbJ8EUbyPW+S4KFL
         IKg5IoaxhhzeHbhRwG7qmM1yla9/TV2WIFUHoLqAiLUPw9Eo1/xpVgYtQ5kMGqSMYMPo
         nCdzHOFFywol73/GqgJw3G1tqgQY2i6vmjlASg+WIWtL2gWbVucVYF9DYeHH2oUDF5mt
         YGhIgGCDR9xuuQYwjVngxJH5HrHTgat5f/CcwODnA3wAd/9GrQjArsY/xpDU9soy0/Np
         TlQyg2IS+HctwnnB+Pt5gfP5E+BMoXR2TwsYCLKkp5bWoXCoTi11PrEkafAmHa7dV1Zc
         x/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OsztXS2pxF0mqVb9NZgLRR6d9O9wIrx2e3naQfnixyw=;
        b=hAJKLXkU88JA6NqHN1kq4nx6se1x0ZA91h55blxJalVBe2NQgqC6oG6SgTo/Ko7oL9
         LcJX3vJKRRmG9zW3FE+iGhLMLfH83bDbsNhXLoFg9lVzrtNFKayhBQOSikazJk0EYc6C
         Pwpry+Brxg1damQKTC7YCAQKScCR0jstBeGaIaTacuF9wvcVA49kDPwgirvq393aUvRK
         qy+3hha3YTcSkh045oAIaWs7nt7t1QiVmKGBOuzhG8n8mswQm4kP5MH/1Rka1wzl3aDx
         LJ58jKDP4H1LY+A8MC3iteGlPbcvYD63Kygopinx1OCAZbhjo9HW0WVHvpM9/xLs20xt
         sEHA==
X-Gm-Message-State: AOAM532Tf8YtDhMy9vLh8m8nE5HNSJz5QhXfjhMccs9OIKFCinwgvU+w
        6uJo8juODbIkRppRlMkpaaw=
X-Google-Smtp-Source: ABdhPJwSLG2nJ/s2aJyqjLoRzlpNT/jkEbmhfYg2OHWfEm5RLYiq3iP9n9FdRbVdUHCVfr8UUSz6LQ==
X-Received: by 2002:adf:d20c:: with SMTP id j12mr4729579wrh.76.1614367405841;
        Fri, 26 Feb 2021 11:23:25 -0800 (PST)
Received: from [192.168.1.21] ([195.245.17.255])
        by smtp.gmail.com with ESMTPSA id t23sm13630703wmn.13.2021.02.26.11.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:23:25 -0800 (PST)
Message-ID: <141f3098744ea8d1cc39abcdce89c0e513bfbc70.camel@gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: don't use clang IAS for crunch
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Fri, 26 Feb 2021 20:23:24 +0100
In-Reply-To: <20210226164345.3889993-1-arnd@kernel.org>
References: <20210226164345.3889993-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, 2021-02-26 at 17:43 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Randconfig builds with ep93xx fail with the clang integrated
> assembler that does not understand the maverick crunch extensions:
> 
> arch/arm/mach-ep93xx/crunch-bits.S:94:2: error: invalid instruction
>  cfstr64 mvdx0, [r1, #0] @ save 64b registers
> 
> It is unclear if anyone is still using support for crunch: gcc-4.8 dropped
> it in 2012 when it was already too broken to be used reliabled. glibc
> support existed as an external patch but was never merged upstream.
> We could consider removing the last bits of the kernel support as well.

This was my impression already in 2006, that Cirrus is not going to work
on Crunch support. From my PoV it's OK to remove the support in the
kernel completely.

> Turn off the integrated assembler for this file for now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ep93xx/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
> index 86768495f61d..f686577ba059 100644
> --- a/arch/arm/mach-ep93xx/Makefile
> +++ b/arch/arm/mach-ep93xx/Makefile
> @@ -7,7 +7,7 @@ obj-y                   := core.o clock.o timer-ep93xx.o
>  obj-$(CONFIG_EP93XX_DMA)       += dma.o
>  
>  obj-$(CONFIG_CRUNCH)           += crunch.o crunch-bits.o
> -AFLAGS_crunch-bits.o           := -Wa,-mcpu=ep9312
> +AFLAGS_crunch-bits.o           := -Wa,-mcpu=ep9312 $(cc-option, -fno-integrated-as)
>  
>  obj-$(CONFIG_MACH_ADSSPHERE)   += adssphere.o
>  obj-$(CONFIG_MACH_EDB93XX)     += edb93xx.o

-- 
Alexander Sverdlin.


