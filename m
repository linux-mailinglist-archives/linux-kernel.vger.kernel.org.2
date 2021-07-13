Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D740A3C6F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhGMLYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhGMLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:24:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12DC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:21:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f17so29995089wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X8xv8rGJpjxSJR0ZZ1INoCyEgsaBC8NAw+scozjjM+4=;
        b=AQj5e6C5XEeEXRIG8v5iLTKUk/Gr+MfghzTZo8yRS78ajPrpvbWofiwJitoaFyhLuo
         xZWD8vvLdBGMNZAa/xRnm/OaZYHeROA5x4cEQ6GcnizCn8Kb+S3E1DNP2ohD/1LkjUsV
         JXo0E3pqVk4zR+ynXd1mEszsKw1zzrHlsJLiZ4bJY6qtv9ZHQEzZOxU8a1YuiTDgVgiJ
         gvQ4NIuP7HNAi64RHyV1zMbaITNeGvd8yVlenMZXHOOhT7YGuYC0/GBueVZgVHQdIC3A
         J3Z/XGcyd8IyiOz1eYq6AxZ/K4Q1tlKR+/f0b0yv+W1XblF7p76jJdC7oinLOqXsBFcb
         kHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X8xv8rGJpjxSJR0ZZ1INoCyEgsaBC8NAw+scozjjM+4=;
        b=RU1yewdRGlDrNhsYFhHOWCz7gQ9xXSP3Utr8e7SxtIP8gnUnSPApoRZVhaYwJl1VEj
         fHp18UgG13P9SewVqE7MXxJ/i/r1Pdwp5rDkq9vmNbGPZmJ5s5Nx+icWX5/uONuXmUIt
         408Zvd0HDdodwyty2ktJGTq6hhGPOl79WZGPtkgNTkAjRf5AjBevDDbyIGg6skPjIAL0
         iZ14+oLnlOP78UFZhuzFma+EMSlfXeB8oVugBmOruI7g1Bs7le3S0j0Lsj11Yo2/r7Pe
         4nh6BkMtrxB09gI9BX2gv8A+z5S8Ci0Y7D1D+pOSScHhgNUICAMz3qfz2sfr37A1YSyG
         8BLQ==
X-Gm-Message-State: AOAM533tAUymMYaLDuuyg99H9YktchM6IvOrinUK/W9hvWis/5BiVnBh
        fjMzmYD7GC0tnFtwTavAp6FRJA==
X-Google-Smtp-Source: ABdhPJzvwdJ9sSppz5IFDqWf15tQKfpvXfce8bcoiU79NtRboFEl4fye5d5p3ODywxEdlU27mR6fwg==
X-Received: by 2002:adf:ef11:: with SMTP id e17mr5064905wro.71.1626175301338;
        Tue, 13 Jul 2021 04:21:41 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id g7sm1948824wmq.22.2021.07.13.04.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 04:21:40 -0700 (PDT)
Date:   Tue, 13 Jul 2021 12:21:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     sameo@linux.intel.com, grant.likely@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YO13QgPCcsFg+Yta@google.com>
References: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021, min.li.xe@renesas.com wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> Add support for ClockMatrix(TM) and 82P33xxx families of timing
> and synchronization devices. The access interface can be either
> SPI or I2C. Currently, it will create 2 types of MFD devices,
> which are to be used by the corresponding rsmu character device
> driver and the PTP hardware clock driver, respectively.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Change log
> -create the core driver suggested by Lee Jones
> -export rsmu_ddata instead of platform_data suggested by Lee Jones
> -add support for 8v19n85x chips
> 
>  drivers/mfd/Kconfig              |  28 ++
>  drivers/mfd/Makefile             |   5 +
>  drivers/mfd/rsmu.h               |  16 +
>  drivers/mfd/rsmu_core.c          |  88 +++++
>  drivers/mfd/rsmu_i2c.c           | 203 +++++++++++
>  drivers/mfd/rsmu_spi.c           | 273 +++++++++++++++
>  include/linux/mfd/idt82p33_reg.h | 112 ++++++
>  include/linux/mfd/idt8a340_reg.h | 729 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rsmu.h         |  36 ++
>  9 files changed, 1490 insertions(+)
>  create mode 100644 drivers/mfd/rsmu.h
>  create mode 100644 drivers/mfd/rsmu_core.c
>  create mode 100644 drivers/mfd/rsmu_i2c.c
>  create mode 100644 drivers/mfd/rsmu_spi.c
>  create mode 100644 include/linux/mfd/idt82p33_reg.h
>  create mode 100644 include/linux/mfd/idt8a340_reg.h
>  create mode 100644 include/linux/mfd/rsmu.h

Thanks for sticking with this.  I still have a couple of minor
niggles, but they'll be fixed over time.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
