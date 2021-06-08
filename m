Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80639EC26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFHCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:35:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8068 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFHCfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:35:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzZ3s59XmzYsSr
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:31:05 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:33:54 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:33:54 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] clockevents: fix doc warnings in clockevents.c
Date:   Tue, 8 Jun 2021 10:43:05 +0800
Message-ID: <20210608024305.2750999-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for `tick_cleanup_dead_cpu` to fix the W=1 warnings:

kernel/time/clockevents.c:634: warning: Function parameter or
 member 'cpu' not described in 'tick_cleanup_dead_cpu'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/time/clockevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0056d2bed53e..bb9d2fe58480 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -629,6 +629,7 @@ void tick_offline_cpu(unsigned int cpu)
 
 /**
  * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
+ * @cpu:	The dead CPU
  */
 void tick_cleanup_dead_cpu(int cpu)
 {
-- 
2.31.1

