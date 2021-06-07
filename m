Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4939D366
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFGD0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:26:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60184 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230172AbhFGD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:26:31 -0400
X-UUID: 4104ab5d812e4f5cbe188db290a0ae51-20210607
X-UUID: 4104ab5d812e4f5cbe188db290a0ae51-20210607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1696112267; Mon, 07 Jun 2021 11:24:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 11:24:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 11:24:36 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] arm64: ftrace: don't dereference a probably invalid address
Date:   Mon, 7 Jun 2021 11:23:30 +0800
Message-ID: <20210607032329.28671-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address in __mcount_loc may be invalid if somthing goes wrong.
On our arm64 platform, the bug in recordmcount make kernel
crash in ftrace_init().

https://lore.kernel.org/lkml/20210607023839.26387-1-mark-pk.tsai@mediatek.com/

Return -EFAULT if we are dealing with out-of-range condition
to prevent dereference the invalid address in ftrace_bug(),
then the kernel can disable ftrace safely for problematic
__mcount_loc.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 arch/arm64/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index b5d3ddaf69d9..98bec8445a58 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -201,7 +201,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 			preempt_enable();
 
 			if (WARN_ON(!mod))
-				return -EINVAL;
+				return -EFAULT;
 		}
 
 		/*
-- 
2.18.0

