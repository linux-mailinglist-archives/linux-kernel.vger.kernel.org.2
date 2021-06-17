Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAF3AB78D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhFQPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFQPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:34:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:31:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so3981817wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VAjzq9mhAWtZ8EHGSkPZvo+bLtkwjx1qvP4uAFGkPj0=;
        b=aNUg+W40bNFPooxDaKIY+OpuKpPaTYzqrKODqK7cN5q3G/gyVLwYtYExf++sTz9csm
         D7jogoYW14iB5p3tBLglLiIKafXPxzL9EyoDpRVJOmh5d8Na1nXAL43wo2ORkUDOaHUf
         SlRIJ3oYvBuAy+ytr6XIQ5yhORI918ReSLlEKWzwWsgLy8Hsi5hNSMX7n9RaaCHZvmOI
         ptmSecREc6efIr9wQIbWDXWuhRayVT35fzxUy0S91oAMf0P/65mHOORw2KKJ6mBmomcd
         9S1i6KwR8ZgPFZu+Eqn9b9ZWetH5sSUm//nCSBRkGL1ZNXp8DhXUDITM7jHI5egDgugs
         zhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VAjzq9mhAWtZ8EHGSkPZvo+bLtkwjx1qvP4uAFGkPj0=;
        b=jqnIM2MewINUz5grAboomjqXt6Ckcn5bv2EhDJXTdnfhz1tsT4JqFgjlutJT8ftVXj
         aJ04EC5HFxPIM5GHoEOyFOrYohhl/ePh0d2N111T2o+A64TefKqnRUM4cKnV3qaPj7V5
         CPMgrhrEFSCM1Q+LCtx1p6pLFAGU724nLQRs++45KmlLz+hjSjSpSQdUAOBXgrBjbfz2
         ALuQp/8jSVx429QB6OBtN9oahK1eHvp1tFXaU3PR2omsee8FInLSRQeb8O+44BLD++tx
         f5NxvQMj6YCRzEK6AK3G6ZaEVwUFR3+ZXoZXqI4GIdbDD6gjEvqB+UmSEydpZg/7ysYH
         120Q==
X-Gm-Message-State: AOAM530RAX0a87+0B7OBZw9k2SkFLOyBpLHOEwvuUrFKsKoRnhzu59n1
        XVWuXMKDV5fO0k/5ozfjXv4aEK5DfYQRpYGX
X-Google-Smtp-Source: ABdhPJxEFRrlycHoxLlGNtCO6tr3Fi4GTVtXp61cXSTq9xjkAJaYVyP2Xjo9FIGAzvm6vTe0XyqKRw==
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr5839635wmd.22.1623943913680;
        Thu, 17 Jun 2021 08:31:53 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a8dd:a686:47bc:b03a? ([2a01:e34:ed2f:f020:a8dd:a686:47bc:b03a])
        by smtp.googlemail.com with ESMTPSA id z6sm2935412wrl.15.2021.06.17.08.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 08:31:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.14
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Benn <evanbenn@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Andrea Merello <andrea.merello@gmail.com>, zou_wei@huawei.com,
        Wan Jiabing <wanjiabing@vivo.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <65ed5f60-d7a5-b4ae-ff78-0382d4671cc5@linaro.org>
Date:   Thu, 17 Jun 2021 17:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

The following changes since commit 245a057fee18be08d6ac12357463579d06bea077:

  timer_list: Print name of per-cpu wakeup device (2021-05-31 17:04:49
+0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.14

for you to fetch changes up to 3d41fff3ae3980c055f3c7861264c46c924f3e4c:

  clocksource/drivers/timer-ti-dm: Drop unnecessary restore (2021-06-16
17:33:04 +0200)

----------------------------------------------------------------
- Remove arch_timer_rate1 variable as it is unused in the architected
  ARM timer (Jisheng Zhang)

- Minor cleanups (whitespace, constification, ...) for the Samsung pwm
  timer (Krzysztof Kozlowski)

- Acknowledge and disable the timer interrupt at suspend time to
  prevent the suspend to be aborted by the ATF if there is a pending
  one on the Mediatek timer (Evan Benn)

- Save and restore the configuration register at suspend/resume time
  for TI dm timer (Tony Lindgren)

- Set the scene for the next timers support by renaming the array
  variables on the Ingenic time (Zhou Yanjie)

- Add the clock rate change notification to adjust the prescalar value
  and compensate the clock source on the ARM global timer (Andrea
  Merello)

- Add missing variable static annotation on the ARM global timer (Zou
  Wei)

- Remove a duplicate argument when building the bits field on the ARM
  global timer (Wan Jiabing)

- Improve the timer workaround function by reducing the loop on the
  Allwinner A64 timer (Samuel Holland)

- Do no restore the register context in case of error on the TI dm
  timer (Tony Lindgren)

----------------------------------------------------------------
Andrea Merello (2):
      clocksource/drivers/arm_global_timer: Implement rate compensation
whenever source clock changes
      arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER due to
CONFIG_CPU_FREQ anymore

Evan Benn (1):
      clocksource/drivers/mediatek: Ack and disable interrupts on suspend

Jisheng Zhang (1):
      clocksource/drivers/arm_arch_timer: Remove arch_timer_rate1

Krzysztof Kozlowski (4):
      clocksource/drivers/samsung_pwm: Minor whitespace cleanup
      clocksource/drivers/samsung_pwm: Constify passed structure
      clocksource/drivers/samsung_pwm: Cleanup on init error
      clocksource/drivers/samsung_pwm: Constify source IO memory

Samuel Holland (1):
      clocksource/arm_arch_timer: Improve Allwinner A64 timer workaround

Tony Lindgren (2):
      clocksource/drivers/timer-ti-dm: Save and restore timer TIOCP_CFG
      clocksource/drivers/timer-ti-dm: Drop unnecessary restore

Wan Jiabing (1):
      clocksource/drivers/arm_global_timer: Remove duplicated argument
in arm_global_timer

Zou Wei (1):
      clocksource/drivers/arm_global_timer: Make symbol
'gt_clk_rate_change_nb' static

周琰杰 (Zhou Yanjie) (1):
      clocksource/drivers/ingenic: Rename unreasonable array names

 arch/arm/mach-zynq/Kconfig              |   2 +-
 drivers/clocksource/Kconfig             |  14 ++++++++++++++
 drivers/clocksource/arm_arch_timer.c    |   3 +--
 drivers/clocksource/arm_global_timer.c  | 122
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 drivers/clocksource/ingenic-sysost.c    |  10 +++++-----
 drivers/clocksource/samsung_pwm_timer.c |  41
+++++++++++++++++++++++++++++------------
 drivers/clocksource/timer-mediatek.c    |  24 ++++++++++++++++++++++++
 drivers/clocksource/timer-ti-dm.c       |   9 ++++++++-
 include/clocksource/samsung_pwm.h       |   3 ++-
 include/clocksource/timer-ti-dm.h       |   1 +
 10 files changed, 197 insertions(+), 32 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
