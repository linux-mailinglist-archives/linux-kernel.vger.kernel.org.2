Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3F3065F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhA0V0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:26:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:2646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234173AbhA0VZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:25:39 -0500
IronPort-SDR: nyjBegzotTwqzLaT852Zn4Seur9+5kKuhBkcF+kEtVWtSPDBKwFizAEnm8LvUWJuXAsubLjGeN
 k3/7j2kHkVAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="241664873"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="241664873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:23:45 -0800
IronPort-SDR: u0JTCth+6rK87nQpzwaoQQzviV6A01pZrHEQQ8Tlj7wIeJfjT7Y+Tvi4cQnrTCXqoLtrNzuQ8Y
 AX956W5i+NMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="388470772"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2021 13:23:44 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     mdf@kernel.org, trix@redhat.com, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
Date:   Wed, 27 Jan 2021 15:43:21 -0600
Message-Id: <1611783801-30766-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611783801-30766-1-git-send-email-richard.gong@linux.intel.com>
References: <1611783801-30766-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
aligns with the firmware settings.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 include/linux/firmware/intel/stratix10-svc-client.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index ebc2956..1ffb982 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -51,12 +51,12 @@
 #define SVC_STATUS_NO_SUPPORT		6
 
 /*
- * Flag bit for COMMAND_RECONFIG
+ * Flag for COMMAND_RECONFIG, in bit number
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
- * Set to FPGA configuration type (full or partial).
+ * Set for partial configuration.
  */
-#define COMMAND_RECONFIG_FLAG_PARTIAL	1
+#define COMMAND_RECONFIG_FLAG_PARTIAL	0
 
 /*
  * Timeout settings for service clients:
-- 
2.7.4

