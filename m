Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EC3A9D52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhFPORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:17:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:8381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233398AbhFPORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:17:48 -0400
IronPort-SDR: gnDRMuIF/FJwihJTlObBB9zgSlIoXRQ5TPy1GBTD1Nw7bwk1xqe0byCsHrmxtMGLdZYZHNdFuR
 OwXvkzohkrBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204354053"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="204354053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:15:28 -0700
IronPort-SDR: aHfl8ULQ/5/NU7KxRf2w8rP8toGI5FA3zX2G2qh4sifPeEpaci6C5qZNhS9o3cjLSnbMSuL7HO
 EomT5cqe79CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="452356370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2021 07:15:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 649512AA; Wed, 16 Jun 2021 17:15:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v1 1/1] auxdisplay: ks0108: Switch to use module_parport_driver()
Date:   Wed, 16 Jun 2021 17:15:48 +0300
Message-Id: <20210616141548.39787-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ks0108.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index 03c95ad4216c..406bb7376df8 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -167,21 +167,8 @@ static struct parport_driver ks0108_parport_driver = {
 	.detach = ks0108_parport_detach,
 	.devmodel = true,
 };
-
-static int __init ks0108_init(void)
-{
-	return parport_register_driver(&ks0108_parport_driver);
-}
-
-static void __exit ks0108_exit(void)
-{
-	parport_unregister_driver(&ks0108_parport_driver);
-}
-
-module_init(ks0108_init);
-module_exit(ks0108_exit);
+module_parport_driver(ks0108_parport_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Miguel Ojeda <ojeda@kernel.org>");
 MODULE_DESCRIPTION("ks0108 LCD Controller driver");
-
-- 
2.30.2

