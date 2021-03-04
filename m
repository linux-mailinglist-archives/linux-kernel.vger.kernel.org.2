Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED7C32D9F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhCDTDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:03:50 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:23372 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236242AbhCDTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:03:41 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124J2BKB016395;
        Thu, 4 Mar 2021 13:02:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ZEQD75MSzh+ZhgpO7KjMll57Fo8bXKYznJcXEyOmr0w=;
 b=f3Z2eMzaVquIaZvLwkPLDTNF0ebigGfNt3lnLX5oFeJGkxR2/EJNAbsqM/MIZbQq6As6
 GSYLl2DgPKtSwlBuNM22Ka9G4gpdK8wbBc6GdEmQkBAWlM7/5cAR54vUFU+5WZUoQ+m+
 ELyNkrIaogDTqHqcu4gtuUUvHI5uoyBfcT4edhVl2RLpy/wp7tC0vj3rht9t785dnC5g
 gZcbD5k0ritexGT87a+hL3QXrCMqLwlSxWS1CsXyUVpk1eRkdl7eJQ+ux7Lg4bctnvzO
 a5Vy4qZfxfCTEgBpUUr9K3llJfBArSqXZ3rWeC8dXuPwx/nWBVNjFnhYiVhOT+eL1Iu+ lQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6y4vx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Mar 2021 13:02:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 4 Mar 2021
 19:02:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 4 Mar 2021 19:02:42 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BC3011D5;
        Thu,  4 Mar 2021 19:02:42 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] ALSA: hda/cirrus: Increase AUTO_CFG_MAX_INS from 8 to 18
Date:   Thu, 4 Mar 2021 19:02:38 +0000
Message-ID: <20210304190241.5363-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304190241.5363-1-vitalyr@opensource.cirrus.com>
References: <20210304190241.5363-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support Cirrus Logic CS8409 HDA bridge on new Dell platforms
it is nessasary to increase AUTO_CFG_MAX_INS and AUTO_CFG_NUM_INPUTS values.
Currently AUTO_CFG_MAX_INS is limited to 8, but Cirrus Logic HDA bridge CS8409
has 18 input pins, 16 ASP receivers and 2 DMIC inputs. We have to increase this
value to 18, so generic code can handle this correctly.

Tested on DELL Inspiron-3505, DELL Inspiron-3501, DELL Inspiron-3500

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/hda_auto_parser.h | 2 +-
 sound/pci/hda/hda_local.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index a22ca0e17a08..df63d66af1ab 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -27,7 +27,7 @@ enum {
 };
 
 #define AUTO_CFG_MAX_OUTS	HDA_MAX_OUTS
-#define AUTO_CFG_MAX_INS	8
+#define AUTO_CFG_MAX_INS	18
 
 struct auto_pin_cfg_item {
 	hda_nid_t pin;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 5beb8aa44ecd..317245a5585d 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -180,7 +180,7 @@ int snd_hda_create_spdif_in_ctls(struct hda_codec *codec, hda_nid_t nid);
 /*
  * input MUX helper
  */
-#define HDA_MAX_NUM_INPUTS	16
+#define HDA_MAX_NUM_INPUTS	36
 struct hda_input_mux_item {
 	char label[32];
 	unsigned int index;
-- 
2.25.1

