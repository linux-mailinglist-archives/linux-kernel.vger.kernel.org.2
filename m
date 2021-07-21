Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151813D1818
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhGUTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhGUTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:43:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D072C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:24:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s13so5020587lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1fSEVFqUHw4YbE91AcPQyxQQAoQKEf3Quu62fEWYpM=;
        b=eNPhHfJRAQmHqXGo9tKdmBMr74Yzifs4VEpKtVWbGpAw3a/ia6SnGPHN++Kg8qNYti
         C2LVca0Zr+CXXv9RqN+9hrUMF8Dy5GlxC9gO2+cGGRoLca9eyCTkOiQkPm+LMc6HAe9K
         LxdQgK7NHnJd5T1mUubdTOkVkknGaQKzOzFIzFfZV6bZFL/L47auyl/st/0JMNR4b5Wn
         qy8/dPed+bfqT0AnW/VcqDSrlSFJ+mxn1G/89uIDBwPD1ADuA/q45pw1K0bH2X2TN+Tv
         MJA+qsN0kRCWuq9Pm1AadJdT/Rce3ppBKvd+S0Ib7jw9IABUZiwoyQ3HC69WF1Jn8Yp8
         Y1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1fSEVFqUHw4YbE91AcPQyxQQAoQKEf3Quu62fEWYpM=;
        b=COt/wguUvva3PQBSE62eX0dL0N3J6nZn9KRYbBUSROiPQunYGuSMUm4VDBELG5KxNG
         cWgpU//tFJhC1blDHgZhxUgKzXpoHGhA/AQb+KUHL9ghhQ6jtyUx9I+5VCF2vXOKh2PR
         C7+MRBZGJRVhjDb7erzH3aw6HSAeYN53W+Oybn6IqaWGeaxNSUNEHHmL8ZfyH/bcH+FC
         mFhdKYy3qCPRH323qYuClD6YzYjSsmXj/+iGlPGqTqUqD+uIgKplsz9gPrZyAqkLSSkC
         PcvnPCfhIMPTbBrxD2/yF6WbEBNPB6tNl7rWG07JRHsS2GpTOyGo9xEkdF0D2QvaYxu8
         HACQ==
X-Gm-Message-State: AOAM531N5sdBqS5jW8WF3BljQZWU8mfvq1TEdKkpOqAN+rzJlSuJBn4e
        dQG5SSvL9fJNUp5pTVWeCKESlqXSzlFC6rbgDUuNrQ==
X-Google-Smtp-Source: ABdhPJyGeXguhortkkfg6BjqS34WA20M1SIfJqsW4mpXW18zkOgpVQv39lVckpNO2cFGBH/aqAfnxROqkwH5q24AkQI=
X-Received: by 2002:a05:6512:169e:: with SMTP id bu30mr6326301lfb.291.1626899057636;
 Wed, 21 Jul 2021 13:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151546.2325937-1-arnd@kernel.org>
In-Reply-To: <20210721151546.2325937-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jul 2021 22:24:06 +0200
Message-ID: <CACRpkdbuXkvOkMNizqmRPwuYz-YU8j-yidtXsOAmEd4z3B0hVA@mail.gmail.com>
Subject: Re: [PATCH] ARM: ixp4xx: fix building both pci drivers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linusw@kernel.org>, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 5:15 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When both the old and the new PCI drivers are enabled
> in the same kernel, there are a couple of namespace
> conflicts that cause a build failure:
>
> drivers/pci/controller/pci-ixp4xx.c:38: error: "IXP4XX_PCI_CSR" redefined [-Werror]
>    38 | #define IXP4XX_PCI_CSR                  0x1c
>       |
> In file included from arch/arm/mach-ixp4xx/include/mach/hardware.h:23,
>                  from arch/arm/mach-ixp4xx/include/mach/io.h:15,
>                  from arch/arm/include/asm/io.h:198,
>                  from include/linux/io.h:13,
>                  from drivers/pci/controller/pci-ixp4xx.c:20:
> arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h:221: note: this is the location of the previous definition
>   221 | #define IXP4XX_PCI_CSR(x) ((volatile u32 *)(IXP4XX_PCI_CFG_BASE_VIRT+(x)))
>       |
> drivers/pci/controller/pci-ixp4xx.c:148:12: error: 'ixp4xx_pci_read' redeclared as different kind of symbol
>   148 | static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
>       |            ^~~~~~~~~~~~~~~
>
> Rename both the ixp4xx_pci_read/ixp4xx_pci_write functions and the
> IXP4XX_PCI_CSR macro. In each case, I went with the version that
> has fewer callers to keep the change small.
>
> Fixes: f7821b493458 ("PCI: ixp4xx: Add a new driver for IXP4xx")
> Cc: soc@kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I tried very hard to make it impossible to build both drivers at the
same time :(

Oh well I guess I failed. Kconfig ... say no more.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
