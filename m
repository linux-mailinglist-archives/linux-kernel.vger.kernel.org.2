Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288284601FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 23:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356487AbhK0Wjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 17:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356405AbhK0Wha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 17:37:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1CC061759
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d24so27345467wra.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8NdHBjQVRIYGsKW2yKV0OuAhmnZpLbolKeCpmly7RWg=;
        b=l4yZmcmZTr7edwfbUcKL115b0MYsPssmDPCQRsyDw5bHhQmV6ar6pK4jAxrDUMK30L
         DhI/JggGzkpZLmknG0AUgMB3oDQ8doG8ujlkjNdlxeJUm/nPpXoFDJXqO1rmQJrTfCzB
         2sPgGDOXV+Jr0yHhAsZ+zJbOQYVOUnJppTaAmjTQUHkQA7HOJCXiDbuCGCezUhVy1dgp
         KeA9+zZ3EKSGbINZGPTVNbsa1MuM3LAZHRj1MEhzDNYGM/KHsV8kd+dpqxs8vEnuqs2C
         thVZHM91MdLG4lWx/cfTcnpHev4yB/26XYz6xouUDmRTaMeXRQ4VmWKen96INpBdT+Kr
         O0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8NdHBjQVRIYGsKW2yKV0OuAhmnZpLbolKeCpmly7RWg=;
        b=PaYW6mc+G67gLuk/dG5FcshD3mriM/anOyhE4NyuFkip89Xy+wcL9HtRP0mhNT3AS8
         8deoEvzG8ZVipqkq48PYUpIk50es851+2YMMOOJA+BRzjkH0AUBLq9oKzh6rHUeBFDGH
         8ScWrp12rv7VDtn2ZiMAEWIb14Ihdxa+vQ+CEJW3HCnHAbTkO2ORdM/94jBj1QfcO2De
         KV74/pN3OPzn78wadN00eCwI3CgjbL94GbIqJCkLrplLzCFbNrbYvSjRfS+Vu60VdA1D
         A9470T9fyD+Eo1yQb5YL9lzDCS5RoMLIDVTSRoVRP5cnngo64NjpMALHo52IuSn8a1OH
         lGKw==
X-Gm-Message-State: AOAM532NYq8xTWOb31wvUesj2R18qQ9HKXU2MO2WefBE5mCLFkouJFtG
        QFhG/56TNO01+d6plNZf918oHw==
X-Google-Smtp-Source: ABdhPJxdLlhFGvAhG6wOiBarzCyE+9iYgVuhsqXhujvzcBgC7mGFjVW53Xkg0QseOIg6FsybsHzQUg==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr23094058wrp.209.1638052376446;
        Sat, 27 Nov 2021 14:32:56 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id y142sm10355694wmc.40.2021.11.27.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 14:32:56 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: soc: samsung: Add Exynos USIv2 bindings
Date:   Sun, 28 Nov 2021 00:32:46 +0200
Message-Id: <20211127223253.19098-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211127223253.19098-1-semen.protsenko@linaro.org>
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add constants for choosing USIv2 configuration mode in device tree.
Those are further used in USIv2 driver to figure out which value to
write into SW_CONF register.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/dt-bindings/soc/samsung,exynos-usi-v2.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi-v2.h

diff --git a/include/dt-bindings/soc/samsung,exynos-usi-v2.h b/include/dt-bindings/soc/samsung,exynos-usi-v2.h
new file mode 100644
index 000000000000..b406c6f6f89e
--- /dev/null
+++ b/include/dt-bindings/soc/samsung,exynos-usi-v2.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Device Tree bindings for Samsung Exynos USI v2 (Universal Serial Interface).
+ */
+
+#ifndef __DT_BINDINGS_SAMSUNG_EXYNOS_USI_V2_H
+#define __DT_BINDINGS_SAMSUNG_EXYNOS_USI_V2_H
+
+#define USI_V2_UART		0
+#define USI_V2_SPI		1
+#define USI_V2_I2C		2
+
+#endif /* __DT_BINDINGS_SAMSUNG_EXYNOS_USI_V2_H */
-- 
2.30.2

