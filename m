Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0893B4C33
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFZDfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:35:18 -0400
Received: from mail1.windriver.com ([147.11.146.13]:43050 "EHLO mail1.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhFZDfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:35:14 -0400
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 15Q3WC66006702
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 25 Jun 2021 20:32:13 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 15Q3WBLd009249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jun 2021 20:32:12 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 25 Jun 2021 20:32:11 -0700
Received: from pek-lpd-ccm2.wrs.com (128.224.179.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.10 via Frontend Transport; Fri, 25 Jun 2021 20:32:09 -0700
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>, <ying.xue@windriver.com>,
        <zhiquan.li@windriver.com>
Subject: [PATCH 2/2] seq_buf: Make trace_seq_putmem_hex() support data longer than 8
Date:   Sat, 26 Jun 2021 11:21:56 +0800
Message-ID: <20210626032156.47889-2-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210626032156.47889-1-yun.zhou@windriver.com>
References: <20210626032156.47889-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the raw memory 'data' does not go forward, it will dump repeated
data if the data length is more than 8. If we want to dump longer data
blocks, we need to repeatedly call macro SEQ_PUT_HEX_FIELD. I think it
is a bit redundant, and multiple function calls also affect the performance.

This patch is to improve the commit 6d2289f3faa7 ("tracing: Make
trace_seq_putmem_hex() more robust").

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 lib/seq_buf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 223fbc3bb958..562e53c93b7b 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -244,12 +244,14 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 			break;
 
 		/* j increments twice per loop */
-		len -= j / 2;
 		hex[j++] = ' ';
 
 		seq_buf_putmem(s, hex, j);
 		if (seq_buf_has_overflowed(s))
 			return -1;
+
+		len -= start_len;
+		data += start_len;
 	}
 	return 0;
 }
-- 
2.26.1

