Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA443B76B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhF2QzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:55:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44820 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhF2QzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:55:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lyGyb-0001Mf-Ci; Tue, 29 Jun 2021 16:52:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] trace: osnoise: Fix u64 less than zero comparison
Date:   Tue, 29 Jun 2021 17:52:45 +0100
Message-Id: <20210629165245.42157-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The less than zero comparison of the u64 variable 'noise' is always
false because the variable is unsigned. Since the time_sub macro
can potentially return an -ve vale, make the variable a s64 to
fix the issue.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/trace_osnoise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 38aa5e208ffd..02c984560ceb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1040,11 +1040,11 @@ static void osnoise_stop_tracing(void)
 static int run_osnoise(void)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	u64 noise = 0, sum_noise = 0, max_noise = 0;
+	u64 sum_noise = 0, max_noise = 0;
 	struct trace_array *tr = osnoise_trace;
 	u64 start, sample, last_sample;
 	u64 last_int_count, int_count;
-	s64 total, last_total = 0;
+	s64 noise = 0, total, last_total = 0;
 	struct osnoise_sample s;
 	unsigned int threshold;
 	int hw_count = 0;
-- 
2.31.1

