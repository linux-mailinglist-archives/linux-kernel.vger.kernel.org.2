Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1603449BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCVPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:51:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:18757 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCVPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:50:41 -0400
IronPort-SDR: eFXSrDvOEjQQY6VYg0cKySA1ZnfsIDzwaLap9afP4gV3KsfPWw/81JLN0FvVrBOAEYVqZi5+V7
 kD7LJseR7bVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254295702"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="254295702"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:50:38 -0700
IronPort-SDR: vNJaX0aGa6CphesZIkFzZg6dXojoVqq1l95EhxF3siD9uAG4Qn31lJV1uW8HB6FxgqyBa4UPkX
 I7zJuTQJrx1A==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="524495805"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.29.9])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:50:38 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RESEND PATCH v10 7/7] fpga: sec-mgr: expose hardware error info
Date:   Mon, 22 Mar 2021 08:50:28 -0700
Message-Id: <20210322155028.531323-8-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322155028.531323-1-russell.h.weight@intel.com>
References: <20210322155028.531323-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the FPGA Security Manager class driver to include
an optional update/hw_errinfo sysfs node that can be used
to retrieve 64 bits of device specific error information
following a secure update failure.

The underlying driver must provide a get_hw_errinfo() callback
function to enable this feature. This data is treated as
opaque by the class driver. It is left to user-space software
or support personnel to interpret this data.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v9:
  - Updated Date and KernelVersion in ABI documentation
v8:
  - No change
v7:
  - Changed Date in documentation file to December 2020
v6:
  - No change
v5:
  - No change
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - No change
v2:
  - Bumped documentation date and version
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 14 +++++++
 drivers/fpga/fpga-sec-mgr.c                   | 38 +++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  5 +++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index fba3066e2b69..ff1458701def 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -65,3 +65,17 @@ Description:	Read-only. Returns a string describing the failure
 		idle state. If this file is read while a secure
 		update is in progress, then the read will fail with
 		EBUSY.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/hw_errinfo
+Date:		April 2021
+KernelVersion:  5.13
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a 64 bit error value providing
+		hardware specific information that may be useful in
+		debugging errors that occur during FPGA image updates.
+		This file is only visible if the underlying device
+		supports it. The hw_errinfo value is only accessible
+		when the secure update engine is in the idle state.
+		If this file is read while a secure update is in
+		progress, then the read will fail with EBUSY.
+		Format: "0x%llx".
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index d354fe2ab582..aebe06d9a54a 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -38,10 +38,17 @@ static void set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_code)
 	smgr->err_code = err_code;
 }
 
+static void set_hw_errinfo(struct fpga_sec_mgr *smgr)
+{
+	if (smgr->sops->get_hw_errinfo)
+		smgr->hw_errinfo = smgr->sops->get_hw_errinfo(smgr);
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
 	set_error(smgr, err_code);
+	set_hw_errinfo(smgr);
 	smgr->sops->cancel(smgr);
 }
 
@@ -227,6 +234,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t
+hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	int ret;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->progress != FPGA_SEC_PROG_IDLE)
+		ret = -EBUSY;
+	else
+		ret = sysfs_emit(buf, "0x%llx\n", smgr->hw_errinfo);
+	mutex_unlock(&smgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(hw_errinfo);
+
 static ssize_t remaining_size_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -258,6 +282,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->hw_errinfo = 0;
 	smgr->request_cancel = false;
 	smgr->progress = FPGA_SEC_PROG_READING;
 	reinit_completion(&smgr->update_done);
@@ -292,18 +317,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(cancel);
 
+static umode_t
+sec_mgr_update_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_hw_errinfo.attr && !smgr->sops->get_hw_errinfo)
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_cancel.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
 	&dev_attr_remaining_size.attr,
+	&dev_attr_hw_errinfo.attr,
 	NULL,
 };
 
 static struct attribute_group sec_mgr_update_attr_group = {
 	.name = "update",
 	.attrs = sec_mgr_update_attrs,
+	.is_visible = sec_mgr_update_visible,
 };
 
 static ssize_t name_show(struct device *dev,
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index e63e6437f394..04235fab8667 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -40,6 +40,9 @@ enum fpga_sec_err {
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
  *			    if the prepare function succeeded.
+ * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
+ *			    The software err_code may used to determine
+ *			    whether the hw error info is applicable.
  */
 struct fpga_sec_mgr_ops {
 	enum fpga_sec_err (*prepare)(struct fpga_sec_mgr *smgr);
@@ -48,6 +51,7 @@ struct fpga_sec_mgr_ops {
 	enum fpga_sec_err (*poll_complete)(struct fpga_sec_mgr *smgr);
 	enum fpga_sec_err (*cancel)(struct fpga_sec_mgr *smgr);
 	void (*cleanup)(struct fpga_sec_mgr *smgr);
+	u64 (*get_hw_errinfo)(struct fpga_sec_mgr *smgr);
 };
 
 /* Update progress codes */
@@ -73,6 +77,7 @@ struct fpga_sec_mgr {
 	enum fpga_sec_prog progress;
 	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
+	u64 hw_errinfo;			/* 64 bits of HW specific error info */
 	bool request_cancel;
 	bool driver_unload;
 	void *priv;
-- 
2.25.1

