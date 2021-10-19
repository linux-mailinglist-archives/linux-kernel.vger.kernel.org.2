Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11960433BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhJSQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:16:34 -0400
Received: from esa1.hc324-48.eu.iphmx.com ([207.54.68.119]:57222 "EHLO
        esa1.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhJSQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:16:33 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 12:16:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1634660059; x=1666196059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oD+DZzszIEuflNePjFtSSKHZIBXf6iwTbyvm2sXUzj4=;
  b=jp28DhzzjK+7CohZQ8VPrvYlYbsTDVSC3752jr2NrXDiUHWb4jXYv6Wj
   b5YdA9Z+siPBtYjuXNZ8sEps04Kh1Uuonfqx8N9vnyMKoVWIgzbD8Q1ep
   9nzpbb+UXKWVB6gN9xbboEqpEr8FihPXP6M07rTFgYi8mfNrdcaSyD24l
   M=;
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 19 Oct 2021 18:07:09 +0200
Received: from esabb6.muc ([160.50.100.50])  by esagw4.muc with ESMTP/TLS;
 19 Oct 2021 18:07:09 +0200
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb6.muc with ESMTP/TLS; 19 Oct 2021 18:07:09 +0200
Received: from greenhouse.bmw-carit.intra (192.168.221.40) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Tue, 19 Oct 2021 18:07:09 +0200
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     jing yangyang <jing.yangyang@zte.com.cn>,
        <davidcomponentone@gmail.com>, <linux-kernel@vger.kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools/latency-collector: Use correct size when writing queue_full_warning
Date:   Tue, 19 Oct 2021 18:07:01 +0200
Message-ID: <20211019160701.15587-1-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucm15m.europe.bmw.corp (160.48.96.69) To
 smucm10m.europe.bmw.corp (160.48.96.49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

queue_full_warning is a pointer, so it is wrong to use sizeof to calculate
the number of characters of the string it points to. The effect is that we
only print out the first few characters of the warning string.

The correct way is to use strlen(). We don't need to add 1 to the strlen()
because we don't want to write the terminating null character to stdout.

Link: https://lore.kernel.org/r/8fd4bb65ef3da67feac9ce3258cdbe9824752cf1.1629198502.git.jing.yangyang@zte.com.cn
Link: https://lore.kernel.org/r/20211012025424.180781-1-davidcomponentone@gmail.com
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
---
 tools/tracing/latency/latency-collector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 3a2e6bb781a8..59a7f2346eab 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1538,7 +1538,7 @@ static void tracing_loop(void)
 				mutex_lock(&print_mtx);
 				check_signals();
 				write_or_die(fd_stdout, queue_full_warning,
-					     sizeof(queue_full_warning));
+					     strlen(queue_full_warning));
 				mutex_unlock(&print_mtx);
 			}
 			modified--;
-- 
2.25.1

