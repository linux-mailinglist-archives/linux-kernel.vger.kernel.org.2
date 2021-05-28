Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C80393E77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhE1IOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhE1IOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:14:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C7C061574;
        Fri, 28 May 2021 01:13:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so1284339plo.2;
        Fri, 28 May 2021 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WFpvdJz81Rofrn0SCvWRF+k7het9w/ooU9Ou53sso1U=;
        b=RQfAOsj/JemwJemXCE6fis1wMnfcIp6Y+sHLpnm3HOZg1fPMfqMp1raHj6xbFggLAh
         8qYd7A+Rx+nd9H+HezIX1/GpsOvzukrzIUmLfPhVWEy2BF+rvQFzZGe0bWK1iPWW5m/H
         6g12Gr3CAV7K6lqgHF/WrxOTTJYOYcQZDpgYTcPVcJuO+eIV8RFqlIcUrnwhxrX8V6ML
         DlF7euw8OBla2Ur0XBAj8oWru5S7u9BYsOahSqoLX2N8NG+Vi2lDRzqqflDsgZLmCfih
         pT3pDHNjysGbC2DsFzDC3TSqPB7GAbw7qGdU3SKJwRH2w/vArotIvbRv8fNg88t5id3i
         +Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WFpvdJz81Rofrn0SCvWRF+k7het9w/ooU9Ou53sso1U=;
        b=BfSS8WFVp2vxwhqFc1NAPunqXfgikNB/7JqZXQDqZSGXSqvDRP/yF6j26APt37Fl4j
         Pi9EldTBABiTVpQG9EDDvX5SsNtqvsxZjS8MG+HlpI5NauomVx8sSB4CUOeW/dbGNyPs
         lvkqeYSm3cuwdMkObekJY+TFe0gv7czW9dLSBSSFRL984SCsF0q9iiDcIODxyAMImiVr
         D23zvht6a/lsmyCm9dOrpVHdJFWtyWHn3hyBLPDESmHh3RbDyvHEH2J9wxw3ynnN9Od+
         zeICfSkrW+VeSWt2MdLGBRHz8XlEo8WKNxMPrH8na/yXHAQMKmtTfq+DiUe+o/VRjIvD
         KNZg==
X-Gm-Message-State: AOAM533rd4uoEM/fvZlZhpkdQxqZdxRRqvMMBoV74MVI53mCdTSq3own
        rl1sJrVIfBUT4R4Sn73MCS0=
X-Google-Smtp-Source: ABdhPJz+VoBj7k8vwcL64HR51mNk+YLRUvpLavlP+rVuUsDqQcGrzR7m5IyQvsxLL+ZbK6YMUSBeJw==
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr3032756pjv.209.1622189588876;
        Fri, 28 May 2021 01:13:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:3194:b541:419e:4878:8a93])
        by smtp.gmail.com with ESMTPSA id z18sm3846594pfc.23.2021.05.28.01.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:13:08 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v5 0/3] power: supply: mt6360_charger: add MT6360 charger support
Date:   Fri, 28 May 2021 16:12:57 +0800
Message-Id: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
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
 drivers/power/supply/mt6360_charger.c                              |  856 ++++++++++
 include/linux/linear_range.h                                       |    2 
 lib/linear_ranges.c                                                |   31 
 6 files changed, 949 insertions(+)

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


