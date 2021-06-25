Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914DB3B47D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFYRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:01:29 -0400
Received: from mail5.windriver.com ([192.103.53.11]:47234 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhFYRB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:01:26 -0400
X-Greylist: delayed 3258 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jun 2021 13:01:25 EDT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 15PG42LR016327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jun 2021 09:04:03 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 25 Jun 2021 09:04:03 -0700
Received: from pek-lpd-ccm2.wrs.com (128.224.179.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.10 via Frontend Transport; Fri, 25 Jun 2021 09:04:01 -0700
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>, <ying.xue@windriver.com>,
        <zhiquan.li@windriver.com>
Subject: [PATCH 2/2] seq_buf: Make trace_seq_putmem_hex() support data longer than 8
Date:   Fri, 25 Jun 2021 23:53:48 +0800
Message-ID: <20210625155348.58266-2-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210625155348.58266-1-yun.zhou@windriver.com>
References: <20210625155348.58266-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, trace_seq_putmem_hex() can only support data with length
of 8 or less, which greatly limits its application scope. If we want to
dump longer data blocks, we need to repeatedly call macro SEQ_PUT_HEX_FIELD.
I think it is a bit redundant, and multiple function calls also affect
the performance.

This patch is to perfect the commit 6d2289f3faa7 ("tracing: Make
trace_seq_putmem_hex() more robust").

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 lib/seq_buf.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index aa2f666e584e..98580a5c32c0 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -210,8 +210,7 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
  * seq_buf_putmem_hex - write raw memory into the buffer in ASCII hex
  * @s: seq_buf descriptor
  * @mem: The raw memory to write its hex ASCII representation of
- * @len: The length of the raw memory to copy (in bytes).
- *       It can be not larger than 8.
+ * @len: The length of the raw memory to copy (in bytes)
  *
  * This is similar to seq_buf_putmem() except instead of just copying the
  * raw memory into the buffer it writes its ASCII representation of it
@@ -229,19 +228,27 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 
 	WARN_ON(s->size == 0);
 
-	start_len = min(len, MAX_MEMHEX_BYTES);
+	while (len) {
+		start_len = min(len, MAX_MEMHEX_BYTES);
 #ifdef __BIG_ENDIAN
-	for (i = 0, j = 0; i < start_len; i++) {
+		for (i = 0, j = 0; i < start_len; i++) {
 #else
-	for (i = start_len-1, j = 0; i >= 0; i--) {
+		for (i = start_len-1, j = 0; i >= 0; i--) {
 #endif
-		hex[j++] = hex_asc_hi(data[i]);
-		hex[j++] = hex_asc_lo(data[i]);
-	}
+			hex[j++] = hex_asc_hi(data[i]);
+			hex[j++] = hex_asc_lo(data[i]);
+		}
 
-	seq_buf_putmem(s, hex, j);
-	if (seq_buf_has_overflowed(s))
-		return -1;
+		/* j increments twice per loop */
+		len -= j / 2;
+		hex[j++] = ' ';
+
+		seq_buf_putmem(s, hex, j);
+		if (seq_buf_has_overflowed(s))
+			return -1;
+
+		data += start_len;
+	}
 	return 0;
 }
 
-- 
2.26.1

