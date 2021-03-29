Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0434CD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhC2KBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53767 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhC2KBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012077; x=1648548077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F8Jrrub5vgiH2R2akdJUDDWSxGTy4TlhVSkDzVNze1A=;
  b=jShpRJH3NgJxls2KcgIypym2pkHfc6748VXVwsEXeI254x8FWrFWJnge
   6wK/Ywsak/ShA2O/7mEdQgiISaMKp4qcPVRVohyrmn1OsunM7kz3Dnt8y
   jWH7aoINiR3UhlolHCWEiUWIz5WduqmCrb0vMeo/FbCa2Fgzi7fL4DIVj
   mnQNTZ4Y+r0gaRFhYRVJ9L/f00Yy/FEbkzNi+eIuNBE7r2b0ss/w71dYf
   11CnRA3z6DV5v9ejTjTN01Qpu7LXviGtDOjQ8O7C/IBfbism3K6AKgtuF
   FVu1s136nESoeLec30da3gkY1/vqchFBidrel1HrmjJEpVndpa7gje7Mm
   g==;
IronPort-SDR: 0MZKzQEnKMoGmE/tfWsQxs3rZQ0ZZYrehUnmoxqzWKRSo+UtABGslWtj7V9XkHwjRne2A8s9nU
 FJGjqRkBBj2it38IRjaIpHCBNqZxyZ2CoDVM/oDl772jPI26EVt06fsg3cYuCEaTSGbFd/Go9f
 gYTS80V6Yd2tboh/7FJvqeVFNh82NY/gnSS9fMX8os4IneogxlBBJ3PyYx9vdvXx4MEuXxdlxD
 IxdkmmGtELn1iyJugSuZC6fBU8Vol4pdBioCRp0NF0KroIfCvGlDcuN8h2Lxl7iU20Fv/gqqRj
 3Wc=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="111696151"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:11 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:09 -0700
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
Subject: [PATCH 4/7] ARM: configs: at91: sama5: Add audio MIKROE PROTO board
Date:   Mon, 29 Mar 2021 11:56:42 +0200
Message-ID: <78529d0252093bbd0e52d560e1767497f00673ae.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617010856.git.nicolas.ferre@microchip.com>
References: <cover.1617010856.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Add this board as a module as it's useful for testing audio on multiple
AT91 boards.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
[nicolas.ferre@microchip.com: adap to newer kernel]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index a528438ed678..774e25a7b246 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -170,6 +170,7 @@ CONFIG_SND_ATMEL_SOC_CLASSD=y
 CONFIG_SND_ATMEL_SOC_PDMIC=y
 CONFIG_SND_ATMEL_SOC_TSE850_PCM5142=m
 CONFIG_SND_ATMEL_SOC_I2S=y
+CONFIG_SND_SOC_MIKROE_PROTO=m
 # CONFIG_HID_GENERIC is not set
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
2.31.1

