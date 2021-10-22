Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F97437376
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJVIII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhJVIIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:08:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658AEC061348
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:05:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so194087wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LwLOjATYr16Reu88cmUIiFsuPl67ksCMcRHqfpd8xTg=;
        b=byB4vm/duyudlBLRci0SgANJ0Wauf4h1mxCu9AeH943eO2VqyYEln2BOc8qI8NrEES
         eXv2Fs8+MIZ41siPMuzbBtpWnKbFQGDSZfqgd5WK49TzTJiqeIq++RoGSBWyKeo374ac
         t2xFjdSUvjpx97E5IxA/CjSjk+Q7f4SYZhSYYeZy5Jvtld6mHQsTliODHQE+y7ZiW9TX
         wPcshckxpjxYl9cvaKGzMUrmUQPUWE/nDcKjvD6uSXKIXoyI/9bMxwwrr988txUvhXS3
         GXA8O/RDETEG8HdL16v1hlsFTJ6xL5z/Kp9r9K/DFkJyUm6rAI9N6ZUs9bDijENN2vZA
         7JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LwLOjATYr16Reu88cmUIiFsuPl67ksCMcRHqfpd8xTg=;
        b=H5uOS5EgTGtK3/U4gpuTHfvmtOonLHZpEzz8tBqAgvZLrtP2cUCgUZnOw5xXJAxxBl
         Dl/qnEfJRqw7L8nltp1AwRf7XRplj1ETu1CFDPDybKSzjDlIyYiKtOgLWB5wAT1WQQVf
         4RE0g+YgCy6P//vnn+7wqNBeprifbgNzsMsfdZ/msHG+3IWeCmYk5PIMrYWlGD7i6JYx
         NTFXaIBqNU4qVDTLUdduMaTU14bJYYYDDw8p05OYxfvultF+Fq8k1JsDFvI1n7CARJfu
         0v0qhaShyefANcK8gGVZpXRSduHsGfn2cp9sxIIz9XqKP2K6VBQtFrpgSw/SukPgteLO
         UGsQ==
X-Gm-Message-State: AOAM5327ufbjJzpdAhk3gmUsK3bXyHi03s2wGVaYC186JrzDKRBCsbzD
        YiOnPV5WhvmnYswb5TLRxHmodQ==
X-Google-Smtp-Source: ABdhPJy1gKz+t3xHUGfmL2xIDoRAS+7r13b/9+FPupmzbGivyUoJ3E//1yaY1pzMin2NHQFEyLUtSQ==
X-Received: by 2002:a05:6000:156e:: with SMTP id 14mr9707827wrz.358.1634889947953;
        Fri, 22 Oct 2021 01:05:47 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id l6sm7283123wmg.10.2021.10.22.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:05:47 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:05:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>, Wolfram Sang <wsa@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 3/3] mfd: tps80031: Remove driver
Message-ID: <YXJw2fX42REHylOy@google.com>
References: <20211021192258.21968-1-digetx@gmail.com>
 <20211021192258.21968-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021192258.21968-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021, Dmitry Osipenko wrote:

> Driver was upstreamed in 2013 and never got a user, remove it.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/Kconfig          |  14 -
>  drivers/mfd/Makefile         |   1 -
>  drivers/mfd/tps80031.c       | 526 -----------------------------
>  include/linux/mfd/tps80031.h | 637 -----------------------------------
>  4 files changed, 1178 deletions(-)
>  delete mode 100644 drivers/mfd/tps80031.c
>  delete mode 100644 include/linux/mfd/tps80031.h

> -static const struct i2c_device_id tps80031_id_table[] = {
> -	{ "tps80031", TPS80031 },
> -	{ "tps80032", TPS80032 },
> -	{ }
> -};

This is an I2C driver, right?

I was under the impression that Linux could do auto-probing on I2C
devices?  Such that they do not require platform code or DT in order
to bind?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
