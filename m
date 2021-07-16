Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C233CB568
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhGPJrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhGPJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:46:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D0C06175F;
        Fri, 16 Jul 2021 02:44:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 37so9487125pgq.0;
        Fri, 16 Jul 2021 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvgfaT/DggPEKMaWgg32QzuL/QbwcRZYhk8sluuZ2mo=;
        b=K3KdbfkpYxIdwB781I44+IUmmsqNcV3fU1s2rJ160S1NYok7k72cpseSBEEKx5Yqol
         eu9nHe6DVIl++2Xqersz4Ie1kfP4ZTQI08EDg/ewvtq6RqoNefcyvx4oz1sZLby5XyUy
         qGzqW/D4oznrwsszjX5fgmRC6QJ9YGC2rX52PxVPFDRxldHjngf2p+/v1aiyBIOb5uOv
         G0EGgK0fsa3EQSFl4mOjkm9Jd6WUdk8AbYB5W8cACdMQbmjw3F57xzqxZgrdLRwAF2Yt
         MywTkdpDk8F2ULAS3ZrnCzBQlmnSB53fAml03+Z/e7ExItva3SLrf9pCtPm5lpWVzXQr
         KdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvgfaT/DggPEKMaWgg32QzuL/QbwcRZYhk8sluuZ2mo=;
        b=Z5XsnroJmul/mW1dQq7+zqAHh/dK8chbsl0THAUzN+XShbiexD1yIt5n+5u8eX/ypm
         M5NC9/VUY67VS2idU2w/jLzTA6HhqJwm8wVM94DAQ0olPOddmiY/AQrPeuYwrX5EPj2v
         lStvZDJuii3hybPMJqvsQHQLPLpKkoBWfzXWUmN3U9U7o84LxotMC24VQN3DMyCY5VPR
         /+PkQG/Jx1tQVXT1i2qyBQCe1QC3ffdD+GKFoBE43CQgV9K9JgmyCuLFhv+5KTdEIDD3
         8JBfE/1KO6FMBpP7A+1CZlOB1h89UadrSwYq0X4sjcm1MDEq/w//jOwD71qLrHukt5OU
         QMZA==
X-Gm-Message-State: AOAM5305CVncytwVGEh4IB0g0BDqnl6rWHOoi+lf28XEH7csN2ledJiZ
        +bxUytQrNj0QtCgLSatUKF0=
X-Google-Smtp-Source: ABdhPJyaJKdQkdnNlsimJBb3PMzrB99ouiFnKdeevfDuWUIiqsAoCO5jlU+w/O/KDgbYuxL2DZmflg==
X-Received: by 2002:a63:1252:: with SMTP id 18mr9310623pgs.126.1626428642116;
        Fri, 16 Jul 2021 02:44:02 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m21sm9508800pfo.159.2021.07.16.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:44:01 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 0/3] power: supply: mt6360_charger: add MT6360 charger support
Date:   Fri, 16 Jul 2021 17:43:50 +0800
Message-Id: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series add MT6360 Charger support contains driver and binding
document

Gene Chen (3)
 lib: add linear range get selector within
 dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
 power: supply: mt6360_charger: add MT6360 charger support

 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |   48 
 drivers/power/supply/Kconfig                                       |   11 
 drivers/power/supply/Makefile                                      |    1 
 drivers/power/supply/mt6360_charger.c                              |  867 ++++++++++
 include/linux/linear_range.h                                       |    2 
 lib/linear_ranges.c                                                |   31 
 6 files changed, 960 insertions(+)

changelogs between v1 & v2
 - Add binding property with unit and custom name prefix
 - Remove extcon device, redundant brackets and interrupts
 - Fix power supply prop "charger type"

changelogs between v2 & v3
 - Add register selector to value mapping

changelogs between v3 & v4
 - move pdata vinovp to mt6360_chg_info
 - remove unuse sysfs attribute
 - refactor debug log and warning
 - add power supply prop input voltage limit

changelogs between v4 & v5
 - add linear range selector mapping
 - use linear range to map charger setting

changelogs between v5 & v6
 - use REGULATOR_LINEAR_RANGE
 - use devm_work_autocancel


