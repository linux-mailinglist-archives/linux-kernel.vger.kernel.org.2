Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CA39F0C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhFHI02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:26:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4518 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:26:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzjrQ6FxvzZdsQ;
        Tue,  8 Jun 2021 16:21:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:24:32 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:24:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jessica Yu <jeyu@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        James Morris <jmorris@namei.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] kernel/params.c: remove leading spaces before tabs
Date:   Tue, 8 Jun 2021 16:24:15 +0800
Message-ID: <20210608082415.13641-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Run the following command to find and remove the leading spaces before
   tabs:
   sed -r -i 's/^[ ]+\t/\t/' kernel/params.c
2) Manually check and correct if necessary

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2daa2780a92c..ceaf06788068 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -556,7 +556,7 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module_kobject *mk,
 				const char *buf, size_t len)
 {
- 	int err;
+	int err;
 	struct param_attribute *attribute = to_param_attr(mattr);
 
 	if (!attribute->param->ops->set)
-- 
2.25.1


