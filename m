Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198013B77BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhF2SX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhF2SXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:23:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B5C061760;
        Tue, 29 Jun 2021 11:20:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m1so610342edq.8;
        Tue, 29 Jun 2021 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2R0bzURTRSXhlCdDiao5H3DH/BIRyXSazQ8H4jPLA3E=;
        b=a36TZfVjhjRRsUyXpGefeihG5ZNVjStiIkMe3Omzxx82Z/x4ZIti6W7pnKbj4RDIZN
         u0Q8gqLSw8QabTeZmnTvbH62w5dJrKPmBXeYd19kpgJAXSNGA3O42fHoqXcwnsZ7mpTT
         ZQ8XABMXTwpIoXI/4d+axQRWa4Tc8mqD5tmVG6CGAPyrkJk0m16b5j3kM6FoRG8HqnZ3
         r23manBjaDmva7424tFPsUoCDW4yuJWcXV0kVTTotVm3JsnaV1ngEQiA/SSSmCrSePJY
         YKbQEyVec32zGBiJG8pRP4zHTDRiq3vm8VRDuDddkGk7yB/Uwi7uE4ntUT5Ry6pJz4iY
         KHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2R0bzURTRSXhlCdDiao5H3DH/BIRyXSazQ8H4jPLA3E=;
        b=m2fEcDPXmMr+VrLFzvjXSUoClEBCIOo9R9yDNP3tQJ4xbXJgAcdHjcXLc+Tkp9NOgP
         rxcAo9PlWHcLz4T+xEipCg5hOvbbS+rJ4oOTq1DZJX8F8OKVDIzV8DhvD7cW0RFYk8La
         7cgZpyaDI1/zkhq/F5TeYkKJhwKuXLT5MI2dPa8MEdi/2/I+EpgenXiIi9cZ6JDMvjEE
         SQ+6gyrgJ5+s38L8DBjgAJN//wFyX8m/ZLc9ynGXil+VAzT+oMX/HPlHVmwtiPSm8vdX
         CFCOpyqxzP/e38pIm9kRh3xILDaOGOEhbiRd2wh+6mGo8N3MGpFaZNvBt03pf+vXyUWH
         /KYg==
X-Gm-Message-State: AOAM530bCopHaVk/yD9dM1H5jMpnrleslawRv00oCIWzZd2t26jQ+KSc
        Hufae8XIi04rZeCPPNAMy44=
X-Google-Smtp-Source: ABdhPJxkiIQCHMOXhupD9cEHjpNgzA394/SOlHy9zqpbvuQoq3/lr2EOi6CXDLuwXFJO9aWH+TBWUA==
X-Received: by 2002:a50:ee9a:: with SMTP id f26mr157300edr.96.1624990853440;
        Tue, 29 Jun 2021 11:20:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c0d8-f500-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c0d8:f500:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v5sm11565678edt.55.2021.06.29.11.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:20:52 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] phy: Add support for the HDMI TX PHY on Meson8/8b/8m2
Date:   Tue, 29 Jun 2021 20:20:45 +0200
Message-Id: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8/8b/8m2 SoCs embed a HDMI TX PHY. Unfortunately there is
no (public) documentation for this hardware. The best thing we have is
the 3.10 vendor kernel, which unfortunately doesn't document most
register bits (only a few are named there, the rest is all magic
numbers).
It is possible that this is a TranSwitch HDMI TX PHY based core, but
this is pure speculation.

Adding a driver for the HDMI TX PHY gets us one step closer to video
output on these older SoCs.


Changes since v1 at [0]:
- add a reg property to the dt-bindings
- parse the reg property (register offset) in the driver
- update copyright year to 2021 (spotted by Vinod, thanks!)
- drop "default ARCH_MESON" from the Kconfig entry


[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20210604190338.2248295-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
  phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2

 .../phy/amlogic,meson8-hdmi-tx-phy.yaml       |  55 ++++++
 drivers/phy/amlogic/Kconfig                   |  10 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c      | 162 ++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c

-- 
2.32.0

