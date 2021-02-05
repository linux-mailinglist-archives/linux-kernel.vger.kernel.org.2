Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0E3105BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBEHTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhBEHTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:19:22 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F8CC06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 23:18:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g15so3907069pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 23:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7So9syvFy4xx92Iz/ZAlBHZhzSfnTIupI/lSGlpxtUU=;
        b=Ipd1YcWOhq8nhua/gXdKUV3k8eIFZnN/a6FgqIzA+PKGwktHd4OA/3JyG7Bw6WbSQx
         Orux6hYIzIBBQeBBvxXQ9/e3zjrSjWXpemjsPRxnIXHVytIKDoe8MYGlSbXsTyIuAmg+
         Y4Z2dfpEWfc3NgMyblLC7BLVCa6sUbvkDLvyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7So9syvFy4xx92Iz/ZAlBHZhzSfnTIupI/lSGlpxtUU=;
        b=WF1aKl+A9FDwtRKbg4VH7j66s7p4Hw8lcOhCBFMGC54cD3/qhU/bWlFWJ8yykyh2sQ
         /pboDMVJ7kArB+JJzQ8a2jXpOZZoh6OnIqjElAqL6OvuxIyP7RPzaJ1lUsoBn/+R7iAT
         ywc5PQ8wYOC+z1JF7iEjSYpEXPk/SEUsOLKM20po2PhxzNeezBe/3VHm7+XlJXzXTICf
         JmfQBYq+2ZDgLiSJgLAHbIr/nRBykksb+v4P0cHinY+Ybk2StjSl8aBd5miAMtMnDisj
         zrb+Bfil9emgc+N4ahiDJgnse0O9675Nb3XlzwTBpV9W3tbwTds3m1hzd5u2S0JRDryS
         sLLQ==
X-Gm-Message-State: AOAM530PbjwBWsgJoKXzT8t12E08rltgyduWawS0zGaT5GJS7jncXid2
        IL+MCB6ZRqyg7xrkQl0MdK4n8Q==
X-Google-Smtp-Source: ABdhPJz4XHmMIjp9q5M/FQlBgA7ZY6d/k7aUiKy9OJYlWtIFNMM6EF9DW0xcoRtDByfyzH4MHcLcyg==
X-Received: by 2002:a63:1110:: with SMTP id g16mr2992499pgl.357.1612509521854;
        Thu, 04 Feb 2021 23:18:41 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id oa10sm6292028pjb.45.2021.02.04.23.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 23:18:41 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-binding: gce: add gce header file for mt8192
Date:   Fri,  5 Feb 2021 15:18:31 +0800
Message-Id: <20210205071833.2707243-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210205071833.2707243-1-hsinyi@chromium.org>
References: <20210205071833.2707243-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Add documentation for the mt8192 gce.

Add gce header file defined the gce hardware event,
subsys number and constant for mt8192.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../devicetree/bindings/mailbox/mtk-gce.txt   |   7 +-
 include/dt-bindings/gce/mt8192-gce.h          | 419 ++++++++++++++++++
 2 files changed, 423 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8192-gce.h

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index 7771ecaac5868..ac4245050d17d 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -9,8 +9,8 @@ CMDQ driver uses mailbox framework for communication. Please refer to
 mailbox.txt for generic information about mailbox device-tree bindings.
 
 Required properties:
-- compatible: can be "mediatek,mt8173-gce", "mediatek,mt8183-gce" or
-  "mediatek,mt6779-gce".
+- compatible: can be "mediatek,mt8173-gce", "mediatek,mt8183-gce",
+  "mediatek,mt8192-gce" or "mediatek,mt6779-gce".
 - reg: Address range of the GCE unit
 - interrupts: The interrupt signal from the GCE block
 - clock: Clocks according to the common clock binding
@@ -36,7 +36,8 @@ Optional properties for a client device:
   size: the total size of register address that GCE can access.
 
 Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
-'dt-binding/gce/mt8183-gce.h' or 'dt-bindings/gce/mt6779-gce.h'. Such as
+'dt-binding/gce/mt8183-gce.h', 'dt-binding/gce/mt8192-gce.h' or
+'dt-bindings/gce/mt6779-gce.h'. Such as
 sub-system ids, thread priority, event ids.
 
 Example:
