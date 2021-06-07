Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958E439D30A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFGCpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:45:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3441 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGCpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:45:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FyyJs5Db8z6vwS;
        Mon,  7 Jun 2021 10:40:13 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:43:12 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:43:12 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <benh@kernel.crashing.org>, <aik@ozlabs.ru>,
        <rdunlap@infradead.org>, <unixbhaskar@gmail.com>,
        <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] macintosh: Use for_each_child_of_node() macro
Date:   Mon, 7 Jun 2021 11:01:48 +0800
Message-ID: <1623034908-30525-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/macintosh/macio_asic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 49af60b..f552c7c 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -474,7 +474,7 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 	root_res = &rdev->resource[0];
 
 	/* First scan 1st level */
-	for (np = NULL; (np = of_get_next_child(pnode, np)) != NULL;) {
+	for_each_child_of_node(pnode, np) {
 		if (macio_skip_device(np))
 			continue;
 		of_node_get(np);
@@ -491,7 +491,7 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 	/* Add media bay devices if any */
 	if (mbdev) {
 		pnode = mbdev->ofdev.dev.of_node;
-		for (np = NULL; (np = of_get_next_child(pnode, np)) != NULL;) {
+		for_each_child_of_node(pnode, np) {
 			if (macio_skip_device(np))
 				continue;
 			of_node_get(np);
@@ -504,7 +504,7 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 	/* Add serial ports if any */
 	if (sdev) {
 		pnode = sdev->ofdev.dev.of_node;
-		for (np = NULL; (np = of_get_next_child(pnode, np)) != NULL;) {
+		for_each_child_of_node(pnode, np) {
 			if (macio_skip_device(np))
 				continue;
 			of_node_get(np);
-- 
2.6.2

