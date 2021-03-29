Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F1934CD88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhC2KB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:28561 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhC2KBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012064; x=1648548064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AxnaLNlhsmWb3TB6B1t0l+hwbtO7KO7QMI2hNqu43Qg=;
  b=oBzsrM6WwYKAGQjgM+xvnk1YAhFNqGbjwrKrrJWfvGVkJCwhrCQQgxr7
   tmXbmZm3QAEBEqlYZYvxs/6p/cf7gBV/DXwrFyMSb1BKpZH7WDRHQ6rZo
   BCOiQnejLTqz++k4TTsgxpxE4IXH+Un7bM58jmui5RdmO/M1DEB1MuCrL
   y5p8p2T3aNOnpsFhur9argGN8wJLZh6MWB2/RI5KyU2SJN/hpiS2v9v+/
   3Z9MB7vsIpApKYWjwlv2c0bcinc1t6BF4x0bSyW/R5qlFIx9pAwWaxndz
   pazVE1MjL3adXddpU/mULsD0fHgDeHwfq9gWqg9BgPD7Mo5RDjMmA9/5h
   w==;
IronPort-SDR: kTmin9okQLNrszl/6N7s4dtZMReHyhmBEHeyZ+yGjmFnoYEwK0Y52UugafI79lpPzEJ/U1I0WC
 6hl/MOKMtVI8fYCuv0ONkwRRna2VYytKWQw5Ctmxw2lMS4liDri8kOow9x6SCV0Nl+H8LH9PKs
 9VXjfeUL4BRtibwXxvzZjDYBSrCJ+fs1EALF3JPxcF+k5J4Pmw4cmZJde5FvvyfNGzQEKi06OC
 T8WTSYefFIVCW4yoKiG7jTZkR3WC4/L43WJxGJj4XWn4rFX4zaEkeMM+M5ETxDT8nTEV483Dyw
 gGk=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="108891850"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:03 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:00 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <emil.velikov@collabora.com>, <ezequiel@collabora.com>
Subject: [PATCH 1/7] ARM: configs: at91: sama5: MCP16502 regulator as built-in
Date:   Mon, 29 Mar 2021 11:56:39 +0200
Message-ID: <759835d5aa1e9d839a2ab657528c33b44820eabd.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617010856.git.nicolas.ferre@microchip.com>
References: <cover.1617010856.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

This regulator is needed by several SoC or external peripherals on
different boards, providing required power rails.  Make it built-in
to match usual use-cases.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 5bcf16aecf2f..72e58a835c37 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -138,7 +138,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_ACT8945A=y
-CONFIG_REGULATOR_MCP16502=m
+CONFIG_REGULATOR_MCP16502=y
 CONFIG_REGULATOR_PWM=m
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_SUPPORT_FILTER=y
-- 
2.31.1

