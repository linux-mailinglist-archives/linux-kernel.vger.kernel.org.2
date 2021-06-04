Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5E39B08C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFDCpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:45:16 -0400
Received: from m12-18.163.com ([220.181.12.18]:34603 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhFDCpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UVtAZ
        8h2YkctkjoN+6UQX95BaLWOCITm2n0BN3XeiFU=; b=cKU2U2bmJabJ3tJTsAwpA
        Rzr963KxE7x0N+KMTvsStAFBsS5XHpiST2CrWgNMrQjmFxYvozOjFNhBOD4GQLGQ
        cPSMwRSmc3O6lhkHIRxwdPd/0MtwWRDbjDYLiXyryOmi+60ymhYxXiGG5JpXMTEb
        2Xx8GVzgpnlN5f3Z3DZAys=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowADX2PYxk7lg7Bt0nQ--.55308S2;
        Fri, 04 Jun 2021 10:42:58 +0800 (CST)
From:   lijian_8010a29@163.com
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: cyber2000fb: Removed unnecessary 'return'
Date:   Fri,  4 Jun 2021 10:41:59 +0800
Message-Id: <20210604024159.91666-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADX2PYxk7lg7Bt0nQ--.55308S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxGrW3CF4rCFWUZF17Awb_yoWxAwc_Cw
        4S9r97GryDCr4SvF1ktw42yFy8tF4DZr97ZFnFvr95Cry3C34rXryUX34jgrWUJrWUXanr
        W3ZrWF40yr1rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5niSJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiLxKnUFUMYzi4vwAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

Removed unnecessary 'return' in void functions.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/cyber2000fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index d45355b9a58c..ee17e7fa8f4b 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -231,7 +231,6 @@ static void
 cyber2000fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	cfb_imageblit(info, image);
-	return;
 }
 
 static int cyber2000fb_sync(struct fb_info *info)
-- 
2.25.1


