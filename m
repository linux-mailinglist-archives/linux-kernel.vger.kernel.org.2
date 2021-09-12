Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F1407BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhILF2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 01:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhILF2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 01:28:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5D9B6108F;
        Sun, 12 Sep 2021 05:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631424409;
        bh=zZM8N+PyamLo9wvpBuigp1XpiOZx1+li5iz1+vjv3Pw=;
        h=From:To:Cc:Subject:Date:From;
        b=DaXL/Ev8Tv+fuq6tFE+an+fT0vy1xgj+LlzKrkbw3f452xLYYdkm676ZGcKIvbHVj
         0J3E721TrlkW8Ed28zUERrlPadBa6sqqt2ZAi3JtFV2k3QovxOafAmiamn0QnUCm5A
         76fSz3bYGa/0RUr3GZmyzMLfJu+rsuJAiXL8U9+BZ0cY3OzmJUOuCg1OPFUQAN7NJP
         laMPx9g9op2Z2C/VYmsYOSjOa2pULgjKaT/V+tiBk2b2J9if/988ADeUAgLgYIxz3s
         cn5b3SwolGOstXG0HEsGBcHrhi+mCpE3OIZsjtpoI3m0cjgF06eoqip7nkfaNd9vgu
         Unhw2nkNfqMPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: add debugfs node for configuring CS timeout
Date:   Sun, 12 Sep 2021 08:26:44 +0300
Message-Id: <20210912052645.104082-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Command submission timeout is currently determined during driver
loading time. As some environments requires this timeout to be
modified in runtime, we introduce a new debugfs node that controls
the timeout value without the need to reload the driver.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  6 +++
 drivers/misc/habanalabs/common/debugfs.c      | 51 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 284e2dfa61cd..63c46d9d538f 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -226,6 +226,12 @@ Description:    Gets the state dump occurring on a CS timeout or failure.
                 Writing an integer X discards X state dumps, so that the
                 next read would return X+1-st newest state dump.
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/timeout_locked
+Date:           Sep 2021
+KernelVersion:  5.16
+Contact:        obitton@habana.ai
+Description:    Sets the command submission timeout value in seconds.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
 Date:           Mar 2020
 KernelVersion:  5.6
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 985f1f3dbd20..1f2a3dc6c4e2 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1167,6 +1167,45 @@ static ssize_t hl_state_dump_write(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_timeout_locked_read(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	char tmp_buf[200];
+	ssize_t rc;
+
+	if (*ppos)
+		return 0;
+
+	sprintf(tmp_buf, "%d\n",
+		jiffies_to_msecs(hdev->timeout_jiffies) / 1000);
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	if (value)
+		hdev->timeout_jiffies = msecs_to_jiffies(value * 1000);
+	else
+		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+
+	return count;
+}
+
 static const struct file_operations hl_data32b_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_data_read32,
@@ -1240,6 +1279,12 @@ static const struct file_operations hl_state_dump_fops = {
 	.write = hl_state_dump_write
 };
 
+static const struct file_operations hl_timeout_locked_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_timeout_locked_read,
+	.write = hl_timeout_locked_write
+};
+
 static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_buffers", command_buffers_show, NULL},
 	{"command_submission", command_submission_show, NULL},
@@ -1421,6 +1466,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_state_dump_fops);
 
+	debugfs_create_file("timeout_locked",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_timeout_locked_fops);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
 					0444,
-- 
2.17.1

