Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40EB3AAD70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFQH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:26:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7317 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:26:18 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5D2301Ptz1BNF1;
        Thu, 17 Jun 2021 15:19:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 17 Jun 2021 15:24:08 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] usb: typec: Add the missed altmode_id_remove() in typec_register_altmode()
Date:   Thu, 17 Jun 2021 15:32:26 +0800
Message-ID: <20210617073226.47599-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_register_altmode() misses to call altmode_id_remove() in an error
path. Add the missed function call to fix it.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/usb/typec/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index b9429c9f65f6..aeef453aa658 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -517,8 +517,10 @@ typec_register_altmode(struct device *parent,
 	int ret;
 
 	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
-	if (!alt)
+	if (!alt) {
+		altmode_id_remove(parent, id);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	alt->adev.svid = desc->svid;
 	alt->adev.mode = desc->mode;
-- 
2.26.0.106.g9fadedd

