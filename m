Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B314508CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhKOPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:45:53 -0500
Received: from foss.arm.com ([217.140.110.172]:56882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236675AbhKOPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:44:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FFF21063;
        Mon, 15 Nov 2021 07:41:08 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7AC33F766;
        Mon, 15 Nov 2021 07:41:07 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Fix type error in sensor protocol
Date:   Mon, 15 Nov 2021 15:40:43 +0000
Message-Id: <20211115154043.49284-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115154043.49284-1-cristian.marussi@arm.com>
References: <20211115154043.49284-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect type error reported by sparse as:

drivers/firmware/arm_scmi/sensors.c:640:28: warning: incorrect type in argument 1 (different base types)
drivers/firmware/arm_scmi/sensors.c:640:28: expected unsigned int [usertype] val
drivers/firmware/arm_scmi/sensors.c:640:28: got restricted __le32 [usertype]

Fixes: 7b83c5f410889 ("firmware: arm_scmi: Add SCMI v3.0 sensor configuration support")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 308471586381..cdbb287bd8bc 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -637,7 +637,7 @@ static int scmi_sensor_config_get(const struct scmi_protocol_handle *ph,
 	if (ret)
 		return ret;
 
-	put_unaligned_le32(cpu_to_le32(sensor_id), t->tx.buf);
+	put_unaligned_le32(sensor_id, t->tx.buf);
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		struct sensors_info *si = ph->get_priv(ph);
-- 
2.17.1

