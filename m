Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD51C323558
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 02:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhBXBco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 20:32:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12644 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhBXB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 20:29:58 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DldZM5G9Cz16950;
        Wed, 24 Feb 2021 09:27:23 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Feb 2021 09:28:52 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, Lauri Kasanen <cand@gmx.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sound: n64: Fix return value check in n64audio_probe()
Date:   Wed, 24 Feb 2021 01:38:03 +0000
Message-ID: <20210224013803.2146953-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_platform_ioremap_resource()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Fixes: 1448f8acf4cc ("sound: Add n64 driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/mips/snd-n64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/mips/snd-n64.c b/sound/mips/snd-n64.c
index ca6b4b99da98..e35e93157755 100644
--- a/sound/mips/snd-n64.c
+++ b/sound/mips/snd-n64.c
@@ -312,14 +312,14 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	}
 
 	priv->mi_reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!priv->mi_reg_base) {
-		err = -EINVAL;
+	if (IS_ERR(priv->mi_reg_base)) {
+		err = PTR_ERR(priv->mi_reg_base);
 		goto fail_dma_alloc;
 	}
 
 	priv->ai_reg_base = devm_platform_ioremap_resource(pdev, 1);
-	if (!priv->ai_reg_base) {
-		err = -EINVAL;
+	if (IS_ERR(priv->ai_reg_base)) {
+		err = PTR_ERR(priv->ai_reg_base);
 		goto fail_dma_alloc;
 	}
 

