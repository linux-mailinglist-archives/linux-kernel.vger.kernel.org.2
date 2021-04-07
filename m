Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44834356C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352395AbhDGMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:49:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15157 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352463AbhDGMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:49:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFkfh15VnzpW23;
        Wed,  7 Apr 2021 20:46:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:49:15 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] windfarm: make symbol 'wf_thread' static
Date:   Wed, 7 Apr 2021 20:57:38 +0800
Message-ID: <20210407125738.4138480-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/macintosh/windfarm_core.c:59:20: warning:
 symbol 'wf_thread' was not declared. Should it be static?

This symbol is not used outside of windfarm_core.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/macintosh/windfarm_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 77612303841e..07f91ec1f960 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -56,7 +56,7 @@ static BLOCKING_NOTIFIER_HEAD(wf_client_list);
 static int wf_client_count;
 static unsigned int wf_overtemp;
 static unsigned int wf_overtemp_counter;
-struct task_struct *wf_thread;
+static struct task_struct *wf_thread;
 
 static struct platform_device wf_platform_device = {
 	.name	= "windfarm",
-- 
2.25.4

