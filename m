Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0911C391A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhEZOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:35:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4018 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhEZOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:35:15 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fqtfv5SMVzmYwY;
        Wed, 26 May 2021 22:31:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 22:33:40 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 26 May
 2021 22:33:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <legion@kernel.org>, <ebiederm@xmission.com>
Subject: [PATCH -next] cred: add missing return error code when set_cred_ucounts() failed
Date:   Wed, 26 May 2021 22:38:05 +0800
Message-ID: <20210526143805.2549649-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set_cred_ucounts() failed, we need return the error code.

Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/cred.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index db7c46bf36e5..e6fd2b3fc31f 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -372,7 +372,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		ret = create_user_ns(new);
 		if (ret < 0)
 			goto error_put;
-		if (set_cred_ucounts(new) < 0)
+		ret = set_cred_ucounts(new);
+		if (ret < 0)
 			goto error_put;
 	}
 
-- 
2.25.1

