Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D403A2A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:29:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3941 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhFJL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:29:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G11pv2LLxz6xKk;
        Thu, 10 Jun 2021 19:24:55 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:28:00 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 19:27:59 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <peterz@infradead.org>, <rafael.j.wysocki@intel.com>,
        <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] kernel/notifier.c: fix doc warnings
Date:   Thu, 10 Jun 2021 19:37:06 +0800
Message-ID: <20210610113706.3439933-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 kernel/notifier.c:67: warning: Excess function
  parameter 'returns' description in 'notifier_call_chain'
 kernel/notifier.c:115: warning: Function parameter or
  member 'v' not described in 'notifier_call_chain_robust'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/notifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cbca594..e776e65751c2 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -58,7 +58,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
  *			value of this parameter is -1.
  *	@nr_calls:	Records the number of notifications sent. Don't care
  *			value of this field is NULL.
- *	@returns:	notifier_call_chain returns the value returned by the
+ *	returns:	notifier_call_chain returns the value returned by the
  *			last notifier function called.
  */
 static int notifier_call_chain(struct notifier_block **nl,
@@ -101,7 +101,7 @@ NOKPROBE_SYMBOL(notifier_call_chain);
  * @val_up:	Value passed unmodified to the notifier function
  * @val_down:	Value passed unmodified to the notifier function when recovering
  *              from an error on @val_up
- * @v		Pointer passed unmodified to the notifier function
+ * @v:		Pointer passed unmodified to the notifier function
  *
  * NOTE:	It is important the @nl chain doesn't change between the two
  *		invocations of notifier_call_chain() such that we visit the
-- 
2.31.1

