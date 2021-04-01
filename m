Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5737351BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhDASK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:10:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:59689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236814AbhDARzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:20 -0400
IronPort-SDR: k5HkxKDkn3fiAAnFHOAH/oAzAzEOXzquMlUKFpxZGurHzlr02JChBGvOT/5JrgKKB211lCh/0z
 ml1cTFX2goKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192320370"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192320370"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 10:10:25 -0700
IronPort-SDR: g6Tse/4thvhlVozYx4wVCCtnNaYRAlvK/7I1niy9zfDmq3OAiASjMKaLEq+mR0uRh/uIzsZqqN
 JnhEabq9BCjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="456067919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2021 10:10:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DDCB3A1; Thu,  1 Apr 2021 20:10:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: Cast to (void *) with __force for __percpu pointer
Date:   Thu,  1 Apr 2021 20:10:30 +0300
Message-Id: <20210401171030.60527-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse is not happy:

  drivers/base/devres.c:1230:9: warning: cast removes address space '__percpu' of expression

Use __force attribute to make it happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index fa2cdb250af4..8746f2212781 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1228,6 +1228,6 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
 	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
-			       (void *)pdata));
+			       (__force void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
-- 
2.30.2

