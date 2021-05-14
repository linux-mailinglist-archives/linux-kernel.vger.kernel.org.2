Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79F380154
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhENA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhENA6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:58:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED83C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:57:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so483206pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eejRBKxxhYAhkXmTA5yo8ermmpOl28PbfWMsmjltTac=;
        b=AIUfFOsta7RgFXf1daGWgrPkNEP1Lp+eOrF1J9k7/Xj95HItjICiYXnHGzDcTrXJcc
         0QhUIj5sYLFt/z1qO1N3A1CSN+mk3wXM1QpR6EhxfMN0YKenFl5YToHZkPBwyHwpjNDB
         kur10bjsARSe1aCQY0Svf4yiB1RDlX1PXXba0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eejRBKxxhYAhkXmTA5yo8ermmpOl28PbfWMsmjltTac=;
        b=RAOTWjD6SnYx9WDmtK3KF0spQCuPB2WcPZ1z33sDmuOWRziKE0QMd/LKTENUMV1YUB
         t2VvW301Z1C/hNPPOsL9B8b5C45QhRhA+SQgBd8d7+gO9gscKayH9uRT3hrqE238Nm0W
         9m5it8c4oblmbGUL2wN+VReFlbt9QR6HYzO62HLdHjsk6eGCMQSPcRdRaQHrPWqeDcVx
         91XHeVCkhtsw1gSi+Cig8frTOQBjPvUx+vfR4Mhe3SITm+lHI/Z67YYUYW1U+gquQ5xk
         Oc86QsmN/e1dHYctHJqXkjQ/f3IiU+PeMAd9znHqvlg+My+0dQmoZovJ+mN5F8j7ZSWZ
         4FdA==
X-Gm-Message-State: AOAM5335X8FL1Ag3YQnvafSjFrBIOdBQf3WD44OVbXkj2fBjaonjeVk9
        opDlyuZ172WP+koI0Nyij0s/CQ==
X-Google-Smtp-Source: ABdhPJwrTrz96FDkLKAzLQv4n0nRLFKGFFLwdBgMR8gYNvEBCudmscPeKd/A8x5x5o3BCEZnU3LI7w==
X-Received: by 2002:a17:90a:e648:: with SMTP id ep8mr44559949pjb.163.1620953861197;
        Thu, 13 May 2021 17:57:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6901:3eca:dc9a:8add])
        by smtp.gmail.com with UTF8SMTPSA id f14sm3552093pjq.50.2021.05.13.17.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 17:57:40 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform/chrome: sensorhub: Add trace events for sample
Date:   Thu, 13 May 2021 17:57:33 -0700
Message-Id: <20210514005733.645548-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace event to report samples and their timestamp coming from the
EC. It allows to check if the timestamps are correct and the filter is
working correctly without introducing too much latency.

To enable these events:

cd /sys/kernel/debug/tracing/
echo 1 > events/cros_ec/enable
echo 0 > events/cros_ec/cros_ec_request_start/enable
echo 0 > events/cros_ec/cros_ec_request_done/enable
echo 1 > tracing_on
cat trace_pipe
Observe event flowing:
irq/105-chromeo-95      [000] ....   613.659758: cros_ec_sensorhub_timestamp: ...
irq/105-chromeo-95      [000] ....   613.665219: cros_ec_sensorhub_filter: dx: ...

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/Makefile              |  2 +-
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 14 +++
 drivers/platform/chrome/cros_ec_trace.h       | 94 +++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 41baccba033f7..f901d2e43166c 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
-cros-ec-sensorhub-objs			:= cros_ec_sensorhub.o cros_ec_sensorhub_ring.o
+cros-ec-sensorhub-objs			:= cros_ec_sensorhub.o cros_ec_sensorhub_ring.o cros_ec_trace.o
 obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros-ec-sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 8921f24e83bac..98e37080f7609 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -17,6 +17,8 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 
+#include "cros_ec_trace.h"
+
 /* Precision of fixed point for the m values from the filter */
 #define M_PRECISION BIT(23)
 
@@ -291,6 +293,7 @@ cros_ec_sensor_ring_ts_filter_update(struct cros_ec_sensors_ts_filter_state
 		state->median_m = 0;
 		state->median_error = 0;
 	}
+	trace_cros_ec_sensorhub_filter(state, dx, dy);
 }
 
 /**
@@ -427,6 +430,11 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 			if (new_timestamp - *current_timestamp > 0)
 				*current_timestamp = new_timestamp;
 		}
+		trace_cros_ec_sensorhub_timestamp(in->timestamp,
+						  fifo_info->timestamp,
+						  fifo_timestamp,
+						  *current_timestamp,
+						  now);
 	}
 
 	if (in->flags & MOTIONSENSE_SENSOR_FLAG_ODR) {
@@ -460,6 +468,12 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 
 	/* Regular sample */
 	out->sensor_id = in->sensor_num;
