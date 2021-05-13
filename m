Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DA637F8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhEMNii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:38:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2589 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhEMNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:38:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fgt1Z717pzsRGm;
        Thu, 13 May 2021 21:34:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:37:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <alexander.shishkin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] intel_th: sth: Remove unnecessary return value
Date:   Thu, 13 May 2021 21:37:04 +0800
Message-ID: <1620913024-57219-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

intel_th_sw_init() always return true, it's unnecessary to keep
the return value.

Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/intel_th/sth.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/intel_th/sth.c b/drivers/hwtracing/intel_th/sth.c
index 9ca8c4e..5d4effd 100644
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -164,7 +164,7 @@ static int sth_stm_link(struct stm_data *stm_data, unsigned int master,
 	return intel_th_set_output(to_intel_th_device(sth->dev), master);
 }
 
-static int intel_th_sw_init(struct sth_device *sth)
+static void intel_th_sw_init(struct sth_device *sth)
 {
 	u32 reg;
 
@@ -179,8 +179,6 @@ static int intel_th_sw_init(struct sth_device *sth)
 	dev_dbg(sth->dev, "sw_start: %x sw_end: %x masters: %x nchannels: %x\n",
 		sth->stm.sw_start, sth->stm.sw_end, sth->sw_nmasters,
 		sth->stm.sw_nchannels);
-
-	return 0;
 }
 
 static int intel_th_sth_probe(struct intel_th_device *thdev)
@@ -221,9 +219,7 @@ static int intel_th_sth_probe(struct intel_th_device *thdev)
 	sth->stm.sw_mmiosz = sizeof(struct intel_th_channel);
 	sth->stm.link = sth_stm_link;
 
-	err = intel_th_sw_init(sth);
-	if (err)
-		return err;
+	intel_th_sw_init(sth);
 
 	err = stm_register_device(dev, &sth->stm, THIS_MODULE);
 	if (err) {
-- 
2.8.1

