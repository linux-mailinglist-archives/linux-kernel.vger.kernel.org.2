Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C339D75B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhFGIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:30:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhFGIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:30:08 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqAcK-00031u-Kz
        for linux-kernel@vger.kernel.org; Mon, 07 Jun 2021 08:28:16 +0000
Received: by mail-wm1-f69.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so6549195wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tn/PW7iw3ZbAUs3i31JVSRUjJCgjQwcQNEdZxUQkqes=;
        b=OTyapPICSHhXDC9r5qTDP7x85y/VB0BpnIky1jRTpZhUqnucslmxgsZ+Fvgeek7Ckt
         Haf0IH0XQb87EU60yIDcYuaAUJHcp9aW/fjCltbfuTi3peXfBJ+UZdKzzF7drFDgVD5h
         9BOYAFU7ertxfsMLhD7FITL4hNo4FQrlU4HjAvC3k8speRdUDJ5V5pmPChhAZ4gTbfPK
         e66P2ngCGjOQZsVL8vaD2Nj6K1wvHMvO8m0N4/JX3swPPl7j24AABDKxnxbC9Yq5Thp5
         SoDjMYEaOTTsHM55hY0Pv8dsIVL1zv+GpgvwGlQncjhTCBTlvLI+H+O96UY2heubYm2A
         oCAw==
X-Gm-Message-State: AOAM533yLgoyIvcpwKLWIAX6Mm2y1BNsgHBsjoJAra+gURp+Llp1v782
        agozA87zJcjnKg8EeEO+GBKHwXiCgM2jDTIPAc+R9M4RHZsiePe+xZst8vuSBFjlQauLsm18Gz/
        fWClUoh5XUBliaHQmyJ0xa32MCkS0oduD/+zjiBj3ZQ==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr15621545wme.135.1623054495944;
        Mon, 07 Jun 2021 01:28:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJhpSCFwmj9c2S4ax3pZ90jedpMf6jg3flUJOKt5T80FVwei4/TBIO66LJvQdg1Zb3OAVHaA==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr15621530wme.135.1623054495814;
        Mon, 07 Jun 2021 01:28:15 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id s7sm15631663wrf.91.2021.06.07.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:28:15 -0700 (PDT)
Subject: Re: [PULL] memory: tegra: Changes for v5.14-rc1
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210603143739.787957-1-thierry.reding@gmail.com>
 <772bf62a-fb09-cec4-ed4d-ddbfc2832e2b@gmail.com>
 <YLnzQk+suAG5clzB@orome.fritz.box>
 <3ed358ce-de98-0b42-2446-873af55ed825@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9f1fe71e-3900-fa8a-8c09-4bc2dc084156@canonical.com>
Date:   Mon, 7 Jun 2021 10:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3ed358ce-de98-0b42-2446-873af55ed825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2021 14:51, Dmitry Osipenko wrote:
> 04.06.2021 12:32, Thierry Reding пишет:
>> On Thu, Jun 03, 2021 at 10:56:29PM +0300, Dmitry Osipenko wrote:
>>> 03.06.2021 17:37, Thierry Reding пишет:
>>>> memory: tegra: Changes for v5.14-rc1
>>>>
>>>> This stable tag contains Dmitry's power domain work, including all the
>>>> necessary dependencies from the regulator, clock and ARM SoC trees.
>>>>
>>>> ----------------------------------------------------------------
>>>> Dmitry Osipenko (18):
>>>>       clk: tegra30: Use 300MHz for video decoder by default
>>>>       clk: tegra: Fix refcounting of gate clocks
>>>>       clk: tegra: Ensure that PLLU configuration is applied properly
>>>>       clk: tegra: Halve SCLK rate on Tegra20
>>>>       clk: tegra: Don't allow zero clock rate for PLLs
>>>>       clk: tegra: cclk: Handle thermal DIV2 CPU frequency throttling
>>>>       clk: tegra: Mark external clocks as not having reset control
>>>>       clk: tegra: Don't deassert reset on enabling clocks
>>>>       regulator: core: Add regulator_sync_voltage_rdev()
>>>
>>>>       soc/tegra: regulators: Bump voltages on system reboot
>>>
>>> This patch is a build dependency prerequisite for the "soc/tegra:
>>> regulators: Support core domain state syncing" patch. Will you send a
>>> new PR to Krzysztof with the remaining soc/tegra patches?
>>
>> soc/tegra patches usually go in through ARM SoC. This is merely included
>> here because it was part of the set of patches that were needed to
>> enable compile testing for the memory controller drivers.
>>
>> I've applied the remaining soc/tegra patches (12-14 of the series) to my
>> for-5.14/soc branch but ended up not pulling that part in because it was
>> unnecessary for the memory controller patches.
> 
> Does this mean that if for-5.14/soc will be pulled first into mainline,
> then the patches will be applied in a wrong order?

All of the branches of each maintainer should be bisectable, so order of
pulling by Linus' should not matter. Assuming current Thierry's branches
are bisectable, how Linus' tree can be broken after specific pull order?

Best regards,
Krzysztof
