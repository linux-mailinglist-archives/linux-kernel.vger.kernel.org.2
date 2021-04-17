Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6A362F85
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhDQLah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhDQLa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0731C061574;
        Sat, 17 Apr 2021 04:30:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x12so25070070ejc.1;
        Sat, 17 Apr 2021 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xhYT+iV3aFgNz8/yb0rx39O1slLtrptPkFLaM/76FAs=;
        b=PxBG7GzoOc499bBgqz/aqmBi/4tVAUZ4vK5TqznPACo+H/X9C5AFfbK4728HJ8+eRK
         CJSH9lTGNXom2e9T9vL220sQUhoihY9neURJaJeXnW2iirHMnDOt1BqQLvMSGVbZENZr
         RnuSoowxYQRIa5qkoaviYaPeIDkDYbJqMMDs9n5nHXLr1yyFOctBPROrUl5HUUU+zCWX
         cqiJSIysVTWVNpnGt5IZlFzBPEX7MRczqLsgNGz9VjnVM52/KZzbOzORaVwwKDssIgbo
         HYVoXUqCi6KJgyE1TmZdZ5FkNOix4V8zre7uaRBRvdjPQgtFKIeIYczXJPj9gd2skhKE
         rQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xhYT+iV3aFgNz8/yb0rx39O1slLtrptPkFLaM/76FAs=;
        b=tZgMO2ZzvUQHY7MZfaBQHyjqJ2hoNAVKFghGQ2MTzlmer1ixA4rOEz4lJMyGy3YDf7
         Xejn28jTmke1kQjWeG+vRn/DY2CMEg71TSqZC47TDnlMAPjO0NfVB4IcL5I9w3EIjQ2y
         jVyP9nJX5uVlGpX777QALntLh08NdDm8YpINOKCG5KPq0f9qmrDYQi7BsXBaxWo+JX73
         gj5p4HyL/8YIqGwnbqN66qk4d9U057CrLlA/gclM+yUUO4B8fKpwNPEXT5bVOxV9DxcT
         4fk6TpPX8HAZIXWwzA7DIEu+cLlpb8zNu72dkcP1AKH8kPqt470QEhMdzqJD3XPQW0pM
         2BCQ==
X-Gm-Message-State: AOAM533FEyUG4FEojQTEhbGgzgQeZ5LAgbnSIkhaTyTPKJK1VSd5/nH5
        DtpDujyHdyrun6a/TM69C64J6DkFAFfUcWJP
X-Google-Smtp-Source: ABdhPJxahI6kLtSFba3L+kGx9qvwj1gA/irHSGxfgNPQqFsckHYX+tIVMotagqZ+xWuy5XiFAoJzjA==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12420956ejz.259.1618659000696;
        Sat, 17 Apr 2021 04:30:00 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.29.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:00 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/15] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Sat, 17 Apr 2021 13:29:37 +0200
Message-Id: <20210417112952.8516-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix power-controller node names for dtbs_check.
Convert power domain documentation to json-schema.
Add a meaningful power domain name.
Support power domain function for RK3568 Soc.

Changed in V9:
[PATCH v9 13/15]:
  Rename definitions to $defs
  Restyle patternProperties

Changed in V8:
  Add #power-domain-cells to power domain nodes.
  Convert pmu.txt to YAML.
  Add more compatible strings to pmu.yaml
[PATCH v8 13/15]:
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
 .../bindings/power/rockchip,power-controller.yaml  | 248 ++++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt         | 136 -----------
 arch/arm/boot/dts/rk3066a.dtsi                     |   9 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   9 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  12 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  24 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   9 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  60 +++--
 drivers/soc/rockchip/pm_domains.c                  | 252 ++++++++++++---------
 include/dt-bindings/power/rk3568-power.h           |  32 +++
 12 files changed, 564 insertions(+), 300 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 include/dt-bindings/power/rk3568-power.h

-- 
2.11.0

