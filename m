Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5973E391086
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhEZGYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:24:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6711 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhEZGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:24:11 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fqgks1nLjzpfRJ;
        Wed, 26 May 2021 14:19:01 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 14:22:38 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 26 May
 2021 14:22:37 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <dan.carpenter@oracle.com>, <desmondcheongzx@gmail.com>,
        <marcocesati@gmail.com>, <fabioaiuto83@gmail.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH next] staging: rtl8723bs: HalBtc8723b1Ant.c: Remove unused variables
Date:   Wed, 26 May 2021 15:45:37 +0800
Message-ID: <20210526074537.46259-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build warning: [-Wunused-but-set-variable]

drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:2710:6: warning: variable ‘u4Tmp’ set but not used
 2710 |  u32 u4Tmp;
      |      ^~~~~
drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:2709:13: warning: variable ‘u1Tmpb’ set but not used
 2709 |  u8 u1Tmpa, u1Tmpb;
      |             ^~~~~~
drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:2709:5: warning: variable ‘u1Tmpa’ set but not used
 2709 |  u8 u1Tmpa, u1Tmpb;
      |     ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 518d5354bda4..adfdc4f14b08 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -2706,9 +2706,6 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	bool bBtCtrlAggBufSize = false;
 	u8 aggBufSize = 5;
 
-	u8 u1Tmpa, u1Tmpb;
-	u32 u4Tmp;
-
 	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
 		return;
 
@@ -2716,9 +2713,9 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 		pCoexSta->bWiFiIsHighPriTask = true;
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
-		u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-		u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
-		u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
+		pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
+		pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
+		pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
 	} else {
 		pCoexSta->bWiFiIsHighPriTask = false;
 
-- 
2.17.1

