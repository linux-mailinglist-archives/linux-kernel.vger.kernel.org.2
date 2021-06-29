Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655B93B76F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhF2RNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233118AbhF2RNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yh2F59AqAF8H041ekeZo+V4beqXtOxS1tFuRsx8xUgg=;
        b=GMH9TuQz0Jn7hdyy/8joKhVUHc1Kdch2UYNOa429QCF16mjVnQF0+57q3EAo9cFLX/5tGM
        wZTCNr51uai7Lgbce4jUigy3ZEF1FrsbYkmCjXOJfEwsqbWNNmAvA+pcNkrKjGbdHAiWB0
        aqsM7swp8Lroz4p6BzpddblgRMQbT8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-h8Im1EvbNau3ldosL29Mdw-1; Tue, 29 Jun 2021 13:10:37 -0400
X-MC-Unique: h8Im1EvbNau3ldosL29Mdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C17101F000;
        Tue, 29 Jun 2021 17:10:36 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-116-83.rdu2.redhat.com [10.10.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0C5E17C58;
        Tue, 29 Jun 2021 17:10:30 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] trace/osnoise: Make 'noise' variable s64 in run_osnoise()
Date:   Tue, 29 Jun 2021 19:10:26 +0200
Message-Id: <acd7cd6e7d56b798a298c3bc8139a390b3c4ab52.1624986368.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dab Carpenter reported that:

 The patch bce29ac9ce0b: "trace: Add osnoise tracer" from Jun 22,
 2021, leads to the following static checker warning:

	kernel/trace/trace_osnoise.c:1103 run_osnoise()
	warn: unsigned 'noise' is never less than zero.

In this part of the code:

  1100                  /*
  1101                   * This shouldn't happen.
  1102                   */
  1103                  if (noise < 0) {
                            ^^^^^^^^^
  1104                          osnoise_taint("negative noise!");
  1105                          goto out;
  1106                  }
  1107

And the static checker is right because 'noise' is u64.

Make noise s64 and keep the check. It is important to check if
the time read is behaving correctly - so we can trust the results.

I also re-arranged some variable declarations.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org
Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_osnoise.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 085a83de98ad..cc1faca1a620 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1042,15 +1042,16 @@ static void osnoise_stop_tracing(void)
 static int run_osnoise(void)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	u64 noise = 0, sum_noise = 0, max_noise = 0;
 	struct trace_array *tr = osnoise_trace;
 	u64 start, sample, last_sample;
 	u64 last_int_count, int_count;
+	s64 noise = 0, max_noise = 0;
 	s64 total, last_total = 0;
 	struct osnoise_sample s;
 	unsigned int threshold;
-	int hw_count = 0;
 	u64 runtime, stop_in;
+	u64 sum_noise = 0;
+	int hw_count = 0;
 	int ret = -1;
 
 	/*
-- 
2.31.1

