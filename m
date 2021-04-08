Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC2358E31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhDHUQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:16:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42280 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhDHUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:16:39 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUb4k-0005dg-Gu
        for linux-kernel@vger.kernel.org; Thu, 08 Apr 2021 20:16:26 +0000
Received: by mail-wm1-f70.google.com with SMTP id p11-20020a05600c358bb029011630279b61so53443wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 13:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMABrCg2yQSz0NJfTRJiCfa17aCfiZuFRJh5dj2jnZI=;
        b=KplNFOEFyn38kRA59eKY0cLN+qMEEfWNRcdJkqbOatQZijhHQjMq/Xlc+rIjGI0qgx
         667My7cdgOivOjzHgOY60lK4X7o2gK+Uv5gPZ8Qy7RGRignMg0d+Z/VKjrWEdO42w01g
         zme19IgkzHGdVPNO7EV1INtOyR6yVnv3KWc532Ks90VP+aK4zU3Si8z2Di0/5DkhM/Ov
         Xr0nX0yD2sm40+Qe9vNPlTIaI+CXVao9UzWrSiFdIfGoMMGDHQBn8r8sw0LT2F7gc4G0
         qnG2VSXaTM/tT1mpZ1YSLywKvYbCxEY5irBAcJf6bnRfuaXdzTL1k1q4AddKApDPid3Z
         /zvw==
X-Gm-Message-State: AOAM531YkKJXO/x/yIS9q7d2Cye1HUPFUJgli+PwLFrLEzvc1/H4kltr
        4iJ2fBmsTrCT+8YjItk+uuq7Tv2yPbCKoMJQ9PLPXGvE8JAwSm3TbUh8M77c181o8ut/loy5Qkt
        RJlvWZPHEaO2HqQ+V4TxmxCGI93PBKYd8z0bnysI40Q==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr14429553wrr.140.1617912985385;
        Thu, 08 Apr 2021 13:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIwIaAo5oCPu118XWrKhGbQi+Nic/eanTaCnDGq7QIZYT+he+8z9GdaAve8WhKurUn3nUuoA==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr14429534wrr.140.1617912985197;
        Thu, 08 Apr 2021 13:16:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o62sm22690337wmo.3.2021.04.08.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:16:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: exynos: remove unneeded local variable initialization
Date:   Thu,  8 Apr 2021 22:16:22 +0200
Message-Id: <20210408201622.78009-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of 'fault_addr' local variable is not needed as it is
shortly after overwritten.

Addresses-Coverity: Unused value
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index de324b4eedfe..8fa9a591fb96 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -407,7 +407,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	struct sysmmu_drvdata *data = dev_id;
 	const struct sysmmu_fault_info *finfo;
 	unsigned int i, n, itype;
-	sysmmu_iova_t fault_addr = -1;
+	sysmmu_iova_t fault_addr;
 	unsigned short reg_status, reg_clear;
 	int ret = -ENOSYS;
 
-- 
2.25.1

