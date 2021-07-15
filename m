Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D251E3C9B55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhGOJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:25:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321F7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:22:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso5727821pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYwMREptpH+SMYjUdvFTHh1r7G+lr2bq6Llrywdvilo=;
        b=uR3vskA5gv8/lie36FQ5MbR6XsNMJ+dgsZwEBrZUImZoufJFrJn2lNe1jNOwbcg+Y1
         nwLfUVpZvLAsY8yVOdNI/vXhfy5qFjLVqatDwW4kIhxvilbJom9SJjXSB5H8QVau/ZMY
         /do2Z+ngWIspm+KEbATbMSLjYGM4urexTID36AbqJ4KFEupxT0x9Ei0s/7G84xsxn4MF
         uZZ/XVesEOFnkMyk9dMbJPjeXRzkkHgl6GKpiA+e3qaaoCRZAIIBBiJ0cNZqPgQkZ9Ou
         1c1SYWGNQRTvIAIe4Go6N9aQIQWSVdiROCJLL58afmDlTHukf/VzARGb5Jhgwi2SZXtJ
         AGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYwMREptpH+SMYjUdvFTHh1r7G+lr2bq6Llrywdvilo=;
        b=PJL0Bc3LcCZNoMdUCm4mZDt/K5ltsE6mMLD8y52ROozvGsWVzEspycXfKPrX3emylh
         nb4sml0WGUJ45w84RBBPLPZHXcsKn/gCBIuu/ZVFVUdYt+7QjyIIsj8TlPfz6fIWaKzd
         /H9mjeiXFp6prBcGVkfcUeSMvHX5kfflpfIBZunAr8IPKT4gvZDdhxqy/tfLcQ5gsunl
         0RCcmFVZxSrN5Mq5QzWjUTWoYgWpmXb+X1498RaPuIXW2Z2qN26SQzcth/svO8Nxqmph
         WY/ej3ZMBEbzgXLeU8APLJiSuh6jC9/caU467lVBvoo918QAY/fpy9h/70qdgL62U4oI
         0tqg==
X-Gm-Message-State: AOAM532Ys/hB2StGJpn+c3J3GIMFzILDKqyiEhadqf+f8VAqeag21iCk
        5FQcOPAaI8+0S6X/KP6k/aY=
X-Google-Smtp-Source: ABdhPJw3PICK0TgRXinqxXnC3NhR0qntn+uH2ZB9tj7hrsee2GJQV0H51Ymleus68Z7IM8DFvZ5Uhw==
X-Received: by 2002:a17:90b:3756:: with SMTP id ne22mr3506101pjb.144.1626340964712;
        Thu, 15 Jul 2021 02:22:44 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id k25sm5571603pfa.213.2021.07.15.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:22:44 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCHv2] ARM: multi_v7_defconfig: Enable CONFIG_MMC_MESON_MX_SDHC
Date:   Thu, 15 Jul 2021 09:22:25 +0000
Message-Id: <20210715092233.1084-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_MMC_MESON_MX_SDHC so that SDHC host controller
on Amlogic SoCs boards enable support for eMMC and MMC drivers.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid C1+
V1 > fix the typo Anlogic --> Amlogic
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

