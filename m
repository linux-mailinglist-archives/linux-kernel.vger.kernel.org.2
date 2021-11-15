Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346D34503F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKOMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:05:49 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:63492 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231372AbhKOMFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:05:23 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFBu7I1030566;
        Mon, 15 Nov 2021 06:02:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ZsfDJPs3AQkoppYF0vvBIPQ+auuj++HTA/sVw3iUTIQ=;
 b=Vh0nFoIurj+w7BD/f8pp83NbVxj26FmlU8vUj0ZMyznh5W3b5A4k8Q9oUuT+qrVS080m
 1u1nOb4xhESAWXTjMjKoLQe247QsaZ3dLWRoaixlKD5jdk4UMlc7lmNNPkd8Q270UO2e
 y2T2YGhDZkrcVOdFpHGbae+Z2V0HtLdnAz+KRra+k+W36PpJ6bLJPgPsWXp6RR3CFdb3
 FVPNRp55yh9VH1mbpuBG+xsKRJmg3DuYa67bGgHbNbwt+dVvdJfo5MR+IcNu5XpY/ry0
 3DJHUwS5mEPzhsDUxqq0mMq8+PxVOcUMHJO87g+KoctrlrkeR4gLpbIQur6AW34HZigD rQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgrfcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Nov 2021 06:02:22 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 12:02:20 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 15 Nov 2021 12:02:20 +0000
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 82F86B2F;
        Mon, 15 Nov 2021 12:02:20 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: tidy includes in cs_dsp.c and cs_dsp.h
Date:   Mon, 15 Nov 2021 12:02:15 +0000
Message-ID: <20211115120215.56824-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s5wn5ZZwwKNuipaX-mCAvYa6ih8nO0NH
X-Proofpoint-GUID: s5wn5ZZwwKNuipaX-mCAvYa6ih8nO0NH
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused included header files and moves others into
cs_dsp.h to ensure that types referenced in the header file are properly
described to prevent compiler warnings.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 6 ------
 include/linux/firmware/cirrus/cs_dsp.h | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 948dd8382686..1a0c6c793f6a 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -12,16 +12,10 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/firmware.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/workqueue.h>
 
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 9ad9eaaaa552..3a54b1afc48f 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -11,6 +11,11 @@
 #ifndef __CS_DSP_H
 #define __CS_DSP_H
 
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+
 #define CS_ADSP2_REGION_0 BIT(0)
 #define CS_ADSP2_REGION_1 BIT(1)
 #define CS_ADSP2_REGION_2 BIT(2)
-- 
2.33.0

