Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407C933ED7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCQJyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCQJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:54:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:54:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s7so38208829qkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiWvc+PYoLCHEreqBGBCX0OPe0RZxuTAavG8EjeJpDo=;
        b=R78Un1rARDCwMu29nx1aB0DdMt1wMl08E3HtDawZ76KPmPUtwdGLJdt4hWE+06UJ6g
         QVvvXEuGCBgVN/9hZU+YDxH/uTSk7dmKPYX3Cg1dK5f4QO8Wdrd/igjEPXNla9LBceit
         rQqEupjh0+avQt2XBgMljtdcpwFIAsbWE0anCxaiezORgnetU2HLZhb3+kocWhCFfSQG
         lKsXzdydm3wSJYucXwnBr79hVgoxzBQOMY+1TnMnVUgFIpad7IPoT+DdADX9aCcvVE4U
         g1vMjIXySqc/cwtAi7c4x2A6mW3ekE/mEZICClEkMD3nzuA9WI/fHxfE9PGyGWnHs9NF
         YBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiWvc+PYoLCHEreqBGBCX0OPe0RZxuTAavG8EjeJpDo=;
        b=WW5hnMHWSQG/eAOo028OMbPARuJVHLvaXxauaIuMqB6I5tyOHFh8c+YcWHCw+sWTrD
         QjuiO1JkY6VkCpeZIw8cMS1IXP5SHOuwz0rHJGXvZHPZpEqOnzjOTfYTNgu5VWX/d3em
         MFPmrDFD+GHGFKBafV4kbeddWaqxi9V/XwWTtdYinMRO1FA7d7Lwjir028u/hiQuVlwp
         Q5EVo/DuHy3RtgVPUK+mfeg8rXaLStmwWum0lSY/umPyWsqgSX98ySXKxSlbwEBXTJzA
         ToENqxUjYy/004G0XoH7+0YVsQbwtg71d+J+utJLznW53+pibLMlRy2OmuwPZ4IGyXwx
         K2lw==
X-Gm-Message-State: AOAM5334oXvdMhRvTAQdkX/TcflVr1ICtFuMVXtRgWtG/uGDI/s3rjgn
        F1NcRIzbgKkHL4KBw8F+//g=
X-Google-Smtp-Source: ABdhPJzcS1kWesSEoV/Ygjlg9H7Udj/qk32XmgZsA+ykT/l1tyOsE4E+GZlAVjFRY9tcrNbYg/+s5Q==
X-Received: by 2002:a37:a10a:: with SMTP id k10mr3697872qke.171.1615974859920;
        Wed, 17 Mar 2021 02:54:19 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id f17sm14917267qtl.89.2021.03.17.02.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:54:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: trace: Mundane typo fixes in the file trace_events_filter.c
Date:   Wed, 17 Mar 2021 15:24:01 +0530
Message-Id: <20210317095401.1854544-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/callin/calling/
s/progam/program/
s/interperate/interpret/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/trace/trace_events_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e91259f6a722..49de3e21e9bc 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -256,7 +256,7 @@ enum {
  * is "&&" we don't call update_preds(). Instead continue to "c". As the
  * next token after "c" is not "&&" but the end of input, we first process the
  * "&&" by calling update_preds() for the "&&" then we process the "||" by
- * callin updates_preds() with the values for processing "||".
+ * calling updates_preds() with the values for processing "||".
  *
  * What does that mean? What update_preds() does is to first save the "target"
  * of the program entry indexed by the current program entry's "target"
@@ -296,7 +296,7 @@ enum {
  * and "FALSE" the program entry after that, we are now done with the first
  * pass.
  *
- * Making the above "a || b && c" have a progam of:
+ * Making the above "a || b && c" have a program of:
  *  prog[0] = { "a", 1, 2 }
  *  prog[1] = { "b", 0, 2 }
  *  prog[2] = { "c", 0, 3 }
@@ -390,7 +390,7 @@ enum {
  * F: return FALSE
  *
  * As "r = a; if (!r) goto n5;" is obviously the same as
- * "if (!a) goto n5;" without doing anything we can interperate the
+ * "if (!a) goto n5;" without doing anything we can interpret the
  * program as:
  * n1: if (!a) goto n5;
  * n2: if (!b) goto n5;
--
2.30.2

