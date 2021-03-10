Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0B334270
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhCJQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:06:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:55699 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233191AbhCJQFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:05:43 -0500
IronPort-SDR: 9aTCpE1LPw2hbN8zGtIYdt24cc/G84g4Ezl6UiSUf1vKeBpG8FAYrb/a7FmrzXTPAmLNXMq4yv
 0Yr6uLO1kjwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="185144660"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="185144660"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:05:42 -0800
IronPort-SDR: gV4Byt7U5kLUpP57oQh5PgIFsu2Jw7IxG/0n7xxMHapf0zH6eNMn7yRpRigr8FeGCpVcJCy6xx
 +Ci7p8aUe4dw==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403729909"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:05:41 -0800
From:   Shuo Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH v2] virt: acrn: Fix document of acrn_msi_inject()
Date:   Thu, 11 Mar 2021 00:05:38 +0800
Message-Id: <20210310160538.26227-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes below build warning.

../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
acrn_inject_msi(). Prototype was for acrn_msi_inject() instead

Fixes: c7cf8d27244f ("virt: acrn: Introduce interrupt injection interfaces")
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
---
 drivers/virt/acrn/vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 7804a2492ad7..0d002a355a93 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -94,7 +94,7 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 }
 
 /**
- * acrn_inject_msi() - Inject a MSI interrupt into a User VM
+ * acrn_msi_inject() - Inject a MSI interrupt into a User VM
  * @vm:		User VM
  * @msi_addr:	The MSI address
  * @msi_data:	The MSI data
-- 
2.28.0

