Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96455397F72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 05:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhFBD1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 23:27:37 -0400
Received: from m12-16.163.com ([220.181.12.16]:58171 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhFBD1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hCjNx
        bHkM7idDtVYQL2Q4f8U61IqG0gepdecr463U5U=; b=S4qRZUn8nSOGPmxQ0Nugq
        H6nwe8dTK5MEX9MBMAqZXiuuDfFX+pLQHr1dvfqrVPrvcLMcFxxRsuJ0Ljtf/RCW
        hKl4+LT8Fr66YZ4ISIPYAWuDn+MapflAGGen2cPshvAMUoi/8KxSXQl352cNYhu8
        lDSMGwe4Io5S0ntMk5Myok=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAA3PBg8+rZgOTXqug--.28168S2;
        Wed, 02 Jun 2021 11:25:49 +0800 (CST)
From:   lijian_8010a29@163.com
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: kyro: STG4000OverlayDevice.c: Fix a typo
Date:   Wed,  2 Jun 2021 11:24:50 +0800
Message-Id: <20210602032450.90703-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAA3PBg8+rZgOTXqug--.28168S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4DWrWUur4rKr1rAF1fJFb_yoW3KFg_Cw
        1IvFsxX3y8GFW0g3ZxJry3ZryYvFWUZr95WF1qqas5Xry3X393Xw4jvr18KrnYqrZxu3Zr
        WFsFqr4rA3yfKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnu6wJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBER2lUFaEEj9bzwAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'thses' to 'these'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 7a09178024a6..46f17020c8cd 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -60,7 +60,10 @@ typedef struct _OVRL_SRC_DEST {
 	u32 ulDstX2;
 	u32 ulDstY2;
 
-	/*clipped pixel pos of source data within buffer thses need to be 128 bit word aligned */
+	/*
+	 * clipped pixel pos of source data within buffer
+	 * these need to be 128 bit word aligned
+	 */
 	u32 ulSrcX1;
 	u32 ulSrcY1;
 	u32 ulSrcX2;
-- 
2.25.1


