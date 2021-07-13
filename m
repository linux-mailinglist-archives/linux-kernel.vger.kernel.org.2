Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746653C6D90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhGMJhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:37:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:52088 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234819AbhGMJhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:37:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="273964736"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="273964736"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 02:34:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="492686722"
Received: from pujfalus-mobl.ger.corp.intel.com (HELO peter-virtualbox.ger.corp.intel.com) ([10.252.60.138])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 02:34:45 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        david.m.ertman@intel.com
Cc:     dan.j.williams@intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, peter.ujfalusi@linux.intel.com
Subject: [PATCH] driver core: auxiliary bus: Fix memory leak when driver_register() fail
Date:   Tue, 13 Jul 2021 12:34:38 +0300
Message-Id: <20210713093438.3173-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver_register() returns with error we need to free the memory
allocated for auxdrv->driver.name before returning from
__auxiliary_driver_register()

Fixes: 7de3697e9cbd4 ("Add auxiliary bus support")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 drivers/base/auxiliary.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index adc199dfba3c..6a30264ab2ba 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -231,6 +231,8 @@ EXPORT_SYMBOL_GPL(auxiliary_find_device);
 int __auxiliary_driver_register(struct auxiliary_driver *auxdrv,
 				struct module *owner, const char *modname)
 {
+	int ret;
+
 	if (WARN_ON(!auxdrv->probe) || WARN_ON(!auxdrv->id_table))
 		return -EINVAL;
 
@@ -246,7 +248,11 @@ int __auxiliary_driver_register(struct auxiliary_driver *auxdrv,
 	auxdrv->driver.bus = &auxiliary_bus_type;
 	auxdrv->driver.mod_name = modname;
 
-	return driver_register(&auxdrv->driver);
+	ret = driver_register(&auxdrv->driver);
+	if (ret)
+		kfree(auxdrv->driver.name);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__auxiliary_driver_register);
 
-- 
2.32.0

