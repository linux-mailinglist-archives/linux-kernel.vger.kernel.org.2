Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF145694B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhKSEnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKSEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:43:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w1so37109037edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhRx6ewN7MwnNiVVmf6uS+ga/E3172l7ca+KEv51r0c=;
        b=QcD6JOtHSQXxpeN4cG1iy87xBGDtfFzbi329c8gcT7ioOpD59oqjzanCrw7du7PWgS
         p9i6dzinZ70jG3+73/emKn9E6xMzjKpVIXz4Kc3PPqtaxg63dV9Eboz4KLqkLezz3sQ4
         zdNbQFCoaaey3sqyiiK1p+M6YCMuM7d5kU1k8f7uAe9WLjJz5s4PXUsY13oWlkHtY8QU
         UnZoU1D20I4f3Aw8sN0Dc9hvCCqQn54d9D6yEXU1hdNXEwIQf6eKDlTr3elAoyLb9dsY
         NI/fmHG4UP8qjC2lfujmWOBNLboqDijRc90Bd/vsn3vNCAggI4LZSI2B5pfy1FtXmG79
         RGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhRx6ewN7MwnNiVVmf6uS+ga/E3172l7ca+KEv51r0c=;
        b=3OvI0CmKZZRkW13MXJ8ixgFeH63geynVr81oOBB5/QACTBvMXY2BFY3Js/VQIP6LtO
         +gTEj4BP2HTLPkpgxTHLuYOIwvTEyeuP6E25yrzGPV2ifHJjLthKT5/rg2U8JljT6uwG
         NX05jKFEhngltdcbTPq4JiUPx2+fXBTXynwMaIXfwGOcA6JN9256bMJJBffyj/j8I0QK
         X3Or7wAvLxh3a5ZpzL/Ky0RHHzBVlUmGehNYDp/kDbylKoXPr9ZyDWkErsptGI+1UFQH
         32PFI7qrO+ImUmolyjPCaHsCNooZKmD0YUxQD5072vkDWuUr+HAQITnWu0zAgLP7WzC9
         NRGw==
X-Gm-Message-State: AOAM533sveIu1Od6sbb9MDN1iXJB5hrdW01g4QnSAcJ5hf1WJ37Aq01n
        qrFPL14dDs4ImGcy2OsSGT0kHMwRZaM4Fg==
X-Google-Smtp-Source: ABdhPJzlQYr2/c4h2k4Da/q0+y8ZYRFHZVleQpwZkxTBiW7kVm76gXtKTYfwV7K/nQEk/FC9dEcctg==
X-Received: by 2002:a17:907:6d20:: with SMTP id sa32mr3935757ejc.108.1637296832705;
        Thu, 18 Nov 2021 20:40:32 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id lv19sm694709ejb.54.2021.11.18.20.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 20:40:32 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] [RFC] tracing: Refactor ring buffer implementation
Date:   Fri, 19 Nov 2021 06:40:27 +0200
Message-Id: <20211119044030.85368-2-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119044030.85368-1-tz.stoyanov@gmail.com>
References: <20211119044030.85368-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to introduce sub-buffer size per ring buffer, some internal
refactoring is needed. As ring_buffer_print_page_header() will depend on
the trace_buffer structure, it is moved after the structure definition.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 kernel/trace/ring_buffer.c | 59 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2699e9e562b1..cc34dbfdd29b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -371,35 +371,6 @@ static inline int test_time_stamp(u64 delta)
 /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
 #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
 
-int ring_buffer_print_page_header(struct trace_seq *s)
-{
-	struct buffer_data_page field;
-
-	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
-			 "offset:0;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)sizeof(field.time_stamp),
-			 (unsigned int)is_signed_type(u64));
-
-	trace_seq_printf(s, "\tfield: local_t commit;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 (unsigned int)sizeof(field.commit),
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: int overwrite;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 1,
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: char data;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)BUF_PAGE_SIZE,
-			 (unsigned int)is_signed_type(char));
-
-	return !trace_seq_has_overflowed(s);
-}
 
 struct rb_irq_work {
 	struct irq_work			work;
@@ -559,6 +530,36 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+int ring_buffer_print_page_header(struct trace_seq *s)
+{
+	struct buffer_data_page field;
+
+	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
+			 "offset:0;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)sizeof(field.time_stamp),
+			 (unsigned int)is_signed_type(u64));
+
+	trace_seq_printf(s, "\tfield: local_t commit;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 (unsigned int)sizeof(field.commit),
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: int overwrite;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 1,
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: char data;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), data),
+			 (unsigned int)BUF_PAGE_SIZE,
+			 (unsigned int)is_signed_type(char));
+
+	return !trace_seq_has_overflowed(s);
+}
+
 #ifdef RB_TIME_32
 
 /*
-- 
2.31.1

