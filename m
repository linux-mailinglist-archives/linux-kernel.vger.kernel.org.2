Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A703F823C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhHZGKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbhHZGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:10:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:09:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u9so3107506wrg.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dyDctEcCFTQWagrKchtGj45MTWx5J7OGfGIXDOq+f1k=;
        b=yDEYk+/bvtYSqQ2ThliPo9BtTAK30Rp/czWjIF0CYLT1jl9raDqySDNSqJSNL7d2mV
         Nvh+nUK6rBW7KfairwHa9wv1x7kF/AUElFAquILSv/q6Qc9I2OwvkuvTtdxQQGdJUXjM
         DTFX/ZE99rNg5o6JlxWz5GzioZ43R59N/mH2k5z6PL03tZ01dk6cYIcp1KEO4ZgvZ8yd
         vjjL5y9wAfMLeNpPOhc5RhLHnN6QdZ62RTcC6Wy5O727aqbZ/8oOdESol31t15wpQ/aW
         mBFxeT5Wm52VHElXXfhvF5kFO0Au1RIVY/UycHPiJUnwHl58b0cCExZcw15ZJxACO7L5
         7Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dyDctEcCFTQWagrKchtGj45MTWx5J7OGfGIXDOq+f1k=;
        b=rQX0IyYUgJaFRQ9vAmDl+JBK6owSds/2UM6GOpuJkxgo4vUAq7b5zvuaJNFDjSkslm
         wNCdaNFnfXPW+i5MlWjQbbEk4YTF8+hoJdQwcKkw6nYXgiuPNKxV/6/OzsTuDrKerp8e
         dlHGkIcvJpc5kNiyImmRi3hF7xKKXMov7hyowdXUlxn3VMChkZlRtvIDJuzD4d4lstWX
         JWaMcQm0hvoIjrvfLNUiGKi1tJ06tO9NdXrVVEsSwpW6h3nVxQtVPEHWVVwFR4oApAc8
         1IApO4wD9YF6n1lKNMZjmF5bGvlOHnk1i4uTbLssv9Vgo9+5Vs5V7fVmEiilhIo1fH7n
         iA0Q==
X-Gm-Message-State: AOAM530mWPvU4XRqtNgFqWjm7U9hj5HOSkkENapTIVCX0T9KrVpRzMkE
        eGCaZTz+JGRKdjmX7/eYsrgXUiYOHV/KV8Vd
X-Google-Smtp-Source: ABdhPJxQJX/06bX18ERlziYqTFfcIFghw3b0KcT5wMnJ6G2mPwBdXqm8EazEkC4+1C0cLZGO2dxIsw==
X-Received: by 2002:adf:f750:: with SMTP id z16mr1794604wrp.384.1629958173996;
        Wed, 25 Aug 2021 23:09:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a490:371:4cff:9501? ([2a01:e34:ed2f:f020:a490:371:4cff:9501])
        by smtp.googlemail.com with ESMTPSA id e3sm2065448wrv.65.2021.08.25.23.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 23:09:33 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Fengquan Chen <Fengquan.Chen@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timers driver for v5.15
Message-ID: <c14ad27a-b1c6-6043-0f5e-71dd984bb4ba@linaro.org>
Date:   Thu, 26 Aug 2021 08:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

The following changes since commit f80e21489590c00f46226d5802d900e6f66e5633:

  hrtimer: Unbreak hrtimer_force_reprogram() (2021-08-12 22:34:40 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.15

for you to fetch changes up to f196ae282070d798c9144771db65577910d58566:

  dt-bindings: timer: Add ABIs for new Ingenic SoCs (2021-08-21 09:58:17
+0200)

----------------------------------------------------------------
- Prioritize the ARM architected timer on Exynos platform when the
  architecture is ARM64 (Will Deacon)

- Mark the Exynos timer as a per CPU timer (Will Deacon)

- DT conversion to yaml for the rockchip platform (Ezequiel Garcia)

- Fix IRQ setup if there are two channels on the sh_cmt timer (Phong
  Hoang)

- Use bitfield helper macros in the Ingenic timer (Zhou Yanjie)

- Clear any pending interrupt to prevent an abort of the suspend on
  the Mediatek platform (Fengquan Chen)

- Add DT bindings for new Ingenic SoCs (Zhou Yanjie)

----------------------------------------------------------------
Ezequiel Garcia (1):
      dt-bindings: timer: convert rockchip,rk-timer.txt to YAML

Fengquan Chen (1):
      clocksource/drivers/mediatek: Optimize systimer irq clear flow on
shutdown

Linus Walleij (1):
      clocksource/drivers/fttmr010: Pass around less pointers

Phong Hoang (1):
      clocksource/drivers/sh_cmt: Fix wrong setting if don't request IRQ
for clock source channel

Will Deacon (2):
      clocksource/drivers/exynos_mct: Prioritise Arm arch timer on arm64
      clocksource/drivers/exynos_mct: Mark MCT device as
CLOCK_EVT_FEAT_PERCPU

周琰杰 (Zhou Yanjie) (2):
      clocksource/drivers/ingenic: Use bitfield macro helpers
      dt-bindings: timer: Add ABIs for new Ingenic SoCs

 Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt  | 27
---------------------------
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 64
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/exynos_mct.c                               | 16
+++++++++++++---
 drivers/clocksource/ingenic-sysost.c                           | 13
+++++++------
 drivers/clocksource/sh_cmt.c                                   | 30
++++++++++++++++++------------
 drivers/clocksource/timer-fttmr010.c                           | 32
++++++++++++++++----------------
 drivers/clocksource/timer-mediatek.c                           |  8
++++++--
 include/dt-bindings/clock/ingenic,sysost.h                     | 19
+++++++++++++++++++
 8 files changed, 143 insertions(+), 66 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
 create mode 100644
Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
w

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
