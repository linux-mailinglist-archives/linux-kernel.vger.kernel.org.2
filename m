Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5114430B899
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBBHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:22:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12096 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhBBHWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:22:12 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVGRb62nLz162wf;
        Tue,  2 Feb 2021 15:20:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 15:21:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v7 2/4] ARM: hisi: add support for Kunpeng50x SoC
Date:   Tue, 2 Feb 2021 15:16:46 +0800
Message-ID: <20210202071648.1776-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210202071648.1776-1-thunder.leizhen@huawei.com>
References: <20210202071648.1776-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the Hisilicon Kunpeng506 and Kunpeng509 SoC.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-hisi/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 2e980f834a6aa1b..a004eac24b243af 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -55,6 +55,12 @@ config ARCH_HIX5HD2
 	help
 	  Support for Hisilicon HIX5HD2 SoC family
 
+config ARCH_KUNPENG50X
+	bool "Hisilicon Kunpeng50x family"
+	depends on ARCH_MULTI_V7
+	help
+	  Support for Hisilicon Kunpeng506 and Kunpeng509 SoC family
+
 config ARCH_SD5203
 	bool "Hisilicon SD5203 family"
 	depends on ARCH_MULTI_V5
-- 
2.26.0.106.g9fadedd


