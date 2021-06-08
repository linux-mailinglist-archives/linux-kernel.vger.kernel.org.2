Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0939EC48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFHCo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:44:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5277 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHCoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:44:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FzZCS37Xjz1BKv6;
        Tue,  8 Jun 2021 10:37:40 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:42:30 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:42:29 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] x86: fix doc warnings in csum-wrappers_64.c
Date:   Tue, 8 Jun 2021 10:51:33 +0800
Message-ID: <20210608025133.2759676-1-libaokun1@huawei.com>
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

Fixes the following W=1 kernel build warning(s):

 arch/x86/lib/csum-wrappers_64.c:25: warning: Excess function
  parameter 'isum' description in 'csum_and_copy_from_user'
 arch/x86/lib/csum-wrappers_64.c:25: warning: Excess function
  parameter 'errp' description in 'csum_and_copy_from_user'
 arch/x86/lib/csum-wrappers_64.c:50: warning: Excess function
  parameter 'isum' description in 'csum_and_copy_to_user'
 arch/x86/lib/csum-wrappers_64.c:50: warning: Excess function
  parameter 'errp' description in 'csum_and_copy_to_user'
 arch/x86/lib/csum-wrappers_64.c:73: warning: Excess function
  parameter 'sum' description in 'csum_partial_copy_nocheck'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/x86/lib/csum-wrappers_64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 189344924a2b..25d533502693 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -14,8 +14,6 @@
  * @src: source address (user space)
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad source address.
  *
  * Returns an 32bit unfolded checksum of the buffer.
  * src and dst are best aligned to 64bits.
@@ -39,8 +37,6 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
  * @src: source address
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad destination address.
  *
  * Returns an 32bit unfolded checksum of the buffer.
  * src and dst are best aligned to 64bits.
@@ -64,7 +60,6 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
  * @src: source address
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @sum: initial sum that is added into the result (32bit unfolded)
  *
  * Returns an 32bit unfolded checksum of the buffer.
  */
-- 
2.31.1

