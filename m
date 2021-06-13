Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367963A578D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhFMKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:20:55 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37812 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhFMKUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:20:49 -0400
Received: by mail-wr1-f45.google.com with SMTP id i94so11005432wri.4;
        Sun, 13 Jun 2021 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdbyjhZ0Rh8uIQkMpi2ZIF52kY6qMW2ZB38/qlzn2jw=;
        b=o3yRtZnk+S2NzLuXlfrmCs1lGEPwEur38evNNxrA4TTchT+vxykB4VV/YLevQeBamH
         XvsxFYC6lsPlCLXwOAcHrqvpanA7Md4STGu89+iN8x/E+RMDIOE3BHYb96mDW+jgP62P
         WVXVd71PUNitenxaf0NJUZg1mHdULf7LKp0VkO3oS/8cbqagKM156G4JqJBy9Vro2C/D
         XnNAMhoqRwSPNDoEjuG2eNuztt6EskaooYryyOJLm6DG8sz7yiG90lTaUc4ghDcNZn6c
         Uausm7XecBN/YwPAoXJJd3cThm1ZPCGqFUXq089/5wRnUS/mO8WhDeQow+Ar25l6fXbr
         feeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xdbyjhZ0Rh8uIQkMpi2ZIF52kY6qMW2ZB38/qlzn2jw=;
        b=iYD877cBA4MPlSnAMTL+oz9UEMd1bWV4ETDwCwqyGcVs03AU2QdPl8Iqbm7+bdTAC5
         Toj9QtCHh511vY9kSQmtbcC7CoIDpgTVloglMeLWpkeeLnHfTUxd6yalnfrAU+vOXlNx
         W2fTdfSWCdeKGJyOxERj3nRO5l94EBa/ylSb9UyxEpG1swiCbakOJAT23iTqn7aD2VlZ
         pQgawqPcxjXT4GieaWmUEELZADA+mPrHG7xBfxJa6zbQnAB8pmIpzQsZ1u9lUxaJx/aB
         5NnJ2HKiv4JtQ1uI3+cp4pCX1uNra0h/HfbAnthlDXPNQajuvtdtHh4/DMeKsQ2xssuN
         +2kA==
X-Gm-Message-State: AOAM533LdqE45C5g43TOLZ8jKK6lmLXhBGARQ3f9VlccLOnJNYzbPWN3
        CyASGCtNFaI2vjfwIvEk9ww=
X-Google-Smtp-Source: ABdhPJwp6ECOCLQMCVIdG6nhHH7oJPlKEBP/BcvCeDYzHEIJt9KXR74W+fJjAJb34Wwr8whFJwYBxA==
X-Received: by 2002:a5d:4538:: with SMTP id j24mr13170776wra.391.1623579467888;
        Sun, 13 Jun 2021 03:17:47 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id n18sm11599397wmq.41.2021.06.13.03.17.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 03:17:47 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] ARM: dts: NSP: add Meraki MX64/MX65 series
Date:   Sun, 13 Jun 2021 11:16:44 +0100
Message-Id: <20210613101658.3242777-1-mnhagan88@gmail.com>
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

The following changes have been broken out into a separate series:
 - Introduce patches to disable QSPI & SP804 CCBtimers by default then
   enable where used (Vladimir Oltean)
 - Move mdio@18032000 node from board related file SoC (Vladimir Oltean)
 - In addition to above, relocate mdio-mux to bcm-nsp.dtsi and fix
   the resulting usb3_phy issues


Matthew Hagan (4):
  ARM: dts: NSP: Add common bindings for MX64/MX65
  ARM: dts: NSP: Add DT files for Meraki MX64 series
  ARM: dts: NSP: Add DT files for Meraki MX65 series
  dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65

 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml |   6 +
 arch/arm/boot/dts/Makefile                    |   6 +
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 281 ++++++++++++++++++
 .../boot/dts/bcm958625-meraki-kingpin.dtsi    | 165 ++++++++++
 .../arm/boot/dts/bcm958625-meraki-mx64-a0.dts |  45 +++
 arch/arm/boot/dts/bcm958625-meraki-mx64.dts   |  15 +
 .../boot/dts/bcm958625-meraki-mx64w-a0.dts    |  55 ++++
 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts  |  23 ++
 arch/arm/boot/dts/bcm958625-meraki-mx65.dts   |  15 +
 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts  |  23 ++
 .../dts/bcm958625-meraki-mx6x-common.dtsi     | 145 +++++++++
 11 files changed, 779 insertions(+)
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

