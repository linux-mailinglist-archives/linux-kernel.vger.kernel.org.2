Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FE41555F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhIWCJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:09:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9759 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhIWCJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:09:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HFJSV1LSLzVflN;
        Thu, 23 Sep 2021 10:06:50 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 10:08:01 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 10:08:00 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <feng.tang@intel.com>,
        <mhocko@suse.com>, <rui.xiang@huawei.com>
Subject: [PATCH v3 1/1] mm: Fix the uninitialized use in overcommit_policy_handler
Date:   Thu, 23 Sep 2021 02:05:24 +0000
Message-ID: <20210923020524.13289-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An unexpected value of /proc/sys/vm/overcommit_memory we will get,
after running the following program.

int main()
{
    int fd = open("/proc/sys/vm/overcommit_memory", O_RDWR)
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

Check whether new_policy has been changed by proc_dointvec_minmax.

Fixes: 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy"
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>

---

v3:
  * Correct commit message.

v2:
  * Check whether new_policy has been changed by proc_dointvec_minmax.

 mm/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5..d5be67771850 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -756,7 +756,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
-	int new_policy;
+	int new_policy = -1;
 	int ret;
 
 	/*
@@ -774,7 +774,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 		t = *table;
 		t.data = &new_policy;
 		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
-		if (ret)
+		if (ret || new_policy == -1)
 			return ret;
 
 		mm_compute_batch(new_policy);
-- 
2.17.1

