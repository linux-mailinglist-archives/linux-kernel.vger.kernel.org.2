Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6C37F739
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhEML4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:56:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33196 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhEML4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:56:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lh9vy-0000k1-1o; Thu, 13 May 2021 11:55:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: remove redundant initialization of variable ret
Date:   Thu, 13 May 2021 12:55:17 +0100
Message-Id: <20210513115517.58178-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read,
it is being updated later on. The assignment is redundant and can be
removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 560e4c8d3825..f2ceec787b2d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6122,7 +6122,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 				  unsigned long size, int cpu_id)
 {
-	int ret = size;
+	int ret;
 
 	mutex_lock(&trace_types_lock);
 
-- 
2.30.2

