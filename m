Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1141C182
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbhI2JWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:22:10 -0400
Received: from [119.249.100.165] ([119.249.100.165]:15915 "EHLO
        mx423.baidu.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbhI2JWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:22:09 -0400
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx423.baidu.com (Postfix) with ESMTP id D45D316E01154;
        Wed, 29 Sep 2021 17:20:14 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id CCAC4D9932;
        Wed, 29 Sep 2021 17:20:14 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     lirongqing@baidu.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: [PATCH] KVM: Micro-optimize pvclock_clocksource_read
Date:   Wed, 29 Sep 2021 17:20:14 +0800
Message-Id: <1632907214-29633-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare the return of atomic64_cmpxchg with previous save for last,
to reduce the number of while-loop iterations with atomic operations
from two to one in the most common situation

Original patch at:
https://kvm.vger.kernel.narkive.com/WraXedaQ/patch-kvm-pvclock-clocksource-read-while-loop-optimization

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/pvclock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index eda37df..98d106f 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -67,8 +67,8 @@ u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src)
 u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 {
 	unsigned version;
+	u64 last, save;
 	u64 ret;
-	u64 last;
 	u8 flags;
 
 	do {
@@ -104,8 +104,9 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	do {
 		if (ret < last)
 			return last;
+		save = last;
 		last = atomic64_cmpxchg(&last_value, last, ret);
-	} while (unlikely(last != ret));
+	} while (unlikely(last != save));
 
 	return ret;
 }
-- 
1.7.1

