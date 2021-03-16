Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DC33D43E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhCPMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:50:59 -0400
Received: from foss.arm.com ([217.140.110.172]:37746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233039AbhCPMti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E349142F;
        Tue, 16 Mar 2021 05:49:38 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2F773F792;
        Tue, 16 Mar 2021 05:49:35 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 10/38] firmware: arm_scmi: port Base protocol to new interface
Date:   Tue, 16 Mar 2021 12:48:35 +0000
Message-Id: <20210316124903.35011-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port Base protocol to new protocol handles based interface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
---
 drivers/firmware/arm_scmi/base.c   | 117 +++++++++++++++--------------
 drivers/firmware/arm_scmi/common.h |   3 +-
 drivers/firmware/arm_scmi/driver.c |  14 +++-
 3 files changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 6a5cdef197d0..b5b6bd08132e 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -50,30 +50,30 @@ struct scmi_base_error_notify_payld {
  * scmi_base_attributes_get() - gets the implementation details
  *	that are associated with the base protocol.
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
-static int scmi_base_attributes_get(const struct scmi_handle *handle)
+static int scmi_base_attributes_get(const struct scmi_protocol_handle *ph)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_base_attributes *attr_info;
-	struct scmi_revision_info *rev = handle->version;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_BASE, 0, sizeof(*attr_info), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr_info), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		attr_info = t->rx.buf;
 		rev->num_protocols = attr_info->num_protocols;
 		rev->num_agents = attr_info->num_agents;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -81,19 +81,20 @@ static int scmi_base_attributes_get(const struct scmi_handle *handle)
 /**
  * scmi_base_vendor_id_get() - gets vendor/subvendor identifier ASCII string.
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  * @sub_vendor: specify true if sub-vendor ID is needed
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
 static int
-scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
+scmi_base_vendor_id_get(const struct scmi_protocol_handle *ph, bool sub_vendor)
 {
 	u8 cmd;
 	int ret, size;
 	char *vendor_id;
 	struct scmi_xfer *t;
-	struct scmi_revision_info *rev = handle->version;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
+
 
 	if (sub_vendor) {
 		cmd = BASE_DISCOVER_SUB_VENDOR;
@@ -105,15 +106,15 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
 		size = ARRAY_SIZE(rev->vendor_id);
 	}
 
-	ret = scmi_xfer_get_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
+	ret = ph->xops->xfer_get_init(ph, cmd, 0, size, &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		memcpy(vendor_id, t->rx.buf, size);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -123,30 +124,30 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
  *	implementation 32-bit version. The format of the version number is
  *	vendor-specific
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
 static int
-scmi_base_implementation_version_get(const struct scmi_handle *handle)
+scmi_base_implementation_version_get(const struct scmi_protocol_handle *ph)
 {
 	int ret;
 	__le32 *impl_ver;
 	struct scmi_xfer *t;
-	struct scmi_revision_info *rev = handle->version;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
-				 SCMI_PROTOCOL_BASE, 0, sizeof(*impl_ver), &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_IMPLEMENT_VERSION,
+				      0, sizeof(*impl_ver), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		impl_ver = t->rx.buf;
 		rev->impl_ver = le32_to_cpu(*impl_ver);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -155,23 +156,24 @@ scmi_base_implementation_version_get(const struct scmi_handle *handle)
  * scmi_base_implementation_list_get() - gets the list of protocols it is
  *	OSPM is allowed to access
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  * @protocols_imp: pointer to hold the list of protocol identifiers
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
-static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
-					     u8 *protocols_imp)
+static int
+scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
+				  u8 *protocols_imp)
 {
 	u8 *list;
 	int ret, loop;
 	struct scmi_xfer *t;
 	__le32 *num_skip, *num_ret;
 	u32 tot_num_ret = 0, loop_num_ret;
-	struct device *dev = handle->dev;
+	struct device *dev = ph->dev;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
-				 SCMI_PROTOCOL_BASE, sizeof(*num_skip), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_LIST_PROTOCOLS,
+				      sizeof(*num_skip), 0, &t);
 	if (ret)
 		return ret;
 
@@ -183,7 +185,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 		/* Set the number of protocols to be skipped/already read */
 		*num_skip = cpu_to_le32(tot_num_ret);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			break;
 
