Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36443A3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhJYULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:11:11 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59347 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbhJYUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635192491; x=1666728491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=25RqcBQb1jUlq0bllqQbzEvBDCMFIlLTQ4mb2QI1teI=;
  b=hSlf6fV9UyjAoiwD/KXj3R8xXztrtWGVRRVuTZlZBIcvzw9iQJsTOYM9
   Spz/aDC7V+ZtksHvi1K80X2U8DA+gTHAE6GPtnHi29wV1CtL9VKxDNu4f
   xyOHlsIK+C2eC6cXulSu9lE13GOeKH57CNUBSgYG1mBNgdQDhexOX3Dbu
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 13:08:10 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 13:08:10 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 13:08:09 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] tracing: Fix a unused variable compiling warning
Date:   Mon, 25 Oct 2021 16:07:48 -0400
Message-ID: <20211025200748.209510-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracing_max_lat_fops is only used when LATENCY_FS_NOTIFY is set. Otherwise,
W=1 compiling could generate a warning.

kernel/trace/trace.c:1668:37: warning: 'tracing_max_lat_fops' defined but
not used [-Wunused-const-variable=]
 1668 | static const struct file_operations tracing_max_lat_fops;
      |                                     ^~~~~~~~~~~~~~~~~~~~

Fixes: 6880c987e451 ("tracing: Add LATENCY_FS_NOTIFY to define if latency_fsnotify() is defined")
Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c88bbfe75d1d..7f0801662a6b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1665,10 +1665,10 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 }
 
 unsigned long __read_mostly	tracing_thresh;
-static const struct file_operations tracing_max_lat_fops;
 
 #ifdef LATENCY_FS_NOTIFY
 
+static const struct file_operations tracing_max_lat_fops;
 static struct workqueue_struct *fsnotify_wq;
 
 static void latency_fsnotify_workfn(struct work_struct *work)
-- 
2.30.2

