Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D4416A30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbhIXCyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:54:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:16379 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243907AbhIXCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:54:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFxLL1L83zRS0X;
        Fri, 24 Sep 2021 10:48:42 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:52:55 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:52:54 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <mhiramat@kernel.org>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4.19] tracing/kprobe: Fix kprobe_on_func_entry() modification
Date:   Fri, 24 Sep 2021 10:54:48 +0800
Message-ID: <20210924025448.232959-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 960434acef37 ("tracing/kprobe: Fix to support kretprobe
events on unloaded modules") backport from v5.11, which modifies the
return value of kprobe_on_func_entry(). However, there is no adaptation
modification in create_trace_kprobe(), resulting in the exact opposite
behavior. Now we need to return an error immediately only if
kprobe_on_func_entry() returns -EINVAL.

Fixes: 960434acef37 ("tracing/kprobe: Fix to support kretprobe events on unloaded modules")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 kernel/trace/trace_kprobe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 61eff45653f5..36dfea29d5fa 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -836,8 +836,9 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
+		/* Defer the ENOENT case until register kprobe */
 		if (offset && is_return &&
-		    !kprobe_on_func_entry(NULL, symbol, offset)) {
+		    kprobe_on_func_entry(NULL, symbol, offset) == -EINVAL) {
 			pr_info("Given offset is not valid for return probe.\n");
 			return -EINVAL;
 		}
-- 
2.17.1

