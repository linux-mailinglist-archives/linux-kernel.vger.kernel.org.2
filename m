Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7222B3552D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbhDFLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:54:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15137 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhDFLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:54:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FF5Tg1JMCzpVLN;
        Tue,  6 Apr 2021 19:51:35 +0800 (CST)
Received: from mdc.localdomain (10.175.104.57) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:54:12 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <huangguobin4@huawei.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] dlm: use DEFINE_SPINLOCK() for spinlock
Date:   Tue, 6 Apr 2021 19:54:07 +0800
Message-ID: <1617710047-47972-1-git-send-email-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guobin Huang <huangguobin4@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
---
 fs/dlm/plock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index c38b2b8ffd1d..5a24a2271fdd 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -13,7 +13,7 @@
 #include "dlm_internal.h"
 #include "lockspace.h"
 
-static spinlock_t ops_lock;
+static DEFINE_SPINLOCK(ops_lock);
 static struct list_head send_list;
 static struct list_head recv_list;
 static wait_queue_head_t send_wq;
@@ -492,7 +492,6 @@ int dlm_plock_init(void)
 {
 	int rv;
 
-	spin_lock_init(&ops_lock);
 	INIT_LIST_HEAD(&send_list);
 	INIT_LIST_HEAD(&recv_list);
 	init_waitqueue_head(&send_wq);

