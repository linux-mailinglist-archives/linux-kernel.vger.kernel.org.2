Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5845983C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhKVXKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:10:45 -0500
Received: from foss.arm.com ([217.140.110.172]:46218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhKVXK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:10:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829BE1063;
        Mon, 22 Nov 2021 15:07:19 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40B063F5A1;
        Mon, 22 Nov 2021 15:07:17 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 09/16] firmware: arm_scmi: Make smc support atomic sync commands replies
Date:   Mon, 22 Nov 2021 23:06:33 +0000
Message-Id: <20211122230640.1345-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122230640.1345-1-cristian.marussi@arm.com>
References: <20211122230640.1345-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sync_cmds_atomic_replies in the SMC transport descriptor and remove
SMC specific .poll_done callback support since polling is bypassed when
sync_cmds_atomic_replies is set.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- removed RFC tag
- added comment on setting flag
- remove smc_poll_done
---
 drivers/firmware/arm_scmi/smc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index adaa40df3855..95cafa1bbfbe 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -172,14 +172,6 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 	mutex_unlock(&scmi_info->shmem_lock);
 }
 
-static bool
-smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
-{
-	struct scmi_smc *scmi_info = cinfo->transport_info;
-
-	return shmem_poll_done(scmi_info->shmem, xfer);
-}
-
 static const struct scmi_transport_ops scmi_smc_ops = {
 	.chan_available = smc_chan_available,
 	.chan_setup = smc_chan_setup,
@@ -187,7 +179,6 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.send_message = smc_send_message,
 	.mark_txdone = smc_mark_txdone,
 	.fetch_response = smc_fetch_response,
-	.poll_done = smc_poll_done,
 };
 
 const struct scmi_desc scmi_smc_desc = {
@@ -195,4 +186,13 @@ const struct scmi_desc scmi_smc_desc = {
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
 	.max_msg_size = 128,
+	/*
+	 * Setting .sync_cmds_atomic_replies to true for SMC assumes that,
+	 * once the SMC instruction has completed successfully, the issued
+	 * SCMI command would have been already fully processed by the SCMI
+	 * platform firmware and so any possible response value expected
+	 * for the issued command will be immmediately ready to be fetched
+	 * from the shared memory area.
+	 */
+	.sync_cmds_atomic_replies = true,
 };
-- 
2.17.1

