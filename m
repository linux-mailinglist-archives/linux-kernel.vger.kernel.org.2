Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758BB36EE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhD2RE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhD2REz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:04:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4AAC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:04:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s82so1237593wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4osrw7Ler4/vCy2T4LTFORBBWseqxgPFKsBoHb7/xA=;
        b=Tm/Fk/QObU0IY482tWJn+v/HIVmJ6V+45EWZeCkoejpyX63YUkJHOFDRPVIZXfM52v
         4sMzHaAPsnNKqFTUIjCVoO71g/w8S+mhAMsS/xbuQDnPxidJFFwWsn2VAEYdKGUUV2zm
         lWVt0dXN3PVaPjgHAoey5XI2ma2+71VyxvPjMv2bAl4VqG1Xh9ooNi8zEIbRkPA8eyvi
         LpjVvnLX38Bq4/TonHfcT03XZiKnM40f2xhV7g9qt+YRVzt8k3msfO23aj+zHjV4jnlZ
         lP23XKCxG5pasRAC4coBqxr2BPFNtyNKZNj6a4kG1JKxRUjGnHeDgLsoP8WyMG3ayKcG
         BSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4osrw7Ler4/vCy2T4LTFORBBWseqxgPFKsBoHb7/xA=;
        b=aY8+F8OJpPDsnjvs6xSRU4jknZCc13ic4wfxFzv+zqsm9YD3jPVJuOhTxtGCOiUvtR
         zBLdThjspXZPZ1cLmRBaDiCZob7anx4mDkaX8uL4Z+V66DYF2i6ZIBlh1iOFozRASj8K
         EUl3F9AJYPRBlp+N9RSUpJNJRboDFOvpkcU562a7Ci5h3VpdeqRrX02ObU4otKStLpNK
         gN1w2WcYoG49HjC6ZuwhjIMdsOz4NaYBO68Z4N+UUQ/vmFjN9sspz9z5dQAagW2BalVb
         gOxroFRCGdhR07wJCt+vMZTfEIYMOWAHiYJVF9OASHjzSwROrSo0IxmFJsVfdFdMKhHn
         GfDg==
X-Gm-Message-State: AOAM531DDsUeKhi7Oazzg/RQGi+EpO/FWh5fShMTWMFfcTSumcPj4dMP
        71aolPoZP6t7eNcNL6boYh/tOw==
X-Google-Smtp-Source: ABdhPJzfwWOyATeEOoon2Wmu89CkD9+SVVIBKVropOnFcJ1co1JDEY47UOACmlkf7bw7X1Mun7zu0Q==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr11725084wmi.105.1619715847365;
        Thu, 29 Apr 2021 10:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id 18sm11041275wmo.47.2021.04.29.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 10:04:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] arm64: meson-sm1: add support for Banana PI BPI-M5
Date:   Thu, 29 Apr 2021 19:04:01 +0200
Message-Id: <20210429170404.3616111-1-narmstrong@baylibre.com>
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

Neil Armstrong (3):
  arm64: dts: meson-sm1: add toacodec node
  dt-bindings: arm: amlogic: add Banana PI M5 bindings
  arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-sm1-bananapi-m5.dts     | 606 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  11 +
 4 files changed, 619 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts

-- 
2.25.1

