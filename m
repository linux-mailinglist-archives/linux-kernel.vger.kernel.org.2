Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451E23C8582
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhGNNsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhGNNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:48:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96794C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 06:45:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso3877100pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YEHNelSphOfhN2CYAYUItmw3NXf1k9VBjpF1JvYJEVg=;
        b=Zy2/ynkygPoMjSuWqCGo4hfTMMhOP6yP+Sl0eFkkgaPX8y53+jbbMLHIZ0XpS7AxgV
         kY5VpSM8GUG6XZNTmg+cZvomjzhFte4va1maXe8xmMMtfeDgMTi6fM1DCj65UpV+B6nc
         9aT2Fx6yWcv8n06o04B62h6M8i9Xe0tC9ocBPVrSzEigLK+zENbKgYsTlzsrNqVjU9Ry
         iIQBFKw3MrAmKjHSoCrgO3GJu143h+hNB749z6balhWG5Hj0AuiT2a9LTFlf/xysn8DU
         eLOXLZe6v7Ii/9kX3Gvu6SK4JAZv686/nGnmHFkRdk4iKoiOeSHh0k4kdvTOqLpQ2bEr
         2yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YEHNelSphOfhN2CYAYUItmw3NXf1k9VBjpF1JvYJEVg=;
        b=MShfO0TwqhH8uEzG9JFrp4pwQ54ksKkTmGrzaheqX6qjQMAz9SS7h3iOWfB80WFBd4
         vUGaXiZ0vkmoC8kzRv+3aMKuz7bfq7UprtyiCk4x5qfdDOBsC8Buja0EGTZTvvWCtLEl
         LOVBVbGNjBtZmT3VXVXQMBoeV3qGuS4NbzYDwRsK/UOlvF8u5cQYz6lQdPo/XlqWHs4x
         sA+HZ2ysQBI2NfUgVwkAxLf24L311HL34oYDRoKX2MYjt57ZbrtlerHLr09cVbu+CGbd
         HIAMsjB1SNv03Cu3F3BIzHWxKXTjBHpNOgm28vr8xwfzodjzo4qi2MCjUtkEg1ecDED9
         v0ow==
X-Gm-Message-State: AOAM530l1zkizyagdjfpxtUWlHWgA0yCKHNT+l77s2F1MKS5uxdITCie
        70TgGtYJ54UFfhs6VzjJ2x0=
X-Google-Smtp-Source: ABdhPJxJFc4V0yHzNyzRNPg3A4LXlzSl3Qxlx870Trim8fuLxBUSW33NVSfCoxUymp5cwf8BWeoHeA==
X-Received: by 2002:a17:90a:1c02:: with SMTP id s2mr9796635pjs.172.1626270352963;
        Wed, 14 Jul 2021 06:45:52 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id d2sm3033625pfa.84.2021.07.14.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:45:52 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable CONFIG_MMC_MESON_MX_SDHC
Date:   Wed, 14 Jul 2021 13:45:32 +0000
Message-Id: <20210714134540.1722-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_MMC_MESON_MX_SDHC so that SDHC host controller
on Anlogic SoCs boards enable support for eMMC and MMC drivers.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid C1+
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 52a0400fdd92..8b3f62a0eb22 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -870,6 +870,7 @@ CONFIG_MMC_SDHCI_PXAV2=m
 CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
+CONFIG_MMC_MESON_MX_SDHC=y
 CONFIG_MMC_MESON_MX_SDIO=y
 CONFIG_MMC_SDHCI_ST=y
 CONFIG_MMC_OMAP=y
-- 
2.32.0

