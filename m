Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2301361B05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbhDPIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhDPIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60833C061574;
        Fri, 16 Apr 2021 01:04:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u21so40825065ejo.13;
        Fri, 16 Apr 2021 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OWRXiPGRi09QbcBFvA9VOlXlTCFeZlC+E/sc4KUB+7A=;
        b=YAfK0ActrpH0ig12JPJ+SU8a+VVAabRSDFiW+zaSwaLg0Ee6gIJZn8tP3RecwrR+rm
         g9L8LxCirOy1w6dhRcBh3/qU5dkA/OtyLYGDq62985DRxXQF+TK5KM38e5nkfxNuObdc
         qsH+BjsSndNVdByxQHGyiIS1ZC6XuZuxbfjRLmC0F75xRk7GMnfygH1qDvS1FvFhMC1k
         M25J8o0IRNA3InSOtUJqD2ANSElOIXkvhzUgZm+KCudblw0YK/Z1UVx7M+qutDP9d0T0
         jIh6ikRCPI++HL+ZybODn3A/jgsAzu/TKQ7KsowWG7/i+Olh9gAWOU6GF7Oy8yVgpiM/
         78CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OWRXiPGRi09QbcBFvA9VOlXlTCFeZlC+E/sc4KUB+7A=;
        b=PbnmhgDHALkkd/rkjaUnemZboGXr3txFxQTPdTJcFp3WrfG/EbSLx5j5R4lsFIgWI8
         yonN+0hruv511xOnnve3HOHdCKugOSA2R1TZhRYwUEVumpYqtZKwcyMWDb334UBEjJ3h
         16m4rJaiBbAG9duS5syETeNCZe1P58EHmCmXUZNOVSHjZL2h5UR9LoJRl4yp6tJHfVTE
         QSu2o1ts99Kf+L3TCxtKcVyBus9LyoHDrEnzd6j3yL6ZfmrIBQMDd8W7bmly/85SD77j
         hvuBZteM7FOnuZ8wNV1dR44YGl1UXPDaAyWQDGC/J4gDYWtIbyeiIQJxW5DnTiNXAnVu
         uD5Q==
X-Gm-Message-State: AOAM531BdoD8EVXUM9eXuBYrShFHeLOCcw37wwCCTyczbo3qd3zkH8H4
        QeXcD2VQPB/gjG7eDLTzNa5Ns59UPaF5Kff1
X-Google-Smtp-Source: ABdhPJwtExuvPla2KbvdeXR3UALergaPe7QsuMA4vfP9OXbIKm+ngpy0r+5X0gsJnpl0ENGH/GqBfw==
X-Received: by 2002:a17:906:cb1:: with SMTP id k17mr7136631ejh.307.1618560285007;
        Fri, 16 Apr 2021 01:04:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.04.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:04:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/15] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Fri, 16 Apr 2021 10:03:27 +0200
Message-Id: <20210416080342.18614-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix power-controller node names for dtbs_check.
Convert power domain documentation to json-schema.
Add a meaningful power domain name.
Support power domain function for RK3568 Soc.

Changed in V8:
  Add #power-domain-cells to power domain nodes.
  Convert pmu.txt to YAML.
  Add more compatible strings to pmu.yaml
  Add pd-node ref schema.

Changed in V7:
[PATCH v7 07/11]:
  Fix TAB warning
  Fix alignment
[PATCH v7 09/11]:
  Fix commit message and author format
  Changed SPDX-License-Identifier back to GPL-2.0
  Remove "clocks", "assigned-clocks" and "assigned-clock-parents"
  Fix indent example
[PATCH v7 11/11]:
  Fix alignment

Changed in V6:
[PATCH v6 7/11]: Use kbasename(node->full_name).
[PATCH v6 9/11]: Update the commit message.

Changed in V5:
[PATCH v5 1/11]: New.
[PATCH v5 2/11]: New.
[PATCH v5 3/11]: New.
[PATCH v5 4/11]: New.
[PATCH v5 5/11]: New.
[PATCH v5 6/11]: New.
[PATCH v5 7/11]: New.
[PATCH v5 8/11]: No change. Same as [PATCH v4 1/4].
[PATCH v5 9/11]: [PATCH v4 2/4] Fix up yaml code styles.
[PATCH v5 10/11]: No change. Same as [PATCH v4 3/4].
[PATCH v5 11/11]: [PATCH v4 4/4] add a meaningful power domain name for
RK3568 Soc.

Changed in V4:
[PATCH v4 2/4]: Fix up yaml code styles. Remove the new compatible to [PATCH v4 3/4]
[PATCH v4 3/4]: Adding new compatible for RK3568 Soc.
[PATCH v4 4/4]: No change. Same as [PATCH v3 3/3].

Changed in V3:
[PATCH v3 2/3]: Fix up the code styles and add rk3568 base on:
https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/

Changed in V2:
[PATCH v2 2/3]: Fix up yaml code styles.

Elaine Zhang (10):
  ARM: dts: rockchip: Fix power-controller node names for rk3066a
  ARM: dts: rockchip: Fix power-controller node names for rk3188
  ARM: dts: rockchip: Fix power-controller node names for rk3288
  arm64: dts: rockchip: Fix power-controller node names for px30
  arm64: dts: rockchip: Fix power-controller node names for rk3328
  arm64: dts: rockchip: Fix power-controller node names for rk3399
  soc: rockchip: pm-domains: Add a meaningful power domain name
  dt-bindings: add power-domain header for RK3568 SoCs
  dt-bindings: power: rockchip: Add bindings for RK3568 Soc
  soc: rockchip: power-domain: add rk3568 powerdomains

Enric Balletbo i Serra (1):
  dt-bindings: power: rockchip: Convert to json-schema

Johan Jonker (4):
  ARM: dts: rockchip: add #power-domain-cells to power domain nodes
  arm64: dts: rockchip: add #power-domain-cells to power domain nodes
  dt-bindings: arm: rockchip: convert pmu.txt to YAML
  dt-bindings: arm: rockchip: add more compatible strings to pmu.yaml

 .../devicetree/bindings/arm/rockchip/pmu.txt       |  16 --
 .../devicetree/bindings/arm/rockchip/pmu.yaml      |  57 +++++
 .../bindings/power/rockchip,power-controller.yaml  | 259 +++++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt         | 136 -----------
 arch/arm/boot/dts/rk3066a.dtsi                     |   9 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   9 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  12 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  24 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   9 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  60 +++--
 drivers/soc/rockchip/pm_domains.c                  | 252 +++++++++++---------
 include/dt-bindings/power/rk3568-power.h           |  32 +++
 12 files changed, 575 insertions(+), 300 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 include/dt-bindings/power/rk3568-power.h

-- 
2.11.0

