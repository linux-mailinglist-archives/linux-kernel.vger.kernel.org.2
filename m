Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50A376F27
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEHDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:43:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18012 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHDnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:43:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FcY2t0nhczQkm5;
        Sat,  8 May 2021 11:39:18 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 11:42:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] tools/bootconfig: Fix error return code in apply_xbc()
Date:   Sat, 8 May 2021 11:42:16 +0800
Message-ID: <20210508034216.2277-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Fixes: a995e6bc0524 ("tools/bootconfig: Fix to check the write failure correctly")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 tools/bootconfig/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7362bef1a368..6cd6080cac04 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -399,6 +399,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	if (fstat(fd, &stat) < 0) {
+		ret = -errno;
 		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}
-- 
2.25.1


