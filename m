Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFEB452D10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhKPIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhKPIp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:45:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F263C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:42:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so84366278edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYV6ksTi25ix0CD8L4FcMKWab0S1ZzUdjgFr7L9nZwE=;
        b=57m9St9AVOh8pj4WMB3sEYhx/yBiLzpAHOxtpJ0bEtFWTj9CxHAdGnjOBNJWzv1WeV
         UTBDQprwv0euYmK6nKzU6jJR1jZ5NMaYNoABTq19ASX9g9Qet0T7F+U4Vy6L1ROChWiE
         AGUbPUPd9BQzK5mT7HpNAP7oPU7Dz9OpEIEykl1FRkhoOQnGAGSq+VPNhw6Tv5vsOV/0
         tFqcoT2z93lN2b+pVEFdPd7OTK11wVor4SHk2GPpH24T4kcwUY6qLZipn923S4+p+YLC
         J/pvQ2iSIfWdr2mFPStJosBnVoyD3cex7UEGq86a9hQ2sG27SZ/wrPeSDWMDIXOCfuOM
         YILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYV6ksTi25ix0CD8L4FcMKWab0S1ZzUdjgFr7L9nZwE=;
        b=leHos6CcnQY6A+GZ/h3p+J0dFRyD1Pc1vuLUx4+zfqKyNiKOwbfimTlyH4FhGpBvlW
         jyS9Soh4GvRfUnx0jqE2KxdocBvgp1KE8Fs2Byr0gyqzBpeVAGHSbjJaRM99DXg21I9s
         DIZPVQm6xbTPMaf83y9TuBzm5cdYNYfY/LPnTujSsdkyf1G4L7w155fDXSiRDFGoKotj
         kX6JXxVTJ0DQhiIQoQs/IA9ck8rxvtqQSnYkf/TTxZzJSifyBae3hYBVxt9iS8HE5JQn
         /R3WRg3VoLG4WEX7wUOL7raeGoKmqwSgsmGdVyc9FDsLJAjHLbUKD/eyfPqjJ6/xym2a
         iEsQ==
X-Gm-Message-State: AOAM530rLeQRCdWZE21vUSxMu5pNOI3/n2uTQfQBSOmftJ0oYHnC2aAU
        +tom6vTAfV3gUGZE3uNhtj1m0+Fg/3859izz10MmaA==
X-Google-Smtp-Source: ABdhPJxv/WGMs9OLCxx1pX2wTf2x+92LsB1mD92Ttb1/XTREQ4MCOo+4Chczew7/oujnW992feiOFpmGbioZR+dh9WA=
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr7761729ejc.433.1637052147954;
 Tue, 16 Nov 2021 00:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20211116064627.27115-1-rdunlap@infradead.org>
In-Reply-To: <20211116064627.27115-1-rdunlap@infradead.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 Nov 2021 09:42:17 +0100
Message-ID: <CAMRc=MdtkLgAFGwcKje4D9-nBXB8n5u=9zBzLFJ+w-RvmbNd=Q@mail.gmail.com>
Subject: Re: [PATCH] gpio/rockchip: needs GENERIC_IRQ_CHIP to fix build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 7:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> gpio-rockchip uses interfaces that are provided by the Kconfig
> symbol GENERIC_IRQ_CHIP, so the driver should select that symbol
> in order to prevent build errors.
>
> Fixes these build errors (and more):
>
> aarch64-linux-ld: drivers/gpio/gpio-rockchip.o: in function `rockchip_irq_disable':
> gpio-rockchip.c:(.text+0x454): undefined reference to `irq_gc_mask_set_bit'
> aarch64-linux-ld: drivers/gpio/gpio-rockchip.o: in function `rockchip_irq_enable':
> gpio-rockchip.c:(.text+0x478): undefined reference to `irq_gc_mask_clr_bit'
> aarch64-linux-ld: drivers/gpio/gpio-rockchip.o: in function `rockchip_interrupts_register':
> gpio-rockchip.c:(.text+0x518): undefined reference to `irq_generic_chip_ops'
> aarch64-linux-ld: gpio-rockchip.c:(.text+0x594): undefined reference to `__irq_alloc_domain_generic_chips'
> aarch64-linux-ld: gpio-rockchip.c:(.text+0x5cc): undefined reference to `irq_get_domain_generic_chip'
> aarch64-linux-ld: gpio-rockchip.c:(.text+0x5e0): undefined reference to `irq_gc_ack_set_bit'
> aarch64-linux-ld: gpio-rockchip.c:(.text+0x604): undefined reference to `irq_gc_set_wake'
>
> Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/gpio/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20211116.orig/drivers/gpio/Kconfig
> +++ linux-next-20211116/drivers/gpio/Kconfig
> @@ -523,6 +523,7 @@ config GPIO_REG
>  config GPIO_ROCKCHIP
>         tristate "Rockchip GPIO support"
>         depends on ARCH_ROCKCHIP || COMPILE_TEST
> +       select GENERIC_IRQ_CHIP
>         select GPIOLIB_IRQCHIP
>         default ARCH_ROCKCHIP
>         help

Applied for fixes, thanks!

Bart
