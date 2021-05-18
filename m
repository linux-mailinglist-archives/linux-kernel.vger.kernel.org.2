Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325BD387E03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350972AbhERQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbhERQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:58:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF9C061573;
        Tue, 18 May 2021 09:57:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id et19so8601730ejc.4;
        Tue, 18 May 2021 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7c6MsJBvMXq+ljj949Wf1mhFZUaYPm8nW/9/WPX5d+Q=;
        b=DQeYJxmdnvtw99Mx2oS/EkzthC1fuk3XuorE6cDYm92HzfuV6KW1yPZfRXj5l5C4pT
         DqStW5wfTtxbh6rdnFto+lzfIoC0HhR98XrFr9UrKvO5Dt5H3LlSlKmswPpOm/3zcNHC
         3qQh5W9xmkYB5Nav4ldRdJC2EdFXJhYLwXRZUp57cQbXgXhO76wFxCzqBBwcBniGQDzW
         MiuZebInPy+cJcRCz3xcQYVnold1QOTbkVzSFh58SUVno+CZ/dHbN6ILpBVHFjj18i9y
         oEsTLEbW1npAwr2cwRiRSMiTDUxrGPjn8dDo+W9U0i5MW2HTTVam0JKQn1+A0xmdZbIH
         HFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7c6MsJBvMXq+ljj949Wf1mhFZUaYPm8nW/9/WPX5d+Q=;
        b=sDic+U9hrkNXsPaDOmG+FiMaVeGfZp8SmMSxfQ1C4yfpiI9n7gAOuBuSOn0017EoXH
         Uz1LTNhUlzlCox3sh8/zNCHvr65o2Kr0As/38bWbaCHpNr/oAUD0TRV3h5KuQbI5kTCT
         qJbblgWgcDb5mHF66sgTSuXXScsNjW3N1gJw2X5ccBrFuUxltQQuE4MXijcjW26F/CMP
         A5oCJjijDsj5+Uba8MSwQuqsRDA7007PUneoMQRf5HEuvOtAdpQxHhqVu2Lawd4L+3GD
         8SIbuoRcShqYe01rIM6b0xVQ5pDbb1d7WysX/y4bXVeM7I1qYoo3LboIZpah4C9py3Hu
         5Q3Q==
X-Gm-Message-State: AOAM533GUO2XVwxr6Y6q/X5hwnUcJIZxpCzWGO874Cxyl2hjoY3Otnze
        MjdHSTxrKFJpV4ppo0DyBQ1IItV/G34=
X-Google-Smtp-Source: ABdhPJx826f98Egi0fzl54irC3mn/wDtedMWJGLyctK1eNcZdfToPVVZ+Z8YOx4D3QGT/VtfQveRMw==
X-Received: by 2002:a17:906:e0d5:: with SMTP id gl21mr7042755ejb.93.1621357026749;
        Tue, 18 May 2021 09:57:06 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n2sm13525676edi.32.2021.05.18.09.57.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 09:57:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] convert grf.txt to YAML
Date:   Tue, 18 May 2021 18:56:54 +0200
Message-Id: <20210518165658.12764-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed V6
  remove some #phy-cells in rockchip-usb-phy.yaml
  rename nodename for phy-rockchip-inno-usb2
  remove applied patches

Changed V5:
  changed compatibles for rk3066/rk3188
  add rockchip-usb-phy.yaml
  move and restyle grf nodes rk3066/rk3188
  remove applied patches

Changed V4:
  revert separate schemas for each 'if' subset
  add additionalProperties
  move properties to top level

Changed V3:
  remove select
  change unevaluatedProperties
  add separate schemas for each 'if' subset

Changed V2:
  add rockchip,rk3328-grf-gpio.yaml
  rename grf-gpio nodename

Johan Jonker (4):
  dt-bindings: phy: convert rockchip-usb-phy.txt to YAML
  dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
  ARM: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
  arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2

 .../bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +--
 .../devicetree/bindings/phy/rockchip-usb-phy.txt   | 52 --------------
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml  | 81 ++++++++++++++++++++++
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  4 +-
 arch/arm/boot/dts/rk322x.dtsi                      |  4 +-
 arch/arm/boot/dts/rv1108.dtsi                      |  2 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  4 +-
 9 files changed, 93 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml

-- 
2.11.0

