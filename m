Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB534CD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhC2KBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:01:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27351 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhC2KBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012076; x=1648548076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNGJvdBuFrj9bePKTLnOU3M7EQ8PHMGMySmXeeaCv9U=;
  b=NFjd1kBy5VcN5Uw1a2gXhPIuTS3Bs3YUAV5rI0DVTJKwd6RUaYl2uVBg
   cmi3sfthFiogEVi5bxnPORt3qF81k5tha0Ukx5+36zHGoD2zasU3QKeo5
   bTrbpL2+QMNc6km5+NZPnRWKPA3h5a3hJmqp/CcB0KYcaudGGc87SvD2E
   rPHcQbNKB/WRB/AKwFExFX9IYXJ4T7hP6KjtlwV9jYj2i8wb+0qfMy3gK
   6ouWHGRerNLOmKBxAVGPYQoYFxSdzWjsqoTGGH67S36TucTFiT41TfjF4
   95CYPkceLU3tC4+Ly3HifjCz8ZZMA+XjOZMA02XxgnGe4m50+HZktAHxk
   g==;
IronPort-SDR: 4zfv4hptzk28OowydNn62q2PeFJTwgtiajOcaw2FIuLh1iF80cM8CXyUhDGG3fbj2L+G0pediJ
 EW7OQ0YuNtNqsj7DArZq2B4DfGu9KnAAb3goY7B0+6CZGlCIwPzpMZ40IqE9596WSyIDlk61TF
 kKAFYUzL8JPTOG2sLajRS/oTTnlPDcoWqQqqoK4nXIkT4e+v2TWKLIHLrEt6NKzbEFznTBAf4B
 siztcOW9mgTzel+HhWuvgzTdRy+4xzJtUfmgkXduIb8dTrgqC0Cd8/gvXI9TolL3ln8tfGA4SO
 GFg=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="114497631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:14 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:11 -0700
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
Subject: [PATCH 5/7] ARM: configs: at91: Add mtd tests as modules
Date:   Mon, 29 Mar 2021 11:56:43 +0200
Message-ID: <529ab9039a52d8d1366973ab3bbc28eb27365c86.1617010856.git.nicolas.ferre@microchip.com>
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

Add MTD tests as they are used in CI and for validation plan.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 arch/arm/configs/sama5_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 6403b064e8dc..a462d0ddaa2f 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -46,6 +46,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
+CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 774e25a7b246..bb8c8000318b 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -55,6 +55,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
+CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
-- 
2.31.1

