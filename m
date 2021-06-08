Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2439739FAD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhFHPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:37:00 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46739 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhFHPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:36:59 -0400
Received: by mail-wr1-f54.google.com with SMTP id a11so20195247wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exLxBy2kCwcrb17O37qOOT6y6QhrTOK1Z3D68o8QrCg=;
        b=WAULVsvebNiqIaTajbRIiAJln/Jzebl2PLCpoWKqyD0cnOwDTUEbk6xeNw9m3tUngD
         rF0mWGkKOu0isx6g4WE7bQUAIiXoDFFGGhn/Hd/pca7kIbpBwxft5Fxbev6oc+EX7gp3
         weADaTNlcscRdwf/XSsmH/O3BcCcVff6hTXCD+XNoikhuY328i8kSmYLUWcFZVwFoO9k
         XNNUv6Fn7XjEZqn/Oji3iM3YLXjLfrR43wk0PsTG9SaBOr1mpCYxwCbvMlb10uY7nnq4
         imy12B5l1gygD3++/3blup58DTT+xjmkMNKJrlOw+nahC9luHETXmtFLlR22jRtJzcCt
         arxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exLxBy2kCwcrb17O37qOOT6y6QhrTOK1Z3D68o8QrCg=;
        b=S3iSI/Gs5y7tJ7QvrSynQ1E7VTZf/Gf4Jp/6ic1mhDjKziKCXmEdr0E/ODrHelI+7E
         ZdGjY1JWQSXeHxv38oZYgPs167wBcu/zQSdAXE/E2W6Duj9YD+GJZJXVR4o6UR4mk5Bt
         Yp42/Sf8GRjlmoV+/bnE0f7yDgz5ph+0hwklsnzDjHOQDqSZcMcE9GfVMjOuw5S1ZZlf
         yUYI7sudJDB1gpS3+38xsF8B4GG2bXn9OQ/OV3jZ+m9ximWimBcN2cAY8Lfv1Pkrtrfx
         YjgKwCJtm1vgQwGx7bwI8yneeaTEMQYEce3EwaI4RtgEP38PHg8nFWwa1AdIjbdr1fHn
         QJPQ==
X-Gm-Message-State: AOAM530o1VsRJn1mgGrPV28YC0bEdoqdJu5+n5OmEk8RDuM4JLbXvmWT
        k6MnyZ/uUJpLv0VfCP2BOAJzdG9SWIhCWla0
X-Google-Smtp-Source: ABdhPJz4U/K5xECU1x4OoWAIx1gh84A26TibgV9v+kXvpyqYw7RVPQq2d0+03ulU+sncMyS+Qjxrtg==
X-Received: by 2002:adf:a28c:: with SMTP id s12mr24192569wra.105.1623166431832;
        Tue, 08 Jun 2021 08:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:d35c:a474:f6ef:ed8b])
        by smtp.gmail.com with ESMTPSA id v15sm3171074wmj.39.2021.06.08.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:33:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
Date:   Tue,  8 Jun 2021 17:33:44 +0200
Message-Id: <20210608153344.3813661-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; h=from:subject; bh=rXYEdEvR4nB8Uuzj3wSEdhErRQJIwUAAs0WLZJAZRBo=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgv43EKHb0N7wWQADXSgVpC3TlHAvo7HVCKUWEUvdD 70tVpniJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL+NxAAKCRB33NvayMhJ0RYAEA Cn00ya6QR9FuG8XEUR73LXPWY5M4lH9jzVT80zXzAn9YbOkQp4U0pzyQIE6G73e5CzbRGHu4KMeCiq 97r0m1A1HkVzavTfhNKIHPSKhI1EyRr3aepPgWtTR5JuITYUTKmlnuj4+myBQwmg6DA+xXgTqignax c0Dep6KJJ+6Esn9TL8IGW5wVEHR+dXWhiVi5pi9ct8MJsddTBB3YidOiN65z2/viamzKKoU3mcvNqy USq5QU1XZSPlPYfag2lVMd7Jh0p4YD8dYGM+eYTbsg1AWNuGIjIP2V6Blws6rqtUOCo5T84/jFSPcU O7KM9LBo9KifwUpqlv2hj9PH82vINfOdOUBWAOyy+Qu2c3w9QdPju6mTOXRDceq1sjacQctW50My9G GOdb3NyqhRfKTZfYnEV0v0vwqTSU4l4O42vntZDOTfTz8xg3gOpZCfXW2gDzkwR3kSfgKELzqYAVMp /79j1+VMpxKzpau7x7HaA9+d3Ksil8V5dpGNi2153pblHv3cfz4tOwJlF5xYHrzrZmICr90aZeGBGD EFNUNRuQOTJ7dA3WJgrBPKn0+6aLFOAfiqoIEykuYYMBwwGPaUAUbtraUmC9igOk1AW+PU+nWKzQXv 88VGiq4uFR9Lme6YfTMdScMAOG1ukqzSoKS+72z4B108SLkPDfOQ5GVGDoZQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
is used on the G12A/G12B platforms.

This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
when dram-access-quirk is enabled.

Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Ulf, Marek, Mark,

I haven't tested the patch yet, but should fix issue reported at [2].

Neil

[2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com

 drivers/mmc/host/meson-gx-mmc.c | 48 ++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8b771b643cc..89ff6038092d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -742,6 +742,48 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
 	writel(start, host->regs + SD_EMMC_START);
 }
 
+/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
+static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
+				  size_t buflen, bool to_buffer)
+{
+	unsigned int sg_flags = SG_MITER_ATOMIC;
+	struct scatterlist *sgl = data->sg;
+	unsigned int nents = data->sg_len;
+	struct sg_mapping_iter miter;
+	void *buf = host->bounce_buf;
+	unsigned int offset = 0;
+
+	if (to_buffer)
+		sg_flags |= SG_MITER_FROM_SG;
+	else
+		sg_flags |= SG_MITER_TO_SG;
+
+	sg_miter_start(&miter, sgl, nents, sg_flags);
+
+	while ((offset < buflen) && sg_miter_next(&miter)) {
+		unsigned int len;
+
+		len = min(miter.length, buflen - offset);
+
+		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
+		if (host->dram_access_quirk) {
+			if (to_buffer)
+				memcpy_toio(buf + offset, miter.addr, len);
+			else
+				memcpy_fromio(miter.addr, buf + offset, len);
+		} else {
+			if (to_buffer)
+				memcpy(buf + offset, miter.addr, len);
+			else
+				memcpy(miter.addr, buf + offset, len);
+		}
+
+		offset += len;
+	}
+
+	sg_miter_stop(&miter);
+}
+
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		if (data->flags & MMC_DATA_WRITE) {
 			cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_to_buffer(data->sg, data->sg_len,
-					  host->bounce_buf, xfer_bytes);
+			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
 			dma_wmb();
 		}
 
@@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	if (meson_mmc_bounce_buf_read(data)) {
 		xfer_bytes = data->blksz * data->blocks;
 		WARN_ON(xfer_bytes > host->bounce_buf_size);
-		sg_copy_from_buffer(data->sg, data->sg_len,
-				    host->bounce_buf, xfer_bytes);
+		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
 	}
 
 	next_cmd = meson_mmc_get_next_command(cmd);
-- 
2.25.1

