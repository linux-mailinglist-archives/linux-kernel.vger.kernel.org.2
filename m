Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C946356C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352385AbhDGMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:49:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16813 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352398AbhDGMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:49:11 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FFkfv5Fc5z9x22;
        Wed,  7 Apr 2021 20:46:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:48:48 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] macintosh/windfarm: Make symbol 'pm121_sys_state' static
Date:   Wed, 7 Apr 2021 20:57:12 +0800
Message-ID: <20210407125712.4138033-1-yukuai3@huawei.com>
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

drivers/macintosh/windfarm_pm121.c:436:24: warning:
 symbol 'pm121_sys_state' was not declared. Should it be static?

This symbol is not used outside of windfarm_pm121.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/macintosh/windfarm_pm121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index ab467b9c31be..ba1ec6fc11d2 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -433,7 +433,7 @@ struct pm121_sys_state {
 	struct wf_pid_state	pid;
 };
 
-struct pm121_sys_state *pm121_sys_state[N_LOOPS] = {};
+static struct pm121_sys_state *pm121_sys_state[N_LOOPS] = {};
 
 /*
  * ****** CPU Fans Control Loop ******
-- 
2.25.4

