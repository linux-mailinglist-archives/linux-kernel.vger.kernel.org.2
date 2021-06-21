Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC33AEC19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFUPPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:15:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:18882 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhFUPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:15:33 -0400
IronPort-SDR: vJJoj2OLbE3l9DdVVO7UjSQ36TwgeQboC4B/txZ96ToIApvtmLFzXGwF86wqWAdEwWwD22vD8m
 OdbphIvZUqxA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="205039530"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="205039530"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:13:19 -0700
IronPort-SDR: L7o9korl2VAy9v1eakqZnTdNU8P+zOjLo7xbURphAr/LWUeB1gaysFYNVptf5ZvWEvcTM8Bl6l
 WhzVBC+iDiMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486522888"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:13:18 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/4] intel_th: Wait until port is in reset before programming it
Date:   Mon, 21 Jun 2021 18:12:46 +0300
Message-Id: <20210621151246.31891-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
References: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices don't drain their pipelines if we don't make sure that
the corresponding output port is in reset before programming it for
a new trace capture, resulting in bits of old trace appearing in the
new trace capture. Fix that by explicitly making sure the reset is
asserted before programming new trace capture.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 17 +++++++++++++++++
 drivers/hwtracing/intel_th/gth.c      | 16 ++++++++++++++++
 drivers/hwtracing/intel_th/intel_th.h |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 4bf025ef2031..66eed2dff818 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -217,6 +217,22 @@ static ssize_t port_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(port);
 
+static void intel_th_trace_prepare(struct intel_th_device *thdev)
+{
+	struct intel_th_device *hub = to_intel_th_hub(thdev);
+	struct intel_th_driver *hubdrv = to_intel_th_driver(hub->dev.driver);
+
+	if (hub->type != INTEL_TH_SWITCH)
+		return;
+
+	if (thdev->type != INTEL_TH_OUTPUT)
+		return;
+
+	pm_runtime_get_sync(&thdev->dev);
+	hubdrv->prepare(hub, &thdev->output);
+	pm_runtime_put(&thdev->dev);
+}
+
 static int intel_th_output_activate(struct intel_th_device *thdev)
 {
 	struct intel_th_driver *thdrv =
@@ -237,6 +253,7 @@ static int intel_th_output_activate(struct intel_th_device *thdev)
 	if (ret)
 		goto fail_put;
 
+	intel_th_trace_prepare(thdev);
 	if (thdrv->activate)
 		ret = thdrv->activate(thdev);
 	else
diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index 28509b02a0b5..b3308934a687 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -564,6 +564,21 @@ static void gth_tscu_resync(struct gth_device *gth)
 	iowrite32(reg, gth->base + REG_TSCU_TSUCTRL);
 }
 
+static void intel_th_gth_prepare(struct intel_th_device *thdev,
+				 struct intel_th_output *output)
+{
+	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
+	int count;
+
+	/*
+	 * Wait until the output port is in reset before we start
+	 * programming it.
+	 */
+	for (count = GTH_PLE_WAITLOOP_DEPTH;
+	     count && !(gth_output_get(gth, output->port) & BIT(5)); count--)
+		cpu_relax();
+}
+
 /**
  * intel_th_gth_enable() - enable tracing to an output device
  * @thdev:	GTH device
@@ -815,6 +830,7 @@ static struct intel_th_driver intel_th_gth_driver = {
 	.assign		= intel_th_gth_assign,
 	.unassign	= intel_th_gth_unassign,
 	.set_output	= intel_th_gth_set_output,
+	.prepare	= intel_th_gth_prepare,
 	.enable		= intel_th_gth_enable,
 	.trig_switch	= intel_th_gth_switch,
 	.disable	= intel_th_gth_disable,
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 89c67e0e1d34..0ffb42990175 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -143,6 +143,7 @@ intel_th_output_assigned(struct intel_th_device *thdev)
  * @remove:	remove method
  * @assign:	match a given output type device against available outputs
  * @unassign:	deassociate an output type device from an output port
+ * @prepare:	prepare output port for tracing
  * @enable:	enable tracing for a given output device
  * @disable:	disable tracing for a given output device
  * @irq:	interrupt callback
@@ -164,6 +165,8 @@ struct intel_th_driver {
 					  struct intel_th_device *othdev);
 	void			(*unassign)(struct intel_th_device *thdev,
 					    struct intel_th_device *othdev);
+	void			(*prepare)(struct intel_th_device *thdev,
+					   struct intel_th_output *output);
 	void			(*enable)(struct intel_th_device *thdev,
 					  struct intel_th_output *output);
 	void			(*trig_switch)(struct intel_th_device *thdev,
-- 
2.30.2

