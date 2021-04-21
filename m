Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC164366789
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhDUJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbhDUJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45136C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e9so4292694plj.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YN/nmUh9APD9tW++qNNzvwSyrvP9kAzlnRWJP7UTqw8=;
        b=E/bDd4stpigRKHLBmM7boSUFUdSeoMYg70Sxl7+7SdP/bpB0NRDb/XNrxaSYcSbzA5
         O/ZihtJUWg/RkWrVNDJMJbT4d+xrgZm/eKpbGZZ8Gz0sgfEMiO2USQTymahFefQOLsjL
         I8qgC3vQrlj0b7NYEDrICfBCQXev97pB3tliI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YN/nmUh9APD9tW++qNNzvwSyrvP9kAzlnRWJP7UTqw8=;
        b=GafJcIp0QmzpDeNDXfknl+zIu44lTcSTa28E9bhaiK3MRcIqrsn5W69e2yn6Lga5aj
         lxY/WeuqYj9y0bNRJ36GUkK8/vZE+taWKbHcUisiFOeOzTnzp3KCe4z14xAoPleGegBj
         JNwUJW3dxpfXFeFvJG6FppzyMb8kmV6qjUng88MBL1Emuab2KLQEXZrG77ZtAZ4PBYV0
         5fdjOi7WbgBuEVoX8dVvhOPtB+vlJOHWVlgdAK4fGsohN/Nsmd9hdLziXdsH3WLqD5UJ
         i9FY21+w0h14jIj+R5iJpIWlKWI64Pou9Rd4DJzTBjoVnT3Yc/MJqlMFLhhqFesF17NX
         d/iw==
X-Gm-Message-State: AOAM530Y4ijmtoAN2V/dnf/dsDkk6CCauL0AHzwsW/2A3ghOiNjLgK6E
        sHkLE/S3JPpZMQSwUTIN96lllQ==
X-Google-Smtp-Source: ABdhPJypgg+tTiJKZh+G2ovk+kqA8t7/GJ+LKUMbYaoTtXTh//9Uh6G0vutZCIY27V9JopVBtzfHNA==
X-Received: by 2002:a17:902:d706:b029:e6:90aa:24e0 with SMTP id w6-20020a170902d706b02900e690aa24e0mr33502167ply.42.1618995965639;
        Wed, 21 Apr 2021 02:06:05 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:05 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 00/10] Add several jacuzzi boards
Date:   Wed, 21 Apr 2021 17:05:51 +0800
Message-Id: <20210421090601.730744-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add several jacuzzi follower devices: kappa, willo, burnet, kenzo, and
fennel.

Change log:
v2 -> v3:
 - remove unused property in i2c2 in willow and burnet.
 - add fennel.

Hsin-Yi Wang (10):
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kappa
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-fennel
  arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
  arm64: dts: mt8183: Add kukui-jacuzzi-willow board
  arm64: dts: mt8183: Add kukui-jacuzzi-burnet board
  arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
  arm64: dts: mt8183: Add kukui-jacuzzi-fennel board

 .../devicetree/bindings/arm/mediatek.yaml     | 29 +++++++++++-
 arch/arm64/boot/dts/mediatek/Makefile         |  8 ++++
 .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 30 +++++++++++++
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      | 44 +++++++++++++++++++
 .../mt8183-kukui-jacuzzi-fennel-sku6.dts      | 32 ++++++++++++++
 .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 27 ++++++++++++
 .../mt8183-kukui-jacuzzi-fennel14.dts         | 16 +++++++
 .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   | 16 +++++++
 .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   | 12 +++++
 .../mt8183-kukui-jacuzzi-willow-sku0.dts      | 13 ++++++
 .../mt8183-kukui-jacuzzi-willow-sku1.dts      | 12 +++++
 .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi | 26 +++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  8 ++++
 13 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi

-- 
2.31.1.498.g6c1eba8ee3d-goog

