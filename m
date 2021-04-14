Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F7435F8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352693AbhDNQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:25:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:60708 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233385AbhDNQZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:25:22 -0400
IronPort-SDR: qEdPu2f0prdnVgGFRibsYFmizM+Wy5qjlXaeF0Ca5xyw8vlfpSB05Zf32MAjxuZs30Fm3Nqg95
 4ofeOCx8Bpvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="255995993"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="255995993"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:25:00 -0700
IronPort-SDR: 4FSkHrhbDpM9UP8osiiSC5qSKWbBKqfC/5QpWky9QM0Tx5hTq9GddFMUR7trOKzsZ4rm+dKPay
 oORt8XHHYv1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="443872140"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2021 09:24:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3647B24D; Wed, 14 Apr 2021 19:25:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 3/4] devres: No need to call remove_nodes() when there none present
Date:   Wed, 14 Apr 2021 19:25:10 +0300
Message-Id: <20210414162511.59466-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414162511.59466-1-andriy.shevchenko@linux.intel.com>
References: <20210414162511.59466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a list of devres nodes is empty, no need to call remove_nodes().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
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

