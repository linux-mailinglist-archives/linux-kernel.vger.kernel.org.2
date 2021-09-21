Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA24D4134FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhIUOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:07:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9896 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhIUOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:07:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDNPW3wytz8y0F;
        Tue, 21 Sep 2021 22:01:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 22:05:35 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 22:05:34 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <feng.tang@intel.com>,
        <mhocko@suse.com>, <rui.xiang@huawei.com>
Subject: [PATCH] mm: Fix the uninitialized use in overcommit_policy_handler
Date:   Tue, 21 Sep 2021 14:03:01 +0000
Message-ID: <20210921140301.9058-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An unexpected value of /proc/sys/vm/panic_on_oom we will get,
after running the following program

int main()
{
    int fd = open("/proc/sys/vm/panic_on_oom", O_RDWR)
    write(fd, "1", 1);
    write(fd, "2", 1);
    close(fd);
}

write(fd, "2", 1) will pass *ppos = 1 to proc_dointvec_minmax.
proc_dointvec_minmax will return 0 without setting new_policy.

t.data = &new_policy;
ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos)
      -->do_proc_dointvec
         -->__do_proc_dointvec
              if (write) {
                if (proc_first_pos_non_zero_ignore(ppos, table))
                  goto out;

sysctl_overcommit_memory = new_policy;

so sysctl_overcommit_memory will be set to an uninitialized value.

Initialize new_policy with sysctl_overcommit_memory.

Fixes: 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy"
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5..b4af8a1de4f7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -756,7 +756,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
-	int new_policy;
+	int new_policy = sysctl_overcommit_memory;
 	int ret;
 
 	/*
-- 
2.17.1

