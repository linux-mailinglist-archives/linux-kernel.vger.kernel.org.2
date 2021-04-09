Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436DE359D28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhDILTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:19:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49790 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhDILSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967100; x=1649503100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSpQpv98sh3osaRVrIiVAdt+VOG++l/L01AbZfP6hA4=;
  b=BCMiPYlMMpyUzRCoQRZGLOr3IH6/brVlpeTplOQahGQcuzgjgxs8GUDK
   YhfAX0ujq8gCIxFbr8byjnMYPrhiYLU8DDTK6ZBj4fdzxHmFAh26DjJqZ
   vffPZfrf/gWy+43Sw7Z+ZLBmECcAPnENBnA8rbLv6/8ubC0CJwt7j2m1a
   d/sJI584ACr2UAbME4igwpzdUu3POT5+T6gMZYNvIIzfIijfdqctmPD9O
   z87PxSNqOr2nxa2pvfp+vgkkhdAL95M14X/AQ/oVGehqir1xlb7UIli4d
   3eFR8eA8g2nmZIrA0yeq3lD4GiE7g4pi9fTSskKtHjm55CcqD/FwXLS8f
   g==;
IronPort-SDR: YMh8X0Ivrj1/vOyggFfm52tqXt9JxM3Xk4/YGvGhv7XlKSSpZ7CZHLjPtUs9lUcQfOyGoK0mAf
 AXL0Ntt0jIIy8j2NHSnLgc2M5l+KeVwj40uubsXQUYXzj70JK2o4OVi5cpDIMyeIfHtZs4btj9
 QdWdKMGnEZMgv6Xwp9t0gJvEbDBNcLwRMCs3+5mSUQg/gRmXnOccReOjJ21HsbjazKKgpWVMIq
 nLmQ3699YtpS0q9uVPl2liOalZqiXPu9koPeym0jYbtxLSGugvGRf8IMliiG06m8cM60SfbqW2
 PrE=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="113022693"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:18:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:18:19 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:18:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 24/24] ARM: at91: pm: add sama7g5 shdwc
Date:   Fri, 9 Apr 2021 14:13:45 +0300
Message-ID: <20210409111345.294472-25-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAMA7G5 SHDWC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 24d5fd06d487..d6cfe7c4bb00 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -794,6 +794,7 @@ static int __init at91_pm_backup_init(void)
 static const struct of_device_id atmel_shdwc_ids[] = {
 	{ .compatible = "atmel,sama5d2-shdwc" },
 	{ .compatible = "microchip,sam9x60-shdwc" },
+	{ .compatible = "microchip,sama7g5-shdwc" },
 	{ /* sentinel. */ }
 };
 
-- 
2.25.1

