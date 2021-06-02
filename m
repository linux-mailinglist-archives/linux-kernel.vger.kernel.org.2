Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86E0397F32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFBCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:50:20 -0400
Received: from m12-18.163.com ([220.181.12.18]:36782 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhFBCuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DM3i/
        sEar+rgTXWuUpWQOQV9DGRjv3jpGVAH42azir8=; b=mT0ED5EyN6g/yVX5zve1h
        tc6GPVOZO9NYtYyT0ffcpB7sjlKGWGGXByOX6dSoHa/9BKrnm01hl54xTwA0bDla
        vqecklzyrfgtW5GADD7QXmiFm4aNSzCys1gZRctnJ/I+NqoFKmwqyp71FjJHgUzS
        TlBldhjwovX+BOKaTlrEow=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowAC3vOR58bZgNm7tmw--.26211S2;
        Wed, 02 Jun 2021 10:48:26 +0800 (CST)
From:   lijian_8010a29@163.com
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: kyro: STG4000OverlayDevice.c: deleted the repeated word
Date:   Wed,  2 Jun 2021 10:47:28 +0800
Message-Id: <20210602024728.74862-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAC3vOR58bZgNm7tmw--.26211S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryxJrW5Zw1kGFWkKry8Krg_yoWfZFX_C3
        9FvF4fWrWkKFy8G3ZxJFnIvr90va9rZFyrWF12q3s3GrZxJ3ySq3yjqr1FgrykGrs8Z3WD
        W3ZFqr18Zrn3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5bVy3UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiHRqlUFSIq--YGAAAs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

deleted the repeated word 'number' in the comments

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 9fde0e3b69ec..7a09178024a6 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -398,7 +398,9 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		ulDecimated =
 		    (ulBits * ulApplied) + Overlap((ulSrc % 32),
 						   ulPattern);
-		ulSrc = ulSrc - ulDecimated;	/* the number number of lines that will go into the scaler */
+
+		/* the number of lines that will go into the scaler */
+		ulSrc = ulSrc - ulDecimated;
 	}
 
 	if (ulBits && (ulBits != 32)) {
-- 
2.25.1


