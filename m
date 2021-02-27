Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55F326C24
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 08:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhB0HlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 02:41:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13095 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhB0HlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 02:41:13 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dndgc4FJSz16Cm2;
        Sat, 27 Feb 2021 15:38:52 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 15:40:23 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>,
        <jacob.jun.pan@linux.intel.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] iommu/vt-d: Fix status code for Allocate/Free PASID command
Date:   Sat, 27 Feb 2021 15:39:09 +0800
Message-ID: <20210227073909.432-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Intel vt-d spec, Rev 3.0 (section 10.4.45 "Virtual Command Response
Register"), the status code of "No PASID available" error in response to
the Allocate PASID command is 2, not 1. The same for "Invalid PASID" error
in response to the Free PASID command.

We will otherwise see confusing kernel log under the command failure from
guest side. Fix it.

Fixes: 24f27d32ab6b ("iommu/vt-d: Enlightened PASID allocation")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/iommu/intel/pasid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 97dfcffbf495..444c0bec221a 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -30,8 +30,8 @@
 #define VCMD_VRSP_IP			0x1
 #define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
 #define VCMD_VRSP_SC_SUCCESS		0
-#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
-#define VCMD_VRSP_SC_INVALID_PASID	1
+#define VCMD_VRSP_SC_NO_PASID_AVAIL	2
+#define VCMD_VRSP_SC_INVALID_PASID	2
 #define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
 #define VCMD_CMD_OPERAND(e)		((e) << 8)
 /*
-- 
2.19.1

