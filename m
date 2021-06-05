Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7084239C655
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFEGk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:40:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:40:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fxqf03v8Gz6tlm;
        Sat,  5 Jun 2021 14:36:08 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:39:08 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:39:08 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <jroedel@suse.de>,
        <trix@redhat.com>, <brijesh.singh@amd.com>, <rostedt@goodmis.org>,
        <ying-tsun.huang@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] x86/mm/mtrr: fix doc warnings in generic.c
Date:   Sat, 5 Jun 2021 14:48:21 +0800
Message-ID: <20210605064821.694432-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 arch/x86/kernel/cpu/mtrr/generic.c:120: warning: Function parameter or 
  member 'start' not described in 'mtrr_type_lookup_fixed'
 arch/x86/kernel/cpu/mtrr/generic.c:120: warning: Function parameter or 
  member 'end' not described in 'mtrr_type_lookup_fixed'
 arch/x86/kernel/cpu/mtrr/generic.c:161: warning: Function parameter or 
  member 'start' not described in 'mtrr_type_lookup_variable'
 arch/x86/kernel/cpu/mtrr/generic.c:161: warning: Function parameter or 
  member 'end' not described in 'mtrr_type_lookup_variable'
 arch/x86/kernel/cpu/mtrr/generic.c:161: warning: Function parameter or 
  member 'partial_end' not described in 'mtrr_type_lookup_variable'
 arch/x86/kernel/cpu/mtrr/generic.c:161: warning: Function parameter or 
  member 'repeat' not described in 'mtrr_type_lookup_variable'
 arch/x86/kernel/cpu/mtrr/generic.c:161: warning: Function parameter or 
  member 'uniform' not described in 'mtrr_type_lookup_variable'
 arch/x86/kernel/cpu/mtrr/generic.c:255: warning: Function parameter or 
  member 'start' not described in 'mtrr_type_lookup'
 arch/x86/kernel/cpu/mtrr/generic.c:255: warning: Function parameter or 
  member 'end' not described in 'mtrr_type_lookup'
 arch/x86/kernel/cpu/mtrr/generic.c:255: warning: Function parameter or 
  member 'uniform' not described in 'mtrr_type_lookup'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 558108296f3c..8a943a83845e 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -104,7 +104,8 @@ static int check_type_overlap(u8 *prev, u8 *curr)
 
 /**
  * mtrr_type_lookup_fixed - look up memory type in MTRR fixed entries
- *
+ * @start: Start addaress.
+ * @end: End address.
  * Return the MTRR fixed memory type of 'start'.
  *
  * MTRR fixed entries are divided into the following ways:
@@ -143,7 +144,11 @@ static u8 mtrr_type_lookup_fixed(u64 start, u64 end)
 
 /**
  * mtrr_type_lookup_variable - look up memory type in MTRR variable entries
- *
+ * @start: Start addaress.
+ * @end: End address.
+ * @partial_end: Partial end address.
+ * @repeat: Memory is repeat or not.
+ * @uniform: Memory is uniform or not.
  * Return Value:
  * MTRR_TYPE_(type) - Matched memory type or default memory type (unmatched)
  *
@@ -241,7 +246,9 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 
 /**
  * mtrr_type_lookup - look up memory type in MTRR
- *
+ * @start: Start addaress.
+ * @end: End address.
+ * @uniform: Memory is uniform or not.
  * Return Values:
  * MTRR_TYPE_(type)  - The effective MTRR type for the region
  * MTRR_TYPE_INVALID - MTRR is disabled
-- 
2.31.1

