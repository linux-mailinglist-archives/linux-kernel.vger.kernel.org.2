Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234B23E2D82
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244326AbhHFPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244300AbhHFPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:22:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5FC06179C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:21:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c16so18655460lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H0OxH2DLR+a7XFHFrPAZwX3xA6D5uCHw5+vNuLWj+ZY=;
        b=pbk0Y8q49FHUjZEqTA4TnnaGPMxpn7WVjavgdfR59MN27ETDHVYSTGJT+aY0enr76w
         FqMqk/4fWtwS84qkuXWGWxxn+gFFAtcd26lbO1xGwSyc6nRLR9cA2rBG84+wVYlw9Q+g
         di3cRH+m4dfLCLk/M4a/6z+L/uzcxVqp+itjWYp79cevN6TJvoEyuhhFbheBZJe5LyZg
         nKQH8E7OSS4wzevRBhFC8zIPtN9H13DEC23tbJv2MABzfJX/YJQ7EF01FixcrbGGJ4//
         uz/n35N1lztmB08rAzzqDTrTzGhmIGDHg2aa1C6mOV3TxXi04AzNSG9v94+5KMxfbMJc
         vnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H0OxH2DLR+a7XFHFrPAZwX3xA6D5uCHw5+vNuLWj+ZY=;
        b=r+37k28RpPr80eKbZlPjlXULmVZ5P3HvEiRMwZdqF0MTCuZGPcFJbvd2/ELwvnrB6K
         W+j3QFBrAfhw92UEfmbAlQS5+YE8uS52g07cZiMoZw5ziUTiplNjYkQmIfYTTSFdTzHb
         XlTsFQ0a1o94wc+7998UHvhsFN43UIOVZV2QkqIclhWdOJ228AL8nkLL0eJ1GhDSslL8
         HgEThFM6lf2jOhD03Jtx7L90eSnxEvvYyarz5BhPbgdKx5PdGf8VmyYahBds4++xunLj
         SgDRKNj9q7mi69uhVcgSCVAZCETli2IHhg20P5b5wRgUobfUjVkx+yJ7E9AFfVudkqni
         qNQQ==
X-Gm-Message-State: AOAM531RqFHuyyIbxP1lvkJ97kMgHKy7Sik6idvXpweZMNnxTmHxY+v6
        GaIhqp5lABO4KLJFTrVkxOF+ew==
X-Google-Smtp-Source: ABdhPJx31hm5hWcZpE6dWmGoFrGtIfh+zc6xG8+pt1bd/05YwEKQRDG5g7A6QE8qOgJRduWYS7orrQ==
X-Received: by 2002:a19:6b19:: with SMTP id d25mr7721777lfa.349.1628263308041;
        Fri, 06 Aug 2021 08:21:48 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i3sm275324lfr.217.2021.08.06.08.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:21:47 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 0/8] Add minimal support for Exynos850 SoC
Date:   Fri,  6 Aug 2021 18:21:38 +0300
Message-Id: <20210806152146.16107-1-semen.protsenko@linaro.org>
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

Sam Protsenko (8):
  dt-bindings: pinctrl: samsung: Add Exynos850 doc
  pinctrl: samsung: Add Exynos850 SoC specific data
  dt-bindings: serial: samsung: Add Exynos850 doc
  tty: serial: samsung: Init USI to keep clocks running
  tty: serial: samsung: Fix driver data macros style
  tty: serial: samsung: Add Exynos850 SoC data
  clk: samsung: Add Exynos850 clock driver stub
  arm64: dts: exynos: Add Exynos850 SoC support

 .../bindings/pinctrl/samsung-pinctrl.txt      |   1 +
 .../bindings/serial/samsung_uart.yaml         |   1 +
 .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 748 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi     | 256 ++++++
 drivers/clk/samsung/Makefile                  |   1 +
 drivers/clk/samsung/clk-exynos850.c           |  64 ++
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 116 +++
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  29 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
 drivers/tty/serial/samsung_tty.c              |  49 +-
 include/linux/serial_s3c.h                    |   9 +
 12 files changed, 1274 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos850.c

-- 
2.30.2

