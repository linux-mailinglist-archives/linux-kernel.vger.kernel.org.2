Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB533D458
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhCPMxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:53:50 -0400
Received: from foss.arm.com ([217.140.110.172]:38036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233335AbhCPMu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57AB1597;
        Tue, 16 Mar 2021 05:50:28 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10333F792;
        Tue, 16 Mar 2021 05:50:26 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 31/38] firmware: arm_scmi: make references to handle const
Date:   Tue, 16 Mar 2021 12:48:56 +0000
Message-Id: <20210316124903.35011-32-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the protocol private variable data have been moved out of
struct scmi_handle, mark all of its references as const.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- reworks to fit into refactored scmi_get_protocol_instance()
---
 drivers/firmware/arm_scmi/common.h |  4 ++--
 drivers/firmware/arm_scmi/driver.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 1bd332b5daa7..988f806bcf74 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -276,8 +276,8 @@ void __exit scmi_##name##_unregister(void)			\
 
 const struct scmi_protocol *scmi_protocol_get(int protocol_id);
 
-int scmi_protocol_acquire(struct scmi_handle *handle, u8 protocol_id);
-void scmi_protocol_release(struct scmi_handle *handle, u8 protocol_id);
+int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
+void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
 
 /* SCMI Transport */
 /**
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 23d26e8f2684..eb1276d8026e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -739,7 +739,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	int ret = -ENOMEM;
 	void *gid;
 	struct scmi_protocol_instance *pi;
-	struct scmi_handle *handle = &info->handle;
+	const struct scmi_handle *handle = &info->handle;
 
 	/* Protocol specific devres group */
 	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
@@ -805,7 +805,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
  * Return: A reference to an initialized protocol instance or error on failure.
  */
 static struct scmi_protocol_instance * __must_check
-scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
+scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_protocol_instance *pi;
 	struct scmi_info *info = handle_to_scmi_info(handle);
@@ -840,7 +840,7 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
  *
  * Return: 0 if protocol was acquired successfully.
  */
-int scmi_protocol_acquire(struct scmi_handle *handle, u8 protocol_id)
+int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id)
 {
 	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
 }
@@ -853,7 +853,7 @@ int scmi_protocol_acquire(struct scmi_handle *handle, u8 protocol_id)
  * Remove one user for the specified protocol and triggers de-initialization
  * and resources de-allocation once the last user has gone.
  */
-void scmi_protocol_release(struct scmi_handle *handle, u8 protocol_id)
+void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
@@ -908,7 +908,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 }
 
 struct scmi_protocol_devres {
-	struct scmi_handle *handle;
+	const struct scmi_handle *handle;
 	u8 protocol_id;
 };
 
-- 
2.17.1

