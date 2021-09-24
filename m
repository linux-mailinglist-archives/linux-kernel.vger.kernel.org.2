Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268A54175FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbhIXNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:37:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37984
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346570AbhIXNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:37:23 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E90FE4019A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490549;
        bh=bqjANAhLzTfYF8WKzQgXTtXqvH8y/Gn5SAe1KVujuGM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uD4HnNysPqiHPHevHXimsEwjQXc6cZgGi0VNs9P5q/xRxjKVP6WyzwbmYTGrfhHUd
         LYJR+yAreGVdocX+rz3RMdUriQPyGaVuJAlkSW+Xtyv+dkYB7k13FbMcLEKGzozU/T
         BAI7ulE4k4Jlyhx3QhjBx/vPc/zGAXPFtS3LeJ65V5ly6Ptn13pyt8fjupjFowho+j
         bXHjrO4g4uvScktdpcHCF8YoXCVW181mNV5Bpfoi4Pv+akn1ShJ95XjHmPro5z0OVB
         NZlqBcAwPFIz+wCzo6Fx+tg1O2ExIYSeWHXBgBYldEekUzTVvn7r/DBUI/AQsEawA5
         +scFrlLQkub2g==
Received: by mail-wr1-f71.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so8083632wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqjANAhLzTfYF8WKzQgXTtXqvH8y/Gn5SAe1KVujuGM=;
        b=27VOYU5ls+JvhjTGANiAcwXaYGD1hfhYMDrzK7TvAtleFz9qUa+E7doDziycxrg9ni
         boCI6CuM/JzS/YgxxWeQxnRLDJ6vYAxYtp50jaW2NMyefeTYe8j+KQE/EBaVF3CMnKZg
         XOOh7WbWp1xGaSE5ihfkkTozuzVcRxntI/XGEjsQHEARoSGn7ro9ihqCEJGkwa3FpWSB
         KMhyp80OcWislUaCEzAnb10yNKbRTA3zMpXp/cAlqP1g8SVN2mbDAnLkF0WvMOmNT3b7
         m3YC2AKTQ+KoW0inerJk9NvjZR8WmIz8TYFt1D74xtly6WaVPNNd69Z4zpmfwPFUKOs6
         x+Xw==
X-Gm-Message-State: AOAM531jOHKcjuW1Iel1iN4g2rZPdrZ5rYKlX5IPEi6ZWDiYw5wlZY7w
        9nF6WewSCWMY3MISnSsbpcMbBJKOQUvjgLzEHxbq+KvOY59mOxhM7oYj2bNYdRiT6sIzxlX0/DC
        8GVHttzDOc4CUxJDUGw1Wwyqf2nyl0x+NTx3003tf6w==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr2134468wmi.179.1632490549633;
        Fri, 24 Sep 2021 06:35:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7rmLq5yNcAl0LcoydbosbByRnsKNYZnWMqikQXlR6Bxuv/lGwl1503lvycrJ3IDL2fFdj1Q==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr2134451wmi.179.1632490549491;
        Fri, 24 Sep 2021 06:35:49 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 25sm14091675wmo.9.2021.09.24.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:35:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: exynos: describe drivers in KConfig
Date:   Fri, 24 Sep 2021 15:35:15 +0200
Message-Id: <20210924133515.112357-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/iio/adc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af168e1c9fdb..6cc1268da184 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -430,9 +430,9 @@ config EXYNOS_ADC
 	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || (OF && COMPILE_TEST)
 	depends on HAS_IOMEM
 	help
-	  Core support for the ADC block found in the Samsung EXYNOS series
-	  of SoCs for drivers such as the touchscreen and hwmon to use to share
-	  this resource.
+	  Driver for the ADC block found in the Samsung S3C (S3C2410, S3C2416,
+	  S3C2440, S3C2443, S3C6410), S5Pv210 and Exynos SoCs.
+	  Choose Y here only if you build for such Samsung SoC.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called exynos_adc.
-- 
2.30.2

