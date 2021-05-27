Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAA392A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhE0JCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:02:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2433 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhE0JCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:02:39 -0400
Received: from dggeml768-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrMD32bKTz670b;
        Thu, 27 May 2021 16:58:11 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggeml768-chm.china.huawei.com (10.1.199.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 17:01:04 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 27 May
 2021 17:01:03 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] tracing: Remove set but not used variable 'ret'
Date:   Thu, 27 May 2021 17:10:32 +0800
Message-ID: <20210527091032.3878436-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

kernel/trace/trace_events_hist.c: In function 'unregister_field_var_hists':
kernel/trace/trace_events_hist.c:5228:6: warning:
 variable ‘ret’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/trace/trace_events_hist.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63f1d6c..af4da32f7eab 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5225,13 +5225,12 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	struct trace_event_file *file;
 	unsigned int i;
 	char *cmd;
-	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
 		file = hist_data->field_var_hists[i]->hist_data->event_file;
 		cmd = hist_data->field_var_hists[i]->cmd;
-		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
-					      "!hist", "hist", cmd);
+		event_hist_trigger_func(&trigger_hist_cmd, file,
+					"!hist", "hist", cmd);
 	}
 }
 
-- 
2.25.4

