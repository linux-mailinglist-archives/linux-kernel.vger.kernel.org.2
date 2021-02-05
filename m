Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E92311AE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBFEcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:32:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:55062 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhBFDR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:17:29 -0500
IronPort-SDR: i5/YktUwLTXrmHvFv5NQdmGPQseh6svF/H4rq56dpL4/jyQdu5a9yTAWGoj+tVoGXx78gm1PvU
 VA22ZOjmVC+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="161252119"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="161252119"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:08 -0800
IronPort-SDR: taO8Mi12Xv36iIBFVPi8jgoUfO7c7BTNyJE/dUyiCsWnsg38DFSmjFt2guIiugW1FqZd7JOouf
 IOySZc3+utvA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="397637784"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:52:08 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 8CFEE6365;
        Fri,  5 Feb 2021 14:52:08 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 813AC363372; Fri,  5 Feb 2021 14:52:08 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH v5 12/34] misc: xlink-pcie: lh: Prepare changes for adding remote host driver
Date:   Fri,  5 Feb 2021 14:51:42 -0800
Message-Id: <20210205225204.32902-13-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205225204.32902-1-mgross@linux.intel.com>
References: <20210205225204.32902-1-mgross@linux.intel.com>
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

