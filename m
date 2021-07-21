Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A73D1819
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhGUToj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhGUToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:44:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825DC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:25:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a12so5052118lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MjXDOWyd73wlu1QIRqgI71CqpEzm7Ck3HKRbigN51sg=;
        b=kQ6TYLiVfqICNhW3OwZxp8Qfd7xGJUzTJ1xFrBLx5DD2I2xKISmzOkio1Y72PHh0B6
         Vu31dkKMQK56+NS8E2axT060bnbg8hN2uDHiYpRDnoA5Ge0mTiVIL30vY3OMxRJXPr7x
         siTcNehJaQOMOjVXDVAGpHOUf6KCLhER79LafdIb4rV90jtBPOkPy6dStSKOGYECGzWm
         HcHeLqJy/y/MJZ21LtTR62ZAkSgL9KdhpEfsLC4XcPlP3lzLOKyo0Q/PBTP6cDDQAkQ9
         QjpJlWl+DIx5eQpnGHf7N8XSiJKFd6JSFcLTqHiX4Cdh04M/rqRYXDHePDNakG7+eZE3
         p6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjXDOWyd73wlu1QIRqgI71CqpEzm7Ck3HKRbigN51sg=;
        b=IifpMsJr72r2stxCdkn95OEpYFa7UkQvXWrJAcQow1QzcofcyUHOmtC6u3eG5SQwRu
         Usho/uW6tgSQ0wFqGqND+ZmcFCwFPm3ZdngXk1ayY3RwxuGbrzEJTNLlYxIIJTc7VFE0
         yxMoX1XSFPQ98C0Z0uKIoMJOXdY1KX425iMpVmbhHTA25DBgHwSTsvexZNmEUloeMBjx
         ysjaNRnxgLMQB+MRTddF23Ft+BPPAomLbd3WfjF364LcufhnUzsRYa7+qrGXsAcRv3pt
         wcmpZ6ZvRbZRhfTVIrcxx+m9d7MgX0rFo7xR6rUxHHCYmvkl8QZdkR3u3XQ+UTWAA2eA
         4h9Q==
X-Gm-Message-State: AOAM531eLxu/r5ADB8LgkZhJeyQV/oJmLp+Ff3/UeYh6BJh3ZZpSRZrj
        ySPOFBU1WBWbN1SPAeg7rKR7LPe5KDeMpayIJaqyRw==
X-Google-Smtp-Source: ABdhPJz+Ibpdq9t9/cUreWhO5XZT1p+ryHZn3jXNVmSjN+McdT77o4jR3PjGVJNH4azveTk6PTf1wq1eqskPw47GurI=
X-Received: by 2002:ac2:5312:: with SMTP id c18mr25904144lfh.649.1626899111566;
 Wed, 21 Jul 2021 13:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151620.2373500-1-arnd@kernel.org>
In-Reply-To: <20210721151620.2373500-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jul 2021 22:25:00 +0200
Message-ID: <CACRpkdbpb-mVHQackyJM=yP=TS2c=6zM+ZXfbHZPWfR6cR+xUw@mail.gmail.com>
Subject: Re: [PATCH] ARM: ixp4xx: goramo_mlr depends on old PCI driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linusw@kernel.org>, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 5:16 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When this driver is disabled, the board file fails to build,
> so add a dependency:
>
> arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'gmlr_pci_preinit':
> arch/arm/mach-ixp4xx/goramo_mlr.c:472:9: error: implicit declaration of function 'ixp4xx_pci_preinit'; did you mean 'iop3xx_pci_preinit'? [-Werror=implicit-function-declaration]
>   472 |         ixp4xx_pci_preinit();
>       |         ^~~~~~~~~~~~~~~~~~
>       |         iop3xx_pci_preinit
> arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'gmlr_pci_postinit':
> arch/arm/mach-ixp4xx/goramo_mlr.c:481:22: error: implicit declaration of function 'ixp4xx_pci_read' [-Werror=implicit-function-declaration]
>   481 |                 if (!ixp4xx_pci_read(addr, NP_CMD_CONFIGREAD, &value)) {
>       |                      ^~~~~~~~~~~~~~~
> arch/arm/mach-ixp4xx/goramo_mlr.c:231:35: error: 'IXP4XX_UART1_BASE_PHYS' undeclared here (not in a function)
>   231 |                 .start          = IXP4XX_UART1_BASE_PHYS,
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~
> arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'gmlr_init':
> arch/arm/mach-ixp4xx/goramo_mlr.c:376:9: error: implicit declaration of function 'ixp4xx_sys_init' [-Werror=implicit-function-declaration]
>   376 |         ixp4xx_sys_init();
>       |         ^~~~~~~~~~~~~~~
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: soc@kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ooops
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
