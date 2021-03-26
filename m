Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159BC34AB16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCZPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhCZPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:11:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15981C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x16so5726645iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3Amz4sRXqrDeeMEBKQe2cGc+ePyC2Wm+fZmxeTt5jY=;
        b=kdfXL7dPCD+/9w8rraTmM/vobvbdbr33L08nwKp5QHre+h0stt4UQKj7mZndLNn6hI
         Ac31b4ILq+6qBnBmrWNDxtsHWL3QJmntwuZYVkRWsC3cRaLre8WhC+W9YTCSqrrjUdp+
         btEaRf4gMro7ljk58/xyVtdgTKh4aVqay4DuWxmNDSeLQLv0ZvrMSftyWqLACr05roPX
         NYQdF8y79SyRy5cy1IDmxjiscFZSAKnB4kwLj9FsBNyNXKHzi7swODHE5E0USMdrIkWk
         6f1py4TOjKE4yi8aj43wB9hyHTpWZz3Z3NEelZmbOSBANSvqIBjyXClUhbVnzvCvEpP7
         Jlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3Amz4sRXqrDeeMEBKQe2cGc+ePyC2Wm+fZmxeTt5jY=;
        b=h+caV1LiRZMwOGdlbAeRD/W4JznWM5NEyrBJjUq6o9xA5RvR1JCXBW57pcVIahgjqP
         Lg4EZ4Lpbo5IG0eWWRW+zqlpWx38Li/nmph43TNabkOvTxOI21e5el4dFORmwRUhlaQt
         R3kXCy0cOKcP8vZOce7KzS2JlyxSt/bOl8a7AJt5I99JY5bJQ6wk7bpWjqR+RxuVlPej
         77l89uy9BzoBe5lokTd+2iJGkQ5yQHCrrC3AlYfi2msjmHnxCXgf3xT6b90S1LkBl1RA
         FWIicMZoxrhRWW/f62ET56kkueYpdqT0KtzBBkl25+4U4FQ3SDqXqZV1D6EeduXYtTig
         j8YQ==
X-Gm-Message-State: AOAM530Hdo/ZtwROMfoCgBLY9TW6p3/GcYXc1gRH5+PxfqO5QCZtLrdV
        urI2BhS0y7FEm/3fBaS7fNKiIw==
X-Google-Smtp-Source: ABdhPJy7u4O/1EoD5Y0VlGDsPplpz3pjMNUMpGLxrM8BCKZ1wVG+sbhWVevpTNYUgjVWxUXVK5Kivw==
X-Received: by 2002:a02:2412:: with SMTP id f18mr12534463jaa.142.1616771489534;
        Fri, 26 Mar 2021 08:11:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j17sm4537706iok.37.2021.03.26.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:11:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/12] net: ipa: identify resource groups
Date:   Fri, 26 Mar 2021 10:11:13 -0500
Message-Id: <20210326151122.3121383-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326151122.3121383-1-elder@linaro.org>
References: <20210326151122.3121383-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new ipa_resource_group_id enumerated type, whose members
have numeric values that match the resource group number used when
programming the hardware.  Each platform supports a different number
of source and destination resource groups, so define the type
separately for each platform in its configuration data file.

Use these new symbolic values when specifying the resource group an
endpoint is associated with.  And use them to index the limits
arrays for source and destination resources, making it clearer how
these values are used.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sc7180.c | 38 ++++++++++++---------
 drivers/net/ipa/ipa_data-sdm845.c | 56 +++++++++++++++++++------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index 621ad15c9e67d..e9b741832a1d7 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2019-2020 Linaro Ltd. */
+/* Copyright (C) 2019-2021 Linaro Ltd. */
 
 #include <linux/log2.h>
 
@@ -9,6 +9,15 @@
 #include "ipa_endpoint.h"
 #include "ipa_mem.h"
 
+/* Resource groups used for the SC7180 SoC */
+enum ipa_rsrc_group_id {
+	/* Source resource group identifiers */
+	IPA_RSRC_GROUP_SRC_UL_DL	= 0,
+
+	/* Destination resource group identifiers */
+	IPA_RSRC_GROUP_DST_UL_DL_DPL	= 0,
+};
+
 /* QSB configuration for the SC7180 SoC. */
 static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
