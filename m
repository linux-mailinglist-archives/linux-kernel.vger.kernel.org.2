Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791DF3DBBD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhG3PN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:13:58 -0400
Received: from m12-17.163.com ([220.181.12.17]:52885 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239423AbhG3PN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9WQ7F
        AT/naVSWd89d2D+8E1VEIXkJQgc9nMIZJSn5IQ=; b=cMVI7ogYq8hsgRvR3U4Zt
        YltVVf8y488o/Bx8+HdFQIcUinHGegBT/XmMwhfHPzVjy7+rPxVOCAe7WoaMDP99
        M+qOE2rz0KCaltaW1IvWg9wksMHtHYlqSnEV6aPN/03jsVV2zPePuLPwIfad9RsO
        KUv8hOtM0BHvJiG613tKew=
Received: from localhost (unknown [183.195.9.44])
        by smtp13 (Coremail) with SMTP id EcCowAB3hTksEwRhAgsvDg--.20349S2;
        Fri, 30 Jul 2021 22:56:44 +0800 (CST)
From:   Yanbo Qiao <qiaoyanbo_310@163.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Yanbo Qiao <qiaoyanbo_310@163.com>, Hui Su <suhui@zeku.com>
Subject: [PATCH] fs/ntfs: delete unused header file
Date:   Fri, 30 Jul 2021 22:55:18 +0800
Message-Id: <20210730145518.147805-1-qiaoyanbo_310@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAB3hTksEwRhAgsvDg--.20349S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1Utw1fAry5Gr1UGF1fXrb_yoWxZrc_Ga
        n7Ar48Xw1UtF9rK3Zaka93JF4293W8Jrn5Zw10gFW3CF4Ygayqg34kJws0yrW7u398Gr45
        WFZ5Was0vry3tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0QVyPUUUUU==
X-Originating-IP: [183.195.9.44]
X-CM-SenderInfo: 5tld055dqe0sqtrqqiywtou0bp/1tbi8AzfT1uocuItYwAAsB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux/time.h file is referenced using the
current_kernel_time() function.The current_kernel_time()
was moved from fs/ntfs/time.h, so delete the header file.

Signed-off-by: Yanbo Qiao <qiaoyanbo_310@163.com>
Signed-off-by: Hui Su <suhui@zeku.com>
---
 fs/ntfs/time.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs/time.h b/fs/ntfs/time.h
index 6b63261300cc..2c92abb5d8d2 100644
--- a/fs/ntfs/time.h
+++ b/fs/ntfs/time.h
@@ -8,7 +8,6 @@
 #ifndef _LINUX_NTFS_TIME_H
 #define _LINUX_NTFS_TIME_H
 
-#include <linux/time.h>		/* For current_kernel_time(). */
 #include <asm/div64.h>		/* For do_div(). */
 
 #include "endian.h"
-- 
2.30.2


