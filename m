Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F334475EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhKGUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235724AbhKGUy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99783613D3;
        Sun,  7 Nov 2021 20:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318305;
        bh=uLfEDGAJFNv8NLMewB7vwMTcyL3pUuO6XSwk6mBU1wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gktfqz+Ptyp6sIdT8PQ9tWPzny0xDQk7OQj1In44EMv7ehOkpmth5TRC0gIZPWH6i
         oC/DRpi4ZseXQEnArqZbhNGXzK3Ge2g+CoXgx7jxccnMXSF3h0B6NRUCB3EPVcUPKd
         wawlIk1UZynojVus2uAL/qAgImZRJnhpT55RqfyNkERzKSHzoifj1l3r1zf+Xes6wh
         0nBWkEO2HEwcfiYykaE+dHzO9HU+zvtuw9xF473tQCDvKCBFszDNJzdoG3DrjkaW6Y
         R+SCiOCV5aqBOHe2T5VFj9SbEJi2LTMtE/OSjJ2sx9n9Q2DTqzPiFweKxGe6PU6bek
         V6O2H+xg9PzCQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 03/10] habanalabs: add dedicated message towards f/w to set power
Date:   Sun,  7 Nov 2021 22:51:29 +0200
Message-Id: <20211107205136.2329007-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

CPUCP_PACKET_POWER_GET packet type was used for both
hl_get_power() and hl_set_power().

To align with other sensor functions hl_set_power()
should use CPUCP_PACKET_POWER_SET.

This packet will only be used with newer ASICs, so need to add
a compatibility flag to the asic properties to indicate whether to use
this packet or the GET packet.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h       | 3 +++
 drivers/misc/habanalabs/common/hwmon.c            | 8 +++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c             | 2 ++
 drivers/misc/habanalabs/goya/goya.c               | 2 ++
 drivers/misc/habanalabs/include/common/cpucp_if.h | 4 ++++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 5fc9cfd892e8..dc61f7031c38 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -546,6 +546,8 @@ struct hl_hints_range {
  * @dynamic_fw_load: is dynamic FW load is supported.
  * @gic_interrupts_enable: true if FW is not blocking GIC controller,
  *                         false otherwise.
+ * @use_get_power_for_reset_history: To support backward compatibility for Goya
+ *                                   and Gaudi
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -626,6 +628,7 @@ struct asic_fixed_properties {
 	u8				iatu_done_by_fw;
 	u8				dynamic_fw_load;
 	u8				gic_interrupts_enable;
+	u8				use_get_power_for_reset_history;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index e33f65be8a00..70182b42940d 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -677,12 +677,18 @@ int hl_set_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value)
 {
 	struct cpucp_packet pkt;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
+	if (prop->use_get_power_for_reset_history)
+		pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
 				CPUCP_PKT_CTL_OPCODE_SHIFT);
+	else
+		pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
+
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 	pkt.value = __cpu_to_le64(value);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1dcce1bc976f..738ad2498439 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -665,6 +665,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->clk_pll_index = HL_GAUDI_MME_PLL;
 	prop->max_freq_value = GAUDI_MAX_CLK_FREQ;
 
+	prop->use_get_power_for_reset_history = true;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ce06103292a0..959eb21dcc69 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -475,6 +475,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 
 	prop->clk_pll_index = HL_GOYA_MME_PLL;
 
+	prop->use_get_power_for_reset_history = true;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index ae13231fda94..17927968e19a 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -376,6 +376,9 @@ enum pq_init_status {
  *       and QMANs. The f/w will return a bitmask where each bit represents
  *       a different engine or QMAN according to enum cpucp_idle_mask.
  *       The bit will be 1 if the engine is NOT idle.
+ *
+ * CPUCP_PACKET_POWER_SET -
+ *       Resets power history of device to 0
  */
 
 enum cpucp_packet_id {
@@ -421,6 +424,7 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_NIC_STAT_REGS_CLR,		/* internal */
 	CPUCP_PACKET_NIC_STAT_REGS_ALL_GET,	/* internal */
 	CPUCP_PACKET_IS_IDLE_CHECK,		/* internal */
+	CPUCP_PACKET_POWER_SET,			/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
-- 
2.25.1

