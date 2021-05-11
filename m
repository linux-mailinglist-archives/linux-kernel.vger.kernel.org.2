Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1137ACDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhEKRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:16:33 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28844 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231561AbhEKRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:16:31 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BGujAW031298;
        Tue, 11 May 2021 12:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=9ndZ4Sg/BsAajmexo+cNarRaAk/nyP1KuR4qQ82WWoc=;
 b=jytKabz/KUqmSDt19EHVc7fkBjNj3tvRx7ZOb27zLFvUBch30jllG+5vyK9CczlRQLlz
 FNexpoDvAttAiUeGQvHAFVbirFPZoJBaFgmVDZISH0UeQ2y5Qm+y8+JoQiNkOevZW20N
 /Abw4yhzK6DegjSPctj+IAZbdG83uaNyuLLPxiCId428CyqPg/yctgdfLbiWyBl+Y87U
 YDwIFiJOimEjR0eVzq5gQrF+GazRQRgLp8czxHY1sEJOA7M25EZzorWIb7jyKRhPtqq7
 mdtSCzbEVYApw6jPJbDERtCCbOTrGQ1KK4VTaobtB26XMu++zsSVTxxMJ952TY42EgVH aA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38f4x19u8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 12:15:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 18:15:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 18:15:15 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.134])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA65211CD;
        Tue, 11 May 2021 17:15:15 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm2200: remove include of wmfw.h
Date:   Tue, 11 May 2021 18:15:14 +0100
Message-ID: <20210511171514.270219-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _cIyhthWNAGhruOFNLJMwSDu5EzkXYky
X-Proofpoint-ORIG-GUID: _cIyhthWNAGhruOFNLJMwSDu5EzkXYky
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=716 clxscore=1015 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want all wm_adsp clients to use the wm_adsp.h header as they
shouldn't need to include internal sub-headers.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm2200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index b0a6d31299bb..c35673e7f420 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -30,7 +30,6 @@
 #include <sound/wm2200.h>
 
 #include "wm2200.h"
-#include "wmfw.h"
 #include "wm_adsp.h"
 
 #define WM2200_DSP_CONTROL_1                   0x00
-- 
2.31.1

