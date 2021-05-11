Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF7379D27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKCvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:51:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:39282 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKCvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:51:54 -0400
IronPort-SDR: 0Asez1BZYXKVLYIM9N8gr7yfSWFWzzMKJbN/1FGZlxhkb42l86z9fJo/rQVgeec/9whNx3QDvm
 J/lukT0Y+M4g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284827693"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284827693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:50:48 -0700
IronPort-SDR: NODRnZTUIIC5tWEnSPuI0gozDPinD1oU6M8t4UCYQHfTuOr5WAxMK8GS1/3gvHpmLxttpRMbFB
 HWodagnLp98A==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434083554"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:50:45 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH] soundwire: dmi-quirks: remove duplicate initialization
Date:   Tue, 11 May 2021 10:50:35 +0800
Message-Id: <20210511025035.25233-1-yung-chuan.liao@linux.intel.com>
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

