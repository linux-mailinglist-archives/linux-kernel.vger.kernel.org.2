Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD53382F74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhEQOQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:16:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhEQOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:14:12 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lidzK-0005R3-TX
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 14:12:55 +0000
Received: by mail-qk1-f198.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso4796332qka.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAZsnEd2I8dmVTyQC9mn90iTZNFb90By5nrttFT+170=;
        b=QFkfWjkgs8ylOvCRhQHcCnfKjaJJPW6SAMwu60M1HPKCW9iEM1D8RxZUJOZ7kXaRk8
         qb24KIm5KPywYx+ZTY7wQqmJPMqrq/Mf1voXgMKOFL+pr+XXeFCKHMt33NqCmz6JTb9C
         29vFiiBaTEzE0/uSXu+CaU5ENsxiRZxFnHkbQORlmTaLCFuBWRuYZwRbnW3haSMd1802
         Arrx2jusb02DZWDLNa/iEv4uOWVvHSGmeVtkybLC1tPOdtrgHZuP65PKduR0APThqTu5
         nfSbx1kBhssuPVETPKzjTaa5FExgChrwpxSdW4BnWaYIo9jTnyR05ZxaghGtZHiQSzgB
         G5lg==
X-Gm-Message-State: AOAM530JLFeutUQyyfgvpp5YRYUukJ+Bz9VvBByVCgfvhTVFNBkDXSBG
        mYzg8IGWIgna662DDqqvSl5zDoJID05MSaJHDAfMUq62SqZV2An4HtkffBTom0t4DWh0e877F7V
        dQaq8ld5+SU51OV6QoAEcx5KrYUbxf9jK6lpC1bFZ5Q==
X-Received: by 2002:ac8:7303:: with SMTP id x3mr57042165qto.271.1621260774056;
        Mon, 17 May 2021 07:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYjs9gmXg+QZtFzveAdjVILbpJtsmY19SLw8BW1TsYwHE9JtfKQXjGtTtcQi3H+Qixwtg/IQ==
X-Received: by 2002:ac8:7303:: with SMTP id x3mr57042150qto.271.1621260773888;
        Mon, 17 May 2021 07:12:53 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id r9sm10440990qtf.62.2021.05.17.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:12:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: samsung: pmu: fix BUT->BIT macro typo
Date:   Mon, 17 May 2021 10:12:50 -0400
Message-Id: <20210517141250.55655-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro EXYNOS5_USE_STANDBYWFI_ARM_CORE1 should use BIT, not BUT.  Fix
does not have real effect as the macro is not used in the code.

Fixes: af2e0a0754ac ("ARM: EXYNOS: Add PMU support for exynos5420")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/linux/soc/samsung/exynos-regs-pmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index fc9250fb3133..4bfd9a210da2 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -613,7 +613,7 @@
 
 /* For EXYNOS_CENTRAL_SEQ_OPTION */
 #define EXYNOS5_USE_STANDBYWFI_ARM_CORE0			BIT(16)
-#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1			BUT(17)
+#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1			BIT(17)
 #define EXYNOS5_USE_STANDBYWFE_ARM_CORE0			BIT(24)
 #define EXYNOS5_USE_STANDBYWFE_ARM_CORE1			BIT(25)
 
-- 
2.27.0

