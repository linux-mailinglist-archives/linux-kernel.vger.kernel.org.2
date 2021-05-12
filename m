Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486437B629
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhELGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:31:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3723 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhELGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:31:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg4ZS3k3fzmgKq;
        Wed, 12 May 2021 14:26:56 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 14:30:11 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/8] crypto: hisilicon/hpre - delete rudundant macro definition
Date:   Wed, 12 May 2021 14:27:10 +0800
Message-ID: <1620800831-53346-8-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620800831-53346-1-git-send-email-tanghui20@huawei.com>
References: <1620800831-53346-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete rudundant macro definition.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 46c24f9..31515ae 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -57,7 +57,6 @@
 #define HPRE_CORE_INI_STATUS (HPRE_CLSTR_BASE + HPRE_CORE_INI_STATUS_OFFSET)
 #define HPRE_HAC_ECC1_CNT		0x301a04
 #define HPRE_HAC_ECC2_CNT		0x301a08
-#define HPRE_HAC_INT_STATUS		0x301800
 #define HPRE_HAC_SOURCE_INT		0x301600
 #define HPRE_CLSTR_ADDR_INTRVL		0x1000
 #define HPRE_CLUSTER_INQURY		0x100
@@ -822,7 +821,7 @@ static void hpre_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 
 static u32 hpre_get_hw_err_status(struct hisi_qm *qm)
 {
-	return readl(qm->io_base + HPRE_HAC_INT_STATUS);
+	return readl(qm->io_base + HPRE_INT_STATUS);
 }
 
 static void hpre_clear_hw_err_status(struct hisi_qm *qm, u32 err_sts)
-- 
2.8.1

