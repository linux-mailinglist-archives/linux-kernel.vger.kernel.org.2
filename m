Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32FC34A26C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhCZHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:17:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15316 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCZHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:17:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6Csf3PVkz91Pb;
        Fri, 26 Mar 2021 15:15:02 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 15:16:53 +0800
From:   Zhang Jianhua <zhangjianhua18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <xuzaibo@huawei.com>, <qianweili@huawei.com>,
        <yuehaibing@huawei.com>, <yumeng18@huawei.com>,
        <tanshukun1@huawei.com>, <zhangjianhua18@huawei.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johnny.chenyi@huawei.com>
Subject: [PATCH -next] drivers: crypto: CRYPTO_DEV_HISI_HPRE select CRYPTO_ECC and CRYPTO_ECDH
Date:   Fri, 26 Mar 2021 15:16:48 +0800
Message-ID: <20210326071648.15480-1-zhangjianhua18@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CRYPTO_DEV_HISI_HPRE=y, the following errors will be seen while
building hpre_crypto.c

drivers/crypto/hisilicon/hpre/hpre_crypto.o: In function
`hpre_curve25519_compute_value':
hpre_crypto.c:(.text+0x151b): undefined reference to
`ecc_get_curve25519'
drivers/crypto/hisilicon/hpre/hpre_crypto.o: In function
`hpre_curve25519_set_secret':
hpre_crypto.c:(.text+0x2714): undefined reference to
`ecc_get_curve25519'
drivers/crypto/hisilicon/hpre/hpre_crypto.o: In function
`hpre_ecdh_set_secret':
hpre_crypto.c:(.text+0x27ed): undefined reference to
`crypto_ecdh_decode_key'
hpre_crypto.c:(.text+0x2954): undefined reference to `ecc_get_curve'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index c45adb15ce8d..d87c89af2a7f 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -69,6 +69,8 @@ config CRYPTO_DEV_HISI_HPRE
 	select CRYPTO_DEV_HISI_QM
 	select CRYPTO_DH
 	select CRYPTO_RSA
+	select CRYPTO_ECC
+	select CRYPTO_ECDH
 	help
 	  Support for HiSilicon HPRE(High Performance RSA Engine)
 	  accelerator, which can accelerate RSA and DH algorithms.
-- 
2.17.1

