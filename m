Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614413752E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhEFLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhEFLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:16:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B538C061761;
        Thu,  6 May 2021 04:15:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so5163543wrt.12;
        Thu, 06 May 2021 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnhsZglV9Tim8CW0KmXYUH85PSzSV/y0PNcnH/Ygu/E=;
        b=QuoDQQzU54P/pO1hushKfsM9IASTAvM9x+K+B0FAT5zQxytbkZGXZmxdCZKNPEHc36
         1TBcfDQ+RGmBzGwrk7XvaZzpGq7fakoOOrV+D3d06lYHlYOyoGT/S7Bvbks9WHLOYdH9
         x/0F5Go06xpX9odxmDnVHsrV88rbEDfzWnqkR29V+u8+Wmyoxx8vUkeuMMslGJWRuSCo
         PgY9H9tUVflMZRENVAmmUjFmUJU7KvbZlnOLSc/tIjgy3++rTrNyovAV/9GrgoJWcKna
         H+XMCqKDv/5s9jt/v5LJ+UiltxO5s1u5sQBGuZagFxA2aiwM2zYNcQ1Yo4/Qs9llO7wH
         TVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnhsZglV9Tim8CW0KmXYUH85PSzSV/y0PNcnH/Ygu/E=;
        b=FYW1WEB2SObS6MsEByOBc4Vf8kMr5e7l8BMI4UGSfIyAX8VH5/cAc9iXhuiyJaF04V
         BW39aQ6DhKO1Vx3jLWtN6zpXr42Vz/r4NE+bO/CyRYcYrD7SZEgoUGD1mM56S79SZqGP
         IK/b35PrzDALBuZnSJW1GCVubXlSa24mCp9SZo8q/KpwWXpQv/wXQVrilQzRMog+6SmL
         L5+NKNpOZHm9VGqN7dU1XIZZXaMp+NCnbdslJqv60xYCZIa4hFiZVUNuRWg1oqgCPn6Y
         //Gmro0k/cRXjgVlyxoLgAQoOnYqkqqAQ/e0sz8x6ryawWPjFRyhSUcy/GO9lXxfKyqq
         CPng==
X-Gm-Message-State: AOAM530kSg6P3IoTQQmJAZl0xFpSvM7sDWPXrD2RwEU59N6KECL8y8iV
        4P+Kl/D3e8WfLzrlppXWljjKMnttVYgVoA==
X-Google-Smtp-Source: ABdhPJzH20Vd2ChccpIwWV5inlVmnET2Cb9+hDPcI+6QZIxtgU6qxDS6dx2kxXTSYJMUiQsnwdSzTw==
X-Received: by 2002:a5d:6291:: with SMTP id k17mr4619928wru.247.1620299738265;
        Thu, 06 May 2021 04:15:38 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id u5sm3642433wrt.38.2021.05.06.04.15.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:15:37 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: [PATCH 4/5] phy: ralink: Kconfig: enable COMPILE_TEST on mt7621-pci-phy driver
Date:   Thu,  6 May 2021 13:15:30 +0200
Message-Id: <20210506111531.21978-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
References: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After use the clock apis and avoid custom architecture
code this driver can properly be enabled for COMPILE_TEST.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index ecc309ba9fee..c2373b30b8a6 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -4,7 +4,7 @@
 #
 config PHY_MT7621_PCI
 	tristate "MediaTek MT7621 PCI PHY Driver"
-	depends on RALINK && OF
+	depends on (RALINK && OF) || COMPILE_TEST
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	help
-- 
2.25.1

