Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3104384E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJWT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:26:53 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:54587 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhJWT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:26:51 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id eMcymCjNuTdRTeMczmKM3J; Sat, 23 Oct 2021 21:24:29 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Oct 2021 21:24:29 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] coresight: Use devm_bitmap_zalloc when applicable
Date:   Sat, 23 Oct 2021 21:24:22 +0200
Message-Id: <e5fe23370794e2f5442e11e7f8455ddb06e4b10a.1635016943.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'drvdata->chs.guaranteed' is a bitmap. So use 'devm_bitmap_kzalloc()' to
simplify code, improve the semantic and avoid some open-coded arithmetic
in allocator arguments.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwtracing/coresight/coresight-stm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 58062a5a8238..db9eada24275 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -862,7 +862,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct stm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct resource ch_res;
-	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 
 	desc.name = coresight_alloc_device_name(&stm_devs, dev);
@@ -904,9 +903,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	else
 		drvdata->numsp = stm_num_stimulus_port(drvdata);
 
-	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
-
-	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
+	guaranteed = devm_bitmap_zalloc(dev, drvdata->numsp, GFP_KERNEL);
 	if (!guaranteed)
 		return -ENOMEM;
 	drvdata->chs.guaranteed = guaranteed;
-- 
2.30.2

