Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D83B5E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhF1M54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:57:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34895 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhF1M5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:57:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lxqnL-0004LS-82; Mon, 28 Jun 2021 12:55:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] trace: Fix spelling in osnoise tracer "interferences" -> "interference"
Date:   Mon, 28 Jun 2021 13:55:22 +0100
Message-Id: <20210628125522.56361-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a TP_printk message, the word interferences
is not the plural of interference. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 include/trace/events/osnoise.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 28762c69f6c9..82f741ec0f57 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -129,7 +129,7 @@ TRACE_EVENT(sample_threshold,
 		__entry->interference = interference;
 	),
 
-	TP_printk("start %llu.%09u duration %llu ns interferences %llu",
+	TP_printk("start %llu.%09u duration %llu ns interference %llu",
 		__print_ns_to_secs(__entry->start),
 		__print_ns_without_secs(__entry->start),
 		__entry->duration,
-- 
2.31.1

