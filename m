Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591EB435D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:45:49 -0400
Received: from mx24.baidu.com ([111.206.215.185]:47148 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230385AbhJUIpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:45:47 -0400
Received: from BC-Mail-Ex07.internal.baidu.com (unknown [172.31.51.47])
        by Forcepoint Email with ESMTPS id 3459F51BD06B877B6922;
        Thu, 21 Oct 2021 16:43:31 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX07.internal.baidu.com (172.31.51.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:43:30 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:43:30 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: vchiq_arm: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:43:27 +0800
Message-ID: <20211021084328.2395-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a5e33da74726..6130b95aaca3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1717,15 +1717,12 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 	write_unlock_bh(&arm_state->susp_res_lock);
 	snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
 		 state->id);
-	arm_state->ka_thread = kthread_create(&vchiq_keepalive_thread_func,
-					      (void *)state,
-					      threadname);
+	arm_state->ka_thread = kthread_run(&vchiq_keepalive_thread_func,
+					   (void *)state, threadname);
 	if (IS_ERR(arm_state->ka_thread)) {
 		vchiq_log_error(vchiq_susp_log_level,
 				"vchiq: FATAL: couldn't create thread %s",
 				threadname);
-	} else {
-		wake_up_process(arm_state->ka_thread);
 	}
 }
 
-- 
2.25.1

