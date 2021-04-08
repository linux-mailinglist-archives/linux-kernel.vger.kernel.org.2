Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41963357FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhDHJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:52:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15182 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhDHJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:52:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGGgy3HgTzpVM3;
        Thu,  8 Apr 2021 17:49:34 +0800 (CST)
Received: from Ubuntu1804.huawei.com (10.67.174.169) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 17:52:13 +0800
From:   Zhao Xuehui <zhaoxuehui1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>,
        <zhaoxuehui1@huawei.com>
Subject: [PATCH -next] x86, msr: Make symbol 'msr_read' and 'msr_write' static
Date:   Thu, 8 Apr 2021 17:52:18 +0800
Message-ID: <20210408095218.152264-1-zhaoxuehui1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.169]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol 'msr_read' and 'msr_write' are not used outside of msr.c, so this
commit marks them static.

Signed-off-by: Zhao Xuehui <zhaoxuehui1@huawei.com>
---
 arch/x86/lib/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 3bd905e10ee2..b09cd2ad426c 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL(msrs_free);
  * argument @m.
  *
  */
-int msr_read(u32 msr, struct msr *m)
+static int msr_read(u32 msr, struct msr *m)
 {
 	int err;
 	u64 val;
@@ -54,7 +54,7 @@ int msr_read(u32 msr, struct msr *m)
  * @msr: MSR to write
  * @m: value to write
  */
-int msr_write(u32 msr, struct msr *m)
+static int msr_write(u32 msr, struct msr *m)
 {
 	return wrmsrl_safe(msr, m->q);
 }

