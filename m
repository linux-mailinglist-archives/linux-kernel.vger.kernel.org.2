Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA2443F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhKCJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:29:00 -0400
Received: from smtpbg127.qq.com ([109.244.180.96]:62792 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231278AbhKCJ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:28:59 -0400
X-QQ-mid: bizesmtp44t1635931541thuh86ww
Received: from localhost.localdomain (unknown [125.70.163.9])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 03 Nov 2021 17:25:38 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: ZKIyA7viXp3ttslXS0Q4muEqCwih+SZmXjtGcHa/VVxajBZVs9JP8b/PP2KuC
        Y1yu1pZIUldP6lYrU9GjozskDBSDl1mpHwQKxrZKKubKdF8M/1ZNKO3/IXmHUDHATH1X97B
        wbQ2zPpOEGZkK+SMoQorjTsnPduB6gv9JIbwc6t3oajBqXMWZ3vkTnp1XOLA18j9mC//kZn
        21YfzxcazqyVzZyDrQ/CVxiuioGp8KzjVjDfmaKwAdTvLu73us5Tk3EUPvAyd/kivIej5Xn
        ENp/g74rHKkFz4A79gEYquHa/5Gpvy4XO3yWDtP4SfBTuglZfSeI2/K0d3IcSyEj3MRGVUS
        qx9ZFLmqd+fwTYkmIWpG1z4E0UE9IPtKBoypIPt
X-QQ-GoodBg: 0
From:   Jingjing Liu <liujingjing@cdjrlc.com>
To:     ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jingjing Liu <liujingjing@cdjrlc.com>
Subject: [PATCH] soc: ti: wkup_m3_ipc:Remove redundant return value
Date:   Wed,  3 Nov 2021 17:25:31 +0800
Message-Id: <20211103092531.17874-1-liujingjing@cdjrlc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the return value of the empty function:
remove 'return 0' of the void function 'wkup_m3_rproc_boot_thread'

Signed-off-by: Jingjing Liu <liujingjing@cdjrlc.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 0733443a2631..2238beb40f8d 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -425,8 +425,6 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
 		dev_err(dev, "rproc_boot failed\n");
 	else
 		m3_ipc_state = m3_ipc;
-
-	return 0;
 }
 
 static int wkup_m3_ipc_probe(struct platform_device *pdev)
-- 
2.33.1

