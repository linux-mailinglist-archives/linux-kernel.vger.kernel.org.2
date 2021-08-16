Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC23ED647
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbhHPNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhHPNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:07:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34AC0612A5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:05:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so6398549wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2TLMUpZsqF9Ae6W7VovKuderGPIdSJS+4m+ITA9mHpo=;
        b=ZUnYgPXkLdSduyaLopovzb7t3m77GLXmNIo+lAR56M3bWA1fewt6xbtZ8Q4PBUhhFB
         /0tmbWG3vVKZ31lbHkgE9U19EFeS2b7Kg6Gg/j8WoMeug5aCOl14GOHUZkfBkX1yiSTf
         zRVrO+g+N53DM21uhqj37vACNsQzqo3sR2nuUfH/7Qe+WmexChuWZtXhMwP1HGYheUQ0
         Te/ARLaxNvKjd951Tws59ErAbyQWmYdcSrZL+CUPTLtPeEKStVjtRBJAT3wCZqKnBPfT
         UixYiJ/bJGOWCrx1qtTeEX37jo90g+GEffP4HQQxmyoVpYS0cXol/bvMxZ/Txa+i6WqP
         dSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2TLMUpZsqF9Ae6W7VovKuderGPIdSJS+4m+ITA9mHpo=;
        b=cR+x9lgxkGulQ4t+We/d3kMX9iM6KPVWQO1JVY9dA0A+543wXl6VxeYv02WLxjyoaD
         aehDjfYwQbNZwB3Lvjx/u/IlKfOLE9kYyKR3na/pwrWxyrGo0kyCVD74L/P/EeV9iMYG
         o01tkIrfeV5L5EXHSnmvhkxAGYKn7cN+lbnfEIqRCSNUlfedKVtj8EQksxq/vB3qBywM
         ACoiBIyPNxpvz1I6yB+9WFvU25sCd6UDHr/KGRvfFb935G5w3NYx9bPjnOwZEVWxO0ae
         RwDGJ2gMILCFu9Agg43HbZ7w/q39BS3r9nGLF4i+8VSKuXpImYNWBNy/J0kUdpoXApRJ
         I5HA==
X-Gm-Message-State: AOAM533CQGm9hUT95FEk5zFairbHMulKCd1kXUKCc8/bK1shXzxYupdr
        1+XuB+Sjv2ab6w7B8stFaXb+4w==
X-Google-Smtp-Source: ABdhPJwZVap8mxiIL4sMvu8z3kLgqrFgMMLnVxTQDMX0agP6RVd4BhUaRhzvHWuJuOn1EigzudOUYg==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr18067467wrn.120.1629119110855;
        Mon, 16 Aug 2021 06:05:10 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id d8sm12334380wrv.20.2021.08.16.06.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:05:10 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:05:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v1 3/4] mfd: intel_quark_i2c_gpio: Convert GPIO to use
 software nodes
Message-ID: <YRpihHP3kDz5nYV9@google.com>
References: <20210726125436.58685-1-andriy.shevchenko@linux.intel.com>
 <20210726125436.58685-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210726125436.58685-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021, Andy Shevchenko wrote:

> The driver can provide a software node group instead of
> passing legacy platform data. This will allow to drop
> the legacy platform data structures along with unifying
> a child device driver to use same interface for all
> property providers, i.e. Device Tree, ACPI, and board files.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 70 ++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 33 deletions(-)

Doesn't seem to want to apply.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
