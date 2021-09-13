Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039AA409834
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbhIMQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:03:10 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61487 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343907AbhIMQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:46 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9L9002377;
        Mon, 13 Sep 2021 11:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=gAi6bsx98UZU8FZXLBW0SVx/jzJTeMZYBy0/3ptxLfc=;
 b=oKSrgmgcBIa/9DkNtAHwKS1tZBAcCbeaNFLfLiNmT2mudasV26PCLjK/0jhL+nY9oN2s
 9/ECf2pDXCBOrI9SHWqU8pGaThG2Ii8aySGTZCnWhu0UpvGYEQDwSUq8mPtDbXSW0pqQ
 ww4W7fZfGJJW+jZvlyIFh6P4VX5g2aHcgY3HfDDDg8SnahxwCDtn9iSoAjVBSRNX+Wdi
 86ERD2ZmDTXrfHJOOCQxG3zNn8+PbHhY7SSO6rsFizvhoMjaoOcyOs5cB3wtjHaS9ZeC
 isFxevrqILxLZ1P/Q+3ny7yFB3XgMoEX3Fufb2o3wG0VJpycibKiJhdwdgHo2jDCRe7q Xw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-3
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B6357B2F;
        Mon, 13 Sep 2021 16:01:18 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 04/16] ASoC: wm_adsp: Cancel ongoing work when removing controls
Date:   Mon, 13 Sep 2021 17:00:45 +0100
Message-ID: <20210913160057.103842-5-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9-IliWsje6IfdbC7PSjKOs1BrOHTRnfr
X-Proofpoint-ORIG-GUID: 9-IliWsje6IfdbC7PSjKOs1BrOHTRnfr
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes wm_adsp_ctl_work and integrates the work_struct into
wm_coeff_ctl so it may be referenced.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9c3d4b96fd7c..c1b5ea3b5718 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -613,6 +613,7 @@ struct wm_coeff_ctl {
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
 	unsigned int type;
+	struct work_struct work;
 };
 
 static const char *wm_adsp_mem_region_name(unsigned int type)
@@ -1240,12 +1241,6 @@ static int wm_coeff_get_acked(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-struct wmfw_ctl_work {
-	struct wm_adsp *dsp;
-	struct wm_coeff_ctl *ctl;
-	struct work_struct work;
-};
-
 static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
 {
 	unsigned int out, rd, wr, vol;
@@ -1394,16 +1389,17 @@ static void wm_adsp_signal_event_controls(struct wm_adsp *dsp,
 
 static void wm_adsp_ctl_work(struct work_struct *work)
 {
-	struct wmfw_ctl_work *ctl_work = container_of(work,
-						      struct wmfw_ctl_work,
-						      work);
+	struct wm_coeff_ctl *ctl = container_of(work,
+						struct wm_coeff_ctl,
+						work);
 
-	wmfw_add_ctl(ctl_work->dsp, ctl_work->ctl);
-	kfree(ctl_work);
+	wmfw_add_ctl(ctl->dsp, ctl);
 }
 
 static void wm_adsp_free_ctl_blk(struct wm_coeff_ctl *ctl)
 {
+	cancel_work_sync(&ctl->work);
+
 	kfree(ctl->cache);
 	kfree(ctl->name);
 	kfree(ctl->subname);
@@ -1417,7 +1413,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  unsigned int flags, unsigned int type)
 {
 	struct wm_coeff_ctl *ctl;
-	struct wmfw_ctl_work *ctl_work;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	const char *region_name;
 	int ret;
@@ -1513,22 +1508,11 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	if (flags & WMFW_CTL_FLAG_SYS)
 		return 0;
 
-	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
-	if (!ctl_work) {
-		ret = -ENOMEM;
-		goto err_list_del;
-	}
-
-	ctl_work->dsp = dsp;
-	ctl_work->ctl = ctl;
-	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
-	schedule_work(&ctl_work->work);
+	INIT_WORK(&ctl->work, wm_adsp_ctl_work);
+	schedule_work(&ctl->work);
 
 	return 0;
 
-err_list_del:
-	list_del(&ctl->list);
-	kfree(ctl->cache);
 err_ctl_subname:
 	kfree(ctl->subname);
 err_ctl_name:
-- 
2.33.0

