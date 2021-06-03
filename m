Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAE399D66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:07:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3529 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:07:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fwg0V4pX6zZcS9;
        Thu,  3 Jun 2021 17:03:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:05:51 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:05:51 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] EISA: use DEVICE_ATTR_RO() helper macro
Date:   Thu, 3 Jun 2021 17:05:06 +0800
Message-ID: <20210603090506.11771-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper macro instead of DEVICE_ATTR(), which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/eisa/eisa-bus.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index d9a16ba2ccc2899..65bffde137e3f70 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -155,34 +155,29 @@ void eisa_driver_unregister(struct eisa_driver *edrv)
 }
 EXPORT_SYMBOL(eisa_driver_unregister);
 
-static ssize_t eisa_show_sig(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t signature_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct eisa_device *edev = to_eisa_device(dev);
 	return sprintf(buf, "%s\n", edev->id.sig);
 }
+static DEVICE_ATTR_RO(signature);
 
-static DEVICE_ATTR(signature, S_IRUGO, eisa_show_sig, NULL);
-
-static ssize_t eisa_show_state(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t enabled_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct eisa_device *edev = to_eisa_device(dev);
 	return sprintf(buf, "%d\n", edev->state & EISA_CONFIG_ENABLED);
 }
+static DEVICE_ATTR_RO(enabled);
 
-static DEVICE_ATTR(enabled, S_IRUGO, eisa_show_state, NULL);
-
-static ssize_t eisa_show_modalias(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct eisa_device *edev = to_eisa_device(dev);
 	return sprintf(buf, EISA_DEVICE_MODALIAS_FMT "\n", edev->id.sig);
 }
-
-static DEVICE_ATTR(modalias, S_IRUGO, eisa_show_modalias, NULL);
+static DEVICE_ATTR_RO(modalias);
 
 static int __init eisa_init_device(struct eisa_root_device *root,
 				   struct eisa_device *edev,
-- 
2.26.0.106.g9fadedd


