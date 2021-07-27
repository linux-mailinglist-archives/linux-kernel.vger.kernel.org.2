Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F03D7889
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhG0Ocr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:32:47 -0400
Received: from m12-17.163.com ([220.181.12.17]:45609 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhG0Ocq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=q/EpB
        PG2gBKakN+i9WATJtutw5w/4nmCrxJ/sRHPi/g=; b=dMx+IGjiEeuheCvQrCzLM
        bCZzq9PlKnp3h0ACXXp6iK8SPKoRE5w9vJ4q14i2VnHqzh1nSW/uNqzC/H5Jo0bH
        CWwgN0K0o51B7oAPm/jcPzhim9YmF8Phmh9heOOl/hUn8UAhlwvFvAzxvbZuUu7T
        RzLkRT8/KWpqhjw6vZNYRg=
Received: from ybqiao-virtual-machine.localdomain (unknown [183.195.9.44])
        by smtp13 (Coremail) with SMTP id EcCowABXdortGABhpMZZDA--.20304S4;
        Tue, 27 Jul 2021 22:32:14 +0800 (CST)
From:   Qiao Yanbo <qiaoyanbo_310@163.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        qiaoyanbo <qiaoyanbo_310@163.com>
Subject: [PATCH] kobject: kobject_add_internal cleanup
Date:   Tue, 27 Jul 2021 22:32:12 +0800
Message-Id: <20210727143212.39142-1-qiaoyanbo_310@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABXdortGABhpMZZDA--.20304S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1xCF1kWw13Jw13GFWfXwb_yoW3Arg_Ja
        4xtF1Dur4DGa4293W7A39YyrZrCay3A3WxCw4ftrZxJryUurn8XF92vw1FkFyrGayUuF98
        Cw4qg3sxGr1UKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ZL0UUUUUU==
X-Originating-IP: [183.195.9.44]
X-CM-SenderInfo: 5tld055dqe0sqtrqqiywtou0bp/xtbBCgzcT13mAT7MIwAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qiaoyanbo <qiaoyanbo_310@163.com>

parent assignment in "if" block only need to consider when parent is NULL.

Signed-off-by: qiaoyanbo <qiaoyanbo_310@163.com>
---
 lib/kobject.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf..d1f4b3411 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -241,10 +241,11 @@ static int kobject_add_internal(struct kobject *kobj)
 
 	/* join kset if set, use it as parent if we do not already have one */
 	if (kobj->kset) {
-		if (!parent)
+		if (!parent) {
 			parent = kobject_get(&kobj->kset->kobj);
+			kobj->parent = parent;
+		}
 		kobj_kset_join(kobj);
-		kobj->parent = parent;
 	}
 
 	pr_debug("kobject: '%s' (%p): %s: parent: '%s', set: '%s'\n",
-- 
2.30.2


