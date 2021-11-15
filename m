Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEAC4508CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhKOPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:44:57 -0500
Received: from foss.arm.com ([217.140.110.172]:56874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236662AbhKOPoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:44:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A44356D;
        Mon, 15 Nov 2021 07:41:07 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7D43F766;
        Mon, 15 Nov 2021 07:41:06 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Fix type error assignment in voltage protocol
Date:   Mon, 15 Nov 2021 15:40:42 +0000
Message-Id: <20211115154043.49284-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect type assignment error reported by sparse as:

drivers/firmware/arm_scmi/voltage.c:159:42: warning: incorrect type in assignment (different base types)
drivers/firmware/arm_scmi/voltage.c:159:42: expected restricted __le32 [usertype] level_index
drivers/firmware/arm_scmi/voltage.c:159:42: got unsigned int [usertype] desc_index

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2add5cacff353 ("firmware: arm_scmi: Add voltage domain management protocol support")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/voltage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index a5048956a0be..ac08e819088b 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -156,7 +156,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 			int cnt;
 
 			cmd->domain_id = cpu_to_le32(v->id);
-			cmd->level_index = desc_index;
+			cmd->level_index = cpu_to_le32(desc_index);
 			ret = ph->xops->do_xfer(ph, tl);
 			if (ret)
 				break;
-- 
2.17.1

