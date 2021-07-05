Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073593BBAEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGEKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhGEKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:16:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05080C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:13:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eb14so1165558edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfApOJf6iNwbtrrm1KAOBk3yCtPkxEl1HuVkK7ORmOg=;
        b=maNjMWMV0zGqSac+rmBYuT37noUL/ENcvD3/pfxliDhS6X5AJ0jrgWBVqYlXJR/vkN
         mJd+xfZT0ptpfxrEY3vwF4oLgKYQruC0Ig0JTPoNxGR/Xq9FmXUN9dtlz4a2aLeKVHyq
         XH+kSZpBO4mBw/tORjJvIO9+a5gAZwP1VljyCWdtwFw0y7SKQChVlFFzFbUI5H6wz+g7
         bUn4Qo/5mNaQuFcm8Q0vDT4GWY7FLtfNpzTPCWF7DHF32nlcJul4/P46i9US/PDTSZ8M
         SYiqspFlmml0qRTtDyh8nEb5tE4+cFnw+VkUfzZ4ab199iL6FRQbv3S3UKqOhWrZaiXv
         vQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfApOJf6iNwbtrrm1KAOBk3yCtPkxEl1HuVkK7ORmOg=;
        b=QcscgspeZ7hRubsVfVCj4Jm84c3rZDwzbv5xeaP/61J9hNz6A+S7yprHf5j9WoqWYz
         k4fUDNuGnMkN4gv7WkvwmH6c6GmRjF3OXTidcVAb+7EFZ9EPPWkNuqarkV29ECt9w8Jk
         WYOAo0b6VZ2VhliFRtOVhTKQcWmMSP7YlH3gXJ8cD1DToYKB5HZ5QFUFDRJS2d9ltsN8
         QFhNDY5ntd+HYdtHEMGGVq60wTI9ihi/FcVMl8C9k+bcTKQsPMiOuhq235h2YHwsp7Mn
         YuTRRTXkfGcdxRFNQXQYE1koFdejmLex9X6s2pxBOyhJrhBYMXLbNzIwm+CwCog0WmxW
         6KFw==
X-Gm-Message-State: AOAM5319rRtT7irWjpT0RwP0JFzzfTY9FLz24Z5muBS6lSr5RH1RHoi3
        9C6vLMTrA9toytMArVQ5Us0=
X-Google-Smtp-Source: ABdhPJxkP8qchOdSVpdGrxAayKDo/r+qVmc/CK+svjxEsBC0S27vbV4zTPSaO/DGXem3UsqCuJg6mg==
X-Received: by 2002:a05:6402:11cd:: with SMTP id j13mr15176267edw.154.1625480014585;
        Mon, 05 Jul 2021 03:13:34 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de. [95.90.192.255])
        by smtp.gmail.com with ESMTPSA id k21sm5119648edo.41.2021.07.05.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:13:33 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH] nvme: Add abrupt shutdown support
Date:   Mon,  5 Jul 2021 10:11:57 +0000
Message-Id: <20210705101157.1009135-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Enabling the abrupt shutdown support. In this shutdown type host does
not need to send Delete I/O Submission Queue and Delete I/O Completion
queue commands to the device.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/nvme/host/core.c | 11 ++++++++++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  5 +++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 80c656dcbbac..c1d1bd6a03af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -40,6 +40,11 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
+bool shutdown_type;
+EXPORT_SYMBOL_GPL(shutdown_type);
+module_param(shutdown_type, bool, 0644);
+MODULE_PARM_DESC(shutdown_type, "Type of controller shutdown");
+
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
@@ -2166,7 +2171,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	if (shutdown_type)
+		ctrl->ctrl_config |= NVME_CC_SHN_ABRUPT;
+	else
+		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75420ceacc10..af14ee1cd7d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -23,6 +23,8 @@
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
+extern bool shutdown_type;
+
 extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d3c5086673bc..6a78233d9645 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2474,13 +2474,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead && shutdown && freeze)
+	if (!dead && shutdown && !shutdown_type && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		if (!shutdown_type)
+			nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_suspend_io_queues(dev);
-- 
2.25.1

