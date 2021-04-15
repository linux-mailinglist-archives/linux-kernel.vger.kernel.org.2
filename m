Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE04C360BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhDOOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:24:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16594 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:24:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLhPD0R9jz19Lkm;
        Thu, 15 Apr 2021 22:22:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 22:24:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nils Carlson <nils.carlson@ericsson.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/1] char: hpet: Remove unused local variable 'm' in hpet_interrupt()
Date:   Thu, 15 Apr 2021 22:24:04 +0800
Message-ID: <20210415142404.3846-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for
delayed interrupt") removed the reference to local variable 'm', but
forgot to remove the definition and assignment of it. Due to
read_counter() indirectly calls "read barrier", the performance is
slightly degraded.

Since the following comments give some description based on 'm', so move
the assignment of 'm' into it.

Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for delayed interrupt")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/char/hpet.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ed3b7dab678dbd1..46950a0cda181a1 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -156,14 +156,16 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
 	 * This has the effect of treating non-periodic like periodic.
 	 */
 	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
-		unsigned long m, t, mc, base, k;
+		unsigned long t, mc, base, k;
 		struct hpet __iomem *hpet = devp->hd_hpet;
 		struct hpets *hpetp = devp->hd_hpets;
 
 		t = devp->hd_ireqfreq;
-		m = read_counter(&devp->hd_timer->hpet_compare);
 		mc = read_counter(&hpet->hpet_mc);
-		/* The time for the next interrupt would logically be t + m,
+		/*
+		 * m = read_counter(&devp->hd_timer->hpet_compare);
+		 *
+		 * The time for the next interrupt would logically be t + m,
 		 * however, if we are very unlucky and the interrupt is delayed
 		 * for longer than t then we will completely miss the next
 		 * interrupt if we set t + m and an application will hang.
-- 
2.26.0.106.g9fadedd


