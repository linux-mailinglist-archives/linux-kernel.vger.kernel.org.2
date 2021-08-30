Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B13FBB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhH3SBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhH3SBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:01:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:00:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m4so9035438pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oq9MDxzCjWgZNcYhm/uX+EK+PnOXVXPhzQM6wZgcoeE=;
        b=kVBExtZHras/dMW0XEphzWaLdTNxWjkXTTLPnwH7jY/ARGID45chscVl7ZCR9lfpyk
         HgKvgVhfHJZOeZERjcOz3Hus0M5AuPSD7lDTX53cYDz1+fRBzbjxaRBuW/6jOKZ0YFox
         TMQsi++O2uym7RWWbvuazzO8B7CQ/DtWNVrW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oq9MDxzCjWgZNcYhm/uX+EK+PnOXVXPhzQM6wZgcoeE=;
        b=qA/rW08EVUl+11LEqVJTmfTPHbzM7h0Z4d6V7tkg3lFwgx3R+F688XIgZ8WuySS09m
         Ftcl9qFgCG2ccWOnDDG0MxAiKvhH0AFn8+g0vV+KbUI/a7fTEAnESJAdxK6Kywr/XQl3
         2zNGT0RIEkGWNNtT829ARm65Ya2IIUZCy1VYAzFexPpVsP5hg0vtqdmxRhrnhcjgWgsN
         i9Nka1xvLyG2gXydgCLAG4buV5tNq+XeSPXZkwYMJgTfMoGr1UTXlkjROCsigxE4arM1
         hAEGzlEukKwclxCTWrUF0eKX0AOvjH06cD4lLiRwY9gmLB1EJtcBVgw3nqfkKGQAJyXj
         qiSg==
X-Gm-Message-State: AOAM531jktDYniy9E/+P4xPCPOVFJwPdumRvvRdPii+W5C8/J3MHE8rI
        aQBV/WBaUGFzNmbum4b6b+i/c6h7/eybiQ==
X-Google-Smtp-Source: ABdhPJyglnQy5wqZONmvuUL5Li8U/nvxCT3THsHP2Hv0vubdhGRNoAcqUtb64IAfjN0K3WmEmLI3EQ==
X-Received: by 2002:a17:902:bb91:b0:138:7c08:b412 with SMTP id m17-20020a170902bb9100b001387c08b412mr776911pls.25.1630346456226;
        Mon, 30 Aug 2021 11:00:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:17e6:fae1:31c8:850b])
        by smtp.gmail.com with UTF8SMTPSA id p9sm15402978pfn.97.2021.08.30.11.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 11:00:55 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] platform/chrome: cros_ec_trace: Fix format warnings
Date:   Mon, 30 Aug 2021 11:00:50 -0700
Message-Id: <20210830180050.2077261-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix printf format issues in new tracing events.

Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to command traces")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v2:
- Use %u instead of %d for sample timestamp it is presented as a u32 as
  well.
- Use %u instead of %d for ec_sensor_num, index is unsigned.
Changes since v1:
- Use %u instead of %d for ec timestamp, it is presented as a u32.

 drivers/platform/chrome/cros_ec_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index f50b9f9b8610..7e7cfc98657a 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -92,7 +92,7 @@ TRACE_EVENT(cros_ec_sensorhub_timestamp,
 		__entry->current_time = current_time;
 		__entry->delta = current_timestamp - current_time;
 	),
-	TP_printk("ec_ts: %12lld, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+	TP_printk("ec_ts: %9u, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
 		  __entry->ec_sample_timestamp,
 		__entry->ec_fifo_timestamp,
 		__entry->fifo_timestamp,
@@ -122,7 +122,7 @@ TRACE_EVENT(cros_ec_sensorhub_data,
 		__entry->current_time = current_time;
 		__entry->delta = current_timestamp - current_time;
 	),
-	TP_printk("ec_num: %4d, ec_fifo_ts: %12lld, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
+	TP_printk("ec_num: %4u, ec_fifo_ts: %9u, fifo_ts: %12lld, curr_ts: %12lld, curr_time: %12lld, delta %12lld",
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
2.33.0.259.gc128427fd7-goog

