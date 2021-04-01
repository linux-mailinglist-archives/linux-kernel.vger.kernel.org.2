Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD693512CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhDAJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:54:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhDAJyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:54:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CC60AEF5;
        Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2 1/3] nvme: Use sysfs_emit instead of sprintf
Date:   Thu,  1 Apr 2021 11:54:10 +0200
Message-Id: <20210401095412.84254-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_emit is the recommended API to use for formatting strings to be
returned to user space. It is equivalent to scnprintf and aware of the
PAGE_SIZE buffer size.

Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c      | 40 +++++++++++++++++------------------
 drivers/nvme/host/multipath.c |  8 +++----
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..b94a30e7298d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2876,8 +2876,8 @@ static ssize_t subsys_##field##_show(struct device *dev,		\
 {									\
 	struct nvme_subsystem *subsys =					\
 		container_of(dev, struct nvme_subsystem, dev);		\
-	return sprintf(buf, "%.*s\n",					\
-		       (int)sizeof(subsys->field), subsys->field);	\
+	return sysfs_emit(buf, "%.*s\n",				\
+			   (int)sizeof(subsys->field), subsys->field);	\
 }									\
 static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
 
@@ -3407,13 +3407,13 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	int model_len = sizeof(subsys->model);
 
 	if (!uuid_is_null(&ids->uuid))
-		return sprintf(buf, "uuid.%pU\n", &ids->uuid);
+		return sysfs_emit(buf, "uuid.%pU\n", &ids->uuid);
 
 	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-		return sprintf(buf, "eui.%16phN\n", ids->nguid);
+		return sysfs_emit(buf, "eui.%16phN\n", ids->nguid);
 
 	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-		return sprintf(buf, "eui.%8phN\n", ids->eui64);
+		return sysfs_emit(buf, "eui.%8phN\n", ids->eui64);
 
 	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
 				  subsys->serial[serial_len - 1] == '\0'))
@@ -3422,7 +3422,7 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 				 subsys->model[model_len - 1] == '\0'))
 		model_len--;
 
-	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
+	return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
 		serial_len, subsys->serial, model_len, subsys->model,
 		head->ns_id);
 }
@@ -3431,7 +3431,7 @@ static DEVICE_ATTR_RO(wwid);
 static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
+	return sysfs_emit(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
 }
 static DEVICE_ATTR_RO(nguid);
 
@@ -3446,23 +3446,23 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	if (uuid_is_null(&ids->uuid)) {
 		printk_ratelimited(KERN_WARNING
 				   "No UUID available providing old NGUID\n");
-		return sprintf(buf, "%pU\n", ids->nguid);
+		return sysfs_emit(buf, "%pU\n", ids->nguid);
 	}
-	return sprintf(buf, "%pU\n", &ids->uuid);
+	return sysfs_emit(buf, "%pU\n", &ids->uuid);
 }
 static DEVICE_ATTR_RO(uuid);
 
 static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
+	return sysfs_emit(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
 }
 static DEVICE_ATTR_RO(eui);
 
 static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
 }
 static DEVICE_ATTR_RO(nsid);
 
@@ -3527,7 +3527,7 @@ static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%.*s\n",						\
+        return sysfs_emit(buf, "%.*s\n",					\
 		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
@@ -3541,7 +3541,7 @@ static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%d\n", ctrl->field);	\
+        return sysfs_emit(buf, "%d\n", ctrl->field);				\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
@@ -3589,9 +3589,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 
 	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
 	    state_name[ctrl->state])
-		return sprintf(buf, "%s\n", state_name[ctrl->state]);
+		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
 
-	return sprintf(buf, "unknown state\n");
+	return sysfs_emit(buf, "unknown state\n");
 }
 
 static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
@@ -3643,9 +3643,9 @@ static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 
 	if (ctrl->opts->max_reconnects == -1)
-		return sprintf(buf, "off\n");
-	return sprintf(buf, "%d\n",
-			opts->max_reconnects * opts->reconnect_delay);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n",
+			  opts->max_reconnects * opts->reconnect_delay);
 }
 
 static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
@@ -3675,8 +3675,8 @@ static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
 	if (ctrl->opts->reconnect_delay == -1)
-		return sprintf(buf, "off\n");
-	return sprintf(buf, "%d\n", ctrl->opts->reconnect_delay);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
 }
 
 static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..e62369d3eae3 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -602,8 +602,8 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	return sprintf(buf, "%s\n",
-			nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
+	return sysfs_emit(buf, "%s\n",
+			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
@@ -628,7 +628,7 @@ SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%d\n", nvme_get_ns_from_dev(dev)->ana_grpid);
+	return sysfs_emit(buf, "%d\n", nvme_get_ns_from_dev(dev)->ana_grpid);
 }
 DEVICE_ATTR_RO(ana_grpid);
 
@@ -637,7 +637,7 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
-	return sprintf(buf, "%s\n", nvme_ana_state_names[ns->ana_state]);
+	return sysfs_emit(buf, "%s\n", nvme_ana_state_names[ns->ana_state]);
 }
 DEVICE_ATTR_RO(ana_state);
 
-- 
2.29.2

