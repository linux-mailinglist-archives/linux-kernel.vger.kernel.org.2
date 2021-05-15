Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEF9381939
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEOOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 10:00:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhEOOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 10:00:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj6Pm4KhNz16PjK;
        Sat, 15 May 2021 21:56:28 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 21:59:01 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <vbabka@suse.cz>, <guohanjun@huawei.com>, <zhangjinhao2@huawei.com>
Subject: [PATCH 1/2] acct: Fix accuracy loss for input value of encode_comp_t()
Date:   Sat, 15 May 2021 22:06:30 +0800
Message-ID: <20210515140631.369106-2-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210515140631.369106-1-zhengyejian1@huawei.com>
References: <20210515140631.369106-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See calculation of ac_{u,s}time in fill_ac():
  > ac->ac_utime = encode_comp_t(nsec_to_AHZ(pacct->ac_utime));
  > ac->ac_stime = encode_comp_t(nsec_to_AHZ(pacct->ac_stime));

Return value of nsec_to_AHZ() is always type of 'u64', but it is
handled as type of 'unsigned long' in encode_comp_t, and accuracy
loss would happen on 32-bit platform when 'unsigned long' value
is 32-bit-width.

So 'u64' value of encode_comp_t() may look better.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/acct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index a64102be2bb0..9e143ed5b5d0 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -301,7 +301,7 @@ void acct_exit_ns(struct pid_namespace *ns)
 }
 
 /*
- *  encode an unsigned long into a comp_t
+ *  encode an u64 into a comp_t
  *
  *  This routine has been adopted from the encode_comp_t() function in
  *  the kern_acct.c file of the FreeBSD operating system. The encoding
@@ -312,7 +312,7 @@ void acct_exit_ns(struct pid_namespace *ns)
 #define	EXPSIZE		3			/* Base 8 (3 bit) exponent. */
 #define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */
 
-static comp_t encode_comp_t(unsigned long value)
+static comp_t encode_comp_t(u64 value)
 {
 	int exp, rnd;
 
-- 
2.17.1

