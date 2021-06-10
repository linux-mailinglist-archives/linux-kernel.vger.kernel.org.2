Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB33A33F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFJT0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:26:12 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:39638 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhFJT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:26:11 -0400
Received: by mail-io1-f41.google.com with SMTP id f10so13753131iok.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lzDnIEiuHeqKMSHR2kedCosArXsL218NPTCRDYpYD8=;
        b=kDAqS9nlvRXkAdNWf2DNRxD/rQ5ly86VqTrzfW6Mhwtt/5N2v7XQz2UGGT/KrxUbWs
         6RVFcH4c33YI9ze+uik0zrtKh/7Ry1b8mM5qTj/uHzeQZkQE8iX4qlVIYQ/GmU7alHKj
         37lleMphxA+w4GVDIX2Yp25onaTEB0oNinRGjMhu7EldtoVjjqNNVhTFqGGFpIc+85xb
         Jo/xstiUaTW1eTPhqJROWdr6GLkRZWknQrQleUVARNtsmsVv5G4zf0N+WrmBInqXLG/S
         UnVqJZrFHtVPeAV+rJCN2FsKo7NM7ES81cqRLnrN0FU9nbafIyMr8GTQ1REAbcRL5iDQ
         dYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lzDnIEiuHeqKMSHR2kedCosArXsL218NPTCRDYpYD8=;
        b=V/en1XXxpSyOv5Ndp8nYuEh/x+ouk0ENXX80ghDwcHN4YqmcQFVwsog+JG0w2RM4mj
         m8/VJarVlql18I/tvflt6Dz5aLtWV8MkDWv/aVJ7QbaiHGD8njF8QL5bDqUFE6iqeO8/
         MZLmKc7/LaOX8jCSTRao3iajcL752XcAQkq6464zxZsMBUbEtHd1LIYRTF2xKi7IiGmX
         /7bEs+eOgSxdlXe9wJ+VoUIIiCbeCBBMWjqbRQiD1quSlIk3slWLTb1UPyCvQEl0NBJa
         s2DsCh2l8IpF5W/q5MnEQvNhSoI/Ok6uoumtvs0w+koKhr4gM7QtJwSFtBdow1IkgZlz
         gB0g==
X-Gm-Message-State: AOAM531aCZHMxNgPy+xe6YSuU4CCn42HF+dedDYxufI5HUxOAKX/a4bs
        WWqYMLFneoxGmrQj4nUCvIvsMQ==
X-Google-Smtp-Source: ABdhPJzLX4ZHkcOOmBh76X893vyb3Osjd+VP5EOAe+9pG8bp5nS5wOtE+Jzj9ujY6n7F5m0qpfnWVg==
X-Received: by 2002:a05:6638:140c:: with SMTP id k12mr201699jad.126.1623352994670;
        Thu, 10 Jun 2021 12:23:14 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w21sm2028684iol.52.2021.06.10.12.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:23:14 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/8] net: ipa: clean up header memory validation
Date:   Thu, 10 Jun 2021 14:23:02 -0500
Message-Id: <20210610192308.2739540-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610192308.2739540-1-elder@linaro.org>
References: <20210610192308.2739540-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some general cleanup in ipa_cmd_header_valid():
  - Delay assigning the mem variable until just before it's used.
  - Assign the maximum offset and size values together.
  - Improve comments explaining the single range of memory being
    made up of a modem portion and an AP portion.
  - Record the offset of the combined range in a local variable.
  - Do the initial size assignment right after assigning the offset.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_cmd.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index 525cdf28d9ea7..3e5f10d3c131d 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -200,41 +200,53 @@ bool ipa_cmd_table_valid(struct ipa *ipa, const struct ipa_mem *mem,
 /* Validate the memory region that holds headers */
 static bool ipa_cmd_header_valid(struct ipa *ipa)
 {
-	const struct ipa_mem *mem = &ipa->mem[IPA_MEM_MODEM_HEADER];
 	struct device *dev = &ipa->pdev->dev;
+	const struct ipa_mem *mem;
 	u32 offset_max;
 	u32 size_max;
+	u32 offset;
 	u32 size;
 
-	/* In ipa_cmd_hdr_init_local_add() we record the offset and size
-	 * of the header table memory area.  Make sure the offset and size
-	 * fit in the fields that need to hold them, and that the entire
-	 * range is within the overall IPA memory range.
+	/* In ipa_cmd_hdr_init_local_add() we record the offset and size of
+	 * the header table memory area in an immediate command.  Make sure
+	 * the offset and size fit in the fields that need to hold them, and
+	 * that the entire range is within the overall IPA memory range.
 	 */
 	offset_max = field_max(HDR_INIT_LOCAL_FLAGS_HDR_ADDR_FMASK);
-	if (mem->offset > offset_max ||
-	    ipa->mem_offset > offset_max - mem->offset) {
-		dev_err(dev, "header table region offset too large\n");
-		dev_err(dev, "    (0x%04x + 0x%04x > 0x%04x)\n",
-			ipa->mem_offset, mem->offset, offset_max);
-
-		return false;
-	}
-
 	size_max = field_max(HDR_INIT_LOCAL_FLAGS_TABLE_SIZE_FMASK);
-	size = ipa->mem[IPA_MEM_MODEM_HEADER].size;
+
+	/* The header memory area contains both the modem and AP header
+	 * regions.  The modem portion defines the address of the region.
+	 */
+	mem = &ipa->mem[IPA_MEM_MODEM_HEADER];
+	offset = mem->offset;
+	size = mem->size;
+
+	/* Make sure the offset fits in the IPA command */
+	if (offset > offset_max || ipa->mem_offset > offset_max - offset) {
+		dev_err(dev, "header table region offset too large\n");
+		dev_err(dev, "    (0x%04x + 0x%04x > 0x%04x)\n",
+			ipa->mem_offset, offset, offset_max);
+
+		return false;
+	}
+
+	/* Add the size of the AP portion to the combined size */
 	size += ipa->mem[IPA_MEM_AP_HEADER].size;
 
+	/* Make sure the combined size fits in the IPA command */
 	if (size > size_max) {
 		dev_err(dev, "header table region size too large\n");
 		dev_err(dev, "    (0x%04x > 0x%08x)\n", size, size_max);
 
 		return false;
 	}
-	if (size > ipa->mem_size || mem->offset > ipa->mem_size - size) {
+
+	/* Make sure the entire combined area fits in IPA memory */
+	if (size > ipa->mem_size || offset > ipa->mem_size - size) {
 		dev_err(dev, "header table region out of range\n");
 		dev_err(dev, "    (0x%04x + 0x%04x > 0x%04x)\n",
-			mem->offset, size, ipa->mem_size);
+			offset, size, ipa->mem_size);
 
 		return false;
 	}
-- 
2.27.0

