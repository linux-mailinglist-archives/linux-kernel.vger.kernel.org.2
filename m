Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861B2382C19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhEQMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:30:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:62855 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhEQMap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:30:45 -0400
IronPort-SDR: wXkMO2ZOKTmNCJvhDnQt1J2C3yJh8h8MC52SbvpOkkKpSoVAgF6BG931JuLuwEq1Kg96L3OrML
 PHqV3H4WUWRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200503830"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200503830"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:29:28 -0700
IronPort-SDR: K800SeI3Oc8FH/odrKivCIdE23HuEchu+xUMuS5WYO/zsOGWxTfkuCcX7sgPXEaHm9gplBf9Le
 CFY7iVV2OJbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="540520382"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2021 05:29:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3FF8850E; Mon, 17 May 2021 15:29:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 3/4] devres: No need to call remove_nodes() when there none present
Date:   Mon, 17 May 2021 15:29:45 +0300
Message-Id: <20210517122946.53161-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
References: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a list of devres nodes is empty, no need to call remove_nodes().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on top of v5.13-rc2

 drivers/base/devres.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index db1f3137fc81..dee48858663f 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -526,6 +526,10 @@ int devres_release_all(struct device *dev)
 	if (WARN_ON(dev->devres_head.next == NULL))
 		return -ENODEV;
 
+	/* Nothing to release if list is empty */
+	if (list_empty(&dev->devres_head))
+		return 0;
+
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	cnt = remove_nodes(dev, dev->devres_head.next, &dev->devres_head, &todo);
 	spin_unlock_irqrestore(&dev->devres_lock, flags);
-- 
2.30.2

