Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1434D0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2NDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhC2NDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:03:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:03:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so19274322ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6T1rMbw5ZcsE5ti8gJc484lBR49yWGMrMkyIroVvTA=;
        b=E9jjE46frS6Ze0NpluGM+E3KK301B9ASIG7y90hoIW8rnMQPvG6D4eNmZ6ziTBD1bR
         +xmyZqeLAK61JhWwzYAi0pVD36WQNisPhSLwrwx6BqKrlfvBuayLG6zYBGMMJey7P6qM
         t1iaBZYlyuvGfbhsD9hMi2ZHgtdrLHuENo67nCUTJ0/JkJoRptCa36na8l4+lhnSIgyb
         bsMSq8PCdit1cLHi8hj8EdVqbH3Azm0tGsP87ueXDJ1trooBb+RCmFOBnZOqTHWphp8f
         DxlAY74Hp2joww8N5FF6MQQv0UCyuUkhWUKNXDtEWPzt9j9zMarFAQhaqyRXQGz1a+VM
         Xasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6T1rMbw5ZcsE5ti8gJc484lBR49yWGMrMkyIroVvTA=;
        b=ibywfpTVnDFjiHRhw5dpDAsOFw5NhB3ycNZzz0XZxBsVqMsqMzyhNw2IBMrbYCWmoa
         ZST/6xlMy1YG9XOjFxcUP3KIf0vswvwLOQPfMAOc5sOtbvXP0jYV57svBAO7NNrahcb2
         lwglbOLgHjG6u6n4msUxI6hZwV71b8ewDwCSjvP51mxE1H6hwPOHE59wK8oZKIA90n7h
         u7aSBpd2/Rfifd5cRTXq/69KzpsE4ZIu9Rm6WxYtkcU9r2pLlG3D4J5DBCDxhkqlHAOj
         6vidizUUM+dmuq5FWssZ68mcdWTvfet58uzR8+Z93ZZTncYsf0mMoeXpQzABJmnO0zMA
         tTOw==
X-Gm-Message-State: AOAM531iuPh7yGh31v5QOdn4Dh+Z1iRLcshdYshHTOR3cwpxp+mLZVJa
        8BjfxGTWL43rs0nEDbTDiMwGhaE1iwg5eQ==
X-Google-Smtp-Source: ABdhPJxf1YwoyYXKusr2cP9YfulH6QiEHXqmay9nX5YOLNnlQan2hbV51ZX5In2i/UB6MqxKHcs0ZQ==
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr28844155ejo.229.1617023023020;
        Mon, 29 Mar 2021 06:03:43 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id eo22sm8299861ejc.0.2021.03.29.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:03:42 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH] tracing: Remove unused argument from "ring_buffer_time_stamp()
Date:   Mon, 29 Mar 2021 16:03:31 +0300
Message-Id: <20210329130331.199402-1-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cpu" parameter is not being used by the function.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 include/linux/ring_buffer.h | 2 +-
 kernel/trace/ring_buffer.c  | 2 +-
 kernel/trace/trace.c        | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 057b7ed4fe24..dac53fd3afea 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -181,7 +181,7 @@ unsigned long ring_buffer_commit_overrun_cpu(struct trace_buffer *buffer, int cp
 unsigned long ring_buffer_dropped_events_cpu(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_read_events_cpu(struct trace_buffer *buffer, int cpu);
 
-u64 ring_buffer_time_stamp(struct trace_buffer *buffer, int cpu);
+u64 ring_buffer_time_stamp(struct trace_buffer *buffer);
 void ring_buffer_normalize_time_stamp(struct trace_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct trace_buffer *buffer,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f4216df58e31..2c0ee6484990 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1080,7 +1080,7 @@ static inline u64 rb_time_stamp(struct trace_buffer *buffer)
 	return ts << DEBUG_SHIFT;
 }
 
-u64 ring_buffer_time_stamp(struct trace_buffer *buffer, int cpu)
+u64 ring_buffer_time_stamp(struct trace_buffer *buffer)
 {
 	u64 time;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c8e54b674d3e..3c605957bb5c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -771,7 +771,7 @@ static u64 buffer_ftrace_now(struct array_buffer *buf, int cpu)
 	if (!buf->buffer)
 		return trace_clock_local();
 
-	ts = ring_buffer_time_stamp(buf->buffer, cpu);
+	ts = ring_buffer_time_stamp(buf->buffer);
 	ring_buffer_normalize_time_stamp(buf->buffer, cpu, &ts);
 
 	return ts;
@@ -7173,7 +7173,7 @@ static int tracing_time_stamp_mode_open(struct inode *inode, struct file *file)
 u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe)
 {
 	if (rbe == this_cpu_read(trace_buffered_event))
-		return ring_buffer_time_stamp(buffer, smp_processor_id());
+		return ring_buffer_time_stamp(buffer);
 
 	return ring_buffer_event_time_stamp(buffer, rbe);
 }
@@ -8087,7 +8087,7 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 		trace_seq_printf(s, "oldest event ts: %5llu.%06lu\n",
 								t, usec_rem);
 
-		t = ns2usecs(ring_buffer_time_stamp(trace_buf->buffer, cpu));
+		t = ns2usecs(ring_buffer_time_stamp(trace_buf->buffer));
 		usec_rem = do_div(t, USEC_PER_SEC);
 		trace_seq_printf(s, "now ts: %5llu.%06lu\n", t, usec_rem);
 	} else {
@@ -8096,7 +8096,7 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 				ring_buffer_oldest_event_ts(trace_buf->buffer, cpu));
 
 		trace_seq_printf(s, "now ts: %llu\n",
-				ring_buffer_time_stamp(trace_buf->buffer, cpu));
+				ring_buffer_time_stamp(trace_buf->buffer));
 	}
 
 	cnt = ring_buffer_dropped_events_cpu(trace_buf->buffer, cpu);
-- 
2.25.1

