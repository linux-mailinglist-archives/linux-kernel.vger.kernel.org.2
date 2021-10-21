Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76470435BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJUHl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:41:57 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3753 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJUHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634801979; x=1666337979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/T+Qr2cdCGei8ovEYQOwJTk3upw5VcxRxTNTUf0UW7M=;
  b=I3gNhcTp3/YU5UnbC9Veaa7mmmpX75h4NDSrEh6lkx77RBtLoQJGm8z+
   b38VWYw9GleKf397n3bams25rZ3iqcf8hyg4xM6SeQ0JS2EOQBEzEJRTG
   hXOnXu3ObSR5Cxz7qVVCvMn5nc+FiBLpECEwOG0kO41HoYWrNd2Gc9scK
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:39:39 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:39:39 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:39:35 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH 01/10] coresight: add support to enable more coresight paths
Date:   Thu, 21 Oct 2021 15:38:47 +0800
Message-ID: <1634801936-15080-2-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
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

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 100 +++++++++++--------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 8a18c71df37a..1e621d61307a 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -37,18 +37,16 @@ struct coresight_node {
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
@@ -354,6 +352,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 	if (ret)
 		return;
 	coresight_control_assoc_ectdev(csdev, false);
+	csdev->activated = false;
 	csdev->enable = false;
 }
 
@@ -590,6 +589,20 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
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
@@ -1086,9 +1099,23 @@ static int coresight_validate_source(struct coresight_device *csdev,
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
@@ -1133,25 +1160,9 @@ int coresight_enable(struct coresight_device *csdev)
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
@@ -1168,8 +1179,11 @@ EXPORT_SYMBOL_GPL(coresight_enable);
 
 void coresight_disable(struct coresight_device *csdev)
 {
-	int cpu, ret;
+	int  ret;
 	struct list_head *path = NULL;
+	struct coresight_path *cspath = NULL;
+	struct coresight_path *cspath_next = NULL;
+	struct coresight_device *src_csdev = NULL;
 
 	mutex_lock(&coresight_mutex);
 
@@ -1180,20 +1194,18 @@ void coresight_disable(struct coresight_device *csdev)
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
2.17.1

