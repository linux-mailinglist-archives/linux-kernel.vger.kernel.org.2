Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D027738AE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhETMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhETMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:37:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DDC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:49:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso4597945wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/62pxyhgvbPd5KZXSP5vbpV2Faf9Dp1qOkElacWi2Ho=;
        b=Hgww3V2vjG/idQ3o9V4g0CompcUETxFS1pbBHbReWrU5mg9GzciyHljVqhLFnGVZ1D
         gbxp8kKUpmr3WOXK6c1xGFB0DcBKOKGUITjcoYocmcIHH+oRxYypwyNJ0SuosH2NgrZo
         M/nU2UCbaBjvmnKlSNxL7rEO36aB44caEgwi/AZAf09YRK/zt5xIacPqll/fZlzWh788
         AoPKiSeYnGhEAjrwrhCgvZafoH/wfDlSWhdG9h3qXpKVtZPnre2wp8cSTtBEwBj4od5X
         Uqd9R95YAWsR9xTmkp4y5Hv/6KGzIPjtsPx6tofY1hqgCHfevKvrWolo9LfQkFMIRdzh
         gSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/62pxyhgvbPd5KZXSP5vbpV2Faf9Dp1qOkElacWi2Ho=;
        b=GqpRPJT47GoHiYEOu66iVQa8Yg2cUw1WB4w+kxhHpw/0SjRTycfHM/zQk1sH1WFT/8
         XcGaXX7gQ/hsmVVE+mxmgu9r8r4CktDGrmhS1jWp6Fhe/kzbEOdyW8ZJcX09NT5HOzZi
         jLSl8yu+JZ2I/Tijs0K674OpLizhOWv0B22/5g+dzbJXNC4DfHOLxrPvfcdA1/m6IzME
         D1oNlnmJ30ev56w/dvSIE0uXiXxWnLRC2mVEVljw8a6ouLv+tamGJQUU1dDeYwc0qObW
         1wQ5ftVRuVUvD2uPRyr4aEsCKPGzTEDtkdt7z6IUJYYP8UfeOQl5Dki2oNq8uZAdoUbx
         z2tw==
X-Gm-Message-State: AOAM5336Ji/rBBAruGYZywVKOiqFSAgldaVT+IaID4dTtzOsBbBM/DQT
        c1I2ITqgzq4wnzM29666td1s/5kP1PXdXQ==
X-Google-Smtp-Source: ABdhPJzmI9RrPGlYzCa8BOTpXn+t3QQHvMmxMBduTKRJ7NaXdyUyTq41RgT/m8ysi7gendwuNjlL8w==
X-Received: by 2002:a1c:bd8a:: with SMTP id n132mr3269285wmf.106.1621511340280;
        Thu, 20 May 2021 04:49:00 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s83sm2478886wms.16.2021.05.20.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:48:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     boris.brezillon@bootlin.com, linus.walleij@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] mtd: partitions: redboot: seek fis-index-block in the right node
Date:   Thu, 20 May 2021 11:48:50 +0000
Message-Id: <20210520114851.1274609-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fis-index-block is seeked in the master node and not in the partitions node.
For following binding and current usage, the driver need to check the
partitions subnode.

Fixes: c0e118c8a1a3 ("mtd: partitions: Add OF support to RedBoot partitions")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/mtd/parsers/redboot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 91146bdc4713..3ccd6363ee8c 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -45,6 +45,7 @@ static inline int redboot_checksum(struct fis_image_desc *img)
 static void parse_redboot_of(struct mtd_info *master)
 {
 	struct device_node *np;
+	struct device_node *npart;
 	u32 dirblock;
 	int ret;
 
@@ -52,7 +53,11 @@ static void parse_redboot_of(struct mtd_info *master)
 	if (!np)
 		return;
 
-	ret = of_property_read_u32(np, "fis-index-block", &dirblock);
+	npart = of_get_child_by_name(np, "partitions");
+	if (!npart)
+		return;
+
+	ret = of_property_read_u32(npart, "fis-index-block", &dirblock);
 	if (ret)
 		return;
 
-- 
2.26.3

