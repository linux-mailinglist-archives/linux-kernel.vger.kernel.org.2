Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87048397864
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFAQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFAQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:49:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4043C061574;
        Tue,  1 Jun 2021 09:48:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so1529595eja.11;
        Tue, 01 Jun 2021 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SNDnPKo0IOSMNHVeB+T/BZBs16GMZgVZnpnc2H3yIYg=;
        b=N68+a2VU87EkEABzexLE5f7OkW4EqtgwbJV0D1To6RbaJLzWTDiAp+spn7lWrbWP4X
         PsCDt68DlfS5gtnpkakBylrDKX2DFxdkekc4M0mdo4eZPitxpkDi7vQYyzdn4VTiJGMH
         JKXu8c+iCRS+rBYXdc8Bd6F25Ww2jHNJaGIOdEpLHn2AWgle+RfIeM8ZMcOW0w2ukoTj
         Nv2G1gDxktgWdwtVbSuqfop9+IjZWMXWH8WCqqAWptG18Sl2UJtLl0HRBXUpTg9Lyzyl
         /l3ChCQoySftQfTcAK6UEDXY5BK2l9nP2plSrPuvFgufw/Ge5Gxm2PXEvTmudipQMOON
         d+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SNDnPKo0IOSMNHVeB+T/BZBs16GMZgVZnpnc2H3yIYg=;
        b=GD7ss+0MNhAyd5tHGUHgBXPTiV0u7Z9prPwHQtJ+j6mGhRh/ORANcNZMdZ4CQOIGBk
         2drPNhoXXxewffY2Lo7Tx22LkSiDL7HbzRfXwl1p7A/7wNagqREXz1YZxlA1gVlowP4n
         PxdTV1HpfhV7AzT4XlY4bCfOifmMTAmn/XZf8ddmURAKJNzlAwtJbD1fjPUmkTUZ9dst
         iaja62PtGKTQx5PIRyAILtO94FJO+8IFAwqaKZ367fz7OXS2XCDAFwoVfxOfa1nldpeA
         ReZjvly6OaHcjlQQyw61VH4exWKfb27cVlXsEPbMln40ymi2tep4P4i7dwbU7li8Z53H
         0+pA==
X-Gm-Message-State: AOAM533AGyY2cP23b04FOZejEBOpJwx18HyEux9/Jw7OZRZLtNzqIC/k
        7kial3GW0ioxG5/emXWJq4XArqc0susR4g==
X-Google-Smtp-Source: ABdhPJwkbv3rOis31nesJnk9sxU1Yy9Oc2BBG/OHbvRnqxP27lKOLXrxLKvHkPDlKK+oO5IT6H7Pjg==
X-Received: by 2002:a17:906:495:: with SMTP id f21mr12030615eja.510.1622566089476;
        Tue, 01 Jun 2021 09:48:09 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm8327750edd.3.2021.06.01.09.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:48:08 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] convert grf.txt to YAML
Date:   Tue,  1 Jun 2021 18:47:55 +0200
Message-Id: <20210601164800.7670-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed V7:
  rebase
  add compatible for rk3308 USB grf
    add "rockchip,rk3308-usb2phy-grf" to "usb2phy@[0-9a-f]+$"
    patternProperties too
  add USB support to rk3308.dtsi
    restyle
    limit grf reg size
    change sub nodename
  remove applied patches

Changed V6:
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

Johan Jonker (3):
  dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
  ARM: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
  arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2

Tobias Schramm (2):
  dt-bindings: soc: rockchip: grf: add compatible for RK3308 USB grf
  arm64: dts: rockchip: add USB support to rk3308.dtsi

 .../bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +---
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  6 +-
 arch/arm/boot/dts/rk322x.dtsi                      |  4 +-
 arch/arm/boot/dts/rv1108.dtsi                      |  2 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  2 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           | 74 +++++++++++++++++++++-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  4 +-
 8 files changed, 87 insertions(+), 18 deletions(-)

-- 
2.11.0

