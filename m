Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668AA3DD241
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhHBItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhHBItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:49:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0788EC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 01:49:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so7805714wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oS4lE7ssaw+gValSJ1G5a+zfogb8J5bISQ28SiJZ3MY=;
        b=gYUDbVhA1ZxEjXZFrI4OlwQ4268BRoqI4gCTGaEP/MfISQCkq9aZJfoMlFIIPsAcph
         /oHOXtUFpo5JgfaODg7whj8J4hXiNt3/kHyPr90PlsCNMqPeIwoNbe1Iig8K+Cr9u4qa
         KLqCzpJcpf84kiSbO8cGC+eJbu9UlzZunGgsM8GYYqmD4NpV6JxUaoUUv8DTPNCT7EM4
         1EGaNoq2R/TES6hkkN0IFZNcIBiFrJUg2t/9j8qKO+ihY/BO7i3hH1VKUlecv3egosHY
         BymOrHpKYfuz4+udKrqHjJMwyQU3q81UK/BAqc+E7dQbtGkGb2/DlNnBF+lrRMbefh9x
         YT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oS4lE7ssaw+gValSJ1G5a+zfogb8J5bISQ28SiJZ3MY=;
        b=fbdqVONE5jQVqEIkGSH7NAXy00A4n9q61TtAsSI9hNADYTxUjEiIcodvA3ei1+GpEs
         f5l9TDeKZw5ce5KtBoLGEN6OVgeykcY08/AgSwD1AWIAqTXtVbxn08FlHF1UpwFQLli9
         8aUYzPhSgj3Ip+/cAK3dOBUUwRQMYAuV2kQd+5ILG1V1Ua3cuoyQnR4K4miPeqCYLdxe
         EkvclV37bAWMHESuDu29Od/IeA9uYouSiok/skJ6E5qMUBi/ESjp+kejc6aIJRmCTI1Y
         /4cFWMqq7WJWBTGQJMyEvfezL5dp7YkzixwsJpYZjz64XIw5xItvFCKyTspSMuUL37iU
         A37w==
X-Gm-Message-State: AOAM531hfsjmgG5WRnvxPpbPJ0wSfV/pSFdQwl/o+CpI7OM7/qhd0blo
        WiJB0dU+H5s2iUY4vqPrplwEyw==
X-Google-Smtp-Source: ABdhPJzDHBWmYChUlgAKktSx26Mvt1Lovf+PhRNq961z+O/UQFFtaPHcojCur1lq4Vmg6dwHeXS5qQ==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr15628948wmj.181.1627894141641;
        Mon, 02 Aug 2021 01:49:01 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id q22sm9453528wmc.16.2021.08.02.01.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:49:01 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:48:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1 1/4] gpio: dwapb: Unify ACPI enumeration checks in
 get_irq() and configure_irqs()
Message-ID: <YQexe1daiEsHxT7j@google.com>
References: <20210726125436.58685-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210726125436.58685-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021, Andy Shevchenko wrote:

> Shared IRQ is only enabled for ACPI enumeration, there is no need
> to have a special flag for that, since we simple can test if device
> has been enumerated by ACPI. This unifies the checks in dwapb_get_irq()
> and dwapb_configure_irqs().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-dwapb.c                | 13 ++++++-------

>  drivers/mfd/intel_quark_i2c_gpio.c       |  1 -

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/platform_data/gpio-dwapb.h |  1 -
>  3 files changed, 6 insertions(+), 9 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
