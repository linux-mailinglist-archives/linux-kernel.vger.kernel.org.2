Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAA3AEC17
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFUPPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:15:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:18874 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFUPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:15:30 -0400
IronPort-SDR: 4xJI4jh8Isr0TEm1gz0vA/gSEquHrDcc71WK/jkpQ/1gN61JtwJbN+TnyQfkk2FSXExi2EAa9g
 HQduvBx/bGqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="205039509"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="205039509"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:13:16 -0700
IronPort-SDR: SQIkoy09putV/Ql2txh0hqWJIwp+1TxlKkvEzpitMzhIu6Usem4c4XT9jPENZKpMziE49fhv3o
 SOYKeFOngyVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486522877"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:13:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/4] intel_th: Remove an unused exit point from intel_th_remove()
Date:   Mon, 21 Jun 2021 18:12:44 +0300
Message-Id: <20210621151246.31891-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
References: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

As described in the added comment device_for_each_child() never returns
a non-zero value. So remove the corresponding error check.

This simplifies the quest to make struct bus_type::remove() return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 24d0c974bfd5..4bf025ef2031 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -100,16 +100,18 @@ static int intel_th_remove(struct device *dev)
 	struct intel_th_driver *thdrv = to_intel_th_driver(dev->driver);
 	struct intel_th_device *thdev = to_intel_th_device(dev);
 	struct intel_th_device *hub = to_intel_th_hub(thdev);
-	int err;
 
 	if (thdev->type == INTEL_TH_SWITCH) {
 		struct intel_th *th = to_intel_th(hub);
 		int i, lowest;
 
-		/* disconnect outputs */
-		err = device_for_each_child(dev, thdev, intel_th_child_remove);
-		if (err)
-			return err;
+		/*
+		 * disconnect outputs
+		 *
+		 * intel_th_child_remove returns 0 unconditionally, so there is
+		 * no need to check the return value of device_for_each_child.
+		 */
+		device_for_each_child(dev, thdev, intel_th_child_remove);
 
 		/*
 		 * Remove outputs, that is, hub's children: they are created
-- 
2.30.2

