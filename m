Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE813CB980
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhGPPRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:17:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10473 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbhGPPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626448495; x=1657984495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFW5iecHUrXYQRMMjleWv1/yTI/kguN5QLIMkSIa2jI=;
  b=q3Lf1luBBo355d5O9JqIKsSt/OSUu5DdX4ywRRWF6yfdOuc31qLFMgs9
   BW5VaI2fNiPVFDj9M5d3bv9tDlyd9wmW+K9nOGjBkpvGGFCUBJc8zjaiB
   n5zrCjlkT6fjTrf/WlNnVMl63dTapuopkL4hXjJcDhUcSWUSQ+4rPj2M0
   nxlg7hLaEMIXWgHVFCyiP6HKtl3MsDBUuKesPpYOrMt0ErPRwCiz7vduR
   zj9DcjpU+U13nBdIV/huGVQcPILi0U+RuAQydn0psNdO2A+yr/T2R6Llw
   sXm9d5Pe5GlM/wJkX83NubJ3wVD1jHuVlGqmo0KUjriWc9nQZ8GX28Ea2
   g==;
IronPort-SDR: Z7DzCzq5S/n8Ey/vcIVCGY5FZxEbudgdHZN9XU3s/GlrPVYbOwf22x8KJmU+qdeLMpFTIwn1t6
 gcXb9LHlPziyfu1I57u3MUQ80AQ16863avdnH5lZQGmRF4ii5/te3bmkTPBByEq0aU0SsLRwiw
 uW2Gp6iU1HDxJIwdTIH09nEwizbrVBz8F2jGFQKFdMZEAwGZWl4bVKCij8IaZ+Jnz9UwafNpt2
 vPS6hw6U6ALtbOq6gkIihHk45NlugVRLtFanexlZ2eDpcEltxIA7YHmfhu3QJnb7rUJd3F3SJb
 iyCcvI4gV49wxhY+eDrFvT+X
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="122322356"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 08:14:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:14:54 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 16 Jul 2021 08:14:51 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <emil.velikov@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] ARM: configs: at91: Enable crypto software implementations
Date:   Fri, 16 Jul 2021 18:14:47 +0300
Message-ID: <20210716151447.833967-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716151447.833967-1-tudor.ambarus@microchip.com>
References: <20210716151447.833967-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a good idea to enable at least the same amount of algs as
the hardware IPs are supporting. Provide the posibility for the
hw accelerated crypto alg to fallback to software implementation,
in case they need it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 8 +++++++-
 arch/arm/configs/sama5_defconfig   | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 06c888a45eb3..d348ae0d5363 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -213,7 +213,13 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 1ccf84091dd7..e170676eed66 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -230,6 +230,13 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
-- 
2.25.1

