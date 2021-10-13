Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CA42BB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhJMJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:12:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25127 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhJMJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:12:12 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HTmsq1PHSz1DHS1;
        Wed, 13 Oct 2021 17:08:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:10:08 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <xiujianfeng@huawei.com>, <wangweiyang2@huawei.com>
Subject: [PATCH -next,v2 2/2] audit: return early if the rule has a lower priority
Date:   Wed, 13 Oct 2021 17:12:08 +0800
Message-ID: <20211013091208.36209-3-cuigaosheng1@huawei.com>
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

It is not necessary for audit_filter_rules() functions to check
audit fileds of the rule with a lower priority, and if we did,
there might be some unintended effects, such as the ctx->ppid
may be changed unexpectedly, so return early if the rule has
a lower priority.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/auditsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 42d4a4320526..b517947bfa48 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -470,6 +470,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 	u32 sid;
 	unsigned int sessionid;
 
+	if (ctx && rule->prio <= ctx->prio)
+		return 0;
+
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
 
 	for (i = 0; i < rule->field_count; i++) {
@@ -737,8 +740,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 	}
 
 	if (ctx) {
-		if (rule->prio <= ctx->prio)
-			return 0;
 		if (rule->filterkey) {
 			kfree(ctx->filterkey);
 			ctx->filterkey = kstrdup(rule->filterkey, GFP_ATOMIC);
-- 
2.30.0

