Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB60A3BACEF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhGDLxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 07:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGDLxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 07:53:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BBCD61108
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625399466;
        bh=fYd7zOqsFt6ETr5L6meJKac+NSHiNzjl2dmEbWKPJGs=;
        h=From:To:Subject:Date:From;
        b=sp1OD19MrVlkZlg7AnzNW7R2wNA3eNWI2haZNSLboSIwwZbzw3/ZYERxkYcD0VdN5
         1FrM4/WD+f9LDJPJdWjhXWE42SkPbNr043mZatQ1q4utQ/uzL87UPJ1z0baWi1qXpO
         RMt8STbIEbyRZUr2rqO4okLjYy8pdgAZ8CxstfIzvWUENiLK/927wtoiPdUxPkzZ2+
         MhCMfd4kKvaGMM7IJ64i+2jqiw26kzU0tFakQmpd1n4bmYHx+SVJgNaVe+khvRfePX
         /CZJ/asLGkCz/ORIesx/4HqDBd39oiBSpUHH84E6SsO1fvtIGTluj0+dCWAJcW6iEL
         CVV7xJ680bPfg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] habanalabs: use get_task_pid() to take PID
Date:   Sun,  4 Jul 2021 14:50:59 +0300
Message-Id: <20210704115102.9223-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous function we used, find_get_pid(), wasn't good in case
the user process was run inside docker.

As a result, we didn't had the PID and we couldn't kill the user
process in case the device got stuck and we needed to reset the
device.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c         | 6 +++++-
 drivers/misc/habanalabs/common/habanalabs_drv.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 43d0dcbd20e3..45070e891544 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -7,11 +7,11 @@
 
 #define pr_fmt(fmt)			"habanalabs: " fmt
 
+#include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
 
 #include <linux/pci.h>
 #include <linux/hwmon.h>
-#include <uapi/misc/habanalabs.h>
 
 enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
@@ -819,6 +819,10 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 			usleep_range(1000, 10000);
 
 			put_task_struct(task);
+		} else {
+			dev_warn(hdev->dev,
+				"Can't get task struct for PID so giving up on killing process\n");
+			return -ETIME;
 		}
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 4194cda2d04c..bffca119946b 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -141,7 +141,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hl_cb_mgr_init(&hpriv->cb_mgr);
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
 
-	hpriv->taskpid = find_get_pid(current->pid);
+	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
 
 	mutex_lock(&hdev->fpriv_list_lock);
 
-- 
2.25.1

