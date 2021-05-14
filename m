Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0274B3803E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhENHC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:02:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2657 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhENHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:02:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhK990rR9zQnHr;
        Fri, 14 May 2021 14:57:49 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.189) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 15:01:04 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <linqiheng@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] misc/pvpanic: add missing MODULE_DEVICE_TABLE
Date:   Fri, 14 May 2021 15:01:03 +0800
Message-ID: <20210514070103.540-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.189]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/misc/pvpanic/pvpanic-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 9ecc4e8559d5..ccd7e32d3f55 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -26,6 +26,7 @@ static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
 	{}
 };
+MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
 
 static ssize_t capability_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)

