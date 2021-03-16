Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0D33C9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhCOXgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:36:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:41776 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhCOXfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:35:38 -0400
IronPort-SDR: kroH6BSycJZDZChmkHxC5ntV03mYyI0Os2i/9GvjrXghSZqc8Avf4k9G8aPiec0dMMkARVMEKF
 ZMdkLc6EGOWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="188529302"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="188529302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:35:37 -0700
IronPort-SDR: qmNBNnkwH3IXwLzEeIKE2sW59SdUcnIRXDjcUYhPbqJlmznM8LdIbBIybT2lOh5koiquM9eA4g
 5n52tf1Nrm0Q==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="405346624"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.252.128.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:35:37 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v11 4/5] fpga: m10bmc-sec: add max10 secure update functions
Date:   Mon, 15 Mar 2021 16:35:31 -0700
Message-Id: <20210315233532.387145-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315233532.387145-1-russell.h.weight@intel.com>
References: <20210315233532.387145-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the MAX10 BMC Secure Update driver to include
the functions that enable secure updates of BMC images,
FPGA images, etc.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v11:
  - No change
v10:
  - No change
v9:
  - No change
v8:
  - Previously patch 5/6, otherwise no change
v7:
  - No change
v6:
  - Changed (size / stride) calculation to ((size + stride - 1) / stride)
    to ensure that the proper count is passed to regmap_bulk_write().
  - Removed unnecessary call to rsu_check_complete() in
    m10bmc_sec_poll_complete() and changed while loop to
    do/while loop.
v5:
  - No change
v4:
  - No change
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Changed calling functions of functions that return "enum fpga_sec_err"
    to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
v2:
  - Reworked the rsu_start_done() function to make it more readable
  - Reworked while-loop condition/content in rsu_prog_ready()
  - Minor code cleanup per review comments
  - Added a comment to the m10bmc_sec_poll_complete() function to
    explain the context (could take 30+ minutes to complete).
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
  - Moved MAX10 BMC address and function definitions to a separate
    patch.
---
 drivers/fpga/intel-m10-bmc-secure.c | 303 +++++++++++++++++++++++++++-
 1 file changed, 302 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 87e16c146569..a290fcc4df4a 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -180,7 +180,308 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
 	NULL,
 };
 
-static const struct fpga_sec_mgr_ops m10bmc_sops = { };
+static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
+{
+	u32 auth_result;
+
+	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
+
+	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
+		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
+}
+
+static enum fpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_BUSY;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static inline bool rsu_start_done(u32 doorbell)
+{
+	u32 status, progress;
+
+	if (doorbell & DRBL_RSU_REQUEST)
+		return false;
+
+	status = rsu_stat(doorbell);
+	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
+		return true;
+
+	progress = rsu_prog(doorbell);
+	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
+		return true;
+
+	return false;
+}
+
+static enum fpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
+{
+	u32 doorbell, status;
+	int ret;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
+				 DRBL_RSU_REQUEST |
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_IDLE));
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_start_done(doorbell),
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (ret) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	}
+
+	status = rsu_stat(doorbell);
+	if (status == RSU_STAT_WEAROUT) {
+		dev_warn(sec->dev, "Excessive flash update count detected\n");
+		return FPGA_SEC_ERR_WEAROUT;
+	} else if (status == RSU_STAT_ERASE_FAIL) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static enum fpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
+{
+	unsigned long poll_timeout;
+	u32 doorbell, progress;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
+	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
+		msleep(RSU_PREP_INTERVAL_MS);
+		if (time_after(jiffies, poll_timeout))
+			break;
+
+		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+		if (ret)
+			return FPGA_SEC_ERR_RW_ERROR;
+	}
+
+	progress = rsu_prog(doorbell);
+	if (progress == RSU_PROG_PREPARE) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (progress != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static enum fpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_HOST_STATUS,
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_WRITE_DONE));
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_prog(doorbell) != RSU_PROG_READY,
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (ret) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	}
+
+	switch (rsu_stat(doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
+{
+	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
+		return -EIO;
+
+	switch (rsu_stat(*doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (rsu_prog(*doorbell)) {
+	case RSU_PROG_IDLE:
+	case RSU_PROG_RSU_DONE:
+		return 0;
+	case RSU_PROG_AUTHENTICATING:
+	case RSU_PROG_COPYING:
+	case RSU_PROG_UPDATE_CANCEL:
+	case RSU_PROG_PROGRAM_KEY_HASH:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum fpga_sec_err m10bmc_sec_prepare(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	enum fpga_sec_err ret;
+
+	if (smgr->remaining_size > M10BMC_STAGING_SIZE)
+		return FPGA_SEC_ERR_INVALID_SIZE;
+
+	ret = rsu_check_idle(sec);
+	if (ret != FPGA_SEC_ERR_NONE)
+		return ret;
+
+	ret = rsu_update_init(sec);
+	if (ret != FPGA_SEC_ERR_NONE)
+		return ret;
+
+	return rsu_prog_ready(sec);
+}
+
+static enum fpga_sec_err
+m10bmc_sec_write_blk(struct fpga_sec_mgr *smgr, u32 offset, u32 size)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	ret = regmap_bulk_write(sec->m10bmc->regmap,
+				M10BMC_STAGING_BASE + offset,
+				(void *)smgr->data + offset,
+				(size + stride - 1) / stride);
+
+	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
+}
+
+/*
+ * m10bmc_sec_poll_complete() is called after handing things off to
+ * the BMC firmware. Depending on the type of update, it could be
+ * 30+ minutes before the BMC firmware completes the update. The
+ * smgr->driver_unload check allows the driver to be unloaded,
+ * but the BMC firmware will continue the update and no further
+ * secure updates can be started for this device until the update
+ * is complete.
+ */
+static enum fpga_sec_err m10bmc_sec_poll_complete(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	unsigned long poll_timeout;
+	enum fpga_sec_err result;
+	u32 doorbell;
+	int ret;
+
+	result = rsu_send_data(sec);
+	if (result != FPGA_SEC_ERR_NONE)
+		return result;
+
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
+	do {
+		msleep(RSU_COMPLETE_INTERVAL_MS);
+		ret = rsu_check_complete(sec, &doorbell);
+		if (smgr->driver_unload)
+			return FPGA_SEC_ERR_CANCELED;
+	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
+
+	if (ret == -EAGAIN) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (ret == -EIO) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	} else if (ret) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_READY)
+		return FPGA_SEC_ERR_BUSY;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_HOST_STATUS,
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_ABORT_RSU));
+
+	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
+}
+
+static const struct fpga_sec_mgr_ops m10bmc_sops = {
+	.prepare = m10bmc_sec_prepare,
+	.write_blk = m10bmc_sec_write_blk,
+	.poll_complete = m10bmc_sec_poll_complete,
+	.cancel = m10bmc_sec_cancel,
+};
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
 {
-- 
2.25.1

