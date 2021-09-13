Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98F409831
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbhIMQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:03:01 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:64462 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343617AbhIMQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:44 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9L8002377;
        Mon, 13 Sep 2021 11:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/0zRk4bgJkrH0dwJlv8Bv+YE3XNYKWjZnfXNPmvVpXU=;
 b=EtT7p3xHNLUv6yuoWJALg3dceD6UUfZW070SFQroxEWJ0tbJCtbvw89RHhtrr0+6zL4T
 lRtxZNSlzsQCwI6Dz1lsep4sqAkh2StueVnsW43kz1D9GvqR5/+dHiS5y9zSSU0Sm51T
 8gNcek+eXPO/+eyITLH8y+89NpK0TIUF8QjGp8PSazUvfJNYcBh2luF1GVI8DS/XZdIc
 Uz4KF1ujH41MPzavCax5aMfI5adIdrGbBdw9eF5whS7Lm2v8ONsM7s1nmGgXG/liGMt7
 P294IPOVpBLWGPLAl3q35ZKQ3eXSeR3ImOwZHTdE6z3XTt/FI2grXFq+mGTw9U/l2i3C Ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:18 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:18 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 39D6FB2F;
        Mon, 13 Sep 2021 16:01:18 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 02/16] ASoC: wm_adsp: Move check for control existence
Date:   Mon, 13 Sep 2021 17:00:43 +0100
Message-ID: <20210913160057.103842-3-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1YorRL9b9FhBxuapBYSWayCZRnnG7Z6l
X-Proofpoint-ORIG-GUID: 1YorRL9b9FhBxuapBYSWayCZRnnG7Z6l
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Checking earlier in the function if a control already exists avoids
superfluous string construction and also prepares for future
refactoring.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f5db6e3b9f60..b300af6fdd41 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1422,6 +1422,19 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	const char *region_name;
 	int ret;
 
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		    ctl->alg_region.alg == alg_region->alg &&
+		    ctl->alg_region.type == alg_region->type) {
+			if ((!subname && !ctl->subname) ||
+			    (subname && !strncmp(ctl->subname, subname, ctl->subname_len))) {
+				if (!ctl->enabled)
+					ctl->enabled = 1;
+				return 0;
+			}
+		}
+	}
+
 	region_name = wm_adsp_mem_region_name(alg_region->type);
 	if (!region_name) {
 		adsp_err(dsp, "Unknown region type: %d\n", alg_region->type);
@@ -1462,14 +1475,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 			 " %.*s", subname_len - skip, subname + skip);
 	}
 
-	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (!strcmp(ctl->name, name)) {
-			if (!ctl->enabled)
-				ctl->enabled = 1;
-			return 0;
-		}
-	}
-
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
 		return -ENOMEM;
-- 
2.33.0

