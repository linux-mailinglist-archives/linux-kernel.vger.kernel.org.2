Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651903EF263
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhHQTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:02:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:18728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhHQTCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:02:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203324520"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="203324520"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 12:01:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="488147342"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.12.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 12:01:31 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC PATCH 1/2] driver core: export driver_deferred_probe_trigger()
Date:   Tue, 17 Aug 2021 14:00:56 -0500
Message-Id: <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The premise of the deferred probe implementation is that a successful
driver binding is a proxy for the resources provided by this driver
becoming available. While this is a correct assumption in most of the
cases, there are exceptions to the rule such as

a) the use of request_firmware_nowait(). In this case, the resources
may become available when the 'cont' callback completes, for example
when if the firmware needs to be downloaded and executed on a SoC
core or DSP.

b) a split implementation of the probe with a workqueue when one or
ore request_module() calls are required: a synchronous probe prevents
other drivers from probing, impacting boot time, and an async probe is
not allowed to avoid a deadlock. This is the case on all Intel audio
platforms, with request_module() being required for the i915 display
audio and HDaudio external codecs.

In these cases, there is no way to notify the deferred probe
infrastructure of the enablement of resources after the driver
binding.

The driver_deferred_probe_trigger() function is currently used
'anytime a driver is successfully bound to a device', this patch
suggest exporing by exporting it so that drivers can kick-off
re-probing of deferred devices at the end of a deferred processing.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/dd.c             | 3 ++-
 include/linux/device/driver.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 437cd61343b2..33eca45aa65a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -171,7 +171,7 @@ static bool driver_deferred_probe_enable = false;
  * changes in the midst of a probe, then deferred processing should be triggered
  * again.
  */
-static void driver_deferred_probe_trigger(void)
+void driver_deferred_probe_trigger(void)
 {
 	if (!driver_deferred_probe_enable)
 		return;
@@ -193,6 +193,7 @@ static void driver_deferred_probe_trigger(void)
 	 */
 	queue_work(system_unbound_wq, &deferred_probe_work);
 }
+EXPORT_SYMBOL_GPL(driver_deferred_probe_trigger);
 
 /**
  * device_block_probing() - Block/defer device's probes
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..2eec79d752a9 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -240,6 +240,7 @@ extern int driver_deferred_probe_timeout;
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 void driver_init(void);
+void driver_deferred_probe_trigger(void);
 
 /**
  * module_driver() - Helper macro for drivers that don't do anything
-- 
2.25.1

