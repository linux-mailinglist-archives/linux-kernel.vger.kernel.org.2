Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DCF34F0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhC3SRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:15278 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhC3SQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:55 -0400
IronPort-SDR: n7JLXXy5EfTvdnR1Wms2qjXQsUzNUJNFjGKHXFAR64M02xqb/PmOWWTNmoV8mcodfH7M6s3nAK
 uj92UTW31Kcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179369079"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179369079"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:55 -0700
IronPort-SDR: etjm4Kucbm6tgRgQa7+SXZVn06MgYXL4KUx/FdC20Aa0BGxFdkSQlLcja4XmiwMEvazbBJCDT4
 cqnkSK4q+t0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="606862472"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2021 11:16:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AABE368; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 09/10] ipmi_si: Drop redundant check before calling put_device()
Date:   Tue, 30 Mar 2021 21:16:48 +0300
Message-Id: <20210330181649.66496-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
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

