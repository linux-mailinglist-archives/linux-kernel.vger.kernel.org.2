Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6B376EDB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 04:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEHChn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 22:37:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17478 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhEHChm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 22:37:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FcWbc225bzkWt8;
        Sat,  8 May 2021 10:34:04 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 10:36:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] stm class: dummy_stm: Fix error return code in dummy_stm_init()
Date:   Sat, 8 May 2021 10:36:15 +0800
Message-ID: <20210508023615.1827-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although 'ret' has been initialized to -ENOMEM, but it will be reassigned
by the "ret = stm_register_device(...)" statement in the for loop. So
that, the value of 'ret' is unknown when kasprintf() failed.

Fixes: bcfdf8afdebe ("stm class: dummy_stm: Create multiple devices")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/hwtracing/stm/dummy_stm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 38528ffdc0b3..36d32e7afb35 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -68,7 +68,7 @@ static int dummy_stm_link(struct stm_data *data, unsigned int master,
 
 static int dummy_stm_init(void)
 {
-	int i, ret = -ENOMEM;
+	int i, ret;
 
 	if (nr_dummies < 0 || nr_dummies > DUMMY_STM_MAX)
 		return -EINVAL;
@@ -80,8 +80,10 @@ static int dummy_stm_init(void)
 
 	for (i = 0; i < nr_dummies; i++) {
 		dummy_stm[i].name = kasprintf(GFP_KERNEL, "dummy_stm.%d", i);
-		if (!dummy_stm[i].name)
+		if (!dummy_stm[i].name) {
+			ret = -ENOMEM;
 			goto fail_unregister;
+		}
 
 		dummy_stm[i].sw_start		= master_min;
 		dummy_stm[i].sw_end		= master_max;
-- 
2.25.1


