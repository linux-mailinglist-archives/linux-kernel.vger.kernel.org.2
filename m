Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81A93804E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhENIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:12:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2660 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhENIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:12:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhLjy6nhKzQnLT;
        Fri, 14 May 2021 16:07:50 +0800 (CST)
Received: from localhost (10.174.179.215) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 16:11:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: soc-core: use DEVICE_ATTR_RO macro
Date:   Fri, 14 May 2021 16:11:00 +0800
Message-ID: <20210514081100.16196-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1c0904acb935..2d969e31f37d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -75,9 +75,9 @@ static ssize_t pmdown_time_show(struct device *dev,
 	return sprintf(buf, "%ld\n", rtd->pmdown_time);
 }
 
-static ssize_t pmdown_time_set(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t pmdown_time_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
 	int ret;
@@ -89,7 +89,7 @@ static ssize_t pmdown_time_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(pmdown_time, 0644, pmdown_time_show, pmdown_time_set);
+static DEVICE_ATTR_RW(pmdown_time);
 
 static struct attribute *soc_dev_attrs[] = {
 	&dev_attr_pmdown_time.attr,
-- 
2.17.1

