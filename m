Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C443A2A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:34:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5322 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:34:52 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G11tT4ZHYz1BL01;
        Thu, 10 Jun 2021 19:28:01 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:32:54 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 19:32:53 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <feng.tang@intel.com>,
        <luming.yu@intel.com>, <paulmck@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] x86/tsc: fix doc warnings in tsc.c
Date:   Thu, 10 Jun 2021 19:42:01 +0800
Message-ID: <20210610114201.3440584-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 arch/x86/kernel/tsc.c:1275: warning: Excess function
  parameter 'cycles' description in 'convert_art_ns_to_tsc'
 arch/x86/kernel/tsc.c:1275: warning: Excess function
  parameter 'cs' description in 'convert_art_ns_to_tsc'
 arch/x86/kernel/tsc.c:1309: warning: Function parameter or
  member 'work' not described in 'tsc_refine_calibration_work'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 2e076a459a0c..312591c8e3d6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1265,8 +1265,8 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  * Return:
  * struct system_counterval_t - system counter value with the pointer to the
  *	corresponding clocksource
- *	@cycles:	System counter value
- *	@cs:		Clocksource corresponding to system counter value. Used
+ *	cycles:		System counter value
+ *	cs:		Clocksource corresponding to system counter value. Used
  *			by timekeeping code to verify comparability of two cycle
  *			values.
  */
@@ -1293,7 +1293,7 @@ static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
  * tsc_refine_calibration_work - Further refine tsc freq calibration
- * @work - ignored.
+ * @work: ignored.
  *
  * This functions uses delayed work over a period of a
  * second to further refine the TSC freq value. Since this is
-- 
2.31.1

