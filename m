Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A805D37359F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEEHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhEEHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:33:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 00:32:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t18so677412wry.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3zD0CEwtCQw4KD7pngUsgxPD/yoCJ3dqXsLOE1tr5c=;
        b=dIPhTRiEcCmC76Tg1k3RXlWHC6kBteJpKUiZZzt+Gu91RjKyys1lGMxS0eaY+aSTt1
         shHvfb/Nxv9iQZG3qQP0ozSvnliBvbfHROgZzT1FTkt30tghWrYWoamG+mlpD5iJILbh
         StpbsQEL0tFPDElftcT22djbGOt9KgshCWfv+JcQdh1vX1M3ta4Q8uFBb4xn6OxJ+ayF
         wMEsdhWvVkMoSFFF6wSvtgq/UHs1/5nWka8+dn0hHOe5IyqEWgDrEcA3xQXXY54jL6NU
         ZIpuZwDjdzGZCYXp1mZwxreyxvQCuLL6Sg/2clroVw0AypgYdDtp4U8dUEJ/Ev8jNjxz
         XMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3zD0CEwtCQw4KD7pngUsgxPD/yoCJ3dqXsLOE1tr5c=;
        b=V8KuNucdo0ZBY1waq2gPkpBRJ5GTcjjg8aB8cm2syIsNI4h4nHtbNuwOk0RjSyLRW8
         5HsjKySZFXOT9C7/NHZa2e8hoYNYkEoHjP6S+/Nm4P/XPPCx2g5VvSF1CEh9Cf68F2zS
         1lV9lMGiMCAUyn2RsPdVK/tL7oA0nCVJyDGnJSVrysEivp9FRkB6l2u/+o3oB8JouU1f
         ZURbov8Rz+s8TbBG7mhaDC+nJFUEikBLE7FcM2mqjx+q/0LVVAYzK3+Ms5rtiQayr1NM
         kzfHAIfvqv1AggUtvhMHTOoCbTw7gOZJsZaGJYU5xZppwzhWpVfKoLXDbQR5uqvFioYs
         yNBw==
X-Gm-Message-State: AOAM530JhbI/TXPIshI+SxvqG4B2Sou86sXUUgcrWf34PUU5jVIKAmKe
        cB8DZ7rrYKEEbBvTU58C7h+QFg==
X-Google-Smtp-Source: ABdhPJwwBp316RbMQbGQUIap/j0NiwhMF9u29cFlS2aXLCYfJBejYdGfgaMfFPENgT4s+FnTAS0gaA==
X-Received: by 2002:a05:6000:504:: with SMTP id a4mr37073746wrf.51.1620199970885;
        Wed, 05 May 2021 00:32:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0])
        by smtp.gmail.com with ESMTPSA id v20sm4965663wmj.15.2021.05.05.00.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 00:32:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] arm64: meson-sm1: add support for Banana PI BPI-M5
Date:   Wed,  5 May 2021 09:32:45 +0200
Message-Id: <20210505073248.3816183-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Banana Pi BPI-M5 is a credit card format SBC with the following features:
- Amlogic S905X3 quad core Cortex-A55
- Mali-G31 GPU
- 4GB LPDDR4
- 16GB eMMC flash
- 4 USB 3.0
- 1 GbE ethernet
- HDMI output
- 2x LEDS
- SDCard
- 2.5mm Jack with Stereo Audio + CVBS
- Infrared Received
- ADC Button
- GPIO Button
- 40 pins header + 3pins debug header

This also adds the missing toacodec node to enable internal audio codec.

Changes since v1 at [1]:
- fixed bad compatible for sm1 toacodec node
- removed tab in bindings (but kept martin's review tag)
- renamed adc key node
- renamed flash_1v8 regulator to match schematics
- fixed vddcpu regulator voltages
- fixed ethmac rgmii-txid and checked it still worked
- added missing GPIO lines names (thanks martin !)
- 

[1] https://lore.kernel.org/r/20210429170404.3616111-1-narmstrong@baylibre.com

Neil Armstrong (3):
  arm64: dts: meson-sm1: add toacodec node
  dt-bindings: arm: amlogic: add Banana PI M5 bindings
  arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-sm1-bananapi-m5.dts     | 646 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  10 +
 4 files changed, 658 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts

-- 
2.25.1

