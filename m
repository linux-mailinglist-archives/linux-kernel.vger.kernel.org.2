Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75233553EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbhDFMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:32:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:37895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343902AbhDFMcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:32:17 -0400
IronPort-SDR: NcvCwHjy7aP06QPQ3kKgoE+V9dv0OFjryEU/BwHe8fECVzNz4Gg3uwfouBH+asXkAKFmjbZaex
 wYaA7Ni7YrgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="254387002"
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="254387002"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 05:32:08 -0700
IronPort-SDR: gzxBCHBfWs47g/UQQVi1nPmJhvGhsip65Jgliv8bE6W7kgVP8L9fXc+PA0c/dvbuxs1mkidMal
 7m7ItYI77t8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="448551645"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Apr 2021 05:32:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A2E312A; Tue,  6 Apr 2021 15:32:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: core: Use acpi_find_child_device() for child devices lookup
Date:   Tue,  6 Apr 2021 15:32:20 +0300
Message-Id: <20210406123220.71075-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use acpi_find_child_device() for child devices lookup in mfd_acpi_add_device()
instead of open coded approach. No functional change intended.

While at it, amend a note comment, since usage of _ADR is found on other
platforms and tables than Intel Galileo Gen 2, in particular USB wired devices
are using it, according to Microsoft specifications for embedded platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Validated on Intel Galileo Gen 2.
 drivers/mfd/mfd-core.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6dcff4b8e15e..6f02b8022c6d 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -65,7 +65,7 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 {
 	const struct mfd_cell_acpi_match *match = cell->acpi_match;
 	struct acpi_device *parent, *child;
-	struct acpi_device *adev;
+	struct acpi_device *adev = NULL;
 
 	parent = ACPI_COMPANION(pdev->dev.parent);
 	if (!parent)
@@ -77,10 +77,9 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 	 * _ADR or it will use the parent handle if is no ID is given.
 	 *
 	 * Note that use of _ADR is a grey area in the ACPI specification,
-	 * though Intel Galileo Gen2 is using it to distinguish the children
-	 * devices.
+	 * though at least Intel Galileo Gen 2 is using it to distinguish
+	 * the children devices.
 	 */
-	adev = parent;
 	if (match) {
 		if (match->pnpid) {
 			struct acpi_device_id ids[2] = {};
@@ -93,22 +92,11 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 				}
 			}
 		} else {
-			unsigned long long adr;
-			acpi_status status;
-
-			list_for_each_entry(child, &parent->children, node) {
-				status = acpi_evaluate_integer(child->handle,
-							       "_ADR", NULL,
-							       &adr);
-				if (ACPI_SUCCESS(status) && match->adr == adr) {
-					adev = child;
-					break;
-				}
-			}
+			adev = acpi_find_child_device(parent, match->adr, false);
 		}
 	}
 
-	ACPI_COMPANION_SET(&pdev->dev, adev);
+	ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
-- 
2.30.2

