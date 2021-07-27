Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFF3D6F73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhG0G3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhG0G3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:29:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B9C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:29:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b6so16340749pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7gbIhgZL1GB7+CVzKz4WvNGA6a2yfgt3NnYEFDZ3OA=;
        b=ddSxW+BF6bMPFIS3LGwe/J3xhVpC83qkgDnt5dwEygoPvNeYihLmgqgwrPBB/WtjCR
         Jz/15O6yuD10YFbiponmOZW9UrhrubeE6/Ba9XH6mR3heqlyqaPeHIlEQk7+D2LkiwUf
         g4NzpLdDxYQY3Xg3d2RrlNPGNtoKK9OXCySPcnumxPhWSLDAb190lsFhQvS4SPUvayz0
         atcKkrG57Lxlm0CCjjEz94GYYmDUtZg4hjEItpxD3jUUjuDl78KYkNtVRtpalvmTwmXL
         0ffCP8+P0qxnK00iybgFPgenhnuaeITfQnJKW64/aIpYNKeYr8exZTo35Y95HHnJuUwZ
         5C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7gbIhgZL1GB7+CVzKz4WvNGA6a2yfgt3NnYEFDZ3OA=;
        b=N2qX1Y3UbTFoK3sTsvQezmy36g4UvDsxwx48sOJFYDuBviaL2giOrzbVzhrxgicdsP
         Qie0P/rEiN6Ay5wkbf9Hl/aXhcuhHK1FmJJKnkbdWDMH4l5NERX8MvmtGWpoXSZQL4lg
         BntdTrqDdLtvAvuUyjSFf+etyg2rgBgY8Q0+3EPK/eFWytmorH1xEyRiC+jjS040IIoO
         EI/XQfP1Zd5hg6IA3J3TLCdv7FzLzHZHVRj2cfTn205C8LqPn54uRIrYG3/jeqaIMbKT
         fOHkrBbJVtgqtM9YTNASsIoGkpE+Jn23esfr5N3o+JfxWBjD1oGU0Dq59NpK3GsGZSmA
         OcpQ==
X-Gm-Message-State: AOAM532OoHA7wY5nnZspkrcN6oNiBzHyo41/4oPyT+r9Lj41oeGi+QAG
        kBz3o3jq4MZLfDnfOYDI5Spx
X-Google-Smtp-Source: ABdhPJwOxewXlQs+hfNI+t3UdmSQFBWp/cZFvddejI5BsF8JNQNf2AicgvXY6VziMptXGG8v7NhzLw==
X-Received: by 2002:a17:90a:c24b:: with SMTP id d11mr2731017pjx.91.1627367341536;
        Mon, 26 Jul 2021 23:29:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:404:9e26:4427:70e5:216c:501f])
        by smtp.gmail.com with ESMTPSA id g3sm2107960pfi.197.2021.07.26.23.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 23:29:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        tudor.ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        martin@kaiser.cx,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] mtd: rawnand: Fix probe failure due to of_get_nand_secure_regions()
Date:   Tue, 27 Jul 2021 11:58:13 +0530
Message-Id: <20210727062813.32619-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to 14f97f0b8e2b, the rawnand platforms without "secure-regions"
property defined in DT fails to probe. The issue is,
of_get_nand_secure_regions() errors out if
of_property_count_elems_of_size() returns a negative error code.

If the "secure-regions" property is not present in DT, then also we'll
get -EINVAL from of_property_count_elems_of_size() but it should not
be treated as an error for platforms not declaring "secure-regions"
in DT.

So fix this behaviour by checking for the existence of that property in
DT and return 0 if it is not present.

Fixes: 14f97f0b8e2b ("mtd: rawnand: Add a check in of_get_nand_secure_regions()")
Reported-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/nand_base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index cbba46432e39..3d6c6e880520 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5228,8 +5228,14 @@ static bool of_get_nand_on_flash_bbt(struct device_node *np)
 static int of_get_nand_secure_regions(struct nand_chip *chip)
 {
 	struct device_node *dn = nand_get_flash_node(chip);
+	struct property *prop;
 	int nr_elem, i, j;
 
+	/* Only proceed if the "secure-regions" property is present in DT */
+	prop = of_find_property(dn, "secure-regions", NULL);
+	if (!prop)
+		return 0;
+
 	nr_elem = of_property_count_elems_of_size(dn, "secure-regions", sizeof(u64));
 	if (nr_elem <= 0)
 		return nr_elem;
-- 
2.25.1

