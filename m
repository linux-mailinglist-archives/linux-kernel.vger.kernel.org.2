Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054EA3E8FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbhHKLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbhHKLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:48:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9122C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:48:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t1so3282077edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxayS6Buf73tv3W4stt0EXlqaddKxMlyi9Xug6Snj2I=;
        b=loysSsRwzb1MyGQ25d/g4sLOBOWXfOWM5v8QQ/qlivnFJCpOyuqXy7OF/Mg+b4EK3p
         ttVxPlPIZZjpplsvj6+hRGePyBYIhXAPUDn1vvq+zrUhT9WPxRpewyeTbUB53f9Hm9nb
         cPAPA9P7QD+Y4cHdnVQoHfpYclsKc3OEDIKjjjKombZirgCh+r+KZYCk/QGbmBtNeQ8d
         xgJamKCDMAs7pdAumsK+i9ULQ61sb0Fx9KF25am1ZFEOGQ+u+EIFDqsvqYS2IX0xwTIH
         4b/9V9pV9f1wSrs68EPyu1tPf59TnOUJqcN1ro0TPiyctZrslcLO0cSxO97+O5Voma2T
         qwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxayS6Buf73tv3W4stt0EXlqaddKxMlyi9Xug6Snj2I=;
        b=buHD1GBMLjVjMiLeSJXZt/8yPPvzdDeT+2YyrV6XYDa7pFj1xO5mgy21u/31WqdMEM
         EpSKvyMU/B1tZvSm6YNQqpOwCQC6tg48+jdFcYl6e5siJw+G36uJtM7yXbib8iZahKMe
         ZRWVd2d7mFQ13E94WUfbCpDKuXOsXhxwPtYTQO4kQNK795IsqJS3ys+dQ7/GyFenh6UB
         j5JTPn3EOb/fKx7cW3o2kO6Jsg4WaIRzmsUBEON/UqLLQOz3G+QyKFYbmJFF1pSi2Ru+
         0KtgnlufHRZlX0F1H4/7Za8atH4ckQ5VhGtY+VXfeMpNe7D3/GwQoN5IqEaKPSLMbaUL
         WpmQ==
X-Gm-Message-State: AOAM53365rH5D9z5kFZnQr66twQiHZ0YhWrsQwkK00k9mOLU6pK5wCoT
        XIRCruS891XgSo0iktPf6PY7GA==
X-Google-Smtp-Source: ABdhPJxho73WzOVrYw9NK76kUVvDzKorlN5ePOWM7MnSaI8LdBh6S7aHNtX2d0X3hINOjcqhrEzptw==
X-Received: by 2002:aa7:d757:: with SMTP id a23mr10907031eds.29.1628682509410;
        Wed, 11 Aug 2021 04:48:29 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id a22sm8094458ejk.35.2021.08.11.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:48:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
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
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 0/7] Add minimal support for Exynos850 SoC
Date:   Wed, 11 Aug 2021 14:48:20 +0300
Message-Id: <20210811114827.27322-1-semen.protsenko@linaro.org>
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

Changes in v3:
 * Removed the stub clock driver; uart clock is modeled as generic fixed
   clock in dts for now
 * See also changes in each particular patch

Changes in v2:
 * Rebased on top of current linux-mainline
 * Removed patch ("pinctrl: samsung: Fix pinctrl bank pin count"); it
   was sent separately, as it's an independent fix
 * Made the patch ("dt-bindings: pinctrl: samsung: Add Exynos850 doc")
   to be the first in series
 * Removed patch ("MAINTAINERS: Changes in v2"); will add that later,
   when proper clock driver is implemented
 * Removed patch ("dt-bindings: clock: Add bindings for Exynos850 clock
   controller"); will add clock bindings later, when proper clock driver
   is implemented
 * Removed patch ("dt-bindings: interrupt-controller: Add IRQ constants
   for Exynos850"), and used hard-coded IRQ numbers in dts instead
 * See also changes in each particular patch

Sam Protsenko (7):
  dt-bindings: pinctrl: samsung: Add Exynos850 doc
  pinctrl: samsung: Add Exynos850 SoC specific data
  dt-bindings: serial: samsung: Add Exynos850 doc
  tty: serial: samsung: Init USI to keep clocks running
  tty: serial: samsung: Fix driver data macros style
  tty: serial: samsung: Add Exynos850 SoC data
  arm64: dts: exynos: Add Exynos850 SoC support

 .../bindings/pinctrl/samsung-pinctrl.txt      |   1 +
 .../bindings/serial/samsung_uart.yaml         |   1 +
 .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 748 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi     | 261 ++++++
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 116 +++
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  29 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
 drivers/tty/serial/samsung_tty.c              |  49 +-
 include/linux/serial_s3c.h                    |   9 +
 10 files changed, 1214 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi

-- 
2.30.2

