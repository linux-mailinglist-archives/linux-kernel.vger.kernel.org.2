Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6773191AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhBKR4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:56:49 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50686 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232333AbhBKRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:22:02 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BHAumQ021507;
        Thu, 11 Feb 2021 11:21:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=fTvHwRBe2cQ/2tIZhu94EvsrE2z9b4Azi0/gslh0SB4=;
 b=mWCSwAIVynj/+AJI0sgxLYyXw4XM5eWp2VxpZ41oo9lOA1wNQMVTAtdyKTv7dPRgywvh
 c+nPEC24EZf2oS0/0d8RIyeTX5AnK9HsRiHGovWX/PcR+Tb6kem4awhA6G6Y9WgEqH6j
 FT8s5eMGtit+TCUFLuXPqCWAB0Xr+z/tEvuRb0TFbHeBAFDIpyXum4ZrL0/v+dmzT9y3
 bvMX0qgU5mezn5W+YNkXP3AHJrrqSr3K1MhPUBoVf9mJ3DW/B79zd9cr02XV1RUUYahW
 DIv8flvIn3hvoschYoWoYM3HINcEd54DQfXh2hwXljbsoNLNeALd/4QmVN3w/Z9spYTN zQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36jdacdyqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Feb 2021 11:21:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 11 Feb
 2021 17:21:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 11 Feb 2021 17:21:06 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9BACA11CF;
        Thu, 11 Feb 2021 17:21:06 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Remove unused control callback structure
Date:   Thu, 11 Feb 2021 17:21:06 +0000
Message-ID: <20210211172106.16258-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=895 phishscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This callback structure has never been used and it is not clear why it
was added in the first place. Remove it to clear up the code a little.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 262c2db4f81ce..070ca7d8c6610 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -595,13 +595,6 @@ static const struct {
 	[WM_ADSP_FW_MISC] =     { .file = "misc" },
 };
 
-struct wm_coeff_ctl_ops {
-	int (*xget)(struct snd_kcontrol *kcontrol,
-		    struct snd_ctl_elem_value *ucontrol);
-	int (*xput)(struct snd_kcontrol *kcontrol,
-		    struct snd_ctl_elem_value *ucontrol);
-};
-
 struct wm_coeff_ctl {
 	const char *name;
 	const char *fw_name;
@@ -609,7 +602,6 @@ struct wm_coeff_ctl {
 	const char *subname;
 	unsigned int subname_len;
 	struct wm_adsp_alg_region alg_region;
-	struct wm_coeff_ctl_ops ops;
 	struct wm_adsp *dsp;
 	unsigned int enabled:1;
 	struct list_head list;
@@ -1497,8 +1489,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	}
 	ctl->enabled = 1;
 	ctl->set = 0;
-	ctl->ops.xget = wm_coeff_get;
-	ctl->ops.xput = wm_coeff_put;
 	ctl->dsp = dsp;
 
 	ctl->flags = flags;
-- 
2.11.0

