Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FCF3DF415
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhHCRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:49:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:35913 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238316AbhHCRtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:49:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="200935802"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="200935802"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 10:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="667314372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2021 10:49:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4753B169; Tue,  3 Aug 2021 20:50:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v1 1/1] platform/surface: aggregator: Ouse y instead of objs in Makefile
Date:   Tue,  3 Aug 2021 20:50:00 +0300
Message-Id: <20210803175000.72880-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'objs' is for user space tools, for the kernel modules
we should use 'y'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/surface/aggregator/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
index c8498c41e758..ce548dba1d4b 100644
--- a/drivers/platform/surface/aggregator/Makefile
+++ b/drivers/platform/surface/aggregator/Makefile
@@ -6,12 +6,12 @@ CFLAGS_core.o = -I$(src)
 
 obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
 
-surface_aggregator-objs := core.o
-surface_aggregator-objs += ssh_parser.o
-surface_aggregator-objs += ssh_packet_layer.o
-surface_aggregator-objs += ssh_request_layer.o
-surface_aggregator-objs += controller.o
+surface_aggregator-y := core.o
+surface_aggregator-y += ssh_parser.o
+surface_aggregator-y += ssh_packet_layer.o
+surface_aggregator-y += ssh_request_layer.o
+surface_aggregator-y += controller.o
 
 ifeq ($(CONFIG_SURFACE_AGGREGATOR_BUS),y)
-surface_aggregator-objs += bus.o
+surface_aggregator-y += bus.o
 endif
-- 
2.30.2

