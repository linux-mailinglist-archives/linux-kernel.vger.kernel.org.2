Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8D3A6DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhFNSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:10:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:39923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233427AbhFNSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:10:47 -0400
IronPort-SDR: MBPkeTgj+3WOnidv59CJwc8iRCsZoMlertpdFP9CWQohOI8Yt29dTImT36+WrRofjKBm/VkVj0
 j6CPG3JA68Tw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227312003"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="227312003"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:44 -0700
IronPort-SDR: epK+xTlGYHENtncTLXGdA6WyMiw/vl1OD/KZoeuxdbIk3sesVcf4S5kDKrTVL6uzmlq3N5E6HR
 5nxDiOhEVZ4A==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="484166413"
Received: from jepowell-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.114.106])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 11:08:42 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        Jack Yu <jack.yu@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] soundwire: export sdw_update() and sdw_update_no_pm()
Date:   Mon, 14 Jun 2021 13:08:11 -0500
Message-Id: <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
References: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently export sdw_read() and sdw_write() but the sdw_update()
and sdw_update_no_pm() are currently available only to the bus
code. This was missed in an earlier contribution.

Export both functions so that codec drivers can perform
read-modify-write operations without duplicating the code.

Fixes: b04c975e654c ('soundwire: bus: use sdw_update_no_pm when initializing a device')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 drivers/soundwire/bus.c       | 17 ++++++++++++++++-
 drivers/soundwire/bus.h       | 13 -------------
 include/linux/soundwire/sdw.h |  3 +++
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a9e0aa72654d..5d5b0bd59ae3 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -492,7 +492,7 @@ int sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 }
 EXPORT_SYMBOL(sdw_read_no_pm);
 
-static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
+int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 {
 	int tmp;
 
@@ -503,6 +503,21 @@ static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 	tmp = (tmp & ~mask) | val;
 	return sdw_write_no_pm(slave, addr, tmp);
 }
+EXPORT_SYMBOL(sdw_update_no_pm);
+
+/* Read-Modify-Write Slave register */
+int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
+{
+	int tmp;
+
+	tmp = sdw_read(slave, addr);
+	if (tmp < 0)
+		return tmp;
+
+	tmp = (tmp & ~mask) | val;
+	return sdw_write(slave, addr, tmp);
+}
+EXPORT_SYMBOL(sdw_update);
 
 /**
  * sdw_nread() - Read "n" contiguous SDW Slave registers
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 40354469860a..7631ef5e71fb 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -201,19 +201,6 @@ static inline void sdw_fill_port_params(struct sdw_port_params *params,
 	params->data_mode = data_mode;
 }
 
-/* Read-Modify-Write Slave register */
-static inline int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
-{
-	int tmp;
-
-	tmp = sdw_read(slave, addr);
-	if (tmp < 0)
-		return tmp;
-
-	tmp = (tmp & ~mask) | val;
-	return sdw_write(slave, addr, tmp);
-}
-
 /* broadcast read/write for tests */
 int sdw_bread_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr);
 int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ced07f8fde87..de9802a24e7e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1041,6 +1041,9 @@ int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
 int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
+int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
+
 int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
 void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
 
-- 
2.25.1

