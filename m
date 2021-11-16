Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9029F453418
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhKPO1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237387AbhKPO1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:27:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0192B61C12;
        Tue, 16 Nov 2021 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637072682;
        bh=RpwgR0Y9aQAKeTWLutjm9N/+V5n5DtiDQ2ssSQYI0IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1RirhRXPQLrmpJMGfUI5iGeXJVxc/Ubtv9qM+JwVDdmV8RjHAODVcKReFAPuZDgm
         bGFpzaoNJJplQL7cFXv2wUZjNuUhZDIXuL6jUiRNf/9r8DLb0bl4PlQ9qLiqje86q1
         nnFMYD9Cn7vurqwdWWemrc7hj2mKzVwxzQH6hCg3LAANvi2Zp13QUnWB7DKYvlBYW0
         RQsXwzC1IMCHWWVl+YR4lxmtmbr2Jdutv8Bay+YXjQghvvz2lC6lQ1Kqz16x2zkz2G
         HDF8L9q9G7XLgfbpqhqYgT9J2FpPJh8JjWnSmDEHgIXd2/f/PUR53FtMT/UjHnq3f3
         LOcpEncJdPCvA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 2/2] habanalabs: Move frequency change thread to goya_late_init
Date:   Tue, 16 Nov 2021 16:24:36 +0200
Message-Id: <20211116142436.1153282-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116142436.1153282-1-ogabbay@kernel.org>
References: <20211116142436.1153282-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Changing the frequency automatically is only done in Goya. In future
ASICs this is done inside the firmware. Therefore, move the common code
into the Goya specific files.

Main changes as part of the commit are:
    1. The thread for setting frequency is moved from device_late_init
       to goya_late_init
    2. hl_device_set_frequency is removed from hl_device_open as it is
       not relevant for other ASICs and for Goya it is taken care by
       the thread
    3. hl_device_set_frequency is renamed as goya_set_frequency

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 58 ---------------
 drivers/misc/habanalabs/common/habanalabs.h   |  7 --
 .../misc/habanalabs/common/habanalabs_drv.c   |  7 --
 drivers/misc/habanalabs/common/sysfs.c        |  5 --
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +
 drivers/misc/habanalabs/goya/goya.c           | 73 +++++++++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h          | 10 +++
 drivers/misc/habanalabs/goya/goya_hwmgr.c     | 27 ++++---
 8 files changed, 100 insertions(+), 89 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index a3d5617da64c..484e0446381e 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -516,22 +516,6 @@ static void device_early_fini(struct hl_device *hdev)
 		hdev->asic_funcs->early_fini(hdev);
 }
 
