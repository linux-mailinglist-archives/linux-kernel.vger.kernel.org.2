Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C89B32775A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhCAGGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:06:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:53894 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhCAGGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:06:10 -0500
IronPort-SDR: 2/IslI08JSqQx301Xzc4eXMM7P5y/PLVRsCef3KJj95KE1ld/WNDH+DfxcmlB5YmIXBXEelZrb
 nEPsuajxoaiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165599696"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="165599696"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 22:04:41 -0800
IronPort-SDR: hboywwKxAtHEETOma3UqlgnKuDluP+OvoY28oExImST73kBjVfRZfj8vRkXg4L2DhhfpDGCK5Z
 rbKuStxr6z5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="397574197"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2021 22:04:39 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v3 1/4] mfd: intel-m10-bmc: Fix the register access range
Date:   Mon,  1 Mar 2021 13:59:42 +0800
Message-Id: <1614578385-26955-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the max register address of MAX 10 BMC. The range
0x20000000 ~ 0x200000fc are for control registers of the QSPI flash
controller, which are not accessible to host.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: no change.
v3: no change, rebased to 5.12-rc1
---
 include/linux/mfd/intel-m10-bmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 74d4e19..9b54ca1 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,7 +11,7 @@
 
 #define M10BMC_LEGACY_SYS_BASE		0x300400
 #define M10BMC_SYS_BASE			0x300800
-#define M10BMC_MEM_END			0x200000fc
+#define M10BMC_MEM_END			0x1fffffff
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
-- 
2.7.4

