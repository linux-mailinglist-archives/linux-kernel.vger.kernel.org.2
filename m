Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35B23DBB10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhG3Otb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbhG3Ota (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:49:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B716C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:49:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n2so13502280eda.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PHkR+YSvqa36gxNmyyX6WoOgZM8UVlxbzCVysbca2U=;
        b=ppXxSci0wZJY7XnVRY4yu+4+WjQPwflcLFwiLy+QQ2ntOFZXb3dYBrtgAZwQGOi+NV
         8ryr8dUU1x3Pk72hg5RJMDLvQ6HSfUlWQ8EhsjLq8MHTWl9lHdDa4QV/YXWlXDc0UCNe
         memZ6BED5+EO4wvTQgR1+L8lXlCDQ5+LPoltjuRKc5UlGaxNzX9gLhdJYS/OBhee8/Vc
         vF93q4YTSPaGqnxeDvez4Id9seJG7z85l00ime4MS8Q4naLZzzVDb/iC/jBEJatL+c+8
         imSkgBkD7IX3F6D//6uXm7OsGe26LDkBDkshApcHXIjIpdAH4bgPtgEvxKRogza7ZtXh
         y8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PHkR+YSvqa36gxNmyyX6WoOgZM8UVlxbzCVysbca2U=;
        b=nwqMKHeCigSrb9ctqMb8JH1woe1rBO4lH/QywIILfnZQ7IOKiuOwfEmITvVUvcSle3
         lBFS2981/JzldujBlSLix32Klu5/vCsbuZaK+o/7m6+awk7Xuy2IUlZ0hZBCdvWhOpCI
         pDxd7y4iCe3syB6StpRxwMt9ugeXBfA4WftQwe9QbB/VPxLuEMC8zP+uTddKQCMwrY99
         oQvy9jc09sYU1WWJmv04W9Q6WcTlA2r302UoLS8G+mHKo0g2vyLZnK5tkfclo11A/SZ7
         TtEpvuZIokPqlImB/aOMCztXHBx0z+Fa/4xGSGiukxOKoR1EJ/byWsF+qOwgyHegn39P
         5yIw==
X-Gm-Message-State: AOAM5323o9SqwAYp965/lqPT6Ry5DyK32gYmnIypcBrod+vb/07QS18y
        QBGjOPEnSDP4AsabCFiKRfe2Qg==
X-Google-Smtp-Source: ABdhPJwdxvjBr38jNA7cLuHBawxASA9D/0kL5M54NafNl/0JLAWo7243dU/nVXHaEZWEexPUYsyDJw==
X-Received: by 2002:a05:6402:49a:: with SMTP id k26mr3291469edv.279.1627656564172;
        Fri, 30 Jul 2021 07:49:24 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p16sm785006eds.73.2021.07.30.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:23 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 00/12] Add minimal support for Exynos850 SoC
Date:   Fri, 30 Jul 2021 17:49:10 +0300
Message-Id: <20210730144922.29111-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds initial platform support for Samsung Exynos850
SoC [1]. With this patchset it's possible to run the kernel with BusyBox
rootfs as a RAM disk. More advanced platform support (like MMC driver
additions) will be added later. The idea is to keep the first submission
minimal to ease the review, and then build up on top of that.

[1] https://www.samsung.com/semiconductor/minisite/exynos/products/mobileprocessor/exynos-850/

Jaehyoung Choi (1):
  pinctrl: samsung: Fix pinctrl bank pin count

Sam Protsenko (11):
  pinctrl: samsung: Add Exynos850 SoC specific data
  dt-bindings: pinctrl: samsung: Add Exynos850 doc
  tty: serial: samsung: Init USI to keep clocks running
  tty: serial: samsung: Fix driver data macros style
  tty: serial: samsung: Add Exynos850 SoC data
  dt-bindings: serial: samsung: Add Exynos850 doc
  MAINTAINERS: Cover Samsung clock YAML bindings
  dt-bindings: clock: Add bindings for Exynos850 clock controller
  clk: samsung: Add Exynos850 clock driver stub
  dt-bindings: interrupt-controller: Add IRQ constants for Exynos850
  arm64: dts: exynos: Add Exynos850 SoC support

 .../bindings/clock/exynos850-clock.yaml       |  70 ++
 .../bindings/pinctrl/samsung-pinctrl.txt      |   1 +
 .../bindings/serial/samsung_uart.yaml         |   1 +
 MAINTAINERS                                   |   3 +-
 .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 782 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos850-usi.dtsi |  30 +
 arch/arm64/boot/dts/exynos/exynos850.dtsi     | 245 ++++++
 drivers/clk/samsung/Makefile                  |   1 +
 drivers/clk/samsung/clk-exynos850.c           |  63 ++
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 129 +++
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  29 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   4 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
 drivers/tty/serial/samsung_tty.c              |  50 +-
 include/dt-bindings/clock/exynos850.h         | 267 ++++++
 .../interrupt-controller/exynos850.h          | 290 +++++++
 include/linux/serial_s3c.h                    |   9 +
 17 files changed, 1970 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos850-clock.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-usi.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos850.c
 create mode 100644 include/dt-bindings/clock/exynos850.h
 create mode 100644 include/dt-bindings/interrupt-controller/exynos850.h

-- 
2.30.2

