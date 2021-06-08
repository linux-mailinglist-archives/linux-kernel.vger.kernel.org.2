Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30C39F0E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFHI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:28:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8086 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhFHI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:28:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzjtF0MLQzYrtv;
        Tue,  8 Jun 2021 16:23:17 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:26:00 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:25:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
Subject: [PATCH v3 resend 15/15] x86: convert to setup_initial_init_mm()
Date:   Tue, 8 Jun 2021 16:34:18 +0800
Message-ID: <20210608083418.137226-16-wangkefeng.wang@huawei.com>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/x86/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1e720626069a..7ca94d062c79 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -870,10 +870,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (!boot_params.hdr.root_flags)
 		root_mountflags &= ~MS_RDONLY;
-	init_mm.start_code = (unsigned long) _text;
-	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = _brk_end;
+	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
 	code_resource.start = __pa_symbol(_text);
 	code_resource.end = __pa_symbol(_etext)-1;
-- 
2.26.2

