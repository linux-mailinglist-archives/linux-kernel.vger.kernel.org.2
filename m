Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB7368ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbhDWIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:30:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56701 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhDWIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:30:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619166603; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YJmp3KTVyg/N0JFsqZLRvQhVZo3nvDVf1sjqFDE5mHo=; b=jdpPOgdPvefRxTo/pax8L9MnqZUhxoiBYeUlz2WCFUh3L9JO3TTJBD/DAopgo7b5hMR0xO/c
 X6Qk5/xVYAISOsfFCQQ/WvEgHMAjLfZpTkxheZyB3XQNPcDmXpmI+i0JUKbaQjUUEpTvyjjY
 57f2UkjMuD8EL6RS4VeWFPOVdMo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60828582a817abd39aa7e299 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Apr 2021 08:29:54
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BEB4AC4338A; Fri, 23 Apr 2021 08:29:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68C93C433F1;
        Fri, 23 Apr 2021 08:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68C93C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=taozha@codeaurora.org
From:   Tao Zhang <taozha@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tao Zhang <taozha@codeaurora.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: [PATCH v1] coresight: add node to reset all coresight devices
Date:   Fri, 23 Apr 2021 16:29:38 +0800
Message-Id: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new reset_source_sink node to be able to disable all active
coresight devices.
In this way, we no longer need to manually disable all active
coresight devices one by one. After enabling multiple coresight
paths, users can reset their status more conveniently by this
node.

This patch base on coresight-next repo
http://git.linaro.org/kernel/coresight.git/log/?h=next

And this patch depends on the following patch
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2551216.html

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
Signed-off-by: Tao Zhang <taozha@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 72 ++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 7dfadb6..0001b6c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -107,6 +107,23 @@ static int coresight_source_is_unique(struct coresight_device *csdev)
 				 csdev, coresight_id_match);
 }
 
+static int coresight_reset_sink(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
+	     csdev->activated)
+		csdev->activated = false;
+
+	return 0;
+}
+
+static void coresight_reset_all_sink(void)
+{
+	bus_for_each_dev(&coresight_bustype, NULL, NULL, coresight_reset_sink);
+}
+
 static int coresight_find_link_inport(struct coresight_device *csdev,
 				      struct coresight_device *parent)
 {
@@ -1137,7 +1154,7 @@ int coresight_enable(struct coresight_device *csdev)
 }
 EXPORT_SYMBOL_GPL(coresight_enable);
 
-void coresight_disable(struct coresight_device *csdev)
+static void __coresight_disable(struct coresight_device *csdev)
 {
 	int  ret;
 	struct list_head *path = NULL;
@@ -1145,14 +1162,12 @@ void coresight_disable(struct coresight_device *csdev)
 	struct coresight_path *cspath_next = NULL;
 	struct coresight_device *src_csdev = NULL;
 
-	mutex_lock(&coresight_mutex);
-
 	ret = coresight_validate_source(csdev, __func__);
 	if (ret)
-		goto out;
+		return;
 
 	if (!csdev->enable || !coresight_disable_source(csdev))
-		goto out;
+		return;
 
 	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
 		src_csdev = coresight_get_source(cspath->path);
@@ -1165,12 +1180,16 @@ void coresight_disable(struct coresight_device *csdev)
 		}
 	}
 	if (path == NULL)
-		goto out;
+		return;
 
 	coresight_disable_path(path);
 	coresight_release_path(path);
+}
 
-out:
+void coresight_disable(struct coresight_device *csdev)
+{
+	mutex_lock(&coresight_mutex);
+	__coresight_disable(csdev);
 	mutex_unlock(&coresight_mutex);
 }
 EXPORT_SYMBOL_GPL(coresight_disable);
@@ -1467,7 +1486,43 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 
 	return -EAGAIN;
 }
-EXPORT_SYMBOL_GPL(coresight_timeout);
+
+static ssize_t reset_source_sink_store(struct bus_type *bus,
+				       const char *buf, size_t size)
+{
+	int ret = 0;
+	unsigned long val;
+	struct coresight_path *cspath = NULL;
+	struct coresight_path *cspath_next = NULL;
+	struct coresight_device *csdev;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&coresight_mutex);
+
+	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
+		csdev = coresight_get_source(cspath->path);
+		if (!csdev)
+			continue;
+		atomic_set(csdev->refcnt, 1);
+		__coresight_disable(csdev);
+	}
+
+	/* Reset all activated sinks */
+	coresight_reset_all_sink();
+
+	mutex_unlock(&coresight_mutex);
+	return size;
+}
+static BUS_ATTR_WO(reset_source_sink);
+
+static struct attribute *coresight_reset_source_sink_attrs[] = {
+	&bus_attr_reset_source_sink.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(coresight_reset_source_sink);
 
 /*
  * coresight_release_platform_data: Release references to the devices connected
@@ -1680,6 +1735,7 @@ EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
 
 struct bus_type coresight_bustype = {
 	.name	= "coresight",
+	.bus_groups	= coresight_reset_source_sink_groups,
 };
 
 static int __init coresight_init(void)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

