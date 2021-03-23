Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969863469DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhCWUcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhCWUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:31:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A53C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:31:48 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 94so16018367qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOQ/VR2f/EQSNjVSoLpprEnzu9FB7rZNdtB4mU/j0KQ=;
        b=XvfKd7158u9qdeVd8RjPTRAY67/TB0iALIYqWpMOxJh3krZaYOChVXgWIgABbwDrs8
         V2Y2EAnd0Pv09LbTIXntgoLz3aNXe20taYiVof5vl5ABw0mowqEyD950o+RxaiKb3MLJ
         HfpacafnQhNo7bBR38Z7rULdidRNxFaeiZbZp8BFeafKfEPkHiGjU/NkLUMia7canJMd
         3HM1Wis2Ksj4ROOdYolJiU3/PIwQMtQLe2WrkTgWFdlGeeOIZqIYC2r54uIWuHjJTHIF
         YKP7WFCntW/LEkG00KhmYwvWcZo6B81cB1mmm/bg6op0ZxNs1HgxrfErAOmfqPW0kI05
         3wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOQ/VR2f/EQSNjVSoLpprEnzu9FB7rZNdtB4mU/j0KQ=;
        b=NnS0Fz7BR9Rl6ug6nap6BQxmxXk0AIPbXHmBQWzomhZ0uIugZY1pV0niCoUF12bT0D
         DzaQR48lG38e3wkzfIcscQmqKe4PzDj0S5mmXgYrzlwFtEEBVup1heZvKTTA1WEFnI9E
         8n1cXM+jWW0Igw5xqL35ylr/UeRyo/dQCZsdiBkzWL2O3GM0c+IxDCa47UGcROlQJxgO
         ZHd+06GVe7PFlJZyrN4ypmN3YBWpX6P75cOtXHDozwHUnCFzNsQmzO2/dbyOymTjYyLJ
         VBZhw+zwPM7Hd4frNdxJZRlVUtBi2lulppJZQO5q6xRD5AyYsP+WfaKgnpFAVkYDkW86
         9PgQ==
X-Gm-Message-State: AOAM5317+JWg8DVIcoTCBYpMBEPNChjSIoSflRpqe5vL6BZFcpolY51g
        5U0peUJH4VT6sjGxe7dJLLg=
X-Google-Smtp-Source: ABdhPJzcOtxKGBEoNOu9vO0TPnlz+4816rn+cOlWbDX/XiTMcQu3DBflMyFz29u7Weshy/Eg/F/7fQ==
X-Received: by 2002:ac8:74c4:: with SMTP id j4mr144739qtr.70.1616531507866;
        Tue, 23 Mar 2021 13:31:47 -0700 (PDT)
Received: from Slackware.localdomain ([37.19.198.105])
        by smtp.gmail.com with ESMTPSA id f20sm4757qtp.67.2021.03.23.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:31:47 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tracing: Trivial typo fixes
Date:   Wed, 24 Mar 2021 02:03:17 +0530
Message-Id: <20210323203317.31944-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial spelling fixes.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/trace/trace_seq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 1d84fcc78e3e..e03eae7a5577 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -12,11 +12,11 @@
  * This will set up the counters within the descriptor. You can call
  * trace_seq_init() more than once to reset the trace_seq to start
  * from scratch.
  * The buffer size is currently PAGE_SIZE, although it may become dynamic
  * in the future.
  *
- * A write to the buffer will either succed or fail. That is, unlike
+ * A write to the buffer will either succeed or fail. That is, unlike
  * sprintf() there will not be a partial write (well it may write into
  * the buffer but it wont update the pointers). This allows users to
  * try to write something into the trace_seq buffer and if it fails
@@ -73,7 +73,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
  * @fmt: printf format string
  *
  * The tracer may use either sequence operations or its own
- * copy to user routines. To simplify formating of a trace
+ * copy to user routines. To simplify formatting of a trace
  * trace_seq_printf() is used to store strings into a special
  * buffer (@s). Then the output may be either used by
  * the sequencer or pulled into another buffer.
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
  * @fmt: printf format string
  *
  * The tracer may use either sequence operations or its own
- * copy to user routines. To simplify formating of a trace
+ * copy to user routines. To simplify formatting of a trace
  * trace_seq_printf is used to store strings into a special
  * buffer (@s). Then the output may be either used by
  * the sequencer or pulled into another buffer.
@@ -226,7 +226,7 @@ EXPORT_SYMBOL_GPL(trace_seq_puts);
  * @c: simple character to record
  *
  * The tracer may use either the sequence operations or its own
- * copy to user routines. This function records a simple charater
+ * copy to user routines. This function records a simple character
  * into a special buffer (@s) for later retrieval by a sequencer
  * or other mechanism.
  */
@@ -348,7 +348,7 @@ int trace_seq_path(struct trace_seq *s, const struct path *path)
 EXPORT_SYMBOL_GPL(trace_seq_path);

 /**
- * trace_seq_to_user - copy the squence buffer to user space
+ * trace_seq_to_user - copy the sequence buffer to user space
  * @s: trace sequence descriptor
  * @ubuf: The userspace memory location to copy to
  * @cnt: The amount to copy
--
2.30.1

