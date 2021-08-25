Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2A3F7C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbhHYSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhHYSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:18:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6BDC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:18:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso4713362pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InsY6Lj4sdxvx5Es6EZDInTBtlPB/ST6GXWE1MVZ6hA=;
        b=NgB+oqTUbX9RTt45b4MdB+l7PFT9efVvVlcKtAZ2bvPaJ6sSNi8wAXWzEH50KgYWrA
         xkE6ST3bDswbQ1epGVUhOOvmt2LVSk3p2aseqvAxxmTm/ojPMkVk9byII7QrFg8FjvGy
         RKaul7UtxqVa8SRgE6ngDRTzJ7/o8OwigodzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InsY6Lj4sdxvx5Es6EZDInTBtlPB/ST6GXWE1MVZ6hA=;
        b=axv6lSWbCiYAzgu9p67GRUZh1bc+6WRotYRyBZg8kN+NoDHeKeNm55DLwtlM3MISSx
         +gd62hhivLaMSa1gg8bKcCahkzIouB8ToPApFKYWc3qNiUfM13FgXok7MwyQkAr8oVML
         HH8wx6kvv72Keth+VXrJvhv8VVBBjWmzrs1paknWm3kLU5KBsgQVcgzBY4gVLMjjN0Jy
         QOPW5nSxG2DGi6MUWKQ4JmE5sIs9WCO/+1mzFyHvjRwBqWv0dB6tN5YCozczE2T/IPzj
         BPQ9wzbwELhQ5plDWfmaeZc8FVkcyMAUt13OgTRuqZyG4qfFc3oNE7vVY4Cp1gPhnUva
         vJjA==
X-Gm-Message-State: AOAM533OIi7G3QWJY/tj64X8y6/wl0O0QtqM7HYClt8acetCeExeXywI
        7+F5a0VFzspz1D2gg+BWacpTSQ==
X-Google-Smtp-Source: ABdhPJzSTjgZtSDgp6sJuCKjKwRbARY8O/vczpgOg/v5P8YCKBabQv0Md42cfC4X3T3NNbbxYx1KWA==
X-Received: by 2002:a17:90b:ec9:: with SMTP id gz9mr11572369pjb.24.1629915489565;
        Wed, 25 Aug 2021 11:18:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:43ef:7c11:c445:195f])
        by smtp.gmail.com with UTF8SMTPSA id fh2sm273902pjb.12.2021.08.25.11.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 11:18:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] platform/chrome: cros_ec_trace: Fix format warnings
Date:   Wed, 25 Aug 2021 11:18:02 -0700
Message-Id: <20210825181802.2838484-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix printf format issues in new tracing events.

Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to command traces")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Use %u instead of %d for ec timestamp, it is presented as a u32.

 drivers/platform/chrome/cros_ec_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index f50b9f9b8610..9d0c848af310 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -92,7 +92,7 @@ TRACE_EVENT(cros_ec_sensorhub_timestamp,
 		__entry->current_time = current_time;
 		__entry->delta = current_timestamp - current_time;
 	),
-	TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+	TP_printk("ec_ts: %9d, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
 		  __entry->ec_sample_timestamp,
 		__entry->ec_fifo_timestamp,
 		__entry->fifo_timestamp,
@@ -122,7 +122,7 @@ TRACE_EVENT(cros_ec_sensorhub_data,
 		__entry->current_time = current_time;
 		__entry->delta = current_timestamp - current_time;
 	),
-	TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+	TP_printk("ec_num: %4d, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
 		  __entry->ec_sensor_num,
 		__entry->ec_fifo_timestamp,
 		__entry->fifo_timestamp,
@@ -153,7 +153,7 @@ TRACE_EVENT(cros_ec_sensorhub_filter,
 		__entry->x = state->x_offset;
 		__entry->y = state->y_offset;
 	),
-	TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %d x: %12lld y: %12lld",
+	TP_printk("dx: %12lld. dy: %12lld median_m: %12lld median_error: %12lld len: %lld x: %12lld y: %12lld",
 		  __entry->dx,
 		__entry->dy,
 		__entry->median_m,
-- 
2.33.0.rc2.250.ged5fa647cd-goog

