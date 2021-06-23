Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2983B11C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 04:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhFWCgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:36:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:28970 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhFWCgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:36:52 -0400
IronPort-SDR: 6UMWCfktRwG2ALyziiaqP/tBH7N6Lq91QBg4pxFGNOlUy+e3+uoXcU34TMwxVxR+Qnvi+rEOR1
 qcKk8H7rgYdg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194318699"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="194318699"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 19:34:34 -0700
IronPort-SDR: YDkhpdlEzymTdTfnSsFsjP4Ois9k2B22KqAV6mdBPvgud1TOw7CfjCaVBn3ON33iPO38bLcaNq
 6OPiEpy1uICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="454486623"
Received: from jianpeng-mobl1.sh.intel.com ([10.239.160.129])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2021 19:34:32 -0700
From:   Jianpeng Ma <jianpeng.ma@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jianpeng.ma@intel.com
Subject: [PATCH] docs:: ABI: testing: sysfs-firmware-memmap: add some memmap types.
Date:   Wed, 23 Jun 2021 10:31:26 +0800
Message-Id: <20210623023126.104380-1-jianpeng.ma@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare with arch/x86/kernel/e820.c, types of memmap omitted some. So add.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-memmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-memmap b/Documentation/ABI/testing/sysfs-firmware-memmap
index 1f6f4d3a32c0..9205122fa4b1 100644
--- a/Documentation/ABI/testing/sysfs-firmware-memmap
+++ b/Documentation/ABI/testing/sysfs-firmware-memmap
@@ -56,6 +56,10 @@ Description:
 		  - System RAM
 		  - ACPI Tables
 		  - ACPI Non-volatile Storage
+		  - Unusable memory
+		  - Persistent Memory (legacy)
+		  - Persistent Memory
+		  - Soft Reserved
 		  - reserved
 
 		Following shell snippet can be used to display that memory
-- 
2.31.1

