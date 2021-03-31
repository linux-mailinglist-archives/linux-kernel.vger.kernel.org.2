Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD51346F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhCXCGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:06:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14453 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhCXCGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:06:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4s3m0ZWpzwQD9;
        Wed, 24 Mar 2021 10:04:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 10:05:56 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: SCO - Remove trailing semicolon in macros
Date:   Wed, 24 Mar 2021 10:03:25 +0800
Message-ID: <1616551405-41488-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not use a trailing semicolon.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---

Changes in v2
-Modify comments 

 net/bluetooth/sco.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 22a110f..3bd4156 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -51,8 +51,8 @@ struct sco_conn {
 	unsigned int    mtu;
 };
 
-#define sco_conn_lock(c)	spin_lock(&c->lock);
-#define sco_conn_unlock(c)	spin_unlock(&c->lock);
+#define sco_conn_lock(c)	spin_lock(&c->lock)
+#define sco_conn_unlock(c)	spin_unlock(&c->lock)
 
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
-- 
2.8.1

