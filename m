Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AAF363912
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbhDSBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 21:25:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:62822 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237054AbhDSBY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:24:58 -0400
IronPort-SDR: nKy/w2ZKydkzvHn383/z11aDIwJZedinDcy49wAfC2u9RMlp9R9Ve5bA7vpwi/IpAuy8QV5zUv
 uxxqTCNZNilA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="182385006"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="182385006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 18:24:28 -0700
IronPort-SDR: zB/Gagp5+vixnmVexCEddJptQ4LNqKi06Wb/CmF74jKQVkFJTk8r4f8SdmVaE3Y4rrQLBmKLEL
 sZ938XkLMQlw==
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="426320687"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 18:24:25 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: dmi-quirks: remove duplicate initialization
Date:   Mon, 19 Apr 2021 09:24:17 +0800
Message-Id: <20210419012417.29366-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

cppcheck warning:

drivers/soundwire/dmi-quirks.c:85:12: style: Redundant initialization
for 'map'. The initialized value is overwritten before it is
read. [redundantInitialization]
  for (map = dmi_id->driver_data; map->adr; map++) {
           ^
drivers/soundwire/dmi-quirks.c:83:25: note: map is initialized
  struct adr_remap *map = dmi_id->driver_data;
                        ^
drivers/soundwire/dmi-quirks.c:85:12: note: map is overwritten
  for (map = dmi_id->driver_data; map->adr; map++) {
           ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 82061c1d9835..5db0a2443a1d 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -80,7 +80,7 @@ u64 sdw_dmi_override_adr(struct sdw_bus *bus, u64 addr)
 	/* check if any address remap quirk applies */
 	dmi_id = dmi_first_match(adr_remap_quirk_table);
 	if (dmi_id) {
-		struct adr_remap *map = dmi_id->driver_data;
+		struct adr_remap *map;
 
 		for (map = dmi_id->driver_data; map->adr; map++) {
 			if (map->adr == addr) {
-- 
2.17.1

