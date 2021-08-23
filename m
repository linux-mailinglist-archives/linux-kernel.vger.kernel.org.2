Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A343F51A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhHWUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhHWUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:02:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D438C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:01:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n12so10844547plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vN8w33D+Pwcz1VufoHf/1Z3mdZFc7Np4Y5/rGD4A5ps=;
        b=Foh25uOS7am8WDPHb2hfI560kfJ+aZWfE1MeSy/Jk79DAkK8et8kb/YZtbFSaWqUwP
         T6AcSz4bL/0z46pkDQ511Yg1llnyXDvangeP3F3quPnno31yMd2MKUNoYlTePh2D6//Z
         b8eNv1ae2xaKkjwa9u6NS1K7gvlDeRIL9cfJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vN8w33D+Pwcz1VufoHf/1Z3mdZFc7Np4Y5/rGD4A5ps=;
        b=XL4SwGIUCcEi+OBlmAHWfFk8v5bIroGafD5R3/1tWM1PpDjDpweKadItSzsKo2R5eB
         /Orwc1orI7zFfieUqbYEj2O7eFYK+4GAlTp7+dXRleXu2Dxaygkn47L4Mw5qQqWZwhdZ
         Ac1huw2TbhRj+SG3vI8c3OrvocUvMR3loKWZXST9lyGx9IlbNKoqHOir1RyBM84SQ60Q
         wu9NhNDXcqSwb2EzXuzI+PZxWbU3BcQO24ydGxZH+hTUXfVbABqzNXH1/GbFdKh9JZ/R
         WVkU8H3jDRhnlX3BfHFrejBxeDjPpPv1uCtJ1jdDmSgAmwaOxbbSK08vrH9nupT1niPH
         61rQ==
X-Gm-Message-State: AOAM533lVF7m2Vfs9btU6K5kybgrFmVs5HFtbol1dj4Hx2F9JbC4LSZg
        ONvTyBxotX0wXuRiFe/c6OcB5w==
X-Google-Smtp-Source: ABdhPJzYMl7P1hpCYhtUHxYx7udSXx9Nqo+M1aUCTrIOXBn2Os1ARhc58IvGdVRRphQkGFEFK+ViMA==
X-Received: by 2002:a17:90b:4b12:: with SMTP id lx18mr255980pjb.121.1629748904956;
        Mon, 23 Aug 2021 13:01:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6e72:aaf4:2f33:9528])
        by smtp.gmail.com with UTF8SMTPSA id w11sm4883971pgf.5.2021.08.23.13.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 13:01:44 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_trace: Fix format warnings
Date:   Mon, 23 Aug 2021 13:01:32 -0700
Message-Id: <20210823200132.2006257-1-gwendal@chromium.org>
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
 drivers/platform/chrome/cros_ec_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index f50b9f9b8610..a2052db55671 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -92,7 +92,7 @@ TRACE_EVENT(cros_ec_sensorhub_timestamp,
 		__entry->current_time = current_time;
 		__entry->delta = current_timestamp - current_time;
 	),
-	TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+	TP_printk("ec_ts: %9d, ec_fifo_ts: %9d, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
 		  __entry->ec_sample_timestamp,
 		__entry->ec_fifo_timestamp,
 		__entry->fifo_timestamp,
@@ -122,7 +122,7 @@ TRACE_EVENT(cros_ec_sensorhub_data,
 		__entry->current_time = current_time;
 		__entry->delta = current_timestamp - current_time;
 	),
-	TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+	TP_printk("ec_num: %4d, ec_fifo_ts: %9d, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
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

