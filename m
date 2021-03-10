Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090583341B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhCJPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:38:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:34510 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhCJPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:38:00 -0500
IronPort-SDR: aKJPMiURrfkDB2spWCH/A4rG4V+AIEnvClMfB5Drc6svh+vTB74TrKiiDZ8Ni81Pogj4LU1YOi
 TEdfQKmwmvGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186112777"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="186112777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:38:00 -0800
IronPort-SDR: Z0L/O6Tsb5NfTOmmLWftSc77ZgyeEsCG6/NDZsvtfw9x0GYgVoQ1bHE/E5nRKUo+IKkN3ECe1I
 KUsRJGDLwCdg==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403719745"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:37:58 -0800
From:   shuo.a.liu@intel.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH] virt: acrn: Fix document of acrn_msi_inject()
Date:   Wed, 10 Mar 2021 23:37:51 +0800
Message-Id: <20210310153751.17516-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

This fixes below sparse warning.

../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
acrn_inject_msi(). Prototype was for acrn_msi_inject() instead

Fixes: c7cf8d27244f ("virt: acrn: Introduce interrupt injection interfaces")
Reported-by: kernel test robot <lkp@intel.com>
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

