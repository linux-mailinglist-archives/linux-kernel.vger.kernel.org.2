Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12676342F05
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCTSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:34:57 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58305 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCTSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:34:47 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DFC9422238;
        Sat, 20 Mar 2021 19:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616265286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BNSCnsLp3RCxuVIYliRxaUH+2qvp7LOKywCuPlHTSw4=;
        b=R5UvGPea/02H5QTe/R4w7s7oTnJy0PulgVFIJRKdGbwYLl/on217yGE0OEG8EDaEJkiA7L
        GzsNAVrO+WGilO5a/ZPMZorhA+jr8VKcExL0jgGXyQNVoVITNgHtAqNE5k+LjaAYp02zV2
        ELkhFEnGGx6Rz8sIBcHm37w1I3Zi9so=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: configs: enable FlexTimer alarm timer
Date:   Sat, 20 Mar 2021 19:34:36 +0100
Message-Id: <20210320183436.27632-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used on Layerscape SoCs to wake up the system from
standby. It works in conjunction with the RCPM driver. The latter is
only available as a builtin.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3f059bca9e24..58ce14b39637 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -884,6 +884,7 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_PCF2127=m
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_CROS_EC=y
+CONFIG_RTC_DRV_FSL_FTM_ALARM=m
 CONFIG_RTC_DRV_S3C=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_SUN6I=y
@@ -997,6 +998,7 @@ CONFIG_OWL_PM_DOMAINS=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_FSL_DPAA=y
 CONFIG_FSL_MC_DPIO=y
+CONFIG_FSL_RCPM=y
 CONFIG_QCOM_AOSS_QMP=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GENI_SE=y
-- 
2.20.1