@@ -32,7 +41,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= 0,
+				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
 				.dma_mode	= true,
 				.dma_endpoint	= IPA_ENDPOINT_AP_LAN_RX,
 				.tx = {
@@ -53,7 +62,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= 0,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -75,7 +84,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.filter_support	= true,
 			.config = {
-				.resource_group	= 0,
+				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
 				.checksum	= true,
 				.qmap		= true,
 				.status_enable	= true,
@@ -100,7 +109,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= 0,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
 				.checksum	= true,
 				.qmap		= true,
 				.aggregation	= true,
@@ -139,58 +148,57 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 	},
 };
 
-/* For the SC7180, resource groups are allocated this way:
- *   group 0:	UL_DL
- */
+/* Source resource configuration data for the SC7180 SoC */
 static const struct ipa_resource_src ipa_resource_src[] = {
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 3,
 			.max = 63,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 3,
 			.max = 3,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 10,
 			.max = 10,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_HPS_DMARS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 1,
 			.max = 1,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 5,
 			.max = 5,
 		},
 	},
 };
 
+/* Destination resource configuration data for the SC7180 SoC */
 static const struct ipa_resource_dst ipa_resource_dst[] = {
 	{
 		.type = IPA_RESOURCE_TYPE_DST_DATA_SECTORS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
 			.min = 3,
 			.max = 3,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_DST_DPS_DMARS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
 			.min = 1,
 			.max = 63,
 		},
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index 6b5173f474444..b6ea6295e7598 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2020 Linaro Ltd.
+ * Copyright (C) 2019-2021 Linaro Ltd.
  */
 
 #include <linux/log2.h>
@@ -11,6 +11,20 @@
 #include "ipa_endpoint.h"
 #include "ipa_mem.h"
 
+/* Resource groups used for the SDM845 SoC */
+enum ipa_rsrc_group_id {
+	/* Source resource group identifiers */
+	IPA_RSRC_GROUP_SRC_LWA_DL	= 0,
+	IPA_RSRC_GROUP_SRC_UL_DL,
+	IPA_RSRC_GROUP_SRC_MHI_DMA,
+	IPA_RSRC_GROUP_SRC_UC_RX_Q,
+
+	/* Destination resource group identifiers */
+	IPA_RSRC_GROUP_DST_LWA_DL	= 0,
+	IPA_RSRC_GROUP_DST_UL_DL_DPL,
+	IPA_RSRC_GROUP_DST_UNUSED_2,
+};
+
 /* QSB configuration for the SDM845 SoC. */
 static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
@@ -37,7 +51,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= 1,
+				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
 				.dma_mode	= true,
 				.dma_endpoint	= IPA_ENDPOINT_AP_LAN_RX,
 				.tx = {
@@ -58,7 +72,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= 1,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -80,7 +94,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.filter_support	= true,
 			.config = {
-				.resource_group	= 1,
+				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
 				.checksum	= true,
 				.qmap		= true,
 				.status_enable	= true,
@@ -104,7 +118,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= 1,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
 				.checksum	= true,
 				.qmap		= true,
 				.aggregation	= true,
@@ -152,72 +166,70 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 	},
 };
 
-/* For the SDM845, resource groups are allocated this way:
- *   group 0:	LWA_DL
- *   group 1:	UL_DL
- */
+/* Source resource configuration data for the SDM845 SoC */
 static const struct ipa_resource_src ipa_resource_src[] = {
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
 			.min = 1,
 			.max = 255,
 		},
-		.limits[1] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 1,
 			.max = 255,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
 			.min = 10,
 			.max = 10,
 		},
-		.limits[1] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 10,
 			.max = 10,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
 			.min = 12,
 			.max = 12,
 		},
-		.limits[1] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 14,
 			.max = 14,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_HPS_DMARS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
 			.min = 0,
 			.max = 63,
 		},
-		.limits[1] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 0,
 			.max = 63,
 		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
 			.min = 14,
 			.max = 14,
 		},
-		.limits[1] = {
+		.limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
 			.min = 20,
 			.max = 20,
 		},
 	},
 };
 
+/* Destination resource configuration data for the SDM845 SoC */
 static const struct ipa_resource_dst ipa_resource_dst[] = {
 	{
 		.type = IPA_RESOURCE_TYPE_DST_DATA_SECTORS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_DST_LWA_DL] = {
 			.min = 4,
 			.max = 4,
 		},
@@ -228,11 +240,11 @@ static const struct ipa_resource_dst ipa_resource_dst[] = {
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_DST_DPS_DMARS,
-		.limits[0] = {
+		.limits[IPA_RSRC_GROUP_DST_LWA_DL] = {
 			.min = 2,
 			.max = 63,
 		},
-		.limits[1] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
 			.min = 1,
 			.max = 63,
 		},
-- 
2.27.0

