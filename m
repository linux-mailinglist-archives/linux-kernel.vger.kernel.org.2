Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A1380BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhENOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhENOeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:34:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DEAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n2so30308795wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/VpTW4d5I0K39oGLweJUltX/Tb/UyuPS5ZReMp5vnM=;
        b=HIM48Rl3L4OrJgDurTmmQ2fPlCmtUz+P0PYpv5ZODTD2JLodczQq98PDcqfnygYikW
         p1PRH4TaDnP7tQWSc+0RX2QSw0rPmRABR9OBL6GARLzPzRCU91k1pYkmCbEX5iRKxnBW
         eIFse9OKYQeqoct5TxC/LK4I11fjcd9RMu12R74C1LE43T50Ec/Ma1TpMap36Vb6AMfy
         5O20Z95JEcTpyyt8af5EHY3wHiGGLTc4/2u8Wqg1aE4e3WihQdkSuhq/LT7zUNlflqPT
         EkkxSghc9odhOZB4QN6Qwqn6RzwEWcDWR9ytlqddihClrltKfs9dVhSqnPDkFOlMKnCO
         SwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/VpTW4d5I0K39oGLweJUltX/Tb/UyuPS5ZReMp5vnM=;
        b=ZanrGzSxm5Gwyy9PhUHbVUkOX/NyLSVl6MIEA1jnmm9DU2JGHZ0OxTiCI0GHdNZ49z
         TLXIEBtxdGcL6N5oKu5So0krAaZezx5MQpiD/KhtDNlCNbEnp5V9ZvF5UVN65lhC2l49
         gL3lejLLNA2C4aOaMbaT10H0765oidCmiupGLyfmHO8JN3Rr0lOOg5IQHA40eUd0IdeF
         H/5TvRgxs9YUcRiTa7BhwARqiL+xuRi5NmR9qVH+vegn09JaxSluJPLjqQ0jsPFPmScX
         amX8FBb+mHkmkzEae8BAliv75UkTqwlSLo0KEeGJOp7FYeS1aQSGzLaKKTMaUktXxW1H
         RB4g==
X-Gm-Message-State: AOAM533OmLJkJJ5XiLAb1gV7O14do/dpUNaHN83pCoUssASJ6yuTYLzO
        dpGNQyejVzBBIyM9dZ0HkpJDEg==
X-Google-Smtp-Source: ABdhPJxBp1hHz7JTDl+SuVo0/37Hv4oTe06YTktDzDjvDBQnHPCvNajnUl3nn6VsedqIrcsfSszD2w==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr59255997wrm.46.1621002781730;
        Fri, 14 May 2021 07:33:01 -0700 (PDT)
Received: from localhost.localdomain ([37.173.48.34])
        by smtp.gmail.com with ESMTPSA id v21sm11552036wml.5.2021.05.14.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:33:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/3] arm64: meson-sm1: add support for Banana PI BPI-M5
Date:   Fri, 14 May 2021 16:32:52 +0200
Message-Id: <20210514143255.3352774-1-narmstrong@baylibre.com>
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

Changes since v2 at [2]:
- small nit fix in DT comment

Changes since v1 at [1]:
- fixed bad compatible for sm1 toacodec node
- removed tab in bindings (but kept martin's review tag)
- renamed adc key node
- renamed flash_1v8 regulator to match schematics
- fixed vddcpu regulator voltages
- fixed ethmac rgmii-txid and checked it still worked
- added missing GPIO lines names (thanks martin !)

[1] https://lore.kernel.org/r/20210429170404.3616111-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20210505073248.3816183-1-narmstrong@baylibre.com

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

