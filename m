Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4677357EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhDHJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:19:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16405 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:19:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGFz45L3zzkjWr;
        Thu,  8 Apr 2021 17:17:36 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:19:14 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>
CC:     <john.wanghui@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: musb: fix PM reference leak in musb_irq_work()
Date:   Thu, 8 Apr 2021 17:18:36 +0800
Message-ID: <20210408091836.55227-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
thus a pairing decrement is needed.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index fc0457db62e1..8f09a387b773 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2070,7 +2070,7 @@ static void musb_irq_work(struct work_struct *data)
 	struct musb *musb = container_of(data, struct musb, irq_work.work);
 	int error;
 
-	error = pm_runtime_get_sync(musb->controller);
+	error = pm_runtime_resume_and_get(musb->controller);
 	if (error < 0) {
 		dev_err(musb->controller, "Could not enable: %i\n", error);
 

