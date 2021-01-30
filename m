Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604CD3091E3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 05:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhA3Ejp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 23:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhA3EGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:06:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA98C061351
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 19:54:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x9so588849plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 19:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHqgS7ucbwBNs/xYikNa19+1cgFYDYneB3HI2cZIiLg=;
        b=QpSOCqCL06OtJJACvhlnNDSyMt6jGyXnBwTO22QdMm5Nq9s1zYPoQp0p2jRJz5+gbT
         qb2P7/62Fo440yVavgQPxjjCNbFGZG4VpaJTX1Vu04aP8c6lsrS412CZDypw39ZvfIaz
         +62HG5L1Qta0MvDf91m7XfbZYc7xpD8oVYrmeBNiUdiQCBfJJObDuwnvc1atDuMd3cRP
         Vp0yr4dyNWFDw3Ufi5Cf1j3Z10ZHn1z/xIxQPFQdmnS+/X6IeV2aFjYQLem5fXaFh538
         XTg6TLmJceKf1XbAJ/Pua6X7jRQB4DKGSBtnIVG2UgjFUZNRn4TtD/4FNs54XhDSX9mv
         WD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHqgS7ucbwBNs/xYikNa19+1cgFYDYneB3HI2cZIiLg=;
        b=pun9iVexvFfLCYZ09EOJ58q7fqdDnS3twHGueDuaMiGJSs3MXTNKSNUwzMdyAI/szp
         GMmLY4m2/pEItfhZ+5KZbxHUsAdQuTJA9St+8yQtQHxV68Gy3/wtFhJjWXnz6kwez1Xd
         rdwYsOfPXKgrMmzZ9JJQ8fa1OK0NEic0qeJtlgIE7A5pG6zLCEREtE1QdWUAwxdxenA/
         lrHt54xihtI7FcWW8fT9uCnHubVadtSKhYu+JB/vJEY4tvYMq0LULi6cGqYc/0FNfw/3
         /RZTclkiWwU0HKHkqXEUm4mAy8qa6+FvR1apT30Mdkqk/DvHWY3JRLy09/apAd47tLKU
         aKPg==
X-Gm-Message-State: AOAM531YD1ncjW7yUNS4QGn7qxOTQqBGyJjOuJvfZ6mB86jMRi8/zMro
        Ay9pfk2w4S6nExV1LI9Zw7ut
X-Google-Smtp-Source: ABdhPJzG642wXylctGzoBrw6niiXdDbet+kcoGCLR3M0N+z/rKswlDuRr7oeHZsafQVOP2P+XikvCA==
X-Received: by 2002:a17:902:bb87:b029:e1:d1f:2736 with SMTP id m7-20020a170902bb87b02900e10d1f2736mr7723660pls.1.1611978860811;
        Fri, 29 Jan 2021 19:54:20 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.140])
        by smtp.gmail.com with ESMTPSA id y22sm10309808pfr.163.2021.01.29.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 19:54:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] mtd: rawnand: Do not check for bad block if bbt is unavailable
Date:   Sat, 30 Jan 2021 09:24:12 +0530
Message-Id: <20210130035412.6456-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bbt pointer will be unavailable when NAND_SKIP_BBTSCAN option is
set for a NAND chip. The intention is to skip scanning for the bad
blocks during boot time. However, the MTD core will call
_block_isreserved() and _block_isbad() callbacks unconditionally for
the rawnand devices due to the callbacks always present while collecting
the ecc stats.

The _block_isreserved() callback for rawnand will bail out if bbt
pointer is not available. But _block_isbad() will continue without
checking for it. So this contradicts with the NAND_SKIP_BBTSCAN option
since the bad block check will happen anyways (ie., not much difference
between scanning for bad blocks and checking each block for bad ones).

Hence, do not check for the bad block if bbt pointer is unavailable.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/nand_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c33fa1b1847f..f18cd1db79a9 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4286,6 +4286,9 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
 	int chipnr = (int)(offs >> chip->chip_shift);
 	int ret;
 
+	if (!chip->bbt)
+		return 0;
+
 	/* Select the NAND device */
 	ret = nand_get_device(chip);
 	if (ret)
-- 
2.25.1