+	trace_cros_ec_sensorhub_data(in->sensor_num,
+				     fifo_info->timestamp,
+				     fifo_timestamp,
+				     *current_timestamp,
+				     now);
+
 	if (*current_timestamp - now > 0) {
 		/*
 		 * This fix is needed to overcome the timestamp filter putting
diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index f744b21bc655f..f50b9f9b86106 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
 
 #include <linux/tracepoint.h>
 
@@ -70,6 +71,99 @@ TRACE_EVENT(cros_ec_request_done,
 		  __entry->retval)
 );
 
+TRACE_EVENT(cros_ec_sensorhub_timestamp,
+	    TP_PROTO(u32 ec_sample_timestamp, u32 ec_fifo_timestamp, s64 fifo_timestamp,
+		     s64 current_timestamp, s64 current_time),
+	TP_ARGS(ec_sample_timestamp, ec_fifo_timestamp, fifo_timestamp, current_timestamp,
+		current_time),
+	TP_STRUCT__entry(
+		__field(u32, ec_sample_timestamp)
+		__field(u32, ec_fifo_timestamp)
+		__field(s64, fifo_timestamp)
+		__field(s64, current_timestamp)
+		__field(s64, current_time)
+		__field(s64, delta)
+	),
+	TP_fast_assign(
+		__entry->ec_sample_timestamp = ec_sample_timestamp;
+		__entry->ec_fifo_timestamp = ec_fifo_timestamp;
+		__entry->fifo_timestamp = fifo_timestamp;
+		__entry->current_timestamp = current_timestamp;
+		__entry->current_time = current_time;
+		__entry->delta = current_timestamp - current_time;
+	),
+	TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+		  __entry->ec_sample_timestamp,
+		__entry->ec_fifo_timestamp,
+		__entry->fifo_timestamp,
+		__entry->current_timestamp,
+		__entry->current_time,
+		__entry->delta
+	)
+);
+
+TRACE_EVENT(cros_ec_sensorhub_data,
+	    TP_PROTO(u32 ec_sensor_num, u32 ec_fifo_timestamp, s64 fifo_timestamp,
+		     s64 current_timestamp, s64 current_time),
+	TP_ARGS(ec_sensor_num, ec_fifo_timestamp, fifo_timestamp, current_timestamp, current_time),
+	TP_STRUCT__entry(
+		__field(u32, ec_sensor_num)
+		__field(u32, ec_fifo_timestamp)
+		__field(s64, fifo_timestamp)
+		__field(s64, current_timestamp)
+		__field(s64, current_time)
+		__field(s64, delta)
+	),
+	TP_fast_assign(
+		__entry->ec_sensor_num = ec_sensor_num;
+		__entry->ec_fifo_timestamp = ec_fifo_timestamp;
+		__entry->fifo_timestamp = fifo_timestamp;
+		__entry->current_timestamp = current_timestamp;
+		__entry->current_time = current_time;
+		__entry->delta = current_timestamp - current_time;
+	),
+	TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+		  __entry->ec_sensor_num,
+		__entry->ec_fifo_timestamp,
+		__entry->fifo_timestamp,
+		__entry->current_timestamp,
+		__entry->current_time,
+		__entry->delta
+	)
+);
+
+TRACE_EVENT(cros_ec_sensorhub_filter,
+	    TP_PROTO(struct cros_ec_sensors_ts_filter_state *state, s64 dx, s64 dy),
+	TP_ARGS(state, dx, dy),
+	TP_STRUCT__entry(
+		__field(s64, dx)
+		__field(s64, dy)
+		__field(s64, median_m)
+		__field(s64, median_error)
+		__field(s64, history_len)
+		__field(s64, x)
+		__field(s64, y)
+	),
+	TP_fast_assign(
+		__entry->dx = dx;
+		__entry->dy = dy;
+		__entry->median_m = state->median_m;
+		__entry->median_error = state->median_error;
+		__entry->history_len = state->history_len;
+		__entry->x = state->x_offset;
+		__entry->y = state->y_offset;
+	),
+	TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %d x: %12lld y: %12lld",
+		  __entry->dx,
+		__entry->dy,
+		__entry->median_m,
+		__entry->median_error,
+		__entry->history_len,
+		__entry->x,
+		__entry->y
+	)
+);
+
 
 #endif /* _CROS_EC_TRACE_H_ */
 
-- 
2.31.1.751.gd2f1c929bd-goog

