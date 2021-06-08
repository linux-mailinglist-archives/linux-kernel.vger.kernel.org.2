Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2CD39F0CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFHI1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:27:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5288 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:27:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fzjqj0fFrz1BK1n;
        Tue,  8 Jun 2021 16:21:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:55 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:55 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guo Ren <guoren@kernel.org>, <linux-csky@vger.kernel.org>
Subject: [PATCH v3 resend 05/15] csky: convert to setup_initial_init_mm()
Date:   Tue, 8 Jun 2021 16:34:08 +0800
Message-ID: <20210608083418.137226-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use setup_initial_init_mm() helper to simplify code.

Acked-by: Guo Ren <guoren@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/csky/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index e93bc6f74432..c64e7be2045b 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -78,10 +78,7 @@ void __init setup_arch(char **cmdline_p)
 	pr_info("Phys. mem: %ldMB\n",
 		(unsigned long) memblock_phys_mem_size()/1024/1024);
 
-	init_mm.start_code = (unsigned long) _stext;
-	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = (unsigned long) _end;
+	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	parse_early_param();
 
-- 
2.26.2

