Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF73352A37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhDBL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:27:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15535 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:27:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBd4H5STPzPnYG;
        Fri,  2 Apr 2021 19:24:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 19:27:03 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] crypto: hisilicon/hpre - delete redundant log
Date:   Fri, 2 Apr 2021 19:24:29 +0800
Message-ID: <1617362669-40372-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hpre_cfg_by_dsm' has checked and printed error path internally. It is not
necessary to do it here, so remove it.

Signed-off-by: Hui Tang <tanghui20@huawei.com>

v1 -> v2:
- Return immediately when return value of 'hpre_cfg_by_dsm' is non-zero.
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index c7ab06d..fa40835 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -386,7 +386,7 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 	if (qm->ver == QM_HW_V2) {
 		ret = hpre_cfg_by_dsm(qm);
 		if (ret)
-			dev_err(dev, "acpi_evaluate_dsm err.\n");
+			return ret;
 
 		disable_flr_of_bme(qm);
 	}
-- 
2.8.1

