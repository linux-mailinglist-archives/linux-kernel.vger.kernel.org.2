Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A935817A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhDHLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:16:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16831 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDHLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:16:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJYm0x5kz7tqY;
        Thu,  8 Apr 2021 19:14:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:16:21 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <mingo@redhat.com>, <acme@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] perf tools: Fix error return code in cmd_buildid_cache()
Date:   Thu, 8 Apr 2021 19:24:44 +0800
Message-ID: <20210408112444.1023427-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: e3ed75bb537a8 ("perf buildid-cache: Move session...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tools/perf/builtin-buildid-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index ecd0d3cb6f5c..f703ba11e12c 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -448,7 +448,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 			return PTR_ERR(session);
 	}
 
-	if (symbol__init(session ? &session->header.env : NULL) < 0)
+	ret = symbol__init(session ? &session->header.env : NULL);
+	if (ret < 0)
 		goto out;
 
 	setup_pager();
-- 
2.25.4