-static void set_freq_to_low_job(struct work_struct *work)
-{
-	struct hl_device *hdev = container_of(work, struct hl_device,
-						work_freq.work);
-
-	mutex_lock(&hdev->fpriv_list_lock);
-
-	if (!hdev->compute_ctx)
-		hl_device_set_frequency(hdev, PLL_LOW);
-
-	mutex_unlock(&hdev->fpriv_list_lock);
-
-	schedule_delayed_work(&hdev->work_freq,
-			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
-}
-
 static void hl_device_heartbeat(struct work_struct *work)
 {
 	struct hl_device *hdev = container_of(work, struct hl_device,
@@ -591,18 +575,6 @@ static int device_late_init(struct hl_device *hdev)
 
 	hdev->high_pll = hdev->asic_prop.high_pll;
 
-	/* force setting to low frequency */
-	hdev->curr_pll_profile = PLL_LOW;
-
-	if (hdev->pm_mng_profile == PM_AUTO)
-		hdev->asic_funcs->set_pll_profile(hdev, PLL_LOW);
-	else
-		hdev->asic_funcs->set_pll_profile(hdev, PLL_LAST);
-
-	INIT_DELAYED_WORK(&hdev->work_freq, set_freq_to_low_job);
-	schedule_delayed_work(&hdev->work_freq,
-	usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
-
 	if (hdev->heartbeat) {
 		INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
 		schedule_delayed_work(&hdev->work_heartbeat,
@@ -625,7 +597,6 @@ static void device_late_fini(struct hl_device *hdev)
 	if (!hdev->late_init_done)
 		return;
 
-	cancel_delayed_work_sync(&hdev->work_freq);
 	if (hdev->heartbeat)
 		cancel_delayed_work_sync(&hdev->work_heartbeat);
 
@@ -655,35 +626,6 @@ int hl_device_utilization(struct hl_device *hdev, u32 *utilization)
 	return 0;
 }
 
-/*
- * hl_device_set_frequency - set the frequency of the device
- *
- * @hdev: pointer to habanalabs device structure
- * @freq: the new frequency value
- *
- * Change the frequency if needed. This function has no protection against
- * concurrency, therefore it is assumed that the calling function has protected
- * itself against the case of calling this function from multiple threads with
- * different values
- *
- * Returns 0 if no change was done, otherwise returns 1
- */
-int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq)
-{
-	if ((hdev->pm_mng_profile == PM_MANUAL) ||
-			(hdev->curr_pll_profile == freq))
-		return 0;
-
-	dev_dbg(hdev->dev, "Changing device frequency to %s\n",
-		freq == PLL_HIGH ? "high" : "low");
-
-	hdev->asic_funcs->set_pll_profile(hdev, freq);
-
-	hdev->curr_pll_profile = freq;
-
-	return 1;
-}
-
 int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 {
 	int rc = 0;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 406ca50f192a..1a7f8d37f684 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2450,7 +2450,6 @@ struct last_error_session_info {
  * @cdev_ctrl: char device for control operations only (INFO IOCTL)
  * @dev: related kernel basic device structure.
  * @dev_ctrl: related kernel device structure for the control device
- * @work_freq: delayed work to lower device frequency if possible.
  * @work_heartbeat: delayed work for CPU-CP is-alive check.
  * @device_reset_work: delayed work which performs hard reset
  * @asic_name: ASIC specific name.
@@ -2485,7 +2484,6 @@ struct last_error_session_info {
  * @asic_specific: ASIC specific information to use only from ASIC files.
  * @vm: virtual memory manager for MMU.
  * @hwmon_dev: H/W monitor device.
- * @pm_mng_profile: current power management profile.
  * @hl_chip_info: ASIC's sensors information.
  * @device_status_description: device status description.
  * @hl_debugfs: device's debugfs manager.
@@ -2530,7 +2528,6 @@ struct last_error_session_info {
  * @open_counter: number of successful device open operations.
  * @fw_poll_interval_usec: FW status poll interval in usec.
  * @in_reset: is device in reset flow.
- * @curr_pll_profile: current PLL profile.
  * @card_type: Various ASICs have several card types. This indicates the card
  *             type of the current device.
  * @major: habanalabs kernel driver major.
@@ -2604,7 +2601,6 @@ struct hl_device {
 	struct cdev			cdev_ctrl;
 	struct device			*dev;
 	struct device			*dev_ctrl;
-	struct delayed_work		work_freq;
 	struct delayed_work		work_heartbeat;
 	struct hl_device_reset_work	device_reset_work;
 	char				asic_name[HL_STR_MAX];
@@ -2635,7 +2631,6 @@ struct hl_device {
 	void				*asic_specific;
 	struct hl_vm			vm;
 	struct device			*hwmon_dev;
-	enum hl_pm_mng_profile		pm_mng_profile;
 	struct hwmon_chip_info		*hl_chip_info;
 
 	struct hl_dbg_device_entry	hl_debugfs;
@@ -2682,7 +2677,6 @@ struct hl_device {
 	u64				fw_poll_interval_usec;
 	atomic_t			in_reset;
 	ktime_t				last_successful_open_ktime;
-	enum hl_pll_frequency		curr_pll_profile;
 	enum cpucp_card_types		card_type;
 	u32				major;
 	u32				high_pll;
@@ -2912,7 +2906,6 @@ int hl_device_resume(struct hl_device *hdev);
 int hl_device_reset(struct hl_device *hdev, u32 flags);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 int hl_hpriv_put(struct hl_fpriv *hpriv);
-int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
 int hl_device_utilization(struct hl_device *hdev, u32 *utilization);
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 1070c80d739c..d4ef99952d15 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -175,13 +175,6 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
-	/* Device is IDLE at this point so it is legal to change PLLs.
-	 * There is no need to check anything because if the PLL is
-	 * already HIGH, the set function will return without doing
-	 * anything
-	 */
-	hl_device_set_frequency(hdev, PLL_HIGH);
-
 	list_add(&hpriv->dev_node, &hdev->fpriv_list);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index aee0cc4d6155..15e4ae65e515 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -449,11 +449,6 @@ int hl_sysfs_init(struct hl_device *hdev)
 {
 	int rc;
 
-	if (hdev->asic_type == ASIC_GOYA)
-		hdev->pm_mng_profile = PM_AUTO;
-	else
-		hdev->pm_mng_profile = PM_MANUAL;
-
 	hdev->max_power = hdev->asic_prop.max_power_default;
 
 	hdev->asic_funcs->add_device_attr(hdev, &hl_dev_clks_attr_group);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b101a46076b8..f29afcca74fc 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1636,6 +1636,8 @@ static int gaudi_late_init(struct hl_device *hdev)
 	 */
 	gaudi_mmu_prepare(hdev, 1);
 
+	hdev->asic_funcs->set_pll_profile(hdev, PLL_LAST);
+
 	return 0;
 
 disable_pci_access:
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5e6998d21adb..bbee6739ce87 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -787,9 +787,59 @@ static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 	prop->psoc_pci_pll_div_factor = div_fctr;
 }
 
+/*
+ * goya_set_frequency - set the frequency of the device
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @freq: the new frequency value
+ *
+ * Change the frequency if needed. This function has no protection against
+ * concurrency, therefore it is assumed that the calling function has protected
+ * itself against the case of calling this function from multiple threads with
+ * different values
+ *
+ * Returns 0 if no change was done, otherwise returns 1
+ */
+int goya_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	if ((goya->pm_mng_profile == PM_MANUAL) ||
+			(goya->curr_pll_profile == freq))
+		return 0;
+
+	dev_dbg(hdev->dev, "Changing device frequency to %s\n",
+		freq == PLL_HIGH ? "high" : "low");
+
+	goya_set_pll_profile(hdev, freq);
+
+	goya->curr_pll_profile = freq;
+
+	return 1;
+}
+
+static void goya_set_freq_to_low_job(struct work_struct *work)
+{
+	struct goya_work_freq *goya_work = container_of(work,
+						struct goya_work_freq,
+						work_freq.work);
+	struct hl_device *hdev = goya_work->hdev;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	if (!hdev->compute_ctx)
+		goya_set_frequency(hdev, PLL_LOW);
+
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	schedule_delayed_work(&goya_work->work_freq,
+			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
+}
+
 int goya_late_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct goya_device *goya = hdev->asic_specific;
 	int rc;
 
 	goya_fetch_psoc_frequency(hdev);
@@ -838,6 +888,16 @@ int goya_late_init(struct hl_device *hdev)
 		return rc;
 	}
 
+	/* force setting to low frequency */
+	goya->curr_pll_profile = PLL_LOW;
+
+	goya->pm_mng_profile = PM_AUTO;
+
+	hdev->asic_funcs->set_pll_profile(hdev, PLL_LOW);
+
+	schedule_delayed_work(&goya->goya_work->work_freq,
+		usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
+
 	return 0;
 }
 
@@ -851,8 +911,11 @@ int goya_late_init(struct hl_device *hdev)
 void goya_late_fini(struct hl_device *hdev)
 {
 	const struct hwmon_channel_info **channel_info_arr;
+	struct goya_device *goya = hdev->asic_specific;
 	int i = 0;
 
+	cancel_delayed_work_sync(&goya->goya_work->work_freq);
+
 	if (!hdev->hl_chip_info->info)
 		return;
 
@@ -976,6 +1039,15 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
+	goya->goya_work = kmalloc(sizeof(struct goya_work_freq), GFP_KERNEL);
+	if (!goya->goya_work) {
+		rc = -ENOMEM;
+		goto free_cpu_accessible_dma_pool;
+	}
+
+	goya->goya_work->hdev = hdev;
+	INIT_DELAYED_WORK(&goya->goya_work->work_freq, goya_set_freq_to_low_job);
+
 	return 0;
 
 free_cpu_accessible_dma_pool:
@@ -1012,6 +1084,7 @@ static int goya_sw_fini(struct hl_device *hdev)
 
 	dma_pool_destroy(hdev->dma_pool);
 
+	kfree(goya->goya_work);
 	kfree(goya);
 
 	return 0;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 97add7b04f82..f0c3c6df04d5 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -153,9 +153,15 @@
 #define HW_CAP_GOLDEN		0x00000400
 #define HW_CAP_TPC		0x00000800
 
+struct goya_work_freq {
+	struct hl_device *hdev;
+	struct delayed_work work_freq;
+};
+
 struct goya_device {
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
+	struct goya_work_freq	*goya_work;
 
 	u64		mme_clk;
 	u64		tpc_clk;
@@ -166,6 +172,9 @@ struct goya_device {
 	u32		events_stat_aggregate[GOYA_ASYNC_EVENT_ID_SIZE];
 	u32		hw_cap_initialized;
 	u8		device_cpu_mmu_mappings_done;
+
+	enum hl_pll_frequency		curr_pll_profile;
+	enum hl_pm_mng_profile		pm_mng_profile;
 };
 
 int goya_set_fixed_properties(struct hl_device *hdev);
@@ -237,5 +246,6 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
 
 u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx);
 u64 goya_get_device_time(struct hl_device *hdev);
+int goya_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 59b2624ff81a..42985a85b625 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -62,7 +62,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	if (hdev->pm_mng_profile == PM_AUTO) {
+	if (goya->pm_mng_profile == PM_AUTO) {
 		count = -EPERM;
 		goto fail;
 	}
@@ -111,7 +111,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	if (hdev->pm_mng_profile == PM_AUTO) {
+	if (goya->pm_mng_profile == PM_AUTO) {
 		count = -EPERM;
 		goto fail;
 	}
@@ -160,7 +160,7 @@ static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	if (hdev->pm_mng_profile == PM_AUTO) {
+	if (goya->pm_mng_profile == PM_AUTO) {
 		count = -EPERM;
 		goto fail;
 	}
@@ -234,13 +234,14 @@ static ssize_t pm_mng_profile_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct goya_device *goya = hdev->asic_specific;
 
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
 	return sprintf(buf, "%s\n",
-			(hdev->pm_mng_profile == PM_AUTO) ? "auto" :
-			(hdev->pm_mng_profile == PM_MANUAL) ? "manual" :
+			(goya->pm_mng_profile == PM_AUTO) ? "auto" :
+			(goya->pm_mng_profile == PM_MANUAL) ? "manual" :
 			"unknown");
 }
 
@@ -248,6 +249,7 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct goya_device *goya = hdev->asic_specific;
 
 	if (!hl_device_operational(hdev, NULL)) {
 		count = -ENODEV;
@@ -265,26 +267,27 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 
 	if (strncmp("auto", buf, strlen("auto")) == 0) {
 		/* Make sure we are in LOW PLL when changing modes */
-		if (hdev->pm_mng_profile == PM_MANUAL) {
-			hdev->curr_pll_profile = PLL_HIGH;
-			hdev->pm_mng_profile = PM_AUTO;
-			hl_device_set_frequency(hdev, PLL_LOW);
+		if (goya->pm_mng_profile == PM_MANUAL) {
+			goya->curr_pll_profile = PLL_HIGH;
+			goya->pm_mng_profile = PM_AUTO;
+			goya_set_frequency(hdev, PLL_LOW);
 		}
 	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
-		if (hdev->pm_mng_profile == PM_AUTO) {
+		if (goya->pm_mng_profile == PM_AUTO) {
 			/* Must release the lock because the work thread also
 			 * takes this lock. But before we release it, set
 			 * the mode to manual so nothing will change if a user
 			 * suddenly opens the device
 			 */
-			hdev->pm_mng_profile = PM_MANUAL;
+			goya->pm_mng_profile = PM_MANUAL;
 
 			mutex_unlock(&hdev->fpriv_list_lock);
 
 			/* Flush the current work so we can return to the user
 			 * knowing that he is the only one changing frequencies
 			 */
-			flush_delayed_work(&hdev->work_freq);
+			if (goya->goya_work)
+				flush_delayed_work(&goya->goya_work->work_freq);
 
 			return count;
 		}
-- 
2.25.1

