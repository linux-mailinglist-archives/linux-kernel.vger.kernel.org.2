Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E33A1560
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhFINWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:22:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42821 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhFINWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:22:49 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqy8b-0006fp-UI
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 13:20:54 +0000
Received: by mail-wm1-f72.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so2536094wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/jeQfD/PRU7+ZLKVWo4kW6eSKyG/9GBLEURDHxDyzY=;
        b=CfBUBYz7Tb5zZ3LTa8Wgf0QcBoghU9r3pMCSlLSm3VZ7BvDE5l/cYmxU9xAhp+mrDP
         3uDKWoLNwhuIOdYXGQ+o+WnR11+46/IBcriqiPl5Xofa8eGaMprWkM1DBVPxOv0dD2rS
         Yrudu/7lIfqwh/cCw+gJ2mSGInI7JuwWNhM69i4lEINV9Ksr/8/Oh9MBsFUIi9O/j0s0
         3xW8vJGWTLJa2LEfyrskxaROZ42RW9C8A7v0c5pRl9dxb/jo7j7+9YMlUhvnvk0BBtWv
         yQKK66bjqQSd167KwC/coY95yB0Tp3CpRhSJvpyDmNYWgRdOG6PqNH/7E6i2BmJfez1l
         Ki2w==
X-Gm-Message-State: AOAM533baAiTovUdDkk9NCIXo5UtWaX/ogPy4+iwqaycsIkpOWT1sH/k
        NgjWGnDkPBHsSBHo6eqcphDfOjd6ohm5TBzU4Pxv5CsJMvcGFZbuvy4S7RGvxcQReidzosjKtJE
        0Kwnt2MBRYj9/lJZdYVAC5EOI7rAAQhRseSjYOO1IjQ==
X-Received: by 2002:adf:e5c1:: with SMTP id a1mr28431604wrn.16.1623244853596;
        Wed, 09 Jun 2021 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPwIER/U8HjPgFdgQi+5438sNuC/K4BzQ7DUDd3BFdNyrQXv/3PhyC1zXgJG2F7mvCt819Hw==
X-Received: by 2002:adf:e5c1:: with SMTP id a1mr28431577wrn.16.1623244853437;
        Wed, 09 Jun 2021 06:20:53 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id v15sm2086058wrw.24.2021.06.09.06.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:20:53 -0700 (PDT)
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <184b726d-fa8a-d708-df95-a0a7d1fcc58f@canonical.com>
Date:   Wed, 9 Jun 2021 15:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2021 10:49, Krzysztof Kozlowski wrote:
> Hi Olof and Arnd,
> 
> Tegra memory controller driver changes with necessary dependency from Thierry
> (which you will also get from him):
> 1. Dmitry's power domain work on Tegra MC drivers,
> 2. Necessary clock and regulator dependencies for Dmitry's work.
> 

Hi Olof and Arnd,

Just FYI, the stable tag from Thierry which I pulled here (and you will
get from him as well) might cause COMPILE_TEST failures on specific
configurations. Regular defconfigs and allyes/allmod should not be affected.

I am giving heads up in case this lands in Linus later...

There will be two fixes for this, sent already by Thierry:
https://lore.kernel.org/lkml/20210609112806.3565057-1-thierry.reding@gmail.com/

1. reset controller stubs: going via reset tree,
2. reserved memory section: probably going via my tree later.


Best regards,
Krzysztof
