Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953F9316FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhBJTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:20:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:36813 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234541AbhBJTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:20:13 -0500
IronPort-SDR: l0e5rbCZPLaDzmXMNc5M1fJAgiVCbt7s6OIIMT7VlZKMCHvfqeDRvhoQj35pws+v4iQtTS8tUT
 58HJw4Gc/Zwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161887925"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="161887925"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:19:50 -0800
IronPort-SDR: 0dffhSzRA77MMCeNSietWGZ0X0f7VfDjvonMrXOOoPODV79KYe3lcueWGES11+65DFPUm6H8kn
 OAvBSqYf2vgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="488844956"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2021 11:19:50 -0800
From:   Casey Bowman <casey.g.bowman@intel.com>
To:     mika.westerberg@linux.intel.com
Cc:     dvhart@infradead.org, andy@infradead.org, azhar.shaikh@intel.com,
        casey.g.bowman@intel.com, lee.jones@linaro.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Subject: [PATCH] platform/x86: intel_scu_ipc: Increase virtual timeout from 3 to 5 seconds
Date:   Wed, 10 Feb 2021 11:20:41 -0800
Message-Id: <20210210192041.17022-1-casey.g.bowman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increasing the virtual timeout time to account for scenarios
that may require more time, like DisplayPort Multi-Stream Transport
(DP MST), where the disconnect time can be extended longer than
usual.

The recommended timeout range is 5-10 seconds, of which
we will take the lower bound.

Signed-off-by: Casey Bowman <casey.g.bowman@intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index d9cf7f7602b0..9171a46a9e3f 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -75,7 +75,7 @@ struct intel_scu_ipc_dev {
 #define IPC_READ_BUFFER		0x90
 
 /* Timeout in jiffies */
-#define IPC_TIMEOUT		(3 * HZ)
+#define IPC_TIMEOUT		(5 * HZ)
 
 static struct intel_scu_ipc_dev *ipcdev; /* Only one for now */
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
-- 
2.17.1

