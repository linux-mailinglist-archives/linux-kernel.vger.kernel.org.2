Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86939B374
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFDHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:00:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3422 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhFDG7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:59:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxD6F5SLHz6vFd;
        Fri,  4 Jun 2021 14:55:01 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:58:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:58:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: [PATCH v2 13/15] s390: convert to setup_initial_init_mm()
Date:   Fri, 4 Jun 2021 15:06:31 +0800
Message-ID: <20210604070633.32363-14-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use setup_initial_init_mm() helper to simplify code.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/s390/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 5aab59ad5688..e1793ed43510 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1119,10 +1119,7 @@ void __init setup_arch(char **cmdline_p)
 
         ROOT_DEV = Root_RAM0;
 
-	init_mm.start_code = (unsigned long) _text;
-	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = (unsigned long) _end;
+	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
 		nospec_auto_detect();
-- 
2.26.2

