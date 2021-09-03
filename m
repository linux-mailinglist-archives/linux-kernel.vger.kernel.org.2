Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3AE3FFFF1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbhICMqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:46:12 -0400
Received: from mx449.baidu.com ([119.249.100.41]:57370 "EHLO mx419.baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234262AbhICMqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:46:11 -0400
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx419.baidu.com (Postfix) with ESMTP id 4E53218181B84;
        Fri,  3 Sep 2021 20:45:08 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 42594D9932;
        Fri,  3 Sep 2021 20:45:08 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Micro-optimize pvclock_clocksource_read
Date:   Fri,  3 Sep 2021 20:45:08 +0800
Message-Id: <1630673108-9121-1-git-send-email-lirongqing@baidu.com>
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

