Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD393B2491
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:39:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:8652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFXBjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:39:15 -0400
IronPort-SDR: Trn/a6TXtJHlb3MAVjjxsnSiI9wT4AGBVAfnIn20cCQ23ZoSPyEadgYnmvacAXkSv39dshyIsi
 74GrJSna9FrA==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187756984"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="187756984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:36:55 -0700
IronPort-SDR: fRKD1f4RaCC1K7hGgeS8GV+N/JRU7rBAyUkzR141Hn/ChHgXQjIuHc4qbE0hs27OLiKNrX0zTY
 6KYtUZeOSvWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="490928468"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 18:36:52 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Subject: [PATCH 1/7] driver core: Add a way to get to bus devices kset
Date:   Wed, 23 Jun 2021 18:22:03 -0700
Message-Id: <1624497729-158864-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add an accessor function to get to the bus devices kset associated with
a struct bus_type.

The user of this is the following perf changes, which will need to get
to the kobj of the 'devices' directory of a certain bus.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com
---
 drivers/base/bus.c         | 6 ++++++
 include/linux/device/bus.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 36d0c65..3d621a8 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -899,6 +899,12 @@ struct kset *bus_get_kset(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(bus_get_kset);
 
+struct kset *bus_get_devices_kset(struct bus_type *bus)
+{
+	return bus->p->devices_kset;
+}
+EXPORT_SYMBOL_GPL(bus_get_devices_kset);
+
 struct klist *bus_get_device_klist(struct bus_type *bus)
 {
 	return &bus->p->klist_devices;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 1ea5e1d..0ab9273 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -283,6 +283,7 @@ extern int bus_unregister_notifier(struct bus_type *bus,
 #define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
+extern struct kset *bus_get_devices_kset(struct bus_type *bus);
 extern struct klist *bus_get_device_klist(struct bus_type *bus);
 
 #endif
-- 
2.7.4

