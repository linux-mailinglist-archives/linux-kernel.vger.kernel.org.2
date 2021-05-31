Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04956396536
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhEaQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:26:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2803 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhEaOoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:44:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtyZw3LwHzWpKB;
        Mon, 31 May 2021 22:38:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:43:13 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 22:43:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lee.jones@linaro.org>, <linus.walleij@linaro.org>
Subject: [PATCH -next] mfd: db8500-prcmu: fix some doc warnings
Date:   Mon, 31 May 2021 22:47:40 +0800
Message-ID: <20210531144740.24466-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 warnings:

  drivers/mfd/db8500-prcmu.c:624: warning: expecting prototype for prcmu_get_current_mode(). Prototype was for prcmu_get_xp70_current_state() instead
  drivers/mfd/db8500-prcmu.c:908: warning: expecting prototype for db8500_set_ape_opp(). Prototype was for db8500_prcmu_set_ape_opp() instead
  drivers/mfd/db8500-prcmu.c:2303: warning: expecting prototype for db8500_prcmu_reset_modem(). Prototype was for db8500_prcmu_modem_reset() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mfd/db8500-prcmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 167faac9b75b..3bde7fda755f 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -616,7 +616,7 @@ enum romcode_read prcmu_get_rc_p2a(void)
 }
 
 /**
- * prcmu_get_current_mode - Return the current XP70 power mode
+ * prcmu_get_xp70_current_state - Return the current XP70 power mode
  * Returns: Returns the current AP(ARM) power mode: init,
  * apBoot, apExecute, apDeepSleep, apSleep, apIdle, apReset
  */
@@ -898,7 +898,7 @@ static void request_even_slower_clocks(bool enable)
 }
 
 /**
- * db8500_set_ape_opp - set the appropriate APE OPP
+ * db8500_prcmu_set_ape_opp - set the appropriate APE OPP
  * @opp: The new APE operating point to which transition is to be made
  * Returns: 0 on success, non-zero on failure
  *
@@ -2297,7 +2297,7 @@ u16 db8500_prcmu_get_reset_code(void)
 }
 
 /**
- * db8500_prcmu_reset_modem - ask the PRCMU to reset modem
+ * db8500_prcmu_modem_reset - ask the PRCMU to reset modem
  */
 void db8500_prcmu_modem_reset(void)
 {
-- 
2.25.1

