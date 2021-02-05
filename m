Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C15B310772
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBEJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:13:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12839 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBEJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:10:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX8j20qVZz7hR5;
        Fri,  5 Feb 2021 17:08:22 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 17:09:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <peterx@redhat.com>,
        <mark.rutland@arm.com>, <elver@google.com>,
        <andreyknvl@google.com>, <vincenzo.frascino@arm.com>,
        <pcc@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/arm64: Correct obsolete comment in do_page_fault()
Date:   Fri, 5 Feb 2021 04:09:19 -0500
Message-ID: <20210205090919.63382-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d8ed45c5dcd4 ("mmap locking API: use coccinelle to convert mmap_sem
rwsem call sites") has convertd down_read_trylock() to mmap_read_trylock().
But it forgot to update the relevant comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 304eef9b7d44..eaa373dab731 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -576,7 +576,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 		mmap_read_lock(mm);
 	} else {
 		/*
-		 * The above down_read_trylock() might have succeeded in which
+		 * The above mmap_read_trylock() might have succeeded in which
 		 * case, we'll have missed the might_sleep() from down_read().
 		 */
 		might_sleep();
-- 
2.19.1

