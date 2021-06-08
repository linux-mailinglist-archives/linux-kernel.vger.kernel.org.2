Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01E39F0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:22:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4517 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:22:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fzjlf0ZSMzZdsr;
        Tue,  8 Jun 2021 16:17:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:20:23 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:20:22 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] kernel/relay.c: remove leading spaces before tabs
Date:   Tue, 8 Jun 2021 16:20:17 +0800
Message-ID: <20210608082017.13541-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Run the following command to find and remove the leading spaces before
   tabs:
   sed -r -i 's/^[ ]+\t/\t/' kernel/relay.c
2) Manually check and correct if necessary

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/relay.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 4a5e58be9731..b6cd0afe575f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -378,10 +378,10 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
  */
 static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 {
- 	struct rchan_buf *buf = NULL;
+	struct rchan_buf *buf = NULL;
 	struct dentry *dentry;
 
- 	if (chan->is_global)
+	if (chan->is_global)
 		return *per_cpu_ptr(chan->buf, 0);
 
 	buf = relay_create_buf(chan);
@@ -402,18 +402,18 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 			goto free_buf;
 	}
 
- 	buf->cpu = cpu;
- 	__relay_reset(buf, 1);
+	buf->cpu = cpu;
+	__relay_reset(buf, 1);
 
- 	if(chan->is_global) {
+	if(chan->is_global) {
 		*per_cpu_ptr(chan->buf, 0) = buf;
- 		buf->cpu = 0;
-  	}
+		buf->cpu = 0;
+	}
 
 	return buf;
 
 free_buf:
- 	relay_destroy_buf(buf);
+	relay_destroy_buf(buf);
 	return NULL;
 }
 
-- 
2.25.1


