Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDF3424DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCSSin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhCSSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B7C61991;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017nB-Ty; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183801.808862244@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [for-next][PATCH 12/13] seq_buf: Add seq_buf_terminate() API
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In the case that the seq_buf buffer needs to be printed directly, add a way
to make sure that the buffer is safe to read by forcing a nul terminating
character at the end of the string, or the last byte of the buffer if the
string has overflowed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 9d6c28cc4d8f..5b31c5147969 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -71,6 +71,31 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 	return min(s->len, s->size);
 }
 
+/**
+ * seq_buf_terminate - Make sure buffer is nul terminated
+ * @s: the seq_buf descriptor to terminate.
+ *
+ * This makes sure that the buffer in @s is nul terminated and
+ * safe to read as a string.
+ *
+ * Note, if this is called when the buffer has overflowed, then
+ * the last byte of the buffer is zeroed, and the len will still
+ * point passed it.
+ *
+ * After this function is called, s->buffer is safe to use
+ * in string operations.
+ */
+static inline void seq_buf_terminate(struct seq_buf *s)
+{
+	if (WARN_ON(s->size == 0))
+		return;
+
+	if (seq_buf_buffer_left(s))
+		s->buffer[s->len] = 0;
+	else
+		s->buffer[s->size - 1] = 0;
+}
+
 /**
  * seq_buf_get_buf - get buffer to write arbitrary data to
  * @s: the seq_buf handle
-- 
2.30.1


