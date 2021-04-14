Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4036E35FD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhDNVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhDNVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDC7C061756;
        Wed, 14 Apr 2021 14:19:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f8so25411049edd.11;
        Wed, 14 Apr 2021 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sivu3yMxn7WQFGx4J7BCqHxoq6bWyr/i/BQeBwsAz6w=;
        b=Ne/Jtg3R3EbB3PKuGutnf/94vrL4JxfSqvcOv9diXq+m8WnrlC7Hmjgy46yv0kjGVv
         Z0qh3xdm3w/9Ei/Kv0xBklKcMIogFEFhQNmtJG2TTp+wkt+/K4D5XxsXgmefTSfsgr46
         gZ7hvKMi6gGoky8WFB9ROmBPhKmHyXTHhiwJerbBzv4Pfzj2tuxJQfDeW/ZediFpeqoY
         A9emGCjGWI0DjqqHG3lF2r5/PaDZZZTAbLtQ5cbbYtvL15pTf/OMLufZI9GMaEan0Uf7
         Gw8rLpHQO0PR9fjtPlX7gQJgaJq091NQJKA8RZETsVqB5KEGxeJfjNAHe5Ug7oXFqR1K
         l/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sivu3yMxn7WQFGx4J7BCqHxoq6bWyr/i/BQeBwsAz6w=;
        b=iLNnzdpp1tLKhKCfJHwufxr9SBCk37HC7e7Ii793963QdxqL/Y5+hfwXGATqSbYB5e
         NokJzdfYVZ1O0EGSCmbVwb3VageYtJ7ZmIADEdgG0obIZWEjdXnnBJlVtruhHlp8fFmE
         bzrTlJ0WP83ruQGen+PZDCS+R4E4CX33swtbDiGQJekXwBgK9tLLjiPkMUk5+c7h2vVN
         /oIVXIbY0zj0ZavxWRp/Weoaml19tOi6gvg1Le1Nj8pQu4R1/kPWTKSiGNjcDMgppKBY
         4686WvpdeizJUrs2zBYOr4eeT2qkNphzFenI3oZ548nlFnpDrPpk+nJvPxGUmnc4CPfS
         9HQQ==
X-Gm-Message-State: AOAM531y/d1M8EtQsa8ObtmhRN6C+hlxq8TRGxiFnkVy6Ti6UqZBfiRw
        0DKPbMfD5nwur0Hefe3+PH6ily6IayX9Aqco
X-Google-Smtp-Source: ABdhPJxgvC3a2ajhFLpY1gsJ62ZsK+Y70a6DRRd1syLq0+TpLW7ewr20jjQ3xy2O4NDexpBYso6UxQ==
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr259245edy.142.1618435145581;
        Wed, 14 Apr 2021 14:19:05 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:05 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/11] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Wed, 14 Apr 2021 23:18:45 +0200
Message-Id: <20210414211856.12104-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix power-controller node names for dtbs_check.
Convert power domain documentation to json-schema.
Add a meaningful power domain name.
Support power domain function for RK3568 Soc.

Changed in V7:
[PATCH v7 07/11]
  Fix TAB warning
  Fix alignment
[PATCH v7 09/11]:
  Fix commit message and author format
  Changed SPDX-License-Identifier back to GPL-2.0
  Remove "clocks", "assigned-clocks" and "assigned-clock-parents"
  Fix indent example
[PATCH v7 11/11]
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
  arm: dts: rockchip: Fix power-controller node names for rk3066a
  arm: dts: rockchip: Fix power-controller node names for rk3188
  arm: dts: rockchip: Fix power-controller node names for rk3288
  arm64: dts: rockchip: Fix power-controller node names for px30
  arm64: dts: rockchip: Fix power-controller node names for rk3328
  arm64: dts: rockchip: Fix power-controller node names for rk3399
  soc: rockchip: pm-domains: Add a meaningful power domain name
  dt-bindings: add power-domain header for RK3568 SoCs
  dt-bindings: power: rockchip: Add bindings for RK3568 Soc
  soc: rockchip: power-domain: add rk3568 powerdomains

Enric Balletbo i Serra (1):
  dt-bindings: power: rockchip: Convert to json-schema

 .../bindings/power/rockchip,power-controller.yaml  | 285 +++++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt         | 136 ----------
 arch/arm/boot/dts/rk3066a.dtsi                     |   6 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   6 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   8 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  16 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  40 +--
 drivers/soc/rockchip/pm_domains.c                  | 252 ++++++++++--------
 include/dt-bindings/power/rk3568-power.h           |  32 +++
 10 files changed, 503 insertions(+), 284 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 include/dt-bindings/power/rk3568-power.h

-- 
2.11.0

