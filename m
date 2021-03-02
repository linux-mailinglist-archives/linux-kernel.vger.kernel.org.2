Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0B32A31D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381890AbhCBIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:47:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:8982 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381685AbhCBIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:31:45 -0500
IronPort-SDR: PHKlo9dePJ1n8uOQvcMFozG2INT9ufL5fn9Gti0Xp8x2LgFSawb9a85AjoHizLmr6m02B7XLf2
 joHmKJBXp/JA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="183340455"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183340455"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:36 -0800
IronPort-SDR: X48LF1vSvlfDH+mntuNDOUikuDyU5dXy1/6HejuRlt9XVne9Qfu/JD9DY3Yuz4GQG6/5tHZQv1
 wG+YzVJHRVCw==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406613529"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:31 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 3/3] soundwire: intel: add master quirks for bus clash and parity
Date:   Tue,  2 Mar 2021 16:27:20 +0800
Message-Id: <20210302082720.12322-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have declarations and bus support, add quirks for Intel
platforms.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a2d5cdaa9998..c1fdc85d0a74 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1286,6 +1286,9 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		prop->hw_disabled = true;
 
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
+
 	return 0;
 }
 
-- 
2.17.1

