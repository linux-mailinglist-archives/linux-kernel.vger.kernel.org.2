Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEF34A3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhCZJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:15:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:23498 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhCZJPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:45 -0400
IronPort-SDR: 5N+559Wxf7UHKDpyVrdNRvHC+I//1lM68VS2fdhxTSP03bGKgc3j/cT1PqmAmGNFbqtLvANzuK
 2h/p8yOtqwFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269576"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:43 -0700
IronPort-SDR: a+Ips0hBo8a/YVK4bEK2GPju3/bfUOE/mDrHpqDvrPQp3AgeFwQHQDLf0k2NsYQjGBmds7yvKO
 OjXHLnxErFow==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463167"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 05/11] soundwire: bus: uniquify dev_err() for SCP_INT access
Date:   Fri, 26 Mar 2021 17:15:08 +0800
Message-Id: <20210326091514.20751-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have multiple cases where we read/write SCP_INT registers, but the
same error message in all cases. Add a distinct error message for each
case to help debug.

Reported-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8b6d8fe934ae..a38b017f7a54 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1636,7 +1636,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		ret = sdw_read_no_pm(slave, SDW_SCP_INT1);
 		if (ret < 0) {
 			dev_err(&slave->dev,
-				"SDW_SCP_INT1 read failed:%d\n", ret);
+				"SDW_SCP_INT1 recheck read failed:%d\n", ret);
 			goto io_err;
 		}
 		_buf = ret;
@@ -1644,7 +1644,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
 		if (ret < 0) {
 			dev_err(&slave->dev,
-				"SDW_SCP_INT2/3 read failed:%d\n", ret);
+				"SDW_SCP_INT2/3 recheck read failed:%d\n", ret);
 			goto io_err;
 		}
 
@@ -1652,7 +1652,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 			if (ret < 0) {
 				dev_err(&slave->dev,
-					"SDW_DP0_INT read failed:%d\n", ret);
+					"SDW_DP0_INT recheck read failed:%d\n", ret);
 				goto io_err;
 			}
 			sdca_cascade = ret & SDW_DP0_SDCA_CASCADE;
-- 
2.17.1

