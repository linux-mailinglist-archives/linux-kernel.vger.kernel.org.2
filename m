Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C641F358769
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhDHOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhDHOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:48:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F01C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 07:47:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a6so2433525wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KmhaWajENDgR5BIM7h5/x6v7T2Cnn0jdRjB4r/hE72s=;
        b=yGQyqePQPX5xRfG9D5muqGfSybBLR3PWxQ1bXRsOsjMGriTFmHHHDjDtgdyOtageqo
         W1hTsqBAufoonYE8mtpIwF+GPV+EnelWx1EGlgIO/V5ndej99cgxjBAIZFtXY9GC/qkU
         lwOq2SVUQrnopsiJcBVZcZoXf1jn3Apm2GodAuoSPa0K+NT4vkRgKZl9KMdHUImjkQGz
         8Ebe4wDGtlKTkWtPm9TqBHla2qFow6OEUaFUtw8klD9e5KSm3UuW3fvRGobsUXt3k46P
         +AY6GKzUpRRx44bxaceKEXuv5iTBS+BwJxISpvAIoKC+iyn5KjqEPMg7ic3beMh/kzUt
         d6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KmhaWajENDgR5BIM7h5/x6v7T2Cnn0jdRjB4r/hE72s=;
        b=fr/4rpxYeEizvZFxoA2yYREWit7vaWy5fcWC9zKTTM7VSpjJhCWY02212I2ApApzqi
         RBGuCIgZl8/qPbh0gpmvz41C2Qjn36apRoVjvtxbDsZnQ3aPk1u+sVUyAR6FMM0L/Poj
         sAU9zeCu8bV6LvKRg6FYjcztiq6bremWbPqgwHBsoJdrp3OYQpnG368krzpaJniN9qSv
         uQ6wSEKuPSrEEscvsW0L21nYn9BIc67eHcYBw3T9E83+IqqvOgPOVAm3X4/1141eBttN
         6gui27CuMxd8OjSP3hCVB3DHbWzMdlpuL2MkHaMfe5Z2VTFdgNkMpsX02T8cYwCyjXGj
         l66g==
X-Gm-Message-State: AOAM530qLfg2rzdzAb3dgDPqPWWoceKESJLg0/tW+hlPGBhT8xjTCWvy
        9lJEh4kAtqsWEccjxpp4o9ctY63v2gUUNV1g
X-Google-Smtp-Source: ABdhPJzYbmZulyVKBBVwyNLrenlOwcP/6W+MtHA4mWVlyGGe5gbAvhnIAfZ4o49s9HMl6/bJ/ewdTQ==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr12092206wrm.291.1617893268931;
        Thu, 08 Apr 2021 07:47:48 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9407:6619:589b:441e? ([2a01:e34:ed2f:f020:9407:6619:589b:441e])
        by smtp.googlemail.com with ESMTPSA id g189sm12442189wmf.14.2021.04.08.07.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 07:47:48 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Tony Lindgren <tony@atomide.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.13
Message-ID: <aa155f48-56ab-9a44-316e-cf1d33fe6d0d@linaro.org>
Date:   Thu, 8 Apr 2021 16:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider these changes for v5.13

Thanks

  -- Daniel

