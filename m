Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04CE352EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhDBRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:17914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235876AbhDBRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:30 -0400
IronPort-SDR: itE+r/OA79lNu8rAZtDWp3RdmVvdR6KRaAVOPNCLuqFPOsNzPoBeCXz8SDbrGXzKNf1Tg3iG4B
 SO7MheuLE/rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="277702231"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="277702231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:28 -0700
IronPort-SDR: vTHVuaPDrEpYeFIAMCyrMd6QsqBFaxYqX0Y6paXYTdOkD/vqvpMFgSIyjqsxQKIBdnORtz5NOy
 LAQzXF/PQXXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="528673883"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2021 10:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE981668; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 09/10] ipmi_si: Drop redundant check before calling put_device()
Date:   Fri,  2 Apr 2021 20:43:33 +0300
Message-Id: <20210402174334.13466-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_device() is NULL aware, drop redundant check before calling it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_hotmod.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_hotmod.c b/drivers/char/ipmi/ipmi_si_hotmod.c
index 087f5eb1ebc0..a07ef37c0e3f 100644
--- a/drivers/char/ipmi/ipmi_si_hotmod.c
+++ b/drivers/char/ipmi/ipmi_si_hotmod.c
@@ -223,8 +223,7 @@ static int hotmod_handler(const char *val, const struct kernel_param *kp)
 				if (strcmp(pdev->name, "hotmod-ipmi-si") == 0)
 					platform_device_unregister(pdev);
 			}
-			if (dev)
-				put_device(dev);
+			put_device(dev);
 		}
 	}
 	rv = strlen(val);
-- 
2.30.2

