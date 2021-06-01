Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA663970B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFAJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:55:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38905 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFAJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:55:49 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo167-0004f7-Jy
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 09:54:07 +0000
Received: by mail-wr1-f71.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so4623939wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OIrf2YpRvopTOP9GrsCcXEr+7TL2pNaPcwxG3gY5kg=;
        b=FHkfFtPf363MnikwnptCwQWcFCQC2Ck5qQeNyrMLOe7B6LL0BsxiDkiyh6hMr+c6yq
         gh8xzeY56aE69rgk9T+P8evU954DBxDpSz+PWMct3y4Mh2yJ1x30RIdXG+ZRLc6Kh4dN
         tdtPFrbNMCIuEB11bRCucBeWYcsVMOpL6I9S1WVLHFExqFMwaHIz1+k7RnA57KEYVTEx
         5hOZryZtcua6dsofplVjj7h17prJ7DLB/SEzFSC3P1MTZ+hv6wP0MMgp7Tq0Vdcgh9Va
         CFHlbzBHCPlxgytZ/VGtViM3Uix204IeL7LKImgpiYpNnmEXWWVs79+tJq2KAG58srUr
         ezHg==
X-Gm-Message-State: AOAM532C+k7ECc7iGDq2pOmhbMiVA4mRfQEHl7hc3tXJt/heCLuSwTkY
        rxzT3T40PsbUmKERXKEzNV9Nq0KT/eeT95Jj04PQZ0pYtjw00PkPV4AxRfMEdy05cL2Y55l/vcg
        MOvtk0N2jYk8kSRMgD/+Lp9oF0dh6YI1OteblIdfINQ==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr26826370wrx.153.1622541247275;
        Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEgSE7f74QpnJ54SuwC0JE/TVO2c38ODfUoM2T1GA4moNTgXFOXZDzv9q0xjvJnadZtjMS5w==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr26826353wrx.153.1622541247176;
        Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id c7sm2018363wml.33.2021.06.01.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:54:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
Date:   Tue,  1 Jun 2021 11:54:02 +0200
Message-Id: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_imx6q_usdhc() function is unused:

  drivers/mmc/host/sdhci-esdhc-imx.c:343:19: warning: unused function 'is_imx6q_usdhc'

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f47c4bbfa283 ("mmc: sdhci-esdhc-imx: create struct esdhc_soc_data")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fba4a963d12e..7336ae749137 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -324,11 +324,6 @@ static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
 	return data->socdata == &esdhc_imx53_data;
 }
 
-static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
-{
-	return data->socdata == &usdhc_imx6q_data;
-}
-
 static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
 {
 	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
-- 
2.27.0

