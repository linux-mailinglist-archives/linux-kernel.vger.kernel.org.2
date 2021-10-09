Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA404277F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJIHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 03:47:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13714 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJIHre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 03:47:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HRHBC0H8SzWWVW;
        Sat,  9 Oct 2021 15:44:03 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 15:45:35 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 9 Oct 2021
 15:45:34 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <peterz@infradead.org>, <jpoimboe@redhat.com>, <jbaron@akamai.com>,
        <rostedt@goodmis.org>, <ardb@kernel.org>, <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] static_call: fix null-ptr-deref in static_call_del_module
Date:   Sat, 9 Oct 2021 15:44:28 +0800
Message-ID: <20211009074428.1668662-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a NULL pointer dereference report when doing fault injection test:

BUG: kernel NULL pointer dereference, address: 0000000000000009
...
RIP: 0010:static_call_del_module+0x7a/0x100
...
Call Trace:
 static_call_module_notify+0x1e1/0x200
 notifier_call_chain_robust+0x6f/0xe0
 blocking_notifier_call_chain_robust+0x4e/0x70
 load_module+0x21f7/0x2b60
 __do_sys_finit_module+0xb0/0xf0
 ? __do_sys_finit_module+0xb0/0xf0
 __x64_sys_finit_module+0x1a/0x20
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

When loading a module, if it fails to allocate memory for static
calls, it will delete the non-existent mods (mods == 1) in the
static_call_module_notify()'s error path.

static_call_module_notify
	static_call_add_module
		__static_call_init
			site_mod = kzalloc() // fault injection
	static_call_del_module // access non-existent mods

This patch fixes the bug by skipping the operation when the key
has no mods.

Fixes: a945c8345ec0 ("static_call: Allow early init")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 kernel/static_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 43ba0b1e0edb..c3f8ffc5a52f 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -400,7 +400,7 @@ static void static_call_del_module(struct module *mod)
 
 	for (site = start; site < stop; site++) {
 		key = static_call_key(site);
-		if (key == prev_key)
+		if (key == prev_key || !static_call_key_has_mods(key))
 			continue;
 
 		prev_key = key;
-- 
2.17.1

