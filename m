Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A169403B57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351888AbhIHOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348570AbhIHOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:18:20 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:17:12 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNy-00CSiw-QE
        for linux-kernel@vger.kernel.org; Wed, 08 Sep 2021 16:17:11 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNL-00CSZU-7R; Wed, 08 Sep 2021 16:16:31 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNK-000ZdC-Mi; Wed, 08 Sep 2021 16:16:30 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Olivier Moysan <olivier.moysan@st.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Bert Vermeulen <bert@biot.com>
Subject: [PATCH v3 5/5] ARM: multi_v7_defconfig: Add support for Airoha EN7523 SoC
Date:   Wed,  8 Sep 2021 16:16:06 +0200
Message-Id: <20210908141606.136792-6-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908141606.136792-1-bert@biot.com>
References: <20210908141606.136792-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

This enables basic bootup support for the Airoha EN7523 SoC.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d9abaae118dd..922650200d74 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -31,6 +31,7 @@ CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_DIGICOLOR=y
+CONFIG_ARCH_AIROHA=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
-- 
2.25.1

