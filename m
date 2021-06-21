Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99BA3AF1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhFURPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFURPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:15:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:13:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so9979584wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4i6nEUVfh/Y08sl+Bt5V/buNM5eumRmDejjNLtBa3t0=;
        b=Dhs/CzchoEy1Qd18n03P5M6oqeh73HOJ5bMqv+/Qr5DuxS9vzUpYGKW45m7ZKA1iWV
         D6hoRxWwAVzZ3yfq8nzB0Qzuhpb+Qf9hP576yTmnMmzIa9tuFOOG8JYdVpN8Wwu3D4WR
         SbvBDZNP9cq0rBJmd9GjUnYk4pMvXlho/B0V0bQTD4qGR70oqfyyJCpPe0PWme9P+ypZ
         Iipek0imAwblBt2PnAs6scn5+GzjHy3eU5LH2q+kzbK+udSje5XfkqSgbdigFligtx7H
         vW1DeOEB806VdbDDx19UNGfVncG9mbVJqMJ4lz9vSRrdKVklCmXsyxfoCyUFQtDC2aTW
         yZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4i6nEUVfh/Y08sl+Bt5V/buNM5eumRmDejjNLtBa3t0=;
        b=R+SHzt9pAbSiUYYxXqp99Xy2daM0krQ4QD0e0KrxmktTk4UxK1ZD8rER+tXRSIuv1h
         euVfbU2WMBYRdjhSUf8aouHaRE2EtuCrG/HBuB2zFR/pzMB8roS88fUKRmCK6yz4f719
         QDkcSSVFNFu9t6fvCGl+PVjgzzIE8Q1Zvqg909p9Z630yMhxCsukvKFtyWJymVAbY1n9
         boiTEKpg5gotpKrAaqZLxz1ud4q/aKrJZDDfnJXyVhgAOXyjFZ/i64e2M3n6j9fl0LOs
         r76wfT/7iU8jUe5bJGVTvgxglS6fN3ndxaFNAsWa6GjxxtU9l0BDvjF8vpBTwPx7Ryzx
         DQKQ==
X-Gm-Message-State: AOAM533b66WGDITz8VBh0A/6dXn7nM0aMjcWiV6KOeitn5xzdkFzMnqb
        eNXpMOvEMVQk2QGJo/UVXADACQ==
X-Google-Smtp-Source: ABdhPJxSoWqFYS/3j+FYJIhz0NY142RhvRcIzSb0atBjmOVMKz6zGh2e6kpvX9Ul3VkFk6qxpN/gdA==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr29063076wry.175.1624295615215;
        Mon, 21 Jun 2021 10:13:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id 9sm197835wmf.3.2021.06.21.10.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 10:13:34 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Add driver for NVIDIA Tegra30 SoC Thermal sensor
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210616190417.32214-1-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e1e3816a-ddf4-be13-0410-0b929f3be60b@linaro.org>
Date:   Mon, 21 Jun 2021 19:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616190417.32214-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dmitry,

I compiled the your series and got these unresolved.

arm-linux-gnueabi-ld: drivers/thermal/tegra/soctherm-fuse.o: in function
`tegra_calc_shared_calib':
soctherm-fuse.c:(.text+0x60): undefined reference to `tegra_fuse_readl'
arm-linux-gnueabi-ld: soctherm-fuse.c:(.text+0xf0): undefined reference
to `tegra_fuse_readl'
arm-linux-gnueabi-ld: drivers/thermal/tegra/soctherm-fuse.o: in function
`tegra_calc_tsensor_calib':
soctherm-fuse.c:(.text+0x144): undefined reference to `tegra_fuse_readl'
arm-linux-gnueabi-ld: drivers/thermal/tegra/tegra30-tsensor.o: in
function `tegra_tsensor_fuse_read_spare':
tegra30-tsensor.c:(.text+0x364): undefined reference to `tegra_fuse_readl'
arm-linux-gnueabi-ld: drivers/thermal/tegra/tegra30-tsensor.o: in
function `tegra_tsensor_probe':
tegra30-tsensor.c:(.text+0x874): undefined reference to `tegra_fuse_readl'
arm-linux-gnueabi-ld:
drivers/thermal/tegra/tegra30-tsensor.o:tegra30-tsensor.c:(.text+0x904):
more undefined references to `tegra_fuse_readl' follow
make[1]: *** [/home/dlezcano/Work/src/linux/Makefile:1196: vmlinux] Error 1
make: *** [/home/dlezcano/Work/src/linux/Makefile:215: __sub-make] Error 2



On 16/06/2021 21:04, Dmitry Osipenko wrote:
> Hi,
> 
> This series adds support for the thermal sensor that is found on NVIDIA
> Tegra30 SoC. Sensor monitors temperature and voltage of the SoC, it also
> emits signals to the power management and clock controllers that are
> performing the emergency shut down and the CPU frequency throttling
> when a pre-programmed temperature levels are reached.
> 
> Changelog:
> 
> v4: - Removed DIV2 CPU frequency throttling and cooling device part as was
>       suggested by Daniel Lezcano since we need to notify cpufreq about the
>       updated frequency and change the thermal pressure. The thermal pressure
>       change should co-exists with the cpufreq_cooling. This all needs some
>       more thought, so the DIV2 mitigation will come sometime later.
> 
>     - Added ack from Thierry Reding.
> 
>     - Changed default TZ trips in the device-tree to the silicon temperature
>       levels, instead of the average device levels.
> 
> v3: - No code changes. CC'ed linux-pm, which was previously missed by accident.
>       Not sure how much that is important for the thermal patches, but won't
>       hurt to re-send since only DT binding was reviewed so far.
> 
> v2: - Made a very minor improvement to one error message, it now prints
>       number of channel at which error occurred.
> 
>     - Added r-b from Rob Herring to the binding.
> 
> Dmitry Osipenko (6):
>   dt-bindings: thermal: Add binding for Tegra30 thermal sensor
>   thermal: thermal_of: Stop zone device before unregistering it
>   thermal/drivers/tegra: Add driver for Tegra30 thermal sensor
>   ARM: tegra_defconfig: Enable CONFIG_TEGRA30_TSENSOR
>   ARM: multi_v7_defconfig: Enable CONFIG_TEGRA30_TSENSOR
>   ARM: tegra: Add SoC thermal sensor to Tegra30 device-trees
> 
>  .../thermal/nvidia,tegra30-tsensor.yaml       |  73 ++
>  arch/arm/boot/dts/tegra30.dtsi                |  87 ++-
>  arch/arm/configs/multi_v7_defconfig           |   1 +
>  arch/arm/configs/tegra_defconfig              |   1 +
>  drivers/thermal/tegra/Kconfig                 |   7 +
>  drivers/thermal/tegra/Makefile                |   1 +
>  drivers/thermal/tegra/tegra30-tsensor.c       | 673 ++++++++++++++++++
>  drivers/thermal/thermal_of.c                  |   3 +
>  8 files changed, 842 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
>  create mode 100644 drivers/thermal/tegra/tegra30-tsensor.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
