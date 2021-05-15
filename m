Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB738150F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhEOBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:54:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:58926 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhEOByW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:54:22 -0400
IronPort-SDR: 6HnMfZOJQNG1Rz+vz4tzwH20VY9DmPdlnFbwrPJjrinNANMfxJ38KcCIKSJQ+ymtCG2jmzRzP8
 APpeNBV5I+lw==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="199946202"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="199946202"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 18:53:10 -0700
IronPort-SDR: QiETuMxT3sfJr9nAwiv530BzdeV7pA09BoGHMon6EN/ZUNrzFjOW1jI5h58W/WsW8qBbaHEARe
 IpgZ2KSTGLYA==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="543042336"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.226.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 18:53:10 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v13 6/7] fpga: sec-mgr: enable cancel of secure update
Date:   Fri, 14 May 2021 18:53:04 -0700
Message-Id: <20210515015305.499167-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515015305.499167-1-russell.h.weight@intel.com>
References: <20210515015305.499167-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the FPGA Security Manager class driver to include
an update/cancel sysfs file that can be written to request
that an update be canceled. The write may return EBUSY if
the update has progressed to the point that it cannot be
canceled by software or ENODEV if there is no update in
progress.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 10 ++++
 drivers/fpga/fpga-sec-mgr.c                   | 59 +++++++++++++++++--
 include/linux/fpga/fpga-sec-mgr.h             |  1 +
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index c5d0b9d7c7e4..749f2d4c78d3 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -17,6 +17,16 @@ Description:	Write only. Write the filename of an image
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/cancel
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. Write a "1" to this file to request
+		that a current update be canceled. This request
+		will be rejected (EBUSY) if the programming phase
+		has already started or (ENODEV) if there is no
+		update in progress.
+
 What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
 Date:		June 2021
 KernelVersion:	5.14
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index bc6b35cc7237..48950843c2b4 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -43,6 +43,23 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 	smgr->sops->cancel(smgr);
 }
 
+static int progress_transition(struct fpga_sec_mgr *smgr,
+			       enum fpga_sec_prog new_progress)
+{
+	int ret = 0;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->request_cancel) {
+		fpga_sec_set_error(smgr, FPGA_SEC_ERR_CANCELED);
+		smgr->sops->cancel(smgr);
+		ret = -ECANCELED;
+	} else {
+		update_progress(smgr, new_progress);
+	}
+	mutex_unlock(&smgr->lock);
+	return ret;
+}
+
 static void progress_complete(struct fpga_sec_mgr *smgr)
 {
 	mutex_lock(&smgr->lock);
@@ -74,15 +91,19 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		goto release_fw_exit;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_PREPARING);
+	if (progress_transition(smgr, FPGA_SEC_PROG_PREPARING))
+		goto modput_exit;
+
 	ret = smgr->sops->prepare(smgr);
 	if (ret != FPGA_SEC_ERR_NONE) {
 		fpga_sec_dev_error(smgr, ret);
 		goto modput_exit;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_WRITING);
-	while (smgr->remaining_size) {
+	if (progress_transition(smgr, FPGA_SEC_PROG_WRITING))
+		goto done;
+
+	while (smgr->remaining_size && !smgr->request_cancel) {
 		ret = smgr->sops->write_blk(smgr, offset);
 		if (ret != FPGA_SEC_ERR_NONE) {
 			fpga_sec_dev_error(smgr, ret);
@@ -92,7 +113,9 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		offset = fw->size - smgr->remaining_size;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
+	if (progress_transition(smgr, FPGA_SEC_PROG_PROGRAMMING))
+		goto done;
+
 	ret = smgr->sops->poll_complete(smgr);
 	if (ret != FPGA_SEC_ERR_NONE)
 		fpga_sec_dev_error(smgr, ret);
@@ -229,6 +252,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->request_cancel = false;
 	smgr->progress = FPGA_SEC_PROG_READING;
 	reinit_completion(&smgr->update_done);
 	schedule_work(&smgr->work);
@@ -239,8 +263,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(filename);
 
+static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	bool cancel;
+	int ret = count;
+
+	if (kstrtobool(buf, &cancel) || !cancel)
+		return -EINVAL;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->progress == FPGA_SEC_PROG_PROGRAMMING)
+		ret = -EBUSY;
+	else if (smgr->progress == FPGA_SEC_PROG_IDLE)
+		ret = -ENODEV;
+	else
+		smgr->request_cancel = true;
+	mutex_unlock(&smgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(cancel);
+
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_cancel.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
 	&dev_attr_remaining_size.attr,
@@ -464,6 +512,9 @@ void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
 		goto unregister;
 	}
 
+	if (smgr->progress != FPGA_SEC_PROG_PROGRAMMING)
+		smgr->request_cancel = true;
+
 	mutex_unlock(&smgr->lock);
 	wait_for_completion(&smgr->update_done);
 
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 6b7b8a3d6aac..0e1f50434024 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -72,6 +72,7 @@ struct fpga_sec_mgr {
 	enum fpga_sec_prog progress;
 	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
+	bool request_cancel;
 	bool driver_unload;
 	void *priv;
 };
-- 
2.25.1

