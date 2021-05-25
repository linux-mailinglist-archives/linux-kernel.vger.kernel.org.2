Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E56390933
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEYStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:49:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60313 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:48:58 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llc5P-0002MB-Bm
        for linux-kernel@vger.kernel.org; Tue, 25 May 2021 18:47:27 +0000
Received: by mail-ua1-f69.google.com with SMTP id t19-20020ab021530000b029020bc458f62fso13528553ual.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcWgt1ET73NMcTCnJjiaPx5gb4lT9PoaXsd+kPCRPqY=;
        b=dBs7k614nx/kvcaiESDLboS6o1JjsclLT69/a8Z5udoNfQHVHz/lQSsaOht47nOkRu
         oRxTRp+rpRobKchgVBCq1Y96AVMUDEBKClW61ZLzIWAc0ZQeIpMLkwGgdbjJW0K+CFE0
         xMC3BXk6ebopFVgnefVFuX+nDRrw/i9/OIPwaHQDkS2uIdk33CJ9eXdQ+SVz+Rm6EGtO
         YoTQNqEdTSG17fCL6dqE7O5LvEtZKbOouNW4bw9rYCrhfI87OmGWcBZX0Jp4TpH+Ph3C
         OJr70Slo4mtuz+5Z8hUB454XZ5d1YSLJjYz7psUH4ET+nrpGlqx7Q4R4Ov2kcMXnunkh
         gbuA==
X-Gm-Message-State: AOAM533fUCvvsGn2ugfr9rHzgP3CB2Y1SalUzegyFAQVEh4GUfDAaa7/
        nmTdqicN5eg1DYBlx7ea+9x9t3Q9eoa+NZdH9B0jm6K7qAsJpd2JD7/sxnDsv54P83TTOS+4M54
        YtxsVir6WsO4YBWNcRwZU9LURtmkQ3t/9EAnT4LIWFQ==
X-Received: by 2002:a9f:2124:: with SMTP id 33mr28761564uab.134.1621968446517;
        Tue, 25 May 2021 11:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDkZP8DPZJi2iv00dSIvvmqyX3P/sg0KsioFp8aLP7djkpx9wc7wtWOIe4/JpLHzBJA0h3Ig==
X-Received: by 2002:a9f:2124:: with SMTP id 33mr28761540uab.134.1621968446301;
        Tue, 25 May 2021 11:47:26 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id t18sm1602491vke.3.2021.05.25.11.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:47:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2] soc: samsung: pmu: drop EXYNOS_CENTRAL_SEQ_OPTION defines
Date:   Tue, 25 May 2021 14:47:16 -0400
Message-Id: <20210525184716.119663-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines for Exynos5 CENTRAL_SEQ_OPTION (e.g.
EXYNOS5_USE_STANDBYWFI_ARM_CORE1) are not used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Drop defines instead of fixing typo.
---
 include/linux/soc/samsung/exynos-regs-pmu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index fc9250fb3133..aa840ed043e1 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -611,12 +611,6 @@
 #define EXYNOS5420_FSYS2_OPTION					0x4168
 #define EXYNOS5420_PSGEN_OPTION					0x4188
 
-/* For EXYNOS_CENTRAL_SEQ_OPTION */
-#define EXYNOS5_USE_STANDBYWFI_ARM_CORE0			BIT(16)
-#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1			BUT(17)
-#define EXYNOS5_USE_STANDBYWFE_ARM_CORE0			BIT(24)
-#define EXYNOS5_USE_STANDBYWFE_ARM_CORE1			BIT(25)
-
 #define EXYNOS5420_ARM_USE_STANDBY_WFI0				BIT(4)
 #define EXYNOS5420_ARM_USE_STANDBY_WFI1				BIT(5)
 #define EXYNOS5420_ARM_USE_STANDBY_WFI2				BIT(6)
-- 
2.27.0

