Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2957031A78A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBLWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:25:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:34611 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhBLWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:24:54 -0500
IronPort-SDR: 288wAyCQX2cYDQrhLy5/rYEQMzoIZBf5fpxE+TEExMqL7/EunbKrCoZ439hoUk7nSmo69f8zII
 4SfN1yhdT7fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="182616438"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="182616438"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:23:08 -0800
IronPort-SDR: r5Yv4bz9+DMZm+es38L4a5H4PDShIJALgl7vEEo4Wm41HF+rHPcdD/sNAIe3ewtsWSWo/N4hkH
 F/M0xorw4wQg==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="400012549"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:23:08 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 224556371;
        Fri, 12 Feb 2021 14:23:08 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 1B4A63636FB; Fri, 12 Feb 2021 14:23:08 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH v6 12/34] misc: xlink-pcie: lh: Prepare changes for adding remote host driver
Date:   Fri, 12 Feb 2021 14:22:42 -0800
Message-Id: <20210212222304.110194-13-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212222304.110194-1-mgross@linux.intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Move logic that can be reused between local host and remote host to
common/ folder

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/{local_host => common}/core.h  | 8 +++-----
 drivers/misc/xlink-pcie/{local_host => common}/util.c  | 8 +++-----
 drivers/misc/xlink-pcie/{local_host => common}/util.h  | 8 +++-----
 drivers/misc/xlink-pcie/{local_host => common}/xpcie.h | 8 +++-----
 drivers/misc/xlink-pcie/local_host/Makefile            | 2 +-
 drivers/misc/xlink-pcie/local_host/core.c              | 4 ++--
 drivers/misc/xlink-pcie/local_host/epf.h               | 4 ++--
 7 files changed, 17 insertions(+), 25 deletions(-)
 rename drivers/misc/xlink-pcie/{local_host => common}/core.h (96%)
 rename drivers/misc/xlink-pcie/{local_host => common}/util.c (97%)
 rename drivers/misc/xlink-pcie/{local_host => common}/util.h (91%)
 rename drivers/misc/xlink-pcie/{local_host => common}/xpcie.h (92%)

diff --git a/drivers/misc/xlink-pcie/local_host/core.h b/drivers/misc/xlink-pcie/common/core.h
similarity index 96%
rename from drivers/misc/xlink-pcie/local_host/core.h
rename to drivers/misc/xlink-pcie/common/core.h
index 84985ef41a64..656b5e2dbfae 100644
--- a/drivers/misc/xlink-pcie/local_host/core.h
+++ b/drivers/misc/xlink-pcie/common/core.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_CORE_HEADER_
 #define XPCIE_CORE_HEADER_
diff --git a/drivers/misc/xlink-pcie/local_host/util.c b/drivers/misc/xlink-pcie/common/util.c
similarity index 97%
rename from drivers/misc/xlink-pcie/local_host/util.c
rename to drivers/misc/xlink-pcie/common/util.c
index ec808b0cd72b..d99125f61ba0 100644
--- a/drivers/misc/xlink-pcie/local_host/util.c
+++ b/drivers/misc/xlink-pcie/common/util.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #include "util.h"
 
diff --git a/drivers/misc/xlink-pcie/local_host/util.h b/drivers/misc/xlink-pcie/common/util.h
similarity index 91%
rename from drivers/misc/xlink-pcie/local_host/util.h
rename to drivers/misc/xlink-pcie/common/util.h
index 908be897a61d..5295783b0437 100644
--- a/drivers/misc/xlink-pcie/local_host/util.h
+++ b/drivers/misc/xlink-pcie/common/util.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_UTIL_HEADER_
 #define XPCIE_UTIL_HEADER_
diff --git a/drivers/misc/xlink-pcie/local_host/xpcie.h b/drivers/misc/xlink-pcie/common/xpcie.h
similarity index 92%
rename from drivers/misc/xlink-pcie/local_host/xpcie.h
rename to drivers/misc/xlink-pcie/common/xpcie.h
index 8a559617daba..48529eb49be0 100644
--- a/drivers/misc/xlink-pcie/local_host/xpcie.h
+++ b/drivers/misc/xlink-pcie/common/xpcie.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*****************************************************************************
- *
+/*
  * Intel Keem Bay XLink PCIe Driver
  *
- * Copyright (C) 2020 Intel Corporation
- *
- ****************************************************************************/
+ * Copyright (C) 2021 Intel Corporation
+ */
 
 #ifndef XPCIE_HEADER_
 #define XPCIE_HEADER_
diff --git a/drivers/misc/xlink-pcie/local_host/Makefile b/drivers/misc/xlink-pcie/local_host/Makefile
index 28761751d43b..65df94c7e860 100644
--- a/drivers/misc/xlink-pcie/local_host/Makefile
+++ b/drivers/misc/xlink-pcie/local_host/Makefile
@@ -2,4 +2,4 @@ obj-$(CONFIG_XLINK_PCIE_LH_DRIVER) += mxlk_ep.o
 mxlk_ep-objs := epf.o
 mxlk_ep-objs += dma.o
 mxlk_ep-objs += core.o
-mxlk_ep-objs += util.o
+mxlk_ep-objs += ../common/util.o
diff --git a/drivers/misc/xlink-pcie/local_host/core.c b/drivers/misc/xlink-pcie/local_host/core.c
index c67ce2c3067d..2c4e29bce7f7 100644
--- a/drivers/misc/xlink-pcie/local_host/core.c
+++ b/drivers/misc/xlink-pcie/local_host/core.c
@@ -8,8 +8,8 @@
 #include <linux/of_reserved_mem.h>
 
 #include "epf.h"
-#include "core.h"
-#include "util.h"
+#include "../common/core.h"
+#include "../common/util.h"
 
 static struct xpcie *global_xpcie;
 
diff --git a/drivers/misc/xlink-pcie/local_host/epf.h b/drivers/misc/xlink-pcie/local_host/epf.h
index 7220cead0973..40bf4ff36580 100644
--- a/drivers/misc/xlink-pcie/local_host/epf.h
+++ b/drivers/misc/xlink-pcie/local_host/epf.h
@@ -11,8 +11,8 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
-#include "xpcie.h"
-#include "util.h"
+#include "../common/xpcie.h"
+#include "../common/util.h"
 
 #define XPCIE_DRIVER_NAME "mxlk_pcie_epf"
 #define XPCIE_DRIVER_DESC "Intel(R) xLink PCIe endpoint function driver"
-- 
2.17.1

