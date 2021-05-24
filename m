Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953738E612
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhEXMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:02:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5757 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhEXMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:02:06 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpbKp1095zmkh2;
        Mon, 24 May 2021 19:57:02 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:00:29 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 20:00:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: pcm: use DEVICE_ATTR_RO macro
Date:   Mon, 24 May 2021 20:00:07 +0800
Message-ID: <20210524120007.39728-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index b163164a83ec..6fd3677685d7 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1004,7 +1004,7 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	substream->pstr->substream_opened--;
 }
 
-static ssize_t show_pcm_class(struct device *dev,
+static ssize_t pcm_class_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct snd_pcm_str *pstr = container_of(dev, struct snd_pcm_str, dev);
@@ -1024,7 +1024,7 @@ static ssize_t show_pcm_class(struct device *dev,
 	return sprintf(buf, "%s\n", str);
 }
 
-static DEVICE_ATTR(pcm_class, 0444, show_pcm_class, NULL);
+static DEVICE_ATTR_RO(pcm_class);
 static struct attribute *pcm_dev_attrs[] = {
 	&dev_attr_pcm_class.attr,
 	NULL
-- 
2.17.1

