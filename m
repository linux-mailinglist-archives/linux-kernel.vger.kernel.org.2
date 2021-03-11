Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F63369E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhCKBwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:52:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:3251 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhCKBwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:52:11 -0500
IronPort-SDR: +WFkLUraPutl/2OXjcx20UmRKd1e1yIlhsE96H7+9Yn2f0Oaq6/A9Ol7c1IuvkBLfDgJxwAclj
 9PO038NwOARA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="249964785"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="249964785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 17:52:11 -0800
IronPort-SDR: J8BWNK1yqu//K2hxUO8C+4JCru+4eCOwFWdx0fwjizZO+c6nRi8I1QWYPBWFYv+R3jPdrpVFzk
 YK4y6BLRS1Ug==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403909016"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 17:52:09 -0800
From:   Shuo Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH v3] virt: acrn: Fix document of acrn_msi_inject()
Date:   Thu, 11 Mar 2021 09:52:06 +0800
Message-Id: <20210311015206.19715-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes below build warning with extra build checks.

$ make W=1

../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
acrn_inject_msi(). Prototype was for acrn_msi_inject() instead

Fixes: c7cf8d27244f ("virt: acrn: Introduce interrupt injection interfaces")
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
---
v3: Mentioned the build warning caused by 'make W=1' 

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

