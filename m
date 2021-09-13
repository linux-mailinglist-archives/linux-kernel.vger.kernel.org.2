Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE1D409837
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbhIMQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:03:26 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59480 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhIMQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:47 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9LD002377;
        Mon, 13 Sep 2021 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tbdHTZRi7Od3F9nMj5YJ7/gwr9t4G1zuAUo0AIFhyww=;
 b=pYVwK4x2IKkDUFg9vKlHUmtcoaKyueEjCGMrjWQfJLckL6xa/KpdX7mrXgvkr9RRMcmg
 qhh+GXSp/yy3p4bzvPg6Q8deenF6B/Tn9UfeCEA/n4tMCYlgrhDXMvqbpqyioRtd07zr
 GugO+nObNxcA7HkzuP58p46FK1HEa5lNzW+zf13pt7Ipv8Ab8wReTFT5H6/bj7LZtdnG
 s9L6dbxTuWm8tFLsU8oXBWnaWDO6dxPcdYqU5pW9TATahKITRlhpi2kC8cFS+TXpLAKC
 JylHvyJHFh6GwQKk0rqnUjHoqS5+rPwc7d9Ya2UO3PkKX9xjRmUMj+qO1dkx+8fXaMvB Ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:21 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 27ECBB16;
        Mon, 13 Sep 2021 16:01:21 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 11/16] ASoC: wm_adsp: Move check of dsp->running to better place
Date:   Mon, 13 Sep 2021 17:00:52 +0100
Message-ID: <20210913160057.103842-12-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YPPGxAXPQ209QJKbTjIL8IeYGVTRTi7e
X-Proofpoint-ORIG-GUID: YPPGxAXPQ209QJKbTjIL8IeYGVTRTi7e
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving the generic DSP support out of ASoC, move
the check of dsp->running to a more appropriate place that will move
to the generic code.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bd335e4240e5..1c8bf818dab9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -976,6 +976,9 @@ static int cs_dsp_coeff_write_acked_control(struct cs_dsp_coeff_ctl *ctl,
 	unsigned int reg;
 	int i, ret;
 
+	if (!dsp->running)
+		return -EPERM;
+
 	ret = cs_dsp_coeff_base_reg(ctl, &reg);
 	if (ret)
 		return ret;
@@ -1129,7 +1132,7 @@ static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
 
 	mutex_lock(&cs_ctl->dsp->pwr_lock);
 
-	if (cs_ctl->enabled && cs_ctl->dsp->running)
+	if (cs_ctl->enabled)
 		ret = cs_dsp_coeff_write_acked_control(cs_ctl, val);
 	else
 		ret = -EPERM;
-- 
2.33.0

