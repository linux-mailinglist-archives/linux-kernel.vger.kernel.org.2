Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C45393EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhE1I2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:28:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2512 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhE1I14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:27:56 -0400
Received: from dggeml762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FryPl5xZmzYq13;
        Fri, 28 May 2021 16:23:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml762-chm.china.huawei.com (10.1.199.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 16:26:20 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 16:26:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     David Kershner <david.kershner@unisys.com>,
        Tim Sell <timothy.sell@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer <sparmaintainer@unisys.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] visorbus: fix error return code in visorchipset_init()
Date:   Fri, 28 May 2021 16:26:14 +0800
Message-ID: <20210528082614.9337-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1366a3db3dcf ("staging: unisys: visorbus: visorchipset_init clean
up gotos") assigns the initial value -ENODEV to the local variable 'err',
and the first several error branches will return this value after "goto
error". But commit f1f537c2e7f5 ("staging: unisys: visorbus: Consolidate
controlvm channel creation.") overwrites 'err' in the middle of the way.
As a result, some error branches do not successfully return the initial
value -ENODEV of 'err', but return 0.

In addition, when kzalloc() fails, -ENOMEM should be returned instead of
-ENODEV.

Fixes: f1f537c2e7f5 ("staging: unisys: visorbus: Consolidate controlvm channel creation.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/visorbus/visorchipset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/visorbus/visorchipset.c b/drivers/visorbus/visorchipset.c
index cb1eb7e05f87..5668cad86e37 100644
--- a/drivers/visorbus/visorchipset.c
+++ b/drivers/visorbus/visorchipset.c
@@ -1561,7 +1561,7 @@ static void controlvm_periodic_work(struct work_struct *work)
 
 static int visorchipset_init(struct acpi_device *acpi_device)
 {
-	int err = -ENODEV;
+	int err = -ENOMEM;
 	struct visorchannel *controlvm_channel;
 
 	chipset_dev = kzalloc(sizeof(*chipset_dev), GFP_KERNEL);
@@ -1584,8 +1584,10 @@ static int visorchipset_init(struct acpi_device *acpi_device)
 				 "controlvm",
 				 sizeof(struct visor_controlvm_channel),
 				 VISOR_CONTROLVM_CHANNEL_VERSIONID,
-				 VISOR_CHANNEL_SIGNATURE))
+				 VISOR_CHANNEL_SIGNATURE)) {
+		err = -ENODEV;
 		goto error_delete_groups;
+	}
 	/* if booting in a crash kernel */
 	if (is_kdump_kernel())
 		INIT_DELAYED_WORK(&chipset_dev->periodic_controlvm_work,
-- 
2.25.1


