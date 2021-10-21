Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3678B435BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhJUHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:42:01 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3753 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhJUHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634801984; x=1666337984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iz553WRkvHQgfCNmPx8UPJtumJ+T7WxvgYhp3zGGM1Q=;
  b=n04X0LBcSyKYlQD/x8ke8LVVuHoyQOFCxAodM2OVIqF3S2r7TgBssEvv
   sptgOQtNFRyHcqfWIYdjfwQIkC8nJJWd4k2gnBD0b0GBn23s3/p3zKblR
   CVcCMn5es3M4iizAT7yRdJOBHwbqT9ILyjacaUVLuttyFMnHjPAkKMdkU
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:39:44 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:39:43 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:39:39 -0700
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
Subject: [PATCH 02/10] coresight: funnel: add support for multiple output ports
Date:   Thu, 21 Oct 2021 15:38:48 +0800
Message-ID: <1634801936-15080-3-git-send-email-quic_taozha@quicinc.com>
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

Funnel devices are now capable of supporting multiple-inputs and
multiple-outputs configuration with in built hardware filtering
for TPDM devices. Add software support to this function. Output
port is selected according to the source of the trace path.

The source of the input port on funnels will be marked in the
device tree.
e.g.
tpdm_XXX: tpdm@xxxxxxx {
    ... ... ... ...
};

funnel_XXX: funnel@xxxxxxx {
    ... ... ... ...
    out-ports {
        ... ... ... ...
        port@x {
            ... ... ... ...
            label = <&tpdm_XXX>; <-- To point out tpdm_XXX should
        };                           be outputed from port@x. And
    ... ... ... ...                  this is a hardware static
    };                               connections. Here needs
    ... ... ... ...                  to refer to hardware design.
};

Then driver will parse the source name marked in the device tree, and
save it to the coresight path. When the function needs to know the
source name, it could get the source name from coresight path parameter.
Finally, the output port knows which source it corresponds to, and it
also knows which input port it corresponds to.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 75 +++++++++++++++----
 .../hwtracing/coresight/coresight-platform.c  |  8 ++
 include/linux/coresight.h                     |  2 +
 3 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1e621d61307a..490c9d8d43f9 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -56,6 +56,8 @@ static LIST_HEAD(cs_active_paths);
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
+static struct coresight_device *coresight_get_source(struct list_head *path);
+
 static const struct cti_assoc_op *cti_assoc_ops;
 
 void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
@@ -121,14 +123,46 @@ static int coresight_source_is_unique(struct coresight_device *csdev)
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
+	if (is_of_node(source->dev.fwnode))
+		return strcmp(conn->source_name,
+			of_node_full_name(to_of_node(source->dev.fwnode)));
+
+	return ret;
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
@@ -140,13 +174,16 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
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
@@ -358,7 +395,8 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
-				 struct coresight_device *child)
+				 struct coresight_device *child,
+				 struct list_head *path)
 {
 	int ret = 0;
 	int link_subtype;
@@ -367,8 +405,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return -EINVAL;
 
-	inport = coresight_find_link_inport(csdev, parent);
-	outport = coresight_find_link_outport(csdev, child);
+	inport = coresight_find_link_inport(csdev, parent, path);
+	outport = coresight_find_link_outport(csdev, child, path);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && inport < 0)
@@ -393,7 +431,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
-				   struct coresight_device *child)
+				   struct coresight_device *child,
+				   struct list_head *path)
 {
 	int i, nr_conns;
 	int link_subtype;
@@ -402,8 +441,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return;
 
-	inport = coresight_find_link_inport(csdev, parent);
-	outport = coresight_find_link_outport(csdev, child);
+	inport = coresight_find_link_inport(csdev, parent, path);
+	outport = coresight_find_link_outport(csdev, child, path);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
@@ -518,7 +557,7 @@ static void coresight_disable_path_from(struct list_head *path,
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			coresight_disable_link(csdev, parent, child);
+			coresight_disable_link(csdev, parent, child, path);
 			break;
 		default:
 			break;
@@ -573,7 +612,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			ret = coresight_enable_link(csdev, parent, child);
+			ret = coresight_enable_link(csdev, parent, child, path);
 			if (ret)
 				goto err;
 			break;
@@ -801,7 +840,8 @@ static void coresight_drop_device(struct coresight_device *csdev)
  */
 static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
-				 struct list_head *path)
+				 struct list_head *path,
+				 struct coresight_device *source)
 {
 	int i, ret;
 	bool found = false;
@@ -813,7 +853,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 
 	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
 	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
-		if (_coresight_build_path(sink, sink, path) == 0) {
+		if (_coresight_build_path(sink, sink, path, source) == 0) {
 			found = true;
 			goto out;
 		}
@@ -824,8 +864,15 @@ static int _coresight_build_path(struct coresight_device *csdev,
 		struct coresight_device *child_dev;
 
 		child_dev = csdev->pdata->conns[i].child_dev;
+
+		if (csdev->pdata->conns[i].source_name &&
+			is_of_node(source->dev.fwnode) &&
+		    strcmp(csdev->pdata->conns[i].source_name,
+				of_node_full_name(to_of_node(source->dev.fwnode))))
+			continue;
+
 		if (child_dev &&
-		    _coresight_build_path(child_dev, sink, path) == 0) {
+		    _coresight_build_path(child_dev, sink, path, source) == 0) {
 			found = true;
 			break;
 		}
@@ -870,7 +917,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
 
 	INIT_LIST_HEAD(path);
 
-	rc = _coresight_build_path(source, sink, path);
+	rc = _coresight_build_path(source, sink, path, source);
 	if (rc) {
 		kfree(path);
 		return ERR_PTR(rc);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index c594f45319fc..60c43ab149a5 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -222,6 +222,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct of_endpoint endpoint, rendpoint;
 	struct device_node *rparent = NULL;
 	struct device_node *rep = NULL;
+	struct device_node *sn = NULL;
 	struct device *rdev = NULL;
 	struct fwnode_handle *rdev_fwnode;
 	struct coresight_connection *conn;
@@ -269,6 +270,13 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		 */
 		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
 		conn->child_port = rendpoint.port;
+		conn->source_name = NULL;
+		sn = of_parse_phandle(ep, "label", 0);
+		if (sn) {
+			conn->source_name = sn->full_name;
+			of_node_put(sn);
+		}
+
 		/* Connection record updated */
 	} while (0);
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 93a2922b7653..7065b60a767b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -170,6 +170,7 @@ struct coresight_desc {
  * struct coresight_connection - representation of a single connection
  * @outport:	a connection's output port number.
  * @child_port:	remote component's port number @output is connected to.
+ * @source_name:source component's name.
  * @chid_fwnode: remote component's fwnode handle.
  * @child_dev:	a @coresight_device representation of the component
 		connected to @outport.
@@ -178,6 +179,7 @@ struct coresight_desc {
 struct coresight_connection {
 	int outport;
 	int child_port;
+	const char *source_name;
 	struct fwnode_handle *child_fwnode;
 	struct coresight_device *child_dev;
 	struct coresight_sysfs_link *link;
-- 
2.17.1

