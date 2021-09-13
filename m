Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A23409836
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbhIMQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:03:18 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47763 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242656AbhIMQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:46 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9L7002377;
        Mon, 13 Sep 2021 11:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4hujD0as6PE7JW9wxaLjFdQN2Foy7imiDuhLgdtvlSU=;
 b=OzfTEO6iYhOfNu60Pvifjktt/LxAp5wxmGdujLuz7NVTivXaUmSBuybNODobvs5NZOvO
 U5yK2NFm/sszKuQoY8tqbRGMFXaEKv1lx9zI+GOdn6qkYIbp+2rJW3nUpV9l6BVlQJ09
 gAF0t5kFbnBEMTv2Rye1M/rHlxsVZC4SwkL6dDesqVODxP39zWyPOdYUCoaTQtjvHyl/
 Zrl3vd4yCDgnVZGn8scOufF+Qdyg2VCa8KwfOvv4MatT7OSXB1WOrK9bg9FPdixA1SEH
 ZZyimdSSkne2WLFkDqbaKi0Wzhn5i53/a99nTXrPY1YN1JaYpyFIIQVEYMMj7BkI3/Aj XA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:18 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:18 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F0745B16;
        Mon, 13 Sep 2021 16:01:17 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 01/16] ASoC: wm_adsp: Remove use of snd_ctl_elem_type_t
Date:   Mon, 13 Sep 2021 17:00:42 +0100
Message-ID: <20210913160057.103842-2-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CqN98IxadS7lUkEXID833BnMb0qzhza-
X-Proofpoint-ORIG-GUID: CqN98IxadS7lUkEXID833BnMb0qzhza-
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving the generic DSP support out of ASoC, remove
the use of the ALSA specific types for the control type. The use of an
ALSA type was unnecessary, the simplified code is easier to read and
avoids Sparse warnings.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 24 +++++++++++-------------
 sound/soc/codecs/wmfw.h    |  8 +++++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f7c800927cb2..f5db6e3b9f60 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -612,7 +612,7 @@ struct wm_coeff_ctl {
 	unsigned int set:1;
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
-	snd_ctl_elem_type_t type;
+	unsigned int type;
 };
 
 static const char *wm_adsp_mem_region_name(unsigned int type)
@@ -1414,7 +1414,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
 				  const char *subname, unsigned int subname_len,
-				  unsigned int flags, snd_ctl_elem_type_t type)
+				  unsigned int flags, unsigned int type)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -1546,7 +1546,7 @@ struct wm_coeff_parsed_coeff {
 	int mem_type;
 	const u8 *name;
 	int name_len;
-	snd_ctl_elem_type_t ctl_type;
+	unsigned int ctl_type;
 	int flags;
 	int len;
 };
@@ -1641,7 +1641,7 @@ static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
 		blk->mem_type = le16_to_cpu(raw->hdr.type);
 		blk->name = raw->name;
 		blk->name_len = strlen(raw->name);
-		blk->ctl_type = (__force snd_ctl_elem_type_t)le16_to_cpu(raw->ctl_type);
+		blk->ctl_type = le16_to_cpu(raw->ctl_type);
 		blk->flags = le16_to_cpu(raw->flags);
 		blk->len = le32_to_cpu(raw->len);
 		break;
@@ -1654,9 +1654,7 @@ static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
 						      &blk->name);
 		wm_coeff_parse_string(sizeof(u8), &tmp, NULL);
 		wm_coeff_parse_string(sizeof(u16), &tmp, NULL);
-		blk->ctl_type =
-			(__force snd_ctl_elem_type_t)wm_coeff_parse_int(sizeof(raw->ctl_type),
-									&tmp);
+		blk->ctl_type = wm_coeff_parse_int(sizeof(raw->ctl_type), &tmp);
 		blk->flags = wm_coeff_parse_int(sizeof(raw->flags), &tmp);
 		blk->len = wm_coeff_parse_int(sizeof(raw->len), &tmp);
 
@@ -1701,7 +1699,7 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 		wm_coeff_parse_coeff(dsp, &data, &coeff_blk);
 
 		switch (coeff_blk.ctl_type) {
-		case SNDRV_CTL_ELEM_TYPE_BYTES:
+		case WMFW_CTL_TYPE_BYTES:
 			break;
 		case WMFW_CTL_TYPE_ACKED:
 			if (coeff_blk.flags & WMFW_CTL_FLAG_SYS)
@@ -2322,7 +2320,7 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
 						     len, NULL, 0, 0,
-						     SNDRV_CTL_ELEM_TYPE_BYTES);
+						     WMFW_CTL_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -2343,7 +2341,7 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
 						     len, NULL, 0, 0,
-						     SNDRV_CTL_ELEM_TYPE_BYTES);
+						     WMFW_CTL_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -2430,7 +2428,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
 						     len, NULL, 0, 0,
-						     SNDRV_CTL_ELEM_TYPE_BYTES);
+						     WMFW_CTL_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -2451,7 +2449,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
 						     len, NULL, 0, 0,
-						     SNDRV_CTL_ELEM_TYPE_BYTES);
+						     WMFW_CTL_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -2472,7 +2470,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
 						     len, NULL, 0, 0,
-						     SNDRV_CTL_ELEM_TYPE_BYTES);
+						     WMFW_CTL_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index f3d51602f85c..a19bf7c6fc8b 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -23,10 +23,12 @@
 #define WMFW_CTL_FLAG_WRITEABLE   0x0002
 #define WMFW_CTL_FLAG_READABLE    0x0001
 
+#define WMFW_CTL_TYPE_BYTES       0x0004 /* byte control */
+
 /* Non-ALSA coefficient types start at 0x1000 */
-#define WMFW_CTL_TYPE_ACKED       ((__force snd_ctl_elem_type_t)0x1000) /* acked control */
-#define WMFW_CTL_TYPE_HOSTEVENT   ((__force snd_ctl_elem_type_t)0x1001) /* event control */
-#define WMFW_CTL_TYPE_HOST_BUFFER ((__force snd_ctl_elem_type_t)0x1002) /* host buffer pointer */
+#define WMFW_CTL_TYPE_ACKED       0x1000 /* acked control */
+#define WMFW_CTL_TYPE_HOSTEVENT   0x1001 /* event control */
+#define WMFW_CTL_TYPE_HOST_BUFFER 0x1002 /* host buffer pointer */
 
 struct wmfw_header {
 	char magic[4];
-- 
2.33.0

