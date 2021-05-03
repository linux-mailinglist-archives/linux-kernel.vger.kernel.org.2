Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E410371742
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhECO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhECO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:58:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D297C06174A;
        Mon,  3 May 2021 07:57:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so5906147pju.2;
        Mon, 03 May 2021 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ik3wrzpwnYSSTSQFdegvdMidUhrImlyxHbi+NVAFZeQ=;
        b=ns82hHHVmswbQv/3kS/nuzUsBa5rE6zd8LmLEbZifQd9bSi3KrQ3kjSCjhierzMpzl
         otGRj+tNg6qFybAWjewmxAIJD7r0DZfjIUyFjG1byU34s9E4XMt2baDRJJbi1bb+jlnY
         fH/U9QiQ0mFK3D8XziD6FA6SefOhO5hGWZ5IlT+YMlGLgKQix9CsWlOHCDf7tVkAu7dh
         PO4wqHzHKyJUNa/UrKZc0nOIFIFjeD5jD43TIiJ4VMnkGc7idCf0EXo2u6oai72Y2Jrk
         h3CYHQ2DuMER1EqZfICCLBDURQuKxbMYgvJIT4GIN/lGITXCRbXZYoY0NcDH2jxRacrd
         U9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ik3wrzpwnYSSTSQFdegvdMidUhrImlyxHbi+NVAFZeQ=;
        b=SRyd0Swy/7Ad/9W2EEZiQZRpmPlUUaoOMrwOlk/dPeM4KxwGYvsUMoSruubFCcBHct
         xfimmTeaGGNKT8gMw5HDTNCVx9PHgSkMNglcGE+7ioGwZWdxyZpjUCHSfTX1EVAOpf1h
         CdoithIzhqt9FvXAC8sdJX+OzbZIv185gYFC0+kU+71qV+PAsyu75ihvMu2jDg/Q/7l0
         6cEkhqIeQbE7F116IF2nTqotuj6B1ZczAIdHB7BJWM6RyoXhI71O2t/heP4U2MaG91xc
         mzrinMTzFaFzaYS2nQBYVc8epbI1HDBy5aaahua5t2kZKuNEcHAsy8uoRRUF6JJ3PlGu
         jSdA==
X-Gm-Message-State: AOAM5321ST6cUHHLSFkZ+Dqtx7RylU/vc0AelPhf5iH0yQv8EjOjAFwU
        sPRVckGgzg0BgvbQkoEAow6fhLVnMvc=
X-Google-Smtp-Source: ABdhPJxx8FIdxq1RnQpNlYcMei/6iy1SFOPobT/FRMctCUBqtt8agD26AIUyd8SxUiJ/z05VmIdMBA==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr31851971pjm.125.1620053841612;
        Mon, 03 May 2021 07:57:21 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:57:21 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 0/9] Added Audio and HDMI power domain for Amlogic SoC
Date:   Mon,  3 May 2021 14:54:33 +0000
Message-Id: <20210503145503.1477-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series add Audio and Hdmi power domain for Amlogic SoC.

Tested on GXBB - Odroid C2
          SM1  - Odroid C4
          G12B - Odroid N2
-Anand

Anand Moon (9):
  soc: amlogic: meson-ee-pwrc: Add audio power domain Meson g12a and
    g12b SoCs
  arm64: dts: amlogic: Add audio power domain for g12a and g12b
  soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson g12a SoCs
  arm64: dts: amlogic: Add hdmi power domain for g12a and g12b
  soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson sm1 SoCs
  arm64: dts: amlogic: Add audio power domain for sm1 SoC
  arm64: dts: amlogic: Add hdmi power domain for sm1 sbc
  soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson gxbb and gxl
    SoCs
  arm64: dts: amlogic: Add hdmi power domain for gxbb and gxl

 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts    |  2 ++
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts      |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 ++
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts  |  1 +
 .../arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts    |  1 +
 .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi |  2 ++
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi     |  1 +
 .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi      |  1 +
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |  1 +
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts      |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi    |  1 +
 .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts     |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts |  1 +
 .../boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |  1 +
 .../dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts  |  1 +
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts     |  1 +
 .../boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts |  1 +
 .../arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |  1 +
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi    |  2 ++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts     |  2 ++
 drivers/soc/amlogic/meson-ee-pwrc.c                  | 12 ++++++++++++
 include/dt-bindings/power/meson-g12a-power.h         |  2 ++
 include/dt-bindings/power/meson-gxbb-power.h         |  1 +
 include/dt-bindings/power/meson-sm1-power.h          |  1 +
 33 files changed, 50 insertions(+)

-- 
2.31.1

