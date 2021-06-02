Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F739887E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFBLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:45:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7073 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFBLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:40 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw6YM0bcqzYnpR;
        Wed,  2 Jun 2021 19:41:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:55 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/9] mfd: wm831x: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 19:43:31 +0800
Message-ID: <20210602114339.11223-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210602114339.11223-1-thunder.leizhen@huawei.com>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/wm831x-otp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm831x-otp.c b/drivers/mfd/wm831x-otp.c
index afe59d52dd74d55..25f5d9fe33a18e2 100644
--- a/drivers/mfd/wm831x-otp.c
+++ b/drivers/mfd/wm831x-otp.c
@@ -38,8 +38,8 @@ static int wm831x_unique_id_read(struct wm831x *wm831x, char *id)
 	return 0;
 }
 
-static ssize_t wm831x_unique_id_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
+static ssize_t unique_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct wm831x *wm831x = dev_get_drvdata(dev);
 	int rval;
@@ -52,7 +52,7 @@ static ssize_t wm831x_unique_id_show(struct device *dev,
 	return sprintf(buf, "%*phN\n", WM831X_UNIQUE_ID_LEN, id);
 }
 
-static DEVICE_ATTR(unique_id, 0444, wm831x_unique_id_show, NULL);
+static DEVICE_ATTR_RO(unique_id);
 
 int wm831x_otp_init(struct wm831x *wm831x)
 {
-- 
2.26.0.106.g9fadedd


