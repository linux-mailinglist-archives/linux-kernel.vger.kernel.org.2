Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C339B36B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFDG74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:59:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3056 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhFDG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:59:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxD490mqHzWrbR;
        Fri,  4 Jun 2021 14:53:13 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:57:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 14:57:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 08/15] nds32: convert to setup_initial_init_mm()
Date:   Fri, 4 Jun 2021 15:06:26 +0800
Message-ID: <20210604070633.32363-9-wangkefeng.wang@huawei.com>
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

Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/nds32/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index af82e996f412..41725eaf8bac 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -294,10 +294,7 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_cpuinfo();
 
-	init_mm.start_code = (unsigned long)&_stext;
-	init_mm.end_code = (unsigned long)&_etext;
-	init_mm.end_data = (unsigned long)&_edata;
-	init_mm.brk = (unsigned long)&_end;
+	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	/* setup bootmem allocator */
 	setup_memory();
-- 
2.26.2

