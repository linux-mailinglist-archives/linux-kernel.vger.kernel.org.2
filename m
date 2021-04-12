Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576B235C6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbhDLMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:49:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17313 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbhDLMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:49:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FJpQQ22WLz9y8s;
        Mon, 12 Apr 2021 20:46:38 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 20:48:45 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <richardcochran@gmail.com>,
        <johnstul@us.ibm.com>, <rui.xiang@huawei.com>
Subject: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Date:   Mon, 12 Apr 2021 12:45:51 +0000
Message-ID: <20210412124552.50213-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the correct error is covered by put_old_timex32.

Fixes: f1f1d5ebd10f ("posix-timers: Introduce a syscall for clock tuning.")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 kernel/time/posix-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bf540f5a..dd5697d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1191,8 +1191,8 @@ SYSCALL_DEFINE2(clock_adjtime32, clockid_t, which_clock,
 
 	err = do_clock_adjtime(which_clock, &ktx);
 
-	if (err >= 0)
-		err = put_old_timex32(utp, &ktx);
+	if (err >= 0 && put_old_timex32(utp, &ktx))
+		return -EFAULT;
 
 	return err;
 }
-- 
2.9.4

