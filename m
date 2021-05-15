Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436D738193A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhEOOAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 10:00:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3700 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhEOOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 10:00:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj6Pm3mJ3z16LXF;
        Sat, 15 May 2021 21:56:28 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 21:59:02 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <vbabka@suse.cz>, <guohanjun@huawei.com>, <zhangjinhao2@huawei.com>
Subject: [PATCH 2/2] acct: Fix potential integer overflow in encode_comp_t()
Date:   Sat, 15 May 2021 22:06:31 +0800
Message-ID: <20210515140631.369106-3-zhengyejian1@huawei.com>
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

The integer overflow is descripted with following codes:
  > 317 static comp_t encode_comp_t(u64 value)
  > 318 {
  > 319         int exp, rnd;
    ......
  > 341         exp <<= MANTSIZE;
  > 342         exp += value;
  > 343         return exp;
  > 344 }

Currently comp_t is defined as type of '__u16', but the
variable 'exp' is type of 'int', so overflow would happen
when variable 'exp' in line 343 is greater than 65535.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/acct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/acct.c b/kernel/acct.c
index 9e143ed5b5d0..4182b92cf3df 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -331,6 +331,8 @@ static comp_t encode_comp_t(u64 value)
 		exp++;
 	}
 
+	if (exp > (((comp_t) ~0U) >> MANTSIZE))
+		return (comp_t) ~0U;
 	/*
 	 * Clean it up and polish it off.
 	 */
-- 
2.17.1

