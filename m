Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1935F758
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350073AbhDNPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:13:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41093 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349964AbhDNPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:13:14 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhCF-0002IS-ON
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 15:12:51 +0000
Received: by mail-ed1-f72.google.com with SMTP id f9-20020a50fe090000b02903839889635cso1563806edt.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COhBZ6btGRsjvqs/la8SVt6/jjZQ184vl6dkwyCMK0o=;
        b=evrW0HDIFrKFFMJvR1Ok6uH2OrmQPAoxhaui/Y1rf0UfZRB9OUsfI74Fzo+lIwynej
         7/kSzJjsksZUptxgbgdyGJg4U4e2WlVLOpZrubFBtIGl1ILsSWaMOGNop/LjO1/mwwtR
         cTwWavjinmfjxo2hz9KPfObP48okopgMhmn/sIoJfsNJIKRYE6vWw0nZyubg5E/jmB5z
         hlKAWgIkjg99nP45AyrLZDHkdBlzG6I6fEWRFZixV+PQ27pqQrjJb+zhBDrE/k8MuRMk
         gs7z+PCChQDeawe5fo7THKlGP1sY6IlupfbSfJhTzQjJZc2cjpMzyapEH6a0OSVKUJoa
         xNQQ==
X-Gm-Message-State: AOAM532IQik9qzSg6V9aeXaL7s3oFjm26uqsYeJbPkNsRihQFSVvRzWl
        QSU/K4opJWdw55G2dfSxMkSlM1xX4gmVxWttsX6NHhg3jQx8Ne2C3ip+X/zPeGP/87kg+5c+EJE
        ZPKfS3PwPQJOQZgFV1JFz9/DOQuDjKW3wnPIOxCSSsw==
X-Received: by 2002:a05:6402:2209:: with SMTP id cq9mr25756423edb.216.1618413171471;
        Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoEnBh0pgDGjY81tHu+mQ80T5OJ5Q2koCwc3xWYjWc3lu5/63JtbuO1Ft0H2LIiJa4xQSZEg==
X-Received: by 2002:a05:6402:2209:: with SMTP id cq9mr25756401edb.216.1618413171329;
        Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o9sm6608022ejg.56.2021.04.14.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
Date:   Wed, 14 Apr 2021 17:12:41 +0200
Message-Id: <20210414151242.102313-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
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

