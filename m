Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742F7332156
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCIIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:50:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhCIIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:50:02 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJY40-00034t-IT
        for linux-kernel@vger.kernel.org; Tue, 09 Mar 2021 08:50:00 +0000
Received: by mail-wr1-f71.google.com with SMTP id i5so6110781wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 00:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SPN8vZGI8qCPyOxRkgbIoU+nCJADrRpUpS5VZAd17hQ=;
        b=fM6u7mFzSvEH1OVBFuPv4XyGUoNgpeXMw4Fq/6O9+LdiqFQWhTkboQIK/J8GVCGYQX
         iJ3P2uq+de1U4n5DRAT0lgENYcsp9Fhnx2VSCDhmKx380BiIPU584QD8g/0ygiluQUIQ
         b8nnbb/CD7YlCtaMHjfzUs/Yd5yqyNxZo8mnLFOlbP/scvpy96vI+AMyCFmyhk7qqjpi
         cMHQuwshOIIkxFek/d5Jwm+/pSPmeWQjxp9rnz1TwJTUNY7Wt8bRUQRdQpgd6z3pOy6s
         8Neqt+qYDT1uGRAKIA8hw9J7ypUkmIZ5X95MO87fPgKLyaCxL21K61FqZYmtEhbgVuYO
         kJig==
X-Gm-Message-State: AOAM530hC7EKIRRinZqf3m/QGBgGiS+PDE+i8us3hG8K+br2/YtNXdwP
        Uql9lhjnLqmOWxQFq27PrHgYq+/bWGyaIwVT6tqYIaojfR/GmLHttoGx7rpFKkBN4UBqPc0n4D0
        dZdRREfdW+hgrRrsbIJwdcyZVhI++Bxo0G8MzatEoNw==
X-Received: by 2002:a7b:c409:: with SMTP id k9mr2773968wmi.151.1615279800329;
        Tue, 09 Mar 2021 00:50:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrJZNyJE9B32wem/EqH35cn/jWxU3fIpyhIw/276Lggs/nwF/mHfMonQ9ARhM+9bPT/mJeAQ==
X-Received: by 2002:a7b:c409:: with SMTP id k9mr2773952wmi.151.1615279800191;
        Tue, 09 Mar 2021 00:50:00 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id p27sm3068427wmi.12.2021.03.09.00.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 00:49:59 -0800 (PST)
Subject: Re: [PATCH 3/3] clk: socfpga: allow compile testing of Stratix 10 /
 Agilex clocks
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org
References: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
 <20210308182339.379775-4-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9c8109f7-47b3-a865-5bd7-656b7c3c318f@canonical.com>
Date:   Tue, 9 Mar 2021 09:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210308182339.379775-4-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 19:23, Krzysztof Kozlowski wrote:
> The Stratix 10 / Agilex / N5X clocks do not use anything other than OF
> or COMMON_CLK so they should be compile testable on most of the
> platforms.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/clk/Makefile        |  5 +----
>  drivers/clk/socfpga/Kconfig | 22 ++++++++++++++++------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 12e46b12e587..9b582b3fca34 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -104,10 +104,7 @@ obj-y					+= renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>  obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
> -obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
> -obj-$(CONFIG_ARCH_AGILEX)		+= socfpga/
> -obj-$(CONFIG_ARCH_N5X)			+= socfpga/
> -obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
> +obj-y					+= socfpga/
>  obj-$(CONFIG_PLAT_SPEAR)		+= spear/
>  obj-y					+= sprd/
>  obj-$(CONFIG_ARCH_STI)			+= st/
> diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
> index 4922cc35f4cc..de7b3137e215 100644
> --- a/drivers/clk/socfpga/Kconfig
> +++ b/drivers/clk/socfpga/Kconfig
> @@ -1,13 +1,23 @@
>  # SPDX-License-Identifier: GPL-2.0
> +config COMMON_CLK_SOCFPGA
> +	bool "Intel SoCFPGA family clock support" if COMPILE_TEST

Kernel test robot found here wrong configuration - possibility to
disable the clocks with compile test. I'll send a v2.

Best regards,
Krzysztof