@@ -198,10 +200,10 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 
 		tot_num_ret += loop_num_ret;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 	} while (loop_num_ret);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -209,7 +211,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 /**
  * scmi_base_discover_agent_get() - discover the name of an agent
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  * @id: Agent identifier
  * @name: Agent identifier ASCII string
  *
@@ -218,63 +220,63 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
-static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
+static int scmi_base_discover_agent_get(const struct scmi_protocol_handle *ph,
 					int id, char *name)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_AGENT,
-				 SCMI_PROTOCOL_BASE, sizeof(__le32),
-				 SCMI_MAX_STR_SIZE, &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_AGENT,
+				      sizeof(__le32), SCMI_MAX_STR_SIZE, &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(id, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		strlcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
 
-static int scmi_base_error_notify(const struct scmi_handle *handle, bool enable)
+static int scmi_base_error_notify(const struct scmi_protocol_handle *ph,
+				  bool enable)
 {
 	int ret;
 	u32 evt_cntl = enable ? BASE_TP_NOTIFY_ALL : 0;
 	struct scmi_xfer *t;
 	struct scmi_msg_base_error_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, BASE_NOTIFY_ERRORS,
-				 SCMI_PROTOCOL_BASE, sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_NOTIFY_ERRORS,
+				      sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
 	cfg = t->tx.buf;
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_base_set_notify_enabled(const void *handle,
+static int scmi_base_set_notify_enabled(const void *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_base_error_notify(handle, enable);
+	ret = scmi_base_error_notify(ph, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] ret:%d\n", evt_id, ret);
 
 	return ret;
 }
 
-static void *scmi_base_fill_custom_report(const void *handle,
+static void *scmi_base_fill_custom_report(const void *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
@@ -326,17 +328,16 @@ static const struct scmi_protocol_events base_protocol_events = {
 	.num_sources = SCMI_BASE_NUM_SOURCES,
 };
 
-int scmi_base_protocol_init(struct scmi_handle *h)
+static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int id, ret;
 	u8 *prot_imp;
 	u32 version;
 	char name[SCMI_MAX_STR_SIZE];
-	const struct scmi_handle *handle = h;
-	struct device *dev = handle->dev;
-	struct scmi_revision_info *rev = handle->version;
+	struct device *dev = ph->dev;
+	struct scmi_revision_info *rev = scmi_revision_area_get(ph);
 
-	ret = scmi_version_get(handle, SCMI_PROTOCOL_BASE, &version);
+	ret = ph->xops->version_get(ph, &version);
 	if (ret)
 		return ret;
 
@@ -346,13 +347,15 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 
 	rev->major_ver = PROTOCOL_REV_MAJOR(version),
 	rev->minor_ver = PROTOCOL_REV_MINOR(version);
+	ph->set_priv(ph, rev);
+
+	scmi_base_attributes_get(ph);
+	scmi_base_vendor_id_get(ph, false);
+	scmi_base_vendor_id_get(ph, true);
+	scmi_base_implementation_version_get(ph);
+	scmi_base_implementation_list_get(ph, prot_imp);
 
-	scmi_base_attributes_get(handle);
-	scmi_base_vendor_id_get(handle, false);
-	scmi_base_vendor_id_get(handle, true);
-	scmi_base_implementation_version_get(handle);
-	scmi_base_implementation_list_get(handle, prot_imp);
-	scmi_setup_protocol_implemented(handle, prot_imp);
+	scmi_setup_protocol_implemented(ph, prot_imp);
 
 	dev_info(dev, "SCMI Protocol v%d.%d '%s:%s' Firmware version 0x%x\n",
 		 rev->major_ver, rev->minor_ver, rev->vendor_id,
@@ -361,7 +364,7 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 		rev->num_agents);
 
 	for (id = 0; id < rev->num_agents; id++) {
-		scmi_base_discover_agent_get(handle, id, name);
+		scmi_base_discover_agent_get(ph, id, name);
 		dev_dbg(dev, "Agent %d: %s\n", id, name);
 	}
 
@@ -370,7 +373,7 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 
 static const struct scmi_protocol scmi_base = {
 	.id = SCMI_PROTOCOL_BASE,
-	.init = &scmi_base_protocol_init,
+	.instance_init = &scmi_base_protocol_init,
 	.ops = NULL,
 	.events = &base_protocol_events,
 };
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6a06adc73f20..1bd332b5daa7 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -221,10 +221,9 @@ int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
 void scmi_set_handle(struct scmi_device *scmi_dev);
 int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
-void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
+void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
-int scmi_base_protocol_init(struct scmi_handle *h);
 typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fa83e1aec6d7..23d26e8f2684 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -883,10 +883,11 @@ void scmi_protocol_release(struct scmi_handle *handle, u8 protocol_id)
 	mutex_unlock(&info->protocols_mtx);
 }
 
-void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
+void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp)
 {
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 
 	info->protocols_imp = prot_imp;
 }
@@ -1263,9 +1264,14 @@ static int scmi_probe(struct platform_device *pdev)
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
-	ret = scmi_base_protocol_init(handle);
+	/*
+	 * Trigger SCMI Base protocol initialization.
+	 * It's mandatory and won't be ever released/deinit until the
+	 * SCMI stack is shutdown/unloaded as a whole.
+	 */
+	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
 	if (ret) {
-		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
+		dev_err(dev, "unable to communicate with SCMI\n");
 		return ret;
 	}
 
-- 
2.17.1

