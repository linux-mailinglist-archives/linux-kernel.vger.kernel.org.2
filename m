Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20B037BC79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhELM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:27:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2463 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhELM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:27:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgDTX6s52zBtV5;
        Wed, 12 May 2021 20:23:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 20:25:45 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] timer: Fix bucket_expiry calculation
Date:   Wed, 12 May 2021 20:15:29 +0800
Message-ID: <1620821729-40694-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I use schedule_timeout(5) to put a process into sleep on my machine
with HZ = 100. It always sleep about 60ms. I enable the timer trace and
find out, when the timer_list expires, 'now' is always equal to
'expires + 1'. I print 'base->next_expiry' in '__run_timers' and find out
'next_expiry' is always equal to 'expires + 1';

  my_test_thread-1230    [001] d...   382.627089: timer_start: timer=000000004ec021c9 function=process_timeout expires=4294975072 [timeout=5] cpu=1 idx=33 flags=
          <idle>-0       [001] ..s.   382.687082: run_timer_softirq: jiffies 4294975073  next_expiry 4294975073
          <idle>-0       [001] ..s.   382.687083: timer_expire_entry: timer=000000004ec021c9 function=process_timeout now=4294975073 baseclk=4294975073
  my_test_thread-1230    [001] d...   382.687089: timer_start: timer=000000004ec021c9 function=process_timeout expires=4294975078 [timeout=5] cpu=1 idx=39 flags=
          <idle>-0       [001] ..s.   382.747083: run_timer_softirq: jiffies 4294975079  next_expiry 4294975079
          <idle>-0       [001] ..s.   382.747084: timer_expire_entry: timer=000000004ec021c9 function=process_timeout now=4294975079 baseclk=4294975079

It is because we use the following equation to calculate bucket_expiry.

  bucket_expiry = ((expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl)) << LVL_SHIFT(lvl)

'bucket_expiry' is equal to 'expires + 1' when lvl = 0. So modify the
equation as follows to fix the issue.

  bucket_expiry = ((expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl)) << LVL_SHIFT(lvl)

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d111adf..a6a26da 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -501,7 +501,7 @@ static inline unsigned calc_index(unsigned long expires, unsigned lvl,
 	 *
 	 * Round up with level granularity to prevent this.
 	 */
-	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	expires = (expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl);
 	*bucket_expiry = expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
-- 
1.7.12.4

