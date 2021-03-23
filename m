Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2125F3454B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhCWBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:09:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13659 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhCWBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:09:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4CrD3XsvznVQx;
        Tue, 23 Mar 2021 09:06:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 09:09:11 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/mutex: Remove repeated declaration
Date:   Tue, 23 Mar 2021 09:09:34 +0800
Message-ID: <1616461774-18644-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
introduces 'struct ww_acquire_ctx' again, remove the repeated declaration.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 include/linux/mutex.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 0cd631a19727..d80c0e22c822 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,8 +20,6 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
-struct ww_acquire_ctx;
-
 /*
  * Simple, straightforward mutexes with strict semantics:
  *
-- 
2.7.4

