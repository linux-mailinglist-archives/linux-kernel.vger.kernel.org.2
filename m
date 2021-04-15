Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96B3604B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhDOIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:44:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhDOIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:44:39 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxbk-0000J4-F9
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 08:44:16 +0000
Received: by mail-ed1-f72.google.com with SMTP id t11-20020aa7d4cb0000b0290382e868be07so4791866edr.20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YAO2kP+UwcFk07vAzhKIghy5JKErNSIyCSfT/ZaQms=;
        b=pJR5t+TeJSf7AzhFhYD04VcA+ItJRJRQmwViML85ECWOy5V+tGeVyPWv9c08RRfbJ6
         zW+uXWu5up+3tf1vCz5EL52YB6cthaBwRFSdQfts16ttdPIyJjzCpgGeB7865JRKTuny
         WvzFbPnwqtFskhSwFTaS7Sr+t1MY39LBAhcYBIAyA27wnvAQR4nW1IwMa4cbMfXtKmQI
         R86G9gFm3dcsmWlW3x41llBPaa6NeDZsyZBB6uCxfpRpPXGiiHFIOI3DduusR5GgH9nf
         rg1ZcfZlRei37oD9FcjkTyHv1q08HY4un7y8FvXmnFHTYg0qiP6Zrsey1AwrMVOq1VAg
         mIQw==
X-Gm-Message-State: AOAM53093JIftZOqV84ncAErTYDYrDD7VuHjE66JlL3LRAY40yC/rlDl
        oVROosERsalBDz5DG0ak10DSWh9DgHvEvDzoJPWxtnkHzPdrysz+V5QGxTu+OdsomN8jWLfbfy/
        NL72O1wgGOrurrjerGswg835AROZVzrVWe/tTvrJf7A==
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr2762944eds.149.1618476256233;
        Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZkslZUZjN5xuGAWGmBMeXcV0Db6KIDdfQofIUygJyUe1yu2Eif2ogeojONnfAUrCCjyD9tQ==
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr2762931eds.149.1618476256083;
        Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k26sm1419360ejk.29.2021.04.15.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 2/3] mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
Date:   Thu, 15 Apr 2021 10:44:11 +0200
Message-Id: <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the name of sdhci_s3c_drv_data structure in kerneldoc:

  drivers/mmc/host/sdhci-s3c.c:143: warning:
    expecting prototype for struct sdhci_s3c_driver_data. Prototype was for struct sdhci_s3c_drv_data instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 drivers/mmc/host/sdhci-s3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e1dca625620..a07a8f011741 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -130,7 +130,7 @@ struct sdhci_s3c {
 };
 
 /**
- * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
+ * struct sdhci_s3c_drv_data - S3C SDHCI platform specific driver data
  * @sdhci_quirks: sdhci host specific quirks.
  * @no_divider: no or non-standard internal clock divider.
  *
-- 
2.25.1

