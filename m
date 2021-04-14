Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C935EB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346374AbhDNDIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:08:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16991 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbhDNDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:08:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKnQR3B72zNvw9;
        Wed, 14 Apr 2021 11:05:03 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 11:07:46 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <richardcochran@gmail.com>,
        <johnstul@us.ibm.com>, <rui.xiang@huawei.com>
Subject: [PATCH v2] time: Fix overwrite err unexpected in clock_adjtime32
Date:   Wed, 14 Apr 2021 03:04:49 +0000
Message-ID: <20210414030449.90692-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the correct error is covered by put_old_timex32.

Fixes: 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to native counterparts")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---

v2: Make "Fixes" tag correct

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

