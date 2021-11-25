Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900D945DCED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhKYPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:12:31 -0500
Received: from foss.arm.com ([217.140.110.172]:52110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239997AbhKYPKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:10:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292191FB;
        Thu, 25 Nov 2021 07:07:38 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 426063F66F;
        Thu, 25 Nov 2021 07:07:37 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH] firmware: arm_scmi: optee: Drop the support for the OPTEE shared dynamic buffer
Date:   Thu, 25 Nov 2021 15:07:30 +0000
Message-Id: <20211125150730.188487-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shared memory buffer allocated by the optee driver is normal cached
memory and can't be used with IOMEM APIs used in shmem_*.

We currently support only IO memory for shared memory and supporting
normal cached memory needs more changes and needs to be thought through
properly. So for now, let us drop the support for this OPTEE shared buffer.

Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/optee.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 901737c9f5f8..175b39bcd470 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -282,23 +282,6 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
 	shmem_clear_channel(channel->shmem);
 }
 
-static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
-{
-	const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
-
-	channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
-	if (IS_ERR(channel->tee_shm)) {
-		dev_err(channel->cinfo->dev, "shmem allocation failed\n");
-		return -ENOMEM;
-	}
-
-	channel->shmem = (void *)tee_shm_get_va(channel->tee_shm, 0);
-	memset(channel->shmem, 0, msg_size);
-	shmem_clear_channel(channel->shmem);
-
-	return 0;
-}
-
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
@@ -342,7 +325,7 @@ static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 	if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
 		return setup_static_shmem(dev, cinfo, channel);
 	else
-		return setup_dynamic_shmem(dev, channel);
+		return -ENOMEM;
 }
 
 static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
-- 
2.25.1

