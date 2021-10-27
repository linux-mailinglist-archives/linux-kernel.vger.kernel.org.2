Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0A43CD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhJ0Pgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:36:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:53164 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233321AbhJ0Pga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:36:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="291024222"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="291024222"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="572983804"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2021 08:34:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BAE74107; Wed, 27 Oct 2021 18:34:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v1 1/1] soc: fsl: Replace kernel.h with the necessary inclusions
Date:   Wed, 27 Oct 2021 18:33:54 +0300
Message-Id: <20211027153354.81129-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/soc/fsl/dpaa2-fd.h    | 3 ++-
 include/soc/fsl/qe/immap_qe.h | 3 ++-
 include/soc/fsl/qe/qe_tdm.h   | 4 +++-
 include/soc/fsl/qe/ucc_fast.h | 2 +-
 include/soc/fsl/qe/ucc_slow.h | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/soc/fsl/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
index 90ae8d191f1a..bae490cac0aa 100644
--- a/include/soc/fsl/dpaa2-fd.h
+++ b/include/soc/fsl/dpaa2-fd.h
@@ -7,7 +7,8 @@
 #ifndef __FSL_DPAA2_FD_H
 #define __FSL_DPAA2_FD_H
 
-#include <linux/kernel.h>
+#include <linux/byteorder/generic.h>
+#include <linux/types.h>
 
 /**
  * DOC: DPAA2 FD - Frame Descriptor APIs for DPAA2
diff --git a/include/soc/fsl/qe/immap_qe.h b/include/soc/fsl/qe/immap_qe.h
index 7614fee532f1..edd601f53f5d 100644
--- a/include/soc/fsl/qe/immap_qe.h
+++ b/include/soc/fsl/qe/immap_qe.h
@@ -13,7 +13,8 @@
 #define _ASM_POWERPC_IMMAP_QE_H
 #ifdef __KERNEL__
 
-#include <linux/kernel.h>
+#include <linux/types.h>
+
 #include <asm/io.h>
 
 #define QE_IMMAP_SIZE	(1024 * 1024)	/* 1MB from 1MB+IMMR */
diff --git a/include/soc/fsl/qe/qe_tdm.h b/include/soc/fsl/qe/qe_tdm.h
index b6febe225071..43ea830cfe1f 100644
--- a/include/soc/fsl/qe/qe_tdm.h
+++ b/include/soc/fsl/qe/qe_tdm.h
@@ -10,8 +10,8 @@
 #ifndef _QE_TDM_H_
 #define _QE_TDM_H_
 
-#include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/types.h>
 
 #include <soc/fsl/qe/immap_qe.h>
 #include <soc/fsl/qe/qe.h>
@@ -19,6 +19,8 @@
 #include <soc/fsl/qe/ucc.h>
 #include <soc/fsl/qe/ucc_fast.h>
 
+struct device_node;
+
 /* SI RAM entries */
 #define SIR_LAST	0x0001
 #define SIR_BYTE	0x0002
diff --git a/include/soc/fsl/qe/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
index 9696a5b9b5d1..ad60b87a3c69 100644
--- a/include/soc/fsl/qe/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -10,7 +10,7 @@
 #ifndef __UCC_FAST_H__
 #define __UCC_FAST_H__
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #include <soc/fsl/qe/immap_qe.h>
 #include <soc/fsl/qe/qe.h>
diff --git a/include/soc/fsl/qe/ucc_slow.h b/include/soc/fsl/qe/ucc_slow.h
index 11a216e4e919..7548ce8a202d 100644
--- a/include/soc/fsl/qe/ucc_slow.h
+++ b/include/soc/fsl/qe/ucc_slow.h
@@ -11,7 +11,7 @@
 #ifndef __UCC_SLOW_H__
 #define __UCC_SLOW_H__
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #include <soc/fsl/qe/immap_qe.h>
 #include <soc/fsl/qe/qe.h>
-- 
2.33.0

