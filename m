Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6930E960
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhBDBTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:19:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12390 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbhBDBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:19:30 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DWLJ36j1Pz7gTD;
        Thu,  4 Feb 2021 09:17:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 09:18:32 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] =?UTF-8?q?usb:=20typec:=20remove=20unused=20variable=20?= =?UTF-8?q?=E2=80=98ret=E2=80=99=20in=20typec=5Fpartner=5Fset=5Fpd=5Frevis?= =?UTF-8?q?ion?=
Date:   Thu, 4 Feb 2021 09:24:30 +0800
Message-ID: <20210204012430.3686636-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix follow warning:
drivers/usb/typec/class.c:763:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/usb/typec/class.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index b6ceab3dc16b..1c2d50e016e2 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -760,8 +760,6 @@ EXPORT_SYMBOL_GPL(typec_partner_set_identity);
  */
 int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision)
 {
-	int ret;
-
 	if (partner->pd_revision == pd_revision)
 		return 0;
 
-- 
2.25.4