The following changes since commit d4c7c28806616809e3baa0b7cd8c665516b2726d:

  timekeeping: Allow runtime PM from change_clocksource() (2021-03-29
16:41:59 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux tags/timers-v5.13-rc1

for you to fetch changes up to 8120891105ba32b45bc35f7dc07e6d87a8314556:

  dt-bindings: timer: nuvoton,npcm7xx: Add wpcm450-timer (2021-04-08
16:41:20 +0200)

----------------------------------------------------------------
 - Add dt bindings for the wpcm450 and the timer declaration (Jonathan
   Neuschäfer)

 - Add dt bindings for the JZ4760, the timer declaration for the
   ingenic ost and timer (Paul Cercueil)

 - Add dt bindings for the cmt r8a779a0 (Wolfram Sang)

 - Add dt bindings for the cmt r8a77961 (Niklas Söderlund)

 - Add missing dt bindings for the tmu r8a7795, r8a7796, r8a77961, r8a77965,
   r8a77990 and r8a77995 (Niklas Söderlund)

 - Check pending post before writing a new post in register for the
   timer TI dm and add the stopped callback ops to prevent any
   spurious interrupt (Tony Lindgren)

 - Fix return value check at init when calling device_node_to_regmap()
   for the Ingenic OST timer (Wei Yongjun)

 - Fix a trivial typo s/overflw/overflow/ for the pistachio timer (Drew
Fustini)

 - Don't use CMTOUT_IE with R-Car Gen2/3 (Wolfram Sang)

 - Fix rollback when the initialization fails on the dw_apb timer (Dinh
Nguyen)

 - Switch to timer TI dm on dra7 in order to prevent using the bogus
   architected timer which fails to wrap correctly after 388 days (Tony
Lindgren)

 - Add function annotation to optimize memory for the ARM architected
   timer (Jisheng Zhang)

----------------------------------------------------------------
Dinh Nguyen (1):
      clocksource/drivers/dw_apb_timer_of: Add handling for potential
memory leak

Drew Fustini (1):
      clocksource/drivers/pistachio: Fix trivial typo

Jisheng Zhang (1):
      clocksource/drivers/arm_arch_timer: Add __ro_after_init and __init

Jonathan Neuschäfer (2):
      clocksource/drivers/npcm: Add support for WPCM450
      dt-bindings: timer: nuvoton,npcm7xx: Add wpcm450-timer

Niklas Söderlund (2):
      dt-bindings: timer: renesas,tmu: Document missing Gen3 SoCs
      dt-bindings: timer: renesas,cmt: Document R8A77961

Paul Cercueil (3):
      dt-bindings: timer: ingenic: Add compatible strings for JZ4760(B)
      clocksource/drivers/ingenic: Add support for the JZ4760
      clocksource/drivers/ingenic-ost: Add support for the JZ4760B

Tony Lindgren (4):
      clocksource/drivers/timer-ti-dm: Fix posted mode status check order
      clocksource/drivers/timer-ti-dm: Add missing set_state_oneshot_stopped
      clocksource/drivers/timer-ti-dm: Prepare to handle dra7 timer wrap
issue
      clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940

Wei Yongjun (1):
      clocksource/drivers/ingenic_ost: Fix return value check in
ingenic_ost_probe()

Wolfram Sang (2):
      dt-bindings: timer: renesas,cmt: Add r8a779a0 CMT support
      clocksource/drivers/sh_cmt: Don't use CMTOUT_IE with R-Car Gen2/3

 .../devicetree/bindings/timer/ingenic,tcu.yaml     |  30 ++--
 .../bindings/timer/nuvoton,npcm7xx-timer.txt       |   3 +-
 .../devicetree/bindings/timer/renesas,cmt.yaml     |   4 +
 .../devicetree/bindings/timer/renesas,tmu.yaml     |   6 +
 arch/arm/boot/dts/dra7-l4.dtsi                     |   4 +-
 arch/arm/boot/dts/dra7.dtsi                        |  20 +++
 drivers/clocksource/arm_arch_timer.c               |  23 +--
 drivers/clocksource/dw_apb_timer_of.c              |  26 +++-
 drivers/clocksource/ingenic-ost.c                  |   9 +-
 drivers/clocksource/ingenic-timer.c                |   2 +
 drivers/clocksource/sh_cmt.c                       |   5 +-
 drivers/clocksource/timer-npcm7xx.c                |   1 +
 drivers/clocksource/timer-pistachio.c              |   4 +-
 drivers/clocksource/timer-ti-dm-systimer.c         | 155
+++++++++++++++++----
 include/linux/cpuhotplug.h                         |   1 +
 15 files changed, 229 insertions(+), 64 deletions(-)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
