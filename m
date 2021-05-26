Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0EF39136E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhEZJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:12:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5555 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhEZJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:11:57 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqlTK1TgvzkYSH;
        Wed, 26 May 2021 17:07:33 +0800 (CST)
Received: from dggema756-chm.china.huawei.com (10.1.198.198) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 17:10:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggema756-chm.china.huawei.com (10.1.198.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 26 May 2021 17:10:23 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jens Axboe" <axboe@kernel.dk>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <ocfs2-devel@oss.oracle.com>,
        Chen Huang <chenhuang5@huawei.com>
Subject: [PATCH -next 3/3] ocfs2: Replaced simple_strtoull() with kstrtoull()
Date:   Wed, 26 May 2021 09:20:20 +0000
Message-ID: <20210526092020.554341-3-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210526092020.554341-1-chenhuang5@huawei.com>
References: <20210526092020.554341-1-chenhuang5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema756-chm.china.huawei.com (10.1.198.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_strtoull() function is deprecated in some situation since
it does not check for the range overflow, use kstrtoull() instead.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 fs/ocfs2/cluster/heartbeat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 1169c8dc9106..f89ffcbd585f 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1596,12 +1596,13 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	struct o2hb_region *reg = to_o2hb_region(item);
 	unsigned long long tmp;
 	char *p = (char *)page;
+	ssize_t ret;
 
 	if (reg->hr_bdev)
 		return -EINVAL;
 
-	tmp = simple_strtoull(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	ret = kstrtoull(p, 0, &tmp);
+	if (ret)
 		return -EINVAL;
 
 	reg->hr_start_block = tmp;
-- 
2.25.1

