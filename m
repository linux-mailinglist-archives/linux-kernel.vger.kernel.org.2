Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5D378B61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhEJMGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:06:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50861 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236283AbhEJLH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:07:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620644813; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=g8JJkyYr0ZPtcbmMhDuSpjRvu4aHPPHqKX2kyi8akF4=; b=f045vk+EDJ0r0QJlqBwyDXeAs6EYQKQj7tPt5nmiip1wSBVIiua5vtrU+zqJhFSWyzUwfYkT
 fERoyJ8U+Jzf8ct6g3N4mX2gFnm8PSuYcPfyfwpBEOU0uW7rlCKizst1pjbkd62pgf94lCeR
 dUMGOVYLForiu0ngA4Di2/0rg9c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6099138e55b14811b4152906 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 11:05:50
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81A19C43143; Mon, 10 May 2021 11:05:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B443FC43149;
        Mon, 10 May 2021 11:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B443FC43149
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
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>,
        Satyajit Desai <sadesai@codeaurora.org>,
        Rama Aparna Mallavarapu <aparnam@codeaurora.org>,
        Mulu He <muluhe@codeaurora.org>
Subject: [PATCH v1 1/3] coresight: add support to enable more coresight paths
Date:   Mon, 10 May 2021 19:05:25 +0800
Message-Id: <1620644727-29279-2-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
References: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current coresight implementation only supports enabling source
ETMs or STM. This patch adds support to enable more kinds of
coresight source to sink paths. We build a path from source to
sink when any source is enabled and store it in a list. When the
source is disabled, we fetch the corresponding path from the list
and decrement the refcount on each device in the path. The device
is disabled if the refcount reaches zero. Don't store path to
coresight data structure of source to avoid unnecessary change to
ABI.
Since some targets may have coresight sources other than STM and
ETMs, we need to add this change to support these coresight
devices.

Signed-off-by: Satyajit Desai <sadesai@codeaurora.org>
Signed-off-by: Rama Aparna Mallavarapu <aparnam@codeaurora.org>
Signed-off-by: Mulu He <muluhe@codeaurora.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Tao Zhang <taozha@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 101 +++++++++++++++------------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 4ba801d..7dfadb6 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -35,18 +35,16 @@ struct coresight_node {
 };
 
 /*
- * When operating Coresight drivers from the sysFS interface, only a single
- * path can exist from a tracer (associated to a CPU) to a sink.
+ * struct coresight_path - path from source to sink
+ * @path:	Address of path list.
+ * @link:	hook to the list.
  */
-static DEFINE_PER_CPU(struct list_head *, tracer_path);
+struct coresight_path {
+	struct list_head *path;
+	struct list_head link;
+};
 
-/*
- * As of this writing only a single STM can be found in CS topologies.  Since
- * there is no way to know if we'll ever see more and what kind of
- * configuration they will enact, for the time being only define a single path
- * for STM.
- */
-static struct list_head *stm_path;
+static LIST_HEAD(cs_active_paths);
 
 /*
  * When losing synchronisation a new barrier packet needs to be inserted at the
@@ -326,7 +324,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 	if (ret)
 		return;
 	coresight_control_assoc_ectdev(csdev, false);
-	csdev->enable = false;
+	csdev->activated = false;
 }
 
 static int coresight_enable_link(struct coresight_device *csdev,
@@ -562,6 +560,20 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 	goto out;
 }
 
+static struct coresight_device *coresight_get_source(struct list_head *path)
+{
+	struct coresight_device *csdev;
+
+	if (!path)
+		return NULL;
+
+	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
+		return NULL;
+
+	return csdev;
+}
+
 struct coresight_device *coresight_get_sink(struct list_head *path)
 {
 	struct coresight_device *csdev;
@@ -1047,9 +1059,23 @@ static int coresight_validate_source(struct coresight_device *csdev,
 	return 0;
 }
 
+static int coresight_store_path(struct list_head *path)
+{
+	struct coresight_path *node;
+
+	node = kzalloc(sizeof(struct coresight_path), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->path = path;
+	list_add(&node->link, &cs_active_paths);
+
+	return 0;
+}
+
 int coresight_enable(struct coresight_device *csdev)
 {
-	int cpu, ret = 0;
+	int ret = 0;
 	struct coresight_device *sink;
 	struct list_head *path;
 	enum coresight_dev_subtype_source subtype;
@@ -1094,25 +1120,9 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_source;
 
-	switch (subtype) {
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		/*
-		 * When working from sysFS it is important to keep track
-		 * of the paths that were created so that they can be
-		 * undone in 'coresight_disable()'.  Since there can only
-		 * be a single session per tracer (when working from sysFS)
-		 * a per-cpu variable will do just fine.
-		 */
-		cpu = source_ops(csdev)->cpu_id(csdev);
-		per_cpu(tracer_path, cpu) = path;
-		break;
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-		stm_path = path;
-		break;
-	default:
-		/* We can't be here */
-		break;
-	}
+	ret = coresight_store_path(path);
+	if (ret)
+		goto err_source;
 
 out:
 	mutex_unlock(&coresight_mutex);
@@ -1129,8 +1139,11 @@ EXPORT_SYMBOL_GPL(coresight_enable);
 
 void coresight_disable(struct coresight_device *csdev)
 {
-	int cpu, ret;
+	int  ret;
 	struct list_head *path = NULL;
+	struct coresight_path *cspath = NULL;
+	struct coresight_path *cspath_next = NULL;
+	struct coresight_device *src_csdev = NULL;
 
 	mutex_lock(&coresight_mutex);
 
@@ -1141,20 +1154,18 @@ void coresight_disable(struct coresight_device *csdev)
 	if (!csdev->enable || !coresight_disable_source(csdev))
 		goto out;
 
-	switch (csdev->subtype.source_subtype) {
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		cpu = source_ops(csdev)->cpu_id(csdev);
-		path = per_cpu(tracer_path, cpu);
-		per_cpu(tracer_path, cpu) = NULL;
-		break;
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-		path = stm_path;
-		stm_path = NULL;
-		break;
-	default:
-		/* We can't be here */
-		break;
+	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
+		src_csdev = coresight_get_source(cspath->path);
+		if (!src_csdev)
+			continue;
+		if (src_csdev == csdev) {
+			path = cspath->path;
+			list_del(&cspath->link);
+			kfree(cspath);
+		}
 	}
+	if (path == NULL)
+		goto out;
 
 	coresight_disable_path(path);
 	coresight_release_path(path);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

