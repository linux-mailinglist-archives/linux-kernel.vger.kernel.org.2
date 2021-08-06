Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3E3E3079
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbhHFUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhHFUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:45:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005CC0613CF;
        Fri,  6 Aug 2021 13:44:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so6220630wms.2;
        Fri, 06 Aug 2021 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvqHVXKHi79eQa5zOD1wzmVDXkASnkyY1VkIn9290Rg=;
        b=UEqY9OVfruZl7dzVTxN6lV+4WokbppoNk8NEOo8TFgYBdJuifevBGY5DBQTViHnvaS
         sMcUyhtkCilGfcODGeqeUwKXw9W5bZKwCcXlU0sz0sWRe+TJQ8hAgAb4IMRKPij096t+
         /rPwzqvtlTMKyRyyqwc4BKbiM1CHOmkddg8wKkrv8e24Lw7lUx1UN4cgP8Evnx0qbAHf
         rbRCjRWj9aAXacAf3WLKTVC4EAezkQ2IBhTI9HpJiuDt0GcfhH8Yzru74mLHdmXjUu0k
         EZs6h+amVuxHV65413JNKAkTTHyicVEErNfK/NYTqe25OVGeQwRrA7EFN4x/57SdfmDG
         w6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvqHVXKHi79eQa5zOD1wzmVDXkASnkyY1VkIn9290Rg=;
        b=aCu4U87HDeu8P5zFLAGnRZAKe1iXxdME/ubrJDGJZ8sIHV7KZzAg6F5JRLJ/nJ9XSy
         airTmLJMsqWCFgA+lm1Vsd7x0MfBaObTIx4RlfqEZXKjFnwiWAIe4lPnPIVkq1a0VX1U
         PnPbtXPdq5bALguycq/fQsyaup2sDcjPtQqOY/KspUVqo49l0K7PMse/VlegR2FvYSLH
         mveL2Cbk4O7Sst9n9/rgjeCALfMXyqAl52A51TTvtbJOh+MDx5m9sXAwovwDlRXWleTq
         uCqhkIFWvvtA27eHuW6ftLNm2Swpv0QccND4e+UFcJLzhQlZGYCqhobwwL+lJTNoYlQA
         wuLw==
X-Gm-Message-State: AOAM5324FQ6b0ljZWZPgeNMmrWgvz1zJ5CLnk0E5y6PW5tDeV4ePg3KB
        D183vGNF7JkFIe2e5WQY8gsncBvxpCw=
X-Google-Smtp-Source: ABdhPJzMC1EHegs5qGPHSILcdEi9QcJvuIMcf6GodC2xHJ6mbnAjX84IJC3GvI2DpCVk0MTQUVkeZg==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr5189879wmj.148.1628282692706;
        Fri, 06 Aug 2021 13:44:52 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id w10sm10110029wrr.23.2021.08.06.13.44.51
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 13:44:52 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/5] ARM: dts: NSP: add Meraki MX64/MX65 series
Date:   Fri,  6 Aug 2021 21:44:31 +0100
Message-Id: <20210806204446.2981299-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
  - Introduce boards to Makefile in same patch as the board dts is added
    (Vladimir Oltean)
  - Use alphabetical ordering for labels (Vladimir Oltean)
  - Remove address-cells and size-cells in qca8337 switch nodes (Vladimir
    Oltean)
  - Remove "cpu" labels from switch nodes' CPU ports (Vladimir Oltean)
  - Various LED fixes, utilising dt-bindings/leds/common.h and correctly
    specifying LEDs in the form "led-N" and with the color/function/
    function-enumerator properties.
  - Fix PWM LEDs and corresponding pinctrl bindings. (Vladimir Oltean)

The following changes were submitted as a separate series:
  - Introduce patches to disable QSPI by default and enable where used
    (Vladimir Oltean)
  - Move mdio@18032000 node from board related file to SoC (Vladimir
    Oltean)
  - In addition to above, relocate mdio-mux to bcm-nsp.dtsi and fix
    the resulting usb3_phy issues

Changes from v3:
  - Sort labels on mx64 a0 dts files into alphabetical order as well
  - move include directives for input/input.h and leds/common.h to
    bcm958625-mx6x-common.dtsi
  - Whitespace fixes in bcm958625-mx6x-common.dtsi
  - rename "senao_nvram" partition to "nvram" 

Changes from v4:
  - Move chosen and memory nodes from bcm958625-mx6x-common.dtsi to
    each .dts file (Arnd Bergmann).
  - Append [@<unit-address>] to memory nodes.
  - Create Ax stepping-specific dtsi for Ax devices (Arnd Bergmann).
  - Append read-only property to at24 eeprom node.
  - Remove L2 properties which should be defined at platform-level.
  - Correct NAND node names.

Matthew Hagan (5):
  ARM: dts: NSP: Add common bindings for MX64/MX65
  ARM: dts: NSP: Add Ax stepping modifications
  ARM: dts: NSP: Add DT files for Meraki MX64 series
  ARM: dts: NSP: Add DT files for Meraki MX65 series
  dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65

 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml |   6 +
 arch/arm/boot/dts/Makefile                    |   6 +
 arch/arm/boot/dts/bcm-nsp-ax.dtsi             |  71 +++++
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 279 ++++++++++++++++++
 .../boot/dts/bcm958625-meraki-kingpin.dtsi    | 163 ++++++++++
 .../arm/boot/dts/bcm958625-meraki-mx64-a0.dts |  25 ++
 arch/arm/boot/dts/bcm958625-meraki-mx64.dts   |  24 ++
 .../boot/dts/bcm958625-meraki-mx64w-a0.dts    |  33 +++
 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts  |  32 ++
 arch/arm/boot/dts/bcm958625-meraki-mx65.dts   |  24 ++
 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts  |  32 ++
 .../dts/bcm958625-meraki-mx6x-common.dtsi     | 129 ++++++++
 12 files changed, 824 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm-nsp-ax.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi

-- 
2.26.3