diff --git a/include/dt-bindings/gce/mt8192-gce.h b/include/dt-bindings/gce/mt8192-gce.h
new file mode 100644
index 0000000000000..062754416bfda
--- /dev/null
+++ b/include/dt-bindings/gce/mt8192-gce.h
@@ -0,0 +1,419 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Yongqiang Niu <yongqiang.niu@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_GCE_MT8192_H
+#define _DT_BINDINGS_GCE_MT8192_H
+
+/* assign timeout 0 also means default */
+#define CMDQ_NO_TIMEOUT		0xffffffff
+#define CMDQ_TIMEOUT_DEFAULT	1000
+
+/* GCE thread priority */
+#define CMDQ_THR_PRIO_LOWEST	0
+#define CMDQ_THR_PRIO_1		1
+#define CMDQ_THR_PRIO_2		2
+#define CMDQ_THR_PRIO_3		3
+#define CMDQ_THR_PRIO_4		4
+#define CMDQ_THR_PRIO_5		5
+#define CMDQ_THR_PRIO_6		6
+#define CMDQ_THR_PRIO_HIGHEST	7
+
+/* CPR count in 32bit register */
+#define GCE_CPR_COUNT		1312
+
+/* GCE subsys table */
+#define SUBSYS_1300XXXX		0
+#define SUBSYS_1400XXXX		1
+#define SUBSYS_1401XXXX		2
+#define SUBSYS_1402XXXX		3
+#define SUBSYS_1502XXXX		4
+#define SUBSYS_1880XXXX		5
+#define SUBSYS_1881XXXX		6
+#define SUBSYS_1882XXXX		7
+#define SUBSYS_1883XXXX		8
+#define SUBSYS_1884XXXX		9
+#define SUBSYS_1000XXXX		10
+#define SUBSYS_1001XXXX		11
+#define SUBSYS_1002XXXX		12
+#define SUBSYS_1003XXXX		13
+#define SUBSYS_1004XXXX		14
+#define SUBSYS_1005XXXX		15
+#define SUBSYS_1020XXXX		16
+#define SUBSYS_1028XXXX		17
+#define SUBSYS_1700XXXX		18
+#define SUBSYS_1701XXXX		19
+#define SUBSYS_1702XXXX		20
+#define SUBSYS_1703XXXX		21
+#define SUBSYS_1800XXXX		22
+#define SUBSYS_1801XXXX		23
+#define SUBSYS_1802XXXX		24
+#define SUBSYS_1804XXXX		25
+#define SUBSYS_1805XXXX		26
+#define SUBSYS_1808XXXX		27
+#define SUBSYS_180aXXXX		28
+#define SUBSYS_180bXXXX		29
+#define SUBSYS_NO_SUPPORT	99
+
+/* GCE General Purpose Register (GPR) support
+ * Leave note for scenario usage here
+ */
+/* GCE: write mask */
+#define GCE_GPR_R00		0x00
+#define GCE_GPR_R01		0x01
+/* MDP: P1: JPEG dest */
+#define GCE_GPR_R02		0x02
+#define GCE_GPR_R03		0x03
+/* MDP: PQ color */
+#define GCE_GPR_R04		0x04
+/* MDP: 2D sharpness */
+#define GCE_GPR_R05		0x05
+/* DISP: poll esd */
+#define GCE_GPR_R06		0x06
+#define GCE_GPR_R07		0x07
+/* MDP: P4: 2D sharpness dst */
+#define GCE_GPR_R08		0x08
+#define GCE_GPR_R09		0x09
+/* VCU: poll with timeout for GPR timer */
+#define GCE_GPR_R10		0x0A
+#define GCE_GPR_R11		0x0B
+/* CMDQ: debug */
+#define GCE_GPR_R12		0x0C
+#define GCE_GPR_R13		0x0D
+/* CMDQ: P7: debug */
+#define GCE_GPR_R14		0x0E
+#define GCE_GPR_R15		0x0F
+
+#define CMDQ_EVENT_VDEC_LAT_SOF_0			0
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_0		1
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_1		2
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_2		3
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_3		4
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_4		5
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_5		6
+#define CMDQ_EVENT_VDEC_LAT_FRAME_DONE_6		7
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_0			8
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_1			9
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_2			10
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_3			11
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_4			12
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_5			13
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_6			14
+#define CMDQ_EVENT_VDEC_LAT_ENG_EVENT_7			15
+
+#define CMDQ_EVENT_ISP_FRAME_DONE_A			65
+#define CMDQ_EVENT_ISP_FRAME_DONE_B			66
+#define CMDQ_EVENT_ISP_FRAME_DONE_C			67
+#define CMDQ_EVENT_CAMSV0_PASS1_DONE			68
+#define CMDQ_EVENT_CAMSV02_PASS1_DONE			69
+#define CMDQ_EVENT_CAMSV1_PASS1_DONE			70
+#define CMDQ_EVENT_CAMSV2_PASS1_DONE			71
+#define CMDQ_EVENT_CAMSV3_PASS1_DONE			72
+#define CMDQ_EVENT_MRAW_0_PASS1_DONE			73
+#define CMDQ_EVENT_MRAW_1_PASS1_DONE			74
+#define CMDQ_EVENT_SENINF_CAM0_FIFO_FULL		75
+#define CMDQ_EVENT_SENINF_CAM1_FIFO_FULL		76
+#define CMDQ_EVENT_SENINF_CAM2_FIFO_FULL		77
+#define CMDQ_EVENT_SENINF_CAM3_FIFO_FULL		78
+#define CMDQ_EVENT_SENINF_CAM4_FIFO_FULL		79
+#define CMDQ_EVENT_SENINF_CAM5_FIFO_FULL		80
+#define CMDQ_EVENT_SENINF_CAM6_FIFO_FULL		81
+#define CMDQ_EVENT_SENINF_CAM7_FIFO_FULL		82
+#define CMDQ_EVENT_SENINF_CAM8_FIFO_FULL		83
+#define CMDQ_EVENT_SENINF_CAM9_FIFO_FULL		84
+#define CMDQ_EVENT_SENINF_CAM10_FIFO_FULL		85
+#define CMDQ_EVENT_SENINF_CAM11_FIFO_FULL		86
+#define CMDQ_EVENT_SENINF_CAM12_FIFO_FULL		87
+#define CMDQ_EVENT_TG_OVRUN_A_INT			88
+#define CMDQ_EVENT_DMA_R1_ERROR_A_INT			89
+#define CMDQ_EVENT_TG_OVRUN_B_INT			90
+#define CMDQ_EVENT_DMA_R1_ERROR_B_INT			91
+#define CMDQ_EVENT_TG_OVRUN_C_INT			92
+#define CMDQ_EVENT_DMA_R1_ERROR_C_INT			93
+#define CMDQ_EVENT_TG_OVRUN_M0_INT			94
+#define CMDQ_EVENT_DMA_R1_ERROR_M0_INT			95
+#define CMDQ_EVENT_TG_GRABERR_M0_INT			96
+#define CMDQ_EVENT_TG_GRABERR_M1_INT			97
+#define CMDQ_EVENT_TG_GRABERR_A_INT			98
+#define CMDQ_EVENT_CQ_VR_SNAP_A_INT			99
+#define CMDQ_EVENT_TG_GRABERR_B_INT			100
+#define CMDQ_EVENT_CQ_VR_SNAP_B_INT			101
+#define CMDQ_EVENT_TG_GRABERR_C_INT			102
+#define CMDQ_EVENT_CQ_VR_SNAP_C_INT			103
+
+#define CMDQ_EVENT_VENC_CMDQ_FRAME_DONE			129
+#define CMDQ_EVENT_VENC_CMDQ_PAUSE_DONE			130
+#define CMDQ_EVENT_JPGENC_CMDQ_DONE			131
+#define CMDQ_EVENT_VENC_CMDQ_MB_DONE			132
+#define CMDQ_EVENT_VENC_CMDQ_128BYTE_CNT_DONE		133
+#define CMDQ_EVENT_VENC_C0_CMDQ_WP_2ND_STAGE_DONE	134
+#define CMDQ_EVENT_VENC_C0_CMDQ_WP_3RD_STAGE_DONE	135
+#define CMDQ_EVENT_VENC_CMDQ_PPS_DONE			136
+#define CMDQ_EVENT_VENC_CMDQ_SPS_DONE			137
+#define CMDQ_EVENT_VENC_CMDQ_VPS_DONE			138
+
+#define CMDQ_EVENT_VDEC_CORE0_SOF_0			160
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_0		161
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_1		162
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_2		163
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_3		164
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_4		165
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_5		166
+#define CMDQ_EVENT_VDEC_CORE0_FRAME_DONE_6		167
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_0		168
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_1		169
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_2		170
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_3		171
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_4		172
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_5		173
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_6		174
+#define CMDQ_EVENT_VDEC_CORE0_ENG_EVENT_7		175
+#define CMDQ_EVENT_FDVT_DONE				177
+#define CMDQ_EVENT_FE_DONE				178
+#define CMDQ_EVENT_RSC_DONE				179
+#define CMDQ_EVENT_DVS_DONE_ASYNC_SHOT			180
+#define CMDQ_EVENT_DVP_DONE_ASYNC_SHOT			181
+
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_0		193
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_1		194
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_2		195
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_3		196
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_4		197
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_5		198
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_6		199
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_7		200
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_8		201
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_9		202
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_10		203
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_11		204
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_12		205
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_13		206
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_14		207
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_15		208
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_16		209
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_17		210
+#define CMDQ_EVENT_IMG2_DIP_FRAME_DONE_P2_18		211
+#define CMDQ_EVENT_IMG2_DIP_DMA_ERR_EVENT		212
+#define CMDQ_EVENT_IMG2_AMD_FRAME_DONE			213
+#define CMDQ_EVENT_IMG2_MFB_DONE_LINK_MISC		214
+#define CMDQ_EVENT_IMG2_WPE_A_DONE_LINK_MISC		215
+#define CMDQ_EVENT_IMG2_MSS_DONE_LINK_MISC		216
+
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_0		225
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_1		226
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_2		227
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_3		228
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_4		229
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_5		230
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_6		231
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_7		232
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_8		233
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_9		234
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_10		235
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_11		236
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_12		237
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_13		238
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_14		239
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_15		240
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_16		241
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_17		242
+#define CMDQ_EVENT_IMG1_DIP_FRAME_DONE_P2_18		243
+#define CMDQ_EVENT_IMG1_DIP_DMA_ERR_EVENT		244
+#define CMDQ_EVENT_IMG1_AMD_FRAME_DONE			245
+#define CMDQ_EVENT_IMG1_MFB_DONE_LINK_MISC		246
+#define CMDQ_EVENT_IMG1_WPE_A_DONE_LINK_MISC		247
+#define CMDQ_EVENT_IMG1_MSS_DONE_LINK_MISC		248
+
+#define CMDQ_EVENT_MDP_RDMA0_SOF			256
+#define CMDQ_EVENT_MDP_RDMA1_SOF			257
+#define CMDQ_EVENT_MDP_AAL0_SOF				258
+#define CMDQ_EVENT_MDP_AAL1_SOF				259
+#define CMDQ_EVENT_MDP_HDR0_SOF				260
+#define CMDQ_EVENT_MDP_HDR1_SOF				261
+#define CMDQ_EVENT_MDP_RSZ0_SOF				262
+#define CMDQ_EVENT_MDP_RSZ1_SOF				263
+#define CMDQ_EVENT_MDP_WROT0_SOF			264
+#define CMDQ_EVENT_MDP_WROT1_SOF			265
+#define CMDQ_EVENT_MDP_TDSHP0_SOF			266
+#define CMDQ_EVENT_MDP_TDSHP1_SOF			267
+#define CMDQ_EVENT_IMG_DL_RELAY0_SOF			268
+#define CMDQ_EVENT_IMG_DL_RELAY1_SOF			269
+#define CMDQ_EVENT_MDP_COLOR0_SOF			270
+#define CMDQ_EVENT_MDP_COLOR1_SOF			271
+#define CMDQ_EVENT_MDP_WROT1_FRAME_DONE			290
+#define CMDQ_EVENT_MDP_WROT0_FRAME_DONE			291
+#define CMDQ_EVENT_MDP_TDSHP1_FRAME_DONE		294
+#define CMDQ_EVENT_MDP_TDSHP0_FRAME_DONE		295
+#define CMDQ_EVENT_MDP_RSZ1_FRAME_DONE			302
+#define CMDQ_EVENT_MDP_RSZ0_FRAME_DONE			303
+#define CMDQ_EVENT_MDP_RDMA1_FRAME_DONE			306
+#define CMDQ_EVENT_MDP_RDMA0_FRAME_DONE			307
+#define CMDQ_EVENT_MDP_HDR1_FRAME_DONE			308
+#define CMDQ_EVENT_MDP_HDR0_FRAME_DONE			309
+#define CMDQ_EVENT_MDP_COLOR1_FRAME_DONE		312
+#define CMDQ_EVENT_MDP_COLOR0_FRAME_DONE		313
+#define CMDQ_EVENT_MDP_AAL1_FRAME_DONE			316
+#define CMDQ_EVENT_MDP_AAL0_FRAME_DONE			317
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_0		320
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_1		321
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_2		322
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_3		323
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_4		324
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_5		325
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_6		326
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_7		327
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_8		328
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_9		329
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_10		330
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_11		331
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_12		332
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_13		333
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_14		334
+#define CMDQ_EVENT_MDP_STREAM_DONE_ENG_EVENT_15		335
+#define CMDQ_EVENT_MDP_WROT1_SW_RST_DONE_ENG_EVENT	338
+#define CMDQ_EVENT_MDP_WROT0_SW_RST_DONE_ENG_EVENT	339
+#define CMDQ_EVENT_MDP_RDMA1_SW_RST_DONE_ENG_EVENT	342
+#define CMDQ_EVENT_MDP_RDMA0_SW_RST_DONE_ENG_EVENT	343
+
+#define CMDQ_EVENT_DISP_OVL0_SOF			384
+#define CMDQ_EVENT_DISP_OVL0_2L_SOF			385
+#define CMDQ_EVENT_DISP_RDMA0_SOF			386
+#define CMDQ_EVENT_DISP_RSZ0_SOF			387
+#define CMDQ_EVENT_DISP_COLOR0_SOF			388
+#define CMDQ_EVENT_DISP_CCORR0_SOF			389
+#define CMDQ_EVENT_DISP_AAL0_SOF			390
+#define CMDQ_EVENT_DISP_GAMMA0_SOF			391
+#define CMDQ_EVENT_DISP_POSTMASK0_SOF			392
+#define CMDQ_EVENT_DISP_DITHER0_SOF			393
+#define CMDQ_EVENT_DISP_DSC_WRAP0_CORE0_SOF		394
+#define CMDQ_EVENT_DISP_DSC_WRAP0_CORE1_SOF		395
+#define CMDQ_EVENT_DSI0_SOF				396
+#define CMDQ_EVENT_DISP_WDMA0_SOF			397
+#define CMDQ_EVENT_DISP_UFBC_WDMA0_SOF			398
+#define CMDQ_EVENT_DISP_PWM0_SOF			399
+#define CMDQ_EVENT_DISP_OVL2_2L_SOF			400
+#define CMDQ_EVENT_DISP_RDMA4_SOF			401
+#define CMDQ_EVENT_DISP_DPI0_SOF			402
+#define CMDQ_EVENT_MDP_RDMA4_SOF			403
+#define CMDQ_EVENT_MDP_HDR4_SOF				404
+#define CMDQ_EVENT_MDP_RSZ4_SOF				405
+#define CMDQ_EVENT_MDP_AAL4_SOF				406
+#define CMDQ_EVENT_MDP_TDSHP4_SOF			407
+#define CMDQ_EVENT_MDP_COLOR4_SOF			408
+#define CMDQ_EVENT_DISP_Y2R0_SOF			409
+#define CMDQ_EVENT_MDP_TDSHP4_FRAME_DONE		410
+#define CMDQ_EVENT_MDP_RSZ4_FRAME_DONE			411
+#define CMDQ_EVENT_MDP_RDMA4_FRAME_DONE			412
+#define CMDQ_EVENT_MDP_HDR4_FRAME_DONE			413
+#define CMDQ_EVENT_MDP_COLOR4_FRAME_DONE		414
+#define CMDQ_EVENT_MDP_AAL4_FRAME_DONE			415
+#define CMDQ_EVENT_DSI0_FRAME_DONE			416
+#define CMDQ_EVENT_DISP_WDMA0_FRAME_DONE		417
+#define CMDQ_EVENT_DISP_UFBC_WDMA0_FRAME_DONE		418
+#define CMDQ_EVENT_DISP_RSZ0_FRAME_DONE			419
+#define CMDQ_EVENT_DISP_RDMA4_FRAME_DONE		420
+#define CMDQ_EVENT_DISP_RDMA0_FRAME_DONE		421
+#define CMDQ_EVENT_DISP_POSTMASK0_FRAME_DONE		422
+#define CMDQ_EVENT_DISP_OVL2_2L_FRAME_DONE		423
+#define CMDQ_EVENT_DISP_OVL0_FRAME_DONE			424
+#define CMDQ_EVENT_DISP_OVL0_2L_FRAME_DONE		425
+#define CMDQ_EVENT_DISP_GAMMA0_FRAME_DONE		426
+#define CMDQ_EVENT_DISP_DSC_WRAP0_CORE1_FRAME_DONE	427
+#define CMDQ_EVENT_DISP_DSC_WRAP0_CORE0_FRAME_DONE	428
+#define CMDQ_EVENT_DISP_DPI0_FRAME_DONE			429
+#define CMDQ_EVENT_DISP_DITHER0_FRAME_DONE		430
+#define CMDQ_EVENT_DISP_COLOR0_FRAME_DONE		431
+#define CMDQ_EVENT_DISP_CCORR0_FRAME_DONE		432
+#define CMDQ_EVENT_DISP_AAL0_FRAME_DONE			433
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0		434
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1		435
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_2		436
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_3		437
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_4		438
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_5		439
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_6		440
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_7		441
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_8		442
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_9		443
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_10	444
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_11	445
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_12	446
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_13	447
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_14	448
+#define CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_15	449
+#define CMDQ_EVENT_DSI0_TE_ENG_EVENT			450
+#define CMDQ_EVENT_DSI0_IRQ_ENG_EVENT			451
+#define CMDQ_EVENT_DSI0_DONE_ENG_EVENT			452
+#define CMDQ_EVENT_DISP_WDMA0_SW_RST_DONE_ENG_EVENT	453
+#define CMDQ_EVENT_DISP_SMIASSERT_ENG_EVENT		454
+#define CMDQ_EVENT_DISP_POSTMASK0_RST_DONE_ENG_EVENT	455
+#define CMDQ_EVENT_DISP_OVL2_2L_RST_DONE_ENG_EVENT	456
+#define CMDQ_EVENT_DISP_OVL0_RST_DONE_ENG_EVENT		457
+#define CMDQ_EVENT_DISP_OVL0_2L_RST_DONE_ENG_EVENT	458
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_0		459
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_1		460
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_2		461
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_3		462
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_4		463
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_5		464
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_6		465
+#define CMDQ_EVENT_BUF_UNDERRUN_ENG_EVENT_7		466
+#define CMDQ_EVENT_OUT_EVENT_0				898
+
+/* CMDQ sw tokens
+ * Following definitions are gce sw token which may use by clients
+ * event operation API.
+ * Note that token 512 to 639 may set secure
+ */
+
+/* end of hw event and begin of sw token */
+#define CMDQ_MAX_HW_EVENT				512
+
+/* Config thread notify trigger thread */
+#define CMDQ_SYNC_TOKEN_CONFIG_DIRTY			640
+/* Trigger thread notify config thread */
+#define CMDQ_SYNC_TOKEN_STREAM_EOF			641
+/* Block Trigger thread until the ESD check finishes. */
+#define CMDQ_SYNC_TOKEN_ESD_EOF				642
+#define CMDQ_SYNC_TOKEN_STREAM_BLOCK			643
+/* check CABC setup finish */
+#define CMDQ_SYNC_TOKEN_CABC_EOF			644
+
+/* Notify normal CMDQ there are some secure task done
+ * MUST NOT CHANGE, this token sync with secure world
+ */
+#define CMDQ_SYNC_SECURE_THR_EOF			647
+
+/* CMDQ use sw token */
+#define CMDQ_SYNC_TOKEN_USER_0				649
+#define CMDQ_SYNC_TOKEN_USER_1				650
+#define CMDQ_SYNC_TOKEN_POLL_MONITOR			651
+
+/* ISP sw token */
+#define CMDQ_SYNC_TOKEN_MSS				665
+#define CMDQ_SYNC_TOKEN_MSF				666
+
+/* DISP sw token */
+#define CMDQ_SYNC_TOKEN_SODI				671
+
+/* GPR access tokens (for HW register backup)
+ * There are 15 32-bit GPR, 3 GPR form a set
+ * (64-bit for address, 32-bit for value)
+ * MUST NOT CHANGE, these tokens sync with MDP
+ */
+#define CMDQ_SYNC_TOKEN_GPR_SET_0			700
+#define CMDQ_SYNC_TOKEN_GPR_SET_1			701
+#define CMDQ_SYNC_TOKEN_GPR_SET_2			702
+#define CMDQ_SYNC_TOKEN_GPR_SET_3			703
+#define CMDQ_SYNC_TOKEN_GPR_SET_4			704
+
+/* Resource lock event to control resource in GCE thread */
+#define CMDQ_SYNC_RESOURCE_WROT0			710
+#define CMDQ_SYNC_RESOURCE_WROT1			711
+
+#define CMDQ_EVENT_MAX					0x3FF
+/* CMDQ sw tokens END */
+
+#endif
-- 
2.30.0.365.g02bc693789-goog

