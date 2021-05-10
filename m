Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE05378B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbhEJL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:59:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50861 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235948AbhEJLHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:07:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620644760; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=08hyiEFVRhHz0TZWfn/UR7stbKUHGZ6gbm5JHCBCHZY=; b=DhsH2nf68FNvvSdlKKwzGOuq9NGyffY+f/veXKGolzX3xu+6ujH4xCaIKpFyDzBSiw/XQi61
 GQrfzibaCNujBTuSeI++12I/vooUOyNGEXJkWMeJ4asT4odFei24nS0MNhAU248VkJEQb8kI
 +F9KCgI5HdKUQkAbHtMbFD/lVNU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60991391febcffa80fa41ea9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 11:05:53
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0471C43151; Mon, 10 May 2021 11:05:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87FAFC4338A;
        Mon, 10 May 2021 11:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87FAFC4338A
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
Subject: [PATCH v1 2/3] coresight: funnel: add support for multiple output ports
Date:   Mon, 10 May 2021 19:05:26 +0800
Message-Id: <1620644727-29279-3-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
References: <1620644727-29279-1-git-send-email-taozha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Funnel devices are now capable of supporting multiple-inputs and
multiple-outputs configuration with in built hardware filtering
for TPDM devices. Add software support to this function. Output
ports is selected according to the source of the trace path.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Tao Zhang <taozha@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-core.c     | 68 +++++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-platform.c |  9 ++++
 include/linux/coresight.h                        |  2 +
 3 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 7dfadb6..e14b294 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -54,6 +54,8 @@ static LIST_HEAD(cs_active_paths);
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
+static struct coresight_device *coresight_get_source(struct list_head *path);
+
 static const struct cti_assoc_op *cti_assoc_ops;
 
 void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
@@ -107,14 +109,42 @@ static int coresight_source_is_unique(struct coresight_device *csdev)
 				 csdev, coresight_id_match);
 }
 
+/**
+ * coresight_source_filter - checks whether the connection matches the source
+ * of path if connection is binded to specific source.
+ * @path:	The list of devices
+ * @conn:	The connection of one outport
+ *
+ * Return zero if the connection doesn't have a source binded or source of the
+ * path matches the source binds to connection.
+ */
+static int coresight_source_filter(struct list_head *path,
+			struct coresight_connection *conn)
+{
+	int ret = 0;
+	struct coresight_device *source = NULL;
+
+	if (conn->source_name == NULL)
+		return ret;
+
+	source = coresight_get_source(path);
+	if (source == NULL)
+		return ret;
+
+	return strcmp(conn->source_name, dev_name(&source->dev));
+}
+
 static int coresight_find_link_inport(struct coresight_device *csdev,
-				      struct coresight_device *parent)
+				      struct coresight_device *parent,
+				      struct list_head *path)
 {
 	int i;
 	struct coresight_connection *conn;
 
 	for (i = 0; i < parent->pdata->nr_outport; i++) {
 		conn = &parent->pdata->conns[i];
+		if (coresight_source_filter(path, conn))
+			continue;
 		if (conn->child_dev == csdev)
 			return conn->child_port;
 	}
@@ -126,13 +156,16 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 }
 
 static int coresight_find_link_outport(struct coresight_device *csdev,
-				       struct coresight_device *child)
+				       struct coresight_device *child,
+				       struct list_head *path)
 {
 	int i;
 	struct coresight_connection *conn;
 
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		conn = &csdev->pdata->conns[i];
+		if (coresight_source_filter(path, conn))
+			continue;
 		if (conn->child_dev == child)
 			return conn->outport;
 	}
@@ -329,7 +362,8 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
-				 struct coresight_device *child)
+				 struct coresight_device *child,
+				 struct list_head *path)
 {
 	int ret = 0;
 	int link_subtype;
@@ -338,8 +372,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return -EINVAL;
 
-	inport = coresight_find_link_inport(csdev, parent);
-	outport = coresight_find_link_outport(csdev, child);
+	inport = coresight_find_link_inport(csdev, parent, path);
+	outport = coresight_find_link_outport(csdev, child, path);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && inport < 0)
@@ -364,7 +398,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
-				   struct coresight_device *child)
+				   struct coresight_device *child,
+				   struct list_head *path)
 {
 	int i, nr_conns;
 	int link_subtype;
@@ -373,8 +408,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return;
 
-	inport = coresight_find_link_inport(csdev, parent);
-	outport = coresight_find_link_outport(csdev, child);
+	inport = coresight_find_link_inport(csdev, parent, path);
+	outport = coresight_find_link_outport(csdev, child, path);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
@@ -489,7 +524,7 @@ static void coresight_disable_path_from(struct list_head *path,
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			coresight_disable_link(csdev, parent, child);
+			coresight_disable_link(csdev, parent, child, path);
 			break;
 		default:
 			break;
@@ -544,7 +579,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			ret = coresight_enable_link(csdev, parent, child);
+			ret = coresight_enable_link(csdev, parent, child, path);
 			if (ret)
 				goto err;
 			break;
@@ -772,7 +807,8 @@ static void coresight_drop_device(struct coresight_device *csdev)
  */
 static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
-				 struct list_head *path)
+				 struct list_head *path,
+				 struct coresight_device *source)
 {
 	int i, ret;
 	bool found = false;
@@ -787,8 +823,14 @@ static int _coresight_build_path(struct coresight_device *csdev,
 		struct coresight_device *child_dev;
 
 		child_dev = csdev->pdata->conns[i].child_dev;
+
+		if (csdev->pdata->conns[i].source_name &&
+		    strcmp(csdev->pdata->conns[i].source_name,
+				dev_name(&source->dev)))
+			continue;
+
 		if (child_dev &&
-		    _coresight_build_path(child_dev, sink, path) == 0) {
+		    _coresight_build_path(child_dev, sink, path, source) == 0) {
 			found = true;
 			break;
 		}
@@ -833,7 +875,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
 
 	INIT_LIST_HEAD(path);
 
-	rc = _coresight_build_path(source, sink, path);
+	rc = _coresight_build_path(source, sink, path, source);
 	if (rc) {
 		kfree(path);
 		return ERR_PTR(rc);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3629b78..47c453f 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -216,6 +216,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct of_endpoint endpoint, rendpoint;
 	struct device_node *rparent = NULL;
 	struct device_node *rep = NULL;
+	struct device_node *sn = NULL;
 	struct device *rdev = NULL;
 	struct fwnode_handle *rdev_fwnode;
 	struct coresight_connection *conn;
@@ -263,6 +264,14 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 */
 		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
 		conn->child_port = rendpoint.port;
+		conn->source_name = NULL;
+		sn = of_parse_phandle(ep, "source", 0);
+		if (sn) {
+			ret = of_property_read_string(sn,
+			"coresight-name", &conn->source_name);
+			of_node_put(sn);
+		}
+
 		/* Connection record updated */
 	} while (0);
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 7d3c87e..ccc2c86 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -140,6 +140,7 @@ struct coresight_desc {
  * struct coresight_connection - representation of a single connection
  * @outport:	a connection's output port number.
  * @child_port:	remote component's port number @output is connected to.
+ * @source_name:source component's name.
  * @chid_fwnode: remote component's fwnode handle.
  * @child_dev:	a @coresight_device representation of the component
 		connected to @outport.
@@ -148,6 +149,7 @@ struct coresight_desc {
 struct coresight_connection {
 	int outport;
 	int child_port;
+	const char *source_name;
 	struct fwnode_handle *child_fwnode;
 	struct coresight_device *child_dev;
 	struct coresight_sysfs_link *link;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

