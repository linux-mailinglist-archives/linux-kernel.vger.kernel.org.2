Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E918C42BB2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhJMJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:12:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25180 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhJMJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:12:12 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HTmtP3Gs3z8tZj;
        Wed, 13 Oct 2021 17:09:01 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:10:08 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <xiujianfeng@huawei.com>, <wangweiyang2@huawei.com>
Subject: [PATCH -next,v2 1/2] audit: fix possible null-pointer dereference in audit_filter_rules
Date:   Wed, 13 Oct 2021 17:12:07 +0800
Message-ID: <20211013091208.36209-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211013091208.36209-1-cuigaosheng1@huawei.com>
References: <20211013091208.36209-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this possible null-pointer dereference in audit_filter_rules.

If ctx is null, a null-pointer dereference will occur:
    case AUDIT_SADDR_FAM:
        if (ctx->sockaddr)
		...
	break;

audit_filter_rules() error: we previously assumed 'ctx' could be null

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4ba3b8573ff4..42d4a4320526 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -647,7 +647,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 			result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
 			break;
 		case AUDIT_SADDR_FAM:
-			if (ctx->sockaddr)
+			if (ctx && ctx->sockaddr)
 				result = audit_comparator(ctx->sockaddr->ss_family,
 							  f->op, f->val);
 			break;
-- 
2.30.0

