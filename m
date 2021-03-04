Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED4432CF42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhCDJFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:05:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:51654 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237369AbhCDJFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:05:08 -0500
IronPort-SDR: AhL7EJUVuNMfM+N1tjoqftp6uCIhfDCTeoVJ4s50qXuilidqJJfntcEVNP/g6pgTMzH36gJjcC
 yaVVL5TaKNqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187486595"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="187486595"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 01:03:20 -0800
IronPort-SDR: iVF34477WQOwcLzYuwmmrFrtjX0FgEqY699W1/68a9ie9vmqwrioqD7Tuk4gFtZzvNP3kZEJGV
 IzN7qDNDxDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507282467"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 01:03:13 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Handle device properties with software node API
Date:   Thu,  4 Mar 2021 12:03:12 +0300
Message-Id: <20210304090312.26827-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old device property API is going to be removed.
Replacing the device_add_properties() call with the software
node API equivalent, device_create_managed_software_node().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/char/ipmi/ipmi_plat_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_plat_data.c b/drivers/char/ipmi/ipmi_plat_data.c
index 28471ff2a3a3e..747b51ae01a80 100644
--- a/drivers/char/ipmi/ipmi_plat_data.c
+++ b/drivers/char/ipmi/ipmi_plat_data.c
@@ -102,7 +102,7 @@ struct platform_device *ipmi_platform_add(const char *name, unsigned int inst,
 		goto err;
 	}
  add_properties:
-	rv = platform_device_add_properties(pdev, pr);
+	rv = device_create_managed_software_node(&pdev->dev, pr, NULL);
 	if (rv) {
 		dev_err(&pdev->dev,
 			"Unable to add hard-code properties: %d\n", rv);
-- 
2.30.1

