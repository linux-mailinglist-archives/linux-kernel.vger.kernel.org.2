Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F303B5E17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhF1MhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhF1Mgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:36:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20BC061768
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:34:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so9493690wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVU8ksdsC+XVYHG6Ii2wFQdpGHXdxNGIwH1FktLhWE0=;
        b=rMh4uZ9nvr/h9VpazM6ooNldYywwlfGegmwt2M9QV+5GtRgMf8W642d+IIOfEYw1Q+
         J+sn+ZMT6Y8eTUrE4J9I4LzpB0ghsNr/njpWf/RaQomIdctZGC5tSIKmcfodSwtqtjvO
         2paN31k8ASzujjKNWQBXmrVSH25ubIJmD4KOUr/7hGXCWY5w4HwY1ETk+TkvtNgR3T8I
         IdpHrwJhQTR6bHPkpRi4l9tjueCXP6e7ekKY/8s5zIcys/X0fXUaeHM5MEgRA74qbL1F
         mFZhV8qdRHXqK8sJZwSev8Q5s4TXh7YKx1RIMsd31X90wb+3D4r3lUT3ES7h0Tt7VT+5
         /oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVU8ksdsC+XVYHG6Ii2wFQdpGHXdxNGIwH1FktLhWE0=;
        b=GPvgAk+94Yh7hAerh1Ue5Q0Oe+6j6N0HppTRDn63Q8J1EKoEP5Vt/uRGS8sqD8SlO0
         TxABoxClrPXBjiEhm/+VfmR7eXT16SlGZGe/d+bGn6lME082U10DssnKQDX91xIfiN7q
         Tsnvd7mNUiTvjt3Bz6uPXZjmgUzg+Rg34iKzykLKICq3034Dr6MJ74gFMn+5ISjmt0ly
         6DAPHEmcEhvJaODfYXCtqVHTQs3JbhX7aSDLj/rjt+DvPeGAdr1QCNS3aGX8dmCEGR9L
         nuELHGBuWm+Zwz4vrN7zqpAMrGHHa/dsq/+eJv+i8n43qnAgUiRkrU7fT1gw5C19LhJ1
         rdOg==
X-Gm-Message-State: AOAM530DFln89tLS9hUCyIevPuf6e0WA1z2Hdw4UM7pLycsG7+k2hV7W
        4yfKajdXVmySdQ2cejvR9h93cw==
X-Google-Smtp-Source: ABdhPJx9klALOlzLwyUXrhxNb6Gsy/pGhiZ2wKZ23hTV0TLHksTI/vl4A4xAcaMGwetVptGG6RZA6g==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr26638745wma.5.1624883658053;
        Mon, 28 Jun 2021 05:34:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:e503:e76:4043:c4f7])
        by smtp.gmail.com with ESMTPSA id p7sm2357334wrr.68.2021.06.28.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:34:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jgg@ziepe.ca, leon@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, ulf.hansson@linaro.org
Cc:     torvalds@linux-foundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RFC 2/2] mmc: meson-gx: use sg_copy_to/from_io instead of local version
Date:   Mon, 28 Jun 2021 14:34:11 +0200
Message-Id: <20210628123411.119778-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628123411.119778-1-narmstrong@baylibre.com>
References: <20210628123411.119778-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3110; h=from:subject; bh=BPfTCGN4I6YQ41hxb4uDuKkhPMuH99t5aMh92aBorsk=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBg2cGYprSmh7eQkK8b0Smn83LQZAlmMENEw7F1uZek 2i7J5qWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYNnBmAAKCRB33NvayMhJ0d8ND/ wN/x1wUT6Y0c6P2LcYAfrhi0cuARzL3mx00mrqR9K0vL2tmj0w6z0DnOPTVlKzgw/pm3OxT8NcazmA U5o8yWVoPWqACBbQgSjlMSG6nfriKiiz2cor/5DoVnTW20ELSLayjVvERcageFnffPArCIOVty+vQu hmBKYEzqvdOeKD4Np34Pp5nzc+m/55P2orNBrJkCC/Lo3OTCkY56we+lpHz+FGQPf//FVx/qoMtTpo 4ohVieXNHfJteDeiuZViO+A5ZP3F7khBbT9Gz+U8t0jMZZctDy8IDDzrtk+CuBQIyDH7FUtVnjeAkL y6m0IFG66c9rDhwziMRCghTi/c9oybJBJf6ABz3kdS9sIsiou00OnPR//AjUX5gQPRe72j730k/bTl zspYNztdYjhHBHE5SK/Hh9Jm+BDZf/PtW+HdhnQKbJhHPrt6fG+U90KaBr44vLdUmeK+VoDzTAqR6c R3aHznEgr90iy+oSasMPAe4u/BqN7gLMwTGSB7aiNhSoWqW5cN2ytK8FV+TzxYX9QmJBXk34EMw6E6 rVadBWdPRjTeGKl2gJFE3JkPB8BFL7fGZ2YxDCc5jk3VwySG4VLHeuHzIxkOX3snEJPwy69Tu3Cmi/ MxxFNjWPosVhlFxsWuDXHe5kmj2e5JY4IWhojlAGn8szVazYWWCIua2ynMFA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper sg_copy_to_io & sg_copy_from_io instead of having a local
sg_copy_buffer variant to handle the I/O mapped buffer case.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 53 +++++++--------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3f28eb4d17fe..c13436efb414 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -746,47 +746,6 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
 	writel(start, host->regs + SD_EMMC_START);
 }
 
-/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
-static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
-				  size_t buflen, bool to_buffer)
-{
-	unsigned int sg_flags = SG_MITER_ATOMIC;
-	struct scatterlist *sgl = data->sg;
-	unsigned int nents = data->sg_len;
-	struct sg_mapping_iter miter;
-	unsigned int offset = 0;
-
-	if (to_buffer)
-		sg_flags |= SG_MITER_FROM_SG;
-	else
-		sg_flags |= SG_MITER_TO_SG;
-
-	sg_miter_start(&miter, sgl, nents, sg_flags);
-
-	while ((offset < buflen) && sg_miter_next(&miter)) {
-		unsigned int len;
-
-		len = min(miter.length, buflen - offset);
-
-		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
-		if (host->dram_access_quirk) {
-			if (to_buffer)
-				memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
-			else
-				memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
-		} else {
-			if (to_buffer)
-				memcpy(host->bounce_buf + offset, miter.addr, len);
-			else
-				memcpy(miter.addr, host->bounce_buf + offset, len);
-		}
-
-		offset += len;
-	}
-
-	sg_miter_stop(&miter);
-}
-
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -830,7 +789,12 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		if (data->flags & MMC_DATA_WRITE) {
 			cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
+			if (host->dram_access_quirk)
+				sg_copy_to_io(data->sg, data->sg_len,
+					      host->bounce_iomem_buf, xfer_bytes);
+			else
+				sg_copy_to_buffer(data->sg, data->sg_len,
+						  host->bounce_buf, xfer_bytes);
 			dma_wmb();
 		}
 
@@ -999,7 +963,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	if (meson_mmc_bounce_buf_read(data)) {
 		xfer_bytes = data->blksz * data->blocks;
 		WARN_ON(xfer_bytes > host->bounce_buf_size);
-		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
+		if (host->dram_access_quirk)
+			sg_copy_from_io(data->sg, data->sg_len, host->bounce_iomem_buf, xfer_bytes);
+		else
+			sg_copy_from_buffer(data->sg, data->sg_len, host->bounce_buf, xfer_bytes);
 	}
 
 	next_cmd = meson_mmc_get_next_command(cmd);
-- 
2.25.1

