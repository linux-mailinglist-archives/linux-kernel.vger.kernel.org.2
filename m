Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065D357AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhDHD61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:58:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15960 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhDHD6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:58:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FG6qv2lV3zyNjT;
        Thu,  8 Apr 2021 11:55:55 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 11:57:58 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <ganeshgr@linux.ibm.com>,
        <christophe.leroy@csgroup.eu>, <mahesh@linux.ibm.com>,
        <clg@kaod.org>, <santosh@fossix.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>,
        <lihuafei1@huawei.com>
Subject: [PATCH -next] powerpc/mce: Make symbol 'mce_ue_event_work' static
Date:   Thu, 8 Apr 2021 11:58:02 +0800
Message-ID: <20210408035802.31853-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

arch/powerpc/kernel/mce.c:43:1: warning:
 symbol 'mce_ue_event_work' was not declared. Should it be static?

This symbol is not used outside of mce.c, so this commit marks it
static.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 11f0cae086ed..6aa6b1cda1ed 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -40,7 +40,7 @@ static struct irq_work mce_ue_event_irq_work = {
 	.func = machine_check_ue_irq_work,
 };
 
-DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
+static DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
 
 static BLOCKING_NOTIFIER_HEAD(mce_notifier_list);
 
-- 
2.17.1

