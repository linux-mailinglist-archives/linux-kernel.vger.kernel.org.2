Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA85416193
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbhIWPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:00:38 -0400
Received: from foss.arm.com ([217.140.110.172]:35990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241928AbhIWPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:00:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E301A113E;
        Thu, 23 Sep 2021 07:58:54 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF463F718;
        Thu, 23 Sep 2021 07:58:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 13/13] firmware: arm_scmi: Make smc support atomic sync commands replies
Date:   Thu, 23 Sep 2021 15:58:02 +0100
Message-Id: <20210923145802.50938-14-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923145802.50938-1-cristian.marussi@arm.com>
References: <20210923145802.50938-1-cristian.marussi@arm.com>
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
index 22c573458719..a338c696852d 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -225,14 +225,6 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 	smc_channel_lock_release(scmi_info);
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
@@ -240,7 +232,6 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.send_message = smc_send_message,
 	.mark_txdone = smc_mark_txdone,
 	.fetch_response = smc_fetch_response,
-	.poll_done = smc_poll_done,
 };
 
 const struct scmi_desc scmi_smc_desc = {
@@ -255,4 +246,13 @@ const struct scmi_desc scmi_smc_desc = {
 	 */
 	.atomic_capable = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
 	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
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

