Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3A409832
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbhIMQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:03:03 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46122 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241149AbhIMQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:46 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DAEA6P014550;
        Mon, 13 Sep 2021 11:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=+1NyDGIefTKtV7GKKWali3tAZDM5tSn5uBEq25JwtI4=;
 b=awM3qDCXc8SunP4jyt4uh8t4tvduuOtIhg8h/C3x+8IXJgcx+QtDOcvtoSbHZwx0r9Fe
 DlfrmSd0ysdTIuNuhhbeSFKKx/Qt6gSkcKKLyJTxULdx5LCGxyJpmm7/y2vE3gNylfbS
 8TVf9exQ8q3Z4oGGxDnEjGUMkQp9NquXNRmZ1XrPAcveBLojOYZfeAvmYwwqoDWlBlHJ
 WA0Nugw7JTw80RGdSZRoGLEVPAOE5XhytLj8o5JQMNcAbngVYD4Yft0jLnvoJ8DoPlFp
 XHYl8AbIsmu7ulBGHGGAes3DKuALmDvhf+3CQwx1Bz1Nhv/CiQBN2uV9V1SzUCxEBwQu Gw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b1n5drxkd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:20 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87FD22A9;
        Mon, 13 Sep 2021 16:01:20 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 09/16] ASoC: wm_adsp: Move sys_config_size to wm_adsp
Date:   Mon, 13 Sep 2021 17:00:50 +0100
Message-ID: <20210913160057.103842-10-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IlkRT3F61XeeoV7lno96EhsdbC4IFea5
X-Proofpoint-ORIG-GUID: IlkRT3F61XeeoV7lno96EhsdbC4IFea5
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

sys_config_size is part of the compressed stream support, move it from
what will become generic DSP code so that it remains in ASoC.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 10 +++++-----
 sound/soc/codecs/wm_adsp.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1bca3922a6b8..82038cac4286 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3467,6 +3467,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	INIT_WORK(&dsp->boot_work, wm_adsp_boot_work);
 
+	dsp->sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr);
+
 	wm_adsp_common_init(dsp);
 
 	return cs_dsp_adsp2_init(dsp);
@@ -3484,6 +3486,8 @@ int wm_halo_init(struct wm_adsp *dsp)
 {
 	INIT_WORK(&dsp->boot_work, wm_adsp_boot_work);
 
+	dsp->sys_config_size = sizeof(struct wm_halo_system_config_xm_hdr);
+
 	wm_adsp_common_init(dsp);
 
 	return cs_dsp_halo_init(dsp);
@@ -3895,7 +3899,7 @@ static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 	if (!buf)
 		return -ENOMEM;
 
-	xmalg = dsp->ops->sys_config_size / sizeof(__be32);
+	xmalg = dsp->sys_config_size / sizeof(__be32);
 
 	addr = alg_region->base + xmalg + ALG_XM_FIELD(magic);
 	ret = cs_dsp_read_data_word(dsp, WMFW_ADSP2_XM, addr, &magic);
@@ -4588,7 +4592,6 @@ static const struct cs_dsp_ops cs_dsp_adsp1_ops = {
 
 static const struct cs_dsp_ops cs_dsp_adsp2_ops[] = {
 	{
-		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = cs_dsp_adsp2_parse_sizes,
 		.validate_version = cs_dsp_validate_version,
 		.setup_algs = cs_dsp_adsp2_setup_algs,
@@ -4607,7 +4610,6 @@ static const struct cs_dsp_ops cs_dsp_adsp2_ops[] = {
 
 	},
 	{
-		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = cs_dsp_adsp2_parse_sizes,
 		.validate_version = cs_dsp_validate_version,
 		.setup_algs = cs_dsp_adsp2_setup_algs,
@@ -4626,7 +4628,6 @@ static const struct cs_dsp_ops cs_dsp_adsp2_ops[] = {
 		.stop_core = cs_dsp_adsp2_stop_core,
 	},
 	{
-		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = cs_dsp_adsp2_parse_sizes,
 		.validate_version = cs_dsp_validate_version,
 		.setup_algs = cs_dsp_adsp2_setup_algs,
@@ -4648,7 +4649,6 @@ static const struct cs_dsp_ops cs_dsp_adsp2_ops[] = {
 };
 
 static const struct cs_dsp_ops cs_dsp_halo_ops = {
-	.sys_config_size = sizeof(struct wm_halo_system_config_xm_hdr),
 	.parse_sizes = cs_dsp_adsp2_parse_sizes,
 	.validate_version = cs_dsp_halo_validate_version,
 	.setup_algs = cs_dsp_halo_setup_algs,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 114bc41981ef..98b12b485916 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -81,6 +81,8 @@ struct wm_adsp {
 	const struct cs_dsp_region *mem;
 	int num_mems;
 
+	unsigned int sys_config_size;
+
 	int fw;
 	int fw_ver;
 
@@ -109,8 +111,6 @@ struct wm_adsp {
 };
 
 struct cs_dsp_ops {
-	unsigned int sys_config_size;
-
 	bool (*validate_version)(struct wm_adsp *dsp, unsigned int version);
 	unsigned int (*parse_sizes)(struct wm_adsp *dsp,
 				    const char * const file,
-- 
2.33.0

