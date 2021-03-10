Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E74334254
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhCJQBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:01:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:32101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233102AbhCJQA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:00:57 -0500
IronPort-SDR: Om5Kes1QTmfzDWs/WfwLRXUWvjB1kn9KaparIkGq4YSaRWVpCZzz4LSusSf74yWCRfyRMNCP//
 8wydTd+/E+Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167770771"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="167770771"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:00:52 -0800
IronPort-SDR: csXwoqiQpgyvem6HP8cBJSQdGd/grBeiGZKFfdh9IhXcHEB0J8UhKI8x2ye8XpKbFvnkPUCU3O
 WuiiggQIsFUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="588877312"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 08:00:46 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 1/4] mfd: intel-m10-bmc: Fix the register access range
Date:   Wed, 10 Mar 2021 23:55:45 +0800
Message-Id: <1615391748-1733-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
References: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the max register address of MAX 10 BMC. The range
0x20000000 ~ 0x200000fc are for control registers of the QSPI flash
controller, which are not accessible to host.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: no change.
v3: no change, rebased to 5.12-rc1
v4: add Lee's Acked-by, no other change.
---
 include/linux/mfd/intel-m10-bmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 74d4e19..9b54ca1 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,7 +11,7 @@
 
 #define M10BMC_LEGACY_SYS_BASE		0x300400
 #define M10BMC_SYS_BASE			0x300800
-#define M10BMC_MEM_END			0x200000fc
+#define M10BMC_MEM_END			0x1fffffff
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
-- 
2.7.4

