Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89616435D32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJUIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:46:21 -0400
Received: from mx22.baidu.com ([220.181.50.185]:47896 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231573AbhJUIqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:46:18 -0400
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
        by Forcepoint Email with ESMTPS id 264DAC337D97058EAA94;
        Thu, 21 Oct 2021 16:44:01 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:44:00 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:44:00 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: mass_storage: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:43:58 +0800
Message-ID: <20211021084359.2607-1-caihuoqing@baidu.com>
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
 drivers/usb/gadget/function/f_mass_storage.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 3cabf7692ee1..1e3cab5d635c 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2962,7 +2962,7 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
 	if (!common->thread_task) {
 		common->state = FSG_STATE_NORMAL;
 		common->thread_task =
-			kthread_create(fsg_main_thread, common, "file-storage");
+			kthread_run(fsg_main_thread, common, "file-storage");
 		if (IS_ERR(common->thread_task)) {
 			ret = PTR_ERR(common->thread_task);
 			common->thread_task = NULL;
@@ -2971,7 +2971,6 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
 		}
 		DBG(common, "I/O thread pid: %d\n",
 		    task_pid_nr(common->thread_task));
-		wake_up_process(common->thread_task);
 	}
 
 	fsg->gadget = gadget;
-- 
2.25.1

