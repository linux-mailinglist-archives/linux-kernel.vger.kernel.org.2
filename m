Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8738BCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhEUC5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:57:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3453 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhEUC5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:57:07 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmWPM2c6GzBvQC;
        Fri, 21 May 2021 10:52:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:55:42 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 10:55:42 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH RESEND] tty: hvc_console: Remove the repeated words 'no' and 'from'
Date:   Fri, 21 May 2021 10:52:38 +0800
Message-ID: <1621565558-26118-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated words 'no' and 'from', reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/hvc/hvc_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cdcc64e..bdd8d2b 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -292,7 +292,7 @@ int hvc_instantiate(uint32_t vtermno, int index, const struct hv_ops *ops)
 	if (vtermnos[index] != -1)
 		return -1;
 
-	/* make sure no no tty has been registered in this index */
+	/* make sure no tty has been registered in this index */
 	hp = hvc_get_by_index(index);
 	if (hp) {
 		tty_port_put(&hp->port);
@@ -620,7 +620,7 @@ static u32 timeout = MIN_TIMEOUT;
 /*
  * Maximum number of bytes to get from the console driver if hvc_poll is
  * called from driver (and can't sleep). Any more than this and we break
- * and start polling with khvcd. This value was derived from from an OpenBMC
+ * and start polling with khvcd. This value was derived from an OpenBMC
  * console with the OPAL driver that results in about 0.25ms interrupts off
  * latency.
  */
-- 
2.8.1

