Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499738E594
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhEXLmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:42:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3647 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhEXLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:42:08 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZtm1CDYzNydt;
        Mon, 24 May 2021 19:37:04 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:40:39 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:40:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cs43130: Use DEVICE_ATTR_RO macro
Date:   Mon, 24 May 2021 19:40:17 +0800
Message-ID: <20210524114017.18672-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cs43130.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index de7fa3e4bfbb..44b20c1ef851 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1672,14 +1672,14 @@ static int cs43130_show_dc(struct device *dev, char *buf, u8 ch)
 				 cs43130->hpload_dc[ch]);
 }
 
-static ssize_t cs43130_show_dc_l(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_dc_l_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_dc(dev, buf, HP_LEFT);
 }
 
-static ssize_t cs43130_show_dc_r(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_dc_r_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
@@ -1719,22 +1719,22 @@ static int cs43130_show_ac(struct device *dev, char *buf, u8 ch)
 	}
 }
 
-static ssize_t cs43130_show_ac_l(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_ac_l_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_ac(dev, buf, HP_LEFT);
 }
 
-static ssize_t cs43130_show_ac_r(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_ac_r_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_ac(dev, buf, HP_RIGHT);
 }
 
-static DEVICE_ATTR(hpload_dc_l, 0444, cs43130_show_dc_l, NULL);
-static DEVICE_ATTR(hpload_dc_r, 0444, cs43130_show_dc_r, NULL);
-static DEVICE_ATTR(hpload_ac_l, 0444, cs43130_show_ac_l, NULL);
-static DEVICE_ATTR(hpload_ac_r, 0444, cs43130_show_ac_r, NULL);
+static DEVICE_ATTR_RO(hpload_dc_l);
+static DEVICE_ATTR_RO(hpload_dc_r);
+static DEVICE_ATTR_RO(hpload_ac_l);
+static DEVICE_ATTR_RO(hpload_ac_r);
 
 static struct attribute *hpload_attrs[] = {
 	&dev_attr_hpload_dc_l.attr,
-- 
2.17.1

