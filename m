Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1338AD92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbhETMHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:07:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:38570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240603AbhETMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:06:25 -0400
IronPort-SDR: 7JXUtJ4uIZIUeUzclbyjtzGx4yazid4DFCBSdYBgJIW2G7AqWx6a0Y34CTrqjCsFKjKtw+wc71
 vh1a+hH3XyOw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200910135"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200910135"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 05:05:02 -0700
IronPort-SDR: c5oImyXSaiNKroa7lrAimVSwts/TNcyTOMvszWN9cSKnfvM6UgfclAZq9CKJwpOfQlrB1oyFPo
 a0L2ldJbuh7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395668989"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2021 05:05:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 684CD12A; Thu, 20 May 2021 15:05:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sander Vanheule <sander@svanheule.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] regmap: mdio: Don't modify output if error happened
Date:   Thu, 20 May 2021 15:05:18 +0300
Message-Id: <20210520120518.30490-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_mdio_read() breaks the principle of "no touch output till it's known
that the operation succeeds". Refactor it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index 5f18fe409f56..5ec208279913 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -11,9 +11,11 @@ static int regmap_mdio_read(void *context, unsigned int reg, unsigned int *val)
 	int ret;
 
 	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg);
-	*val = ret & 0xffff;
+	if (ret < 0)
+		return ret;
 
-	return ret < 0 ? ret : 0;
+	*val = ret & 0xffff;
+	return 0;
 }
 
 static int regmap_mdio_write(void *context, unsigned int reg, unsigned int val)
-- 
2.30.2

