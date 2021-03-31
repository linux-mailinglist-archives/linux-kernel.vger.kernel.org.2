Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF70345894
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:24:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13665 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCWHYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:24:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4N8b1LFZznVJr;
        Tue, 23 Mar 2021 15:21:35 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 15:23:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <xuzaibo@huawei.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
Subject: [PATCH -next] crypto: hisilicon/hpre: fix link error
Date:   Tue, 23 Mar 2021 15:27:16 +0800
Message-ID: <20210323072716.3146252-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the follow link error by select config CRYPTO_ECC and CRYPTO_ECDH.

ERROR: modpost: "ecc_get_curve25519" [drivers/crypto/hisilicon/hpre/hisi_hpre.ko] undefined!
ERROR: modpost: "ecc_get_curve" [drivers/crypto/hisilicon/hpre/hisi_hpre.ko] undefined!
ERROR: modpost: "crypto_ecdh_decode_key" [drivers/crypto/hisilicon/hpre/hisi_hpre.ko] undefined!

Fixes: 90274769cf79 ("crypto: hisilicon/hpre - add 'CURVE25519' algorithm")
Fixes: 05e7b906aa7c ("crypto: hisilicon/hpre - add 'ECDH' algorithm")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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
2.25.1

