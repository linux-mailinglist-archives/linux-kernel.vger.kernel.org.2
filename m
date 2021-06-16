Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE33AA081
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhFPP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhFPP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:57:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B4C06175F;
        Wed, 16 Jun 2021 08:55:18 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1F6D822285;
        Wed, 16 Jun 2021 17:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623858916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAXikuT9TPwwfZl2BgKJ2dYkaUq8Jpu95CziNniOQaI=;
        b=vUbBjPG7JE1U0WoG+9xieoEB9CVlSelEG+bRUfIY6dL8KUYkVmAQHJaeuwII64pITpq8lU
        HCucApu4ecgQ794dxaodWCTxVVQ2eacPxcWyK7wT6QkO24JypJTvCYM+H3jKsVnpPVuKkP
        Nxf1WPw/F3XCJWOP4yZ3FW0+5rqIrUs=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/3] ARM: configs: multi_v7: enable PL35x NAND controller
Date:   Wed, 16 Jun 2021 17:54:35 +0200
Message-Id: <20210616155437.27378-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616155437.27378-1-michael@walle.cc>
References: <20210616155437.27378-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After years, linux finally got a driver for the PL35x NAND controller
found on the Xilinx Zynq-7000 SoC for example. Enable support for this
driver.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 52a0400fdd92..8d5ec5986b42 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -215,6 +215,7 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_NAND_STM32_FMC2=y
+CONFIG_MTD_NAND_PL35X=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_ASPEED_SMC=m
 CONFIG_MTD_UBI=y
-- 
2.20.1

