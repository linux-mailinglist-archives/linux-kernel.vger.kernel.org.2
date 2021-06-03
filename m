Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD639AB08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:46:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49497 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:46:49 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lotH6-0006i9-31
        for linux-kernel@vger.kernel.org; Thu, 03 Jun 2021 19:45:04 +0000
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso2350042ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 12:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bkatCSOblhJnW0MXA23OfZ+fFl/GArRo3ZEN7l5hv/Y=;
        b=aJxtmyAbAtr77GHeueEK8p8SsCoVMr0N9z3Kbw6KJcmCYehMS8XYoRMmUF2vlTBIVe
         6j733pIkKqcGMmb+n4qbp+xLpAl/LHsv4gz0iOZiMm9soocCRPHol8mFCO7zxtcGVoFK
         O0Uv1VA+lXMzM2jb5JOYewtxoS7LO8mNe+J6liNBUUulC3wQFfuMrAsyoKHiPRfuX0cy
         QtfwoFLmONnHdw+R63qfNVzPVRjeZIKpCCu3wnG39a3dP/DLO7Pc/OGwbgd0W7h8pEy3
         HvLOwFL0dt5K2ib7noWkp2OVfGpIBQybIIocanyb6OxSS3UQW8HoiHNutMI4TSo75ndQ
         X+9Q==
X-Gm-Message-State: AOAM531rySmrVJgw/1TRVnDLcmsHZaLRg0gIXJkVFVeztv1mUEsLO4Kc
        CE7rTj5HoMOmhnc02rT4bro7YS2m31oZoUUGQPs/d+XzhBoQkjDddagsdfGuJ1QYyRad2UW86q9
        A873JdxSE/Djy/SjhGkCveSFuy6KdcTyVxYMMgLULKA==
X-Received: by 2002:a17:906:b048:: with SMTP id bj8mr884406ejb.236.1622749503344;
        Thu, 03 Jun 2021 12:45:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6yvSwMykb7JWVrdKR3u7XQKJIwG1s3xs7STX7qqVVMu0IHevSNBS8K6H4wsGP/0U8wANWSw==
X-Received: by 2002:a17:906:b048:: with SMTP id bj8mr884393ejb.236.1622749503213;
        Thu, 03 Jun 2021 12:45:03 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id f6sm1867292eja.108.2021.06.03.12.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:45:02 -0700 (PDT)
Subject: Re: [PULL] memory: tegra: Changes for v5.14-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603143739.787957-1-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a4126d48-f5fa-d20c-9874-fc8ac78febb0@canonical.com>
Date:   Thu, 3 Jun 2021 21:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603143739.787957-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2021 16:37, Thierry Reding wrote:
> Hi Krzysztof,
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.14-memory
> 
> for you to fetch changes up to b4f74b59b99fab61ab97fc0e506f349579d8fefc:
> 
>   memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table() (2021-06-03 14:24:03 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> memory: tegra: Changes for v5.14-rc1
> 
> This stable tag contains Dmitry's power domain work, including all the
> necessary dependencies from the regulator, clock and ARM SoC trees.
> 
> ----------------------------------------------------------------
> Dmitry Osipenko (18):
>       clk: tegra30: Use 300MHz for video decoder by default
>       clk: tegra: Fix refcounting of gate clocks
>       clk: tegra: Ensure that PLLU configuration is applied properly
>       clk: tegra: Halve SCLK rate on Tegra20
>       clk: tegra: Don't allow zero clock rate for PLLs
>       clk: tegra: cclk: Handle thermal DIV2 CPU frequency throttling
>       clk: tegra: Mark external clocks as not having reset control
>       clk: tegra: Don't deassert reset on enabling clocks
>       regulator: core: Add regulator_sync_voltage_rdev()
>       soc/tegra: regulators: Bump voltages on system reboot
>       soc/tegra: Add stub for soc_is_tegra()
>       soc/tegra: Add devm_tegra_core_dev_init_opp_table()
>       soc/tegra: fuse: Add stubs needed for compile-testing
>       clk: tegra: Add stubs needed for compile-testing
>       memory: tegra: Fix compilation warnings on 64bit platforms
>       memory: tegra: Enable compile testing for all drivers
>       memory: tegra20-emc: Use devm_tegra_core_dev_init_opp_table()
>       memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table()
> 
> Thierry Reding (3):
>       Merge branch 'for-5.14/regulator' into for-5.14/soc
>       Merge branch 'for-5.14/clk' into for-5.14/memory
>       Merge branch 'for-5.14/soc' into for-5.14/memory
> 

Thanks, pulled.

Best regards,
Krzysztof
