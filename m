Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8345694D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 05:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhKSEnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 23:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKSEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 23:43:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A51C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x6so25535164edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 20:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RU57N2UcD8nB3ECkusw59vUt4spqdh0Nqi7twS8mDUc=;
        b=XbVh1v442UXE2tUSP2KmD5OYahT5KbPpMdCKq5VnJs9Vbb8y533ZQqerFA1rpmdls+
         uxerLENYCyUg57pkpvILvbLWu4Thz4h6gd+N9lioIvw3+Zh9Gpy19vihXGT2VyYB4xHq
         zdFK3n9PUtwqpnYaUH9cvFu1zXcds3eqCHen/cxczsF77bLwx+1+IBl9NI7JCFHcgiTJ
         jJmyn+MpNDrr7sUSVAFHGCXECBSEBsjJENJ+Rso1WIVdbQWrOyuCmxs1KnvqBTDwDOOR
         uWR54ozWYZE2NJmiQN7rLp91+1A0pebi5+SboUu2HqDK+GGBYNovyq6eWInT+gAvgKSe
         M8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RU57N2UcD8nB3ECkusw59vUt4spqdh0Nqi7twS8mDUc=;
        b=XBuw5d9ZCJx+9jewW6uqg0qWeaqIA/Conmkqofq0h1EIksTyhQ2Z0P7iKZ6d/yPwJs
         W3BOl58fC7Tz8qg//GPUkDgdVSFayUakfSmQlyHAnEgZG2VCwCO0akjLgi6MtC+7nr/+
         CXvxEwXl6zch+GE79FOL/A0qL+mV5fcDWzP1zUkuMAx1/AXNhYf1cq+ew/BtIyQErbDl
         EmEO6KU+HfrWCgYBOMe9hqcD04UF+Wx/Rd1XdpJ4J1c4iUNb8K7iGn3UfpyYJbYidDDf
         Vq6V0wV4vsddm8MfXobQV0nYhmEXd05WW7bt0CQKz3aN4koQaQgg2ukF0lzrTrU62In+
         bF/w==
X-Gm-Message-State: AOAM533RIAJN85+/ZuMX/4fV1RZbObCDH1w5AYe2cSUIK7AuCLBB4VUc
        stjZFUeQEeMcqv415tt+LU6/Hj3jVkKp0w==
X-Google-Smtp-Source: ABdhPJw1+yhB9HJ5JzmkzpwSFTKNB+0E9ow0vOfacQRQQeKVneVoHN/RTZ/GOHEvE9SzYSAgFbh1qA==
X-Received: by 2002:a17:906:f856:: with SMTP id ks22mr3644620ejb.367.1637296834776;
        Thu, 18 Nov 2021 20:40:34 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id lv19sm694709ejb.54.2021.11.18.20.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 20:40:34 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] [RFC] tracing: Add interface for configuring trace sub buffer size
Date:   Fri, 19 Nov 2021 06:40:29 +0200
Message-Id: <20211119044030.85368-4-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119044030.85368-1-tz.stoyanov@gmail.com>
References: <20211119044030.85368-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace ring buffer sub page size can be configured, per trace
instance. A new ftrace file "buffer_subbuf_order" is added to get and
set the size of the ring buffer sub page for current trace instance.
The size must be an order of system page size, that's why the new
interface works with system page order, instead of absolute page size:
0 means the ring buffer sub page is equal to 1 system page and so
forth:
0 - 1 system page
1 - 2 system pages
2 - 4 system pages
...
The ring buffer sub page size is limited between 1 and 128 system
pages. The default value is 1 system page.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 include/linux/ring_buffer.h |  3 ++
 kernel/trace/ring_buffer.c  | 61 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 48 +++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index d9a2e6e8fb79..b8e08920e904 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -202,6 +202,9 @@ struct trace_seq;
 int ring_buffer_print_entry_header(struct trace_seq *s);
 int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s);
 
+int ring_buffer_subbuf_order_get(struct trace_buffer *buffer);
+int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order);
+
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
 };
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 68fdeff449c3..489b8a4c6d77 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -511,6 +511,7 @@ struct trace_buffer {
 	bool				time_stamp_abs;
 
 	unsigned int			subbuf_size;
+	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
 };
 
@@ -5679,6 +5680,66 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+/**
+ * ring_buffer_subbuf_order_get - get order of system sub pages in one buffer page.
+ * @buffer: The ring_buffer to get the system sub page order from
+ *
+ * By default, one ring buffer sub page equals to one system page. This parameter
+ * is configurable, per ring buffer. The size of the ring buffer sub page can be
+ * extended, but must be an order of system page size.
+ *
+ * Returns the order of buffer sub page size, in system pages:
+ * 0 means the sub buffer size is 1 system page and so forth.
+ * In case of an error < 0 is returned.
+ */
+int ring_buffer_subbuf_order_get(struct trace_buffer *buffer)
+{
+	if (!buffer)
+		return -EINVAL;
+
+	return buffer->subbuf_order;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
+
+/**
+ * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
+ * @buffer: The ring_buffer to set the new page size.
+ * @order: Order of the system pages in one sub buffer page
+ *
+ * By default, one ring buffer pages equals to one system page. This API can be
+ * used to set new size of the ring buffer page. The size must be order of
+ * system page size, that's why the input parameter @order is the order of
+ * system pages that are allocated for one ring buffer page:
+ *  0 - 1 system page
+ *  1 - 2 system pages
+ *  3 - 4 system pages
+ *  ...
+ *
+ * Returns 0 on success or < 0 in case of an error.
+ */
+int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
+{
+	int psize;
+
+	if (!buffer || order < 0)
+		return -EINVAL;
+
+	if (buffer->subbuf_order == order)
+		return 0;
+
+	psize = (1 << order) * PAGE_SIZE;
+	if (psize <= BUF_PAGE_HDR_SIZE)
+		return -EINVAL;
+
+	buffer->subbuf_order = order;
+	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
+
+	/* Todo: reset the buffer with the new page size */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d9291bd54fe..cd8bd5ca757e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9005,6 +9005,51 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t
+buffer_order_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	char buf[64];
+	int r;
+
+	r = sprintf(buf, "%d\n", ring_buffer_subbuf_order_get(tr->array_buffer.buffer));
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+buffer_order_write(struct file *filp, const char __user *ubuf,
+		   size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	/* limit between 1 and 128 system pages */
+	if (val < 0 || val > 7)
+		return -EINVAL;
+
+	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
+	if (ret)
+		return ret;
+
+	(*ppos)++;
+
+	return cnt;
+}
+
+static const struct file_operations buffer_order_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= buffer_order_read,
+	.write		= buffer_order_write,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 static struct dentry *trace_instance_dir;
 
 static void
@@ -9458,6 +9503,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
 			tr, &buffer_percent_fops);
 
+	trace_create_file("buffer_subbuf_order", TRACE_MODE_WRITE, d_tracer,
+			  tr, &buffer_order_fops);
+
 	create_trace_options_dir(tr);
 
 	trace_create_maxlat_file(tr, d_tracer);
-- 
2.31.1

