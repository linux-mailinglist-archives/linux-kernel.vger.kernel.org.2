Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76776377EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhEJJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:10:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2740 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhEJJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:10:04 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdwBV1TKwzqV17;
        Mon, 10 May 2021 17:05:38 +0800 (CST)
Received: from huawei.com (10.90.52.161) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 10 May 2021
 17:08:50 +0800
From:   Luo Longjun <luolongjun@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <luolongjun@huawei.com>,
        <sangyan@huawei.com>, <ningyu9@huawei.com>, <luchunhua@huawei.com>
Subject: [PATCH] arm64: configs: remove redundant CONFIG_MTK_PMIC_WRAP
Date:   Sat, 8 May 2021 02:24:10 +0800
Message-ID: <20210507182410.10515-1-luolongjun@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.52.161]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compile kernel in ARM64, it produces the following output:

*** Default configuration is based on 'defconfig'
arch/arm64/configs/defconfig:1018:warning: override: reassigning to
symbol MTK_PMIC_WRAP

After checking defcofnig, I found two CONFIG_MTK_PMIC_WRAP options.

Signed-off-by: Luo Longjun <luolongjun@huawei.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 08c6f769df9a..9907a431db0d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -491,7 +491,6 @@ CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_SPIDEV=m
-CONFIG_MTK_PMIC_WRAP=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
-- 
2.17.1

