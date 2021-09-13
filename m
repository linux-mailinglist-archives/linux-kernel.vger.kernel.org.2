Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127A140982D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbhIMQCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:02:50 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7766 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343864AbhIMQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:46 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DAEA6N014550;
        Mon, 13 Sep 2021 11:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=kd7HwlHwt18qgeDb7UqgfVXVNIZB6qoOcVxR90CXHl4=;
 b=TSrb4orT8kawL6iscEjgt2X78Omb8ngLxwQ3r9K0BCVAKVXhb0gJ/pdCa+kwU8Bo9Iga
 DZk5bA+mQoTbVpwMG5t1qpWGsOgmGr8GGIPNb5aC1fVhYrq8EQ/D4HFqMpLjM+DhXmpe
 lyqs5HLGAOcs4DSTkSvBLfIXAZwLMZVZAIrJoUQo96++O+aJQfRVINnFa8hEzpmgPKK0
 l1/nNMmAvMt1c8ykp6sJLqNzgG0+d2xhnGrpcYtrz9uiqB82fNyFLMDuMvtODnqqTla1
 d7e3awGkTjQ6anQEchUR5fpN0V/VhJKFqgqJaIpRSI0La+/N4k8vfr1VtFtjkSN0L8C/ EA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b1n5drxkd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:18 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:18 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 756262A9;
        Mon, 13 Sep 2021 16:01:18 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 03/16] ASoC: wm_adsp: Switch to using wm_coeff_read_ctrl for compressed buffers
Date:   Mon, 13 Sep 2021 17:00:44 +0100
Message-ID: <20210913160057.103842-4-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: I3YWvJ4wy9kZkMSc-UklCNoRqb0VAUJ3
X-Proofpoint-ORIG-GUID: I3YWvJ4wy9kZkMSc-UklCNoRqb0VAUJ3
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

When parsing a compressed buffer from the firmware the driver currently
open codes reading the firmware coefficient containing the buffer
description. Improve this slightly by using the coefficient read
functions already provided by the wm_adsp driver. It is worth noting
this change requires the running variable to be set before
wm_adsp_buffer_init is called, however this is safe, since its all still
under the power lock and nothing in the compressed code gates itself on
running.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b300af6fdd41..9c3d4b96fd7c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3277,14 +3277,14 @@ int wm_adsp_event(struct snd_soc_dapm_widget *w,
 				goto err;
 		}
 
+		dsp->running = true;
+
 		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
 			if (ret < 0)
 				goto err;
 		}
 
-		dsp->running = true;
-
 		mutex_unlock(&dsp->pwr_lock);
 		break;
 
@@ -3869,26 +3869,21 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 {
 	struct wm_adsp_host_buf_coeff_v1 coeff_v1;
 	struct wm_adsp_compr_buf *buf;
-	unsigned int reg, version;
-	__be32 bufp;
+	unsigned int version;
 	int ret, i;
 
-	ret = wm_coeff_base_reg(ctl, &reg);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < 5; ++i) {
-		ret = regmap_raw_read(ctl->dsp->regmap, reg, &bufp, sizeof(bufp));
+		ret = wm_coeff_read_ctrl(ctl, &coeff_v1, sizeof(coeff_v1));
 		if (ret < 0)
 			return ret;
 
-		if (bufp)
+		if (coeff_v1.host_buf_ptr)
 			break;
 
 		usleep_range(1000, 2000);
 	}
 
-	if (!bufp) {
+	if (!coeff_v1.host_buf_ptr) {
 		adsp_err(ctl->dsp, "Failed to acquire host buffer\n");
 		return -EIO;
 	}
@@ -3898,7 +3893,7 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 		return -ENOMEM;
 
 	buf->host_buf_mem_type = ctl->alg_region.type;
-	buf->host_buf_ptr = be32_to_cpu(bufp);
+	buf->host_buf_ptr = be32_to_cpu(coeff_v1.host_buf_ptr);
 
 	ret = wm_adsp_buffer_populate(buf);
 	if (ret < 0)
@@ -3913,11 +3908,6 @@ static int wm_adsp_buffer_parse_coeff(struct wm_coeff_ctl *ctl)
 		return 0;
 	}
 
-	ret = regmap_raw_read(ctl->dsp->regmap, reg, &coeff_v1,
-			      sizeof(coeff_v1));
-	if (ret < 0)
-		return ret;
-
 	version = be32_to_cpu(coeff_v1.versions) & HOST_BUF_COEFF_COMPAT_VER_MASK;
 	version >>= HOST_BUF_COEFF_COMPAT_VER_SHIFT;
 
-- 
2.33.0

