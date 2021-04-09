Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE33359D08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhDILRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:17:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:9944 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhDILRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967039; x=1649503039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4BQZ/iTmn3jDQYiKb3oiGkOU5qXJu63VT3CwhT9FgTM=;
  b=v9OtB5Wbox7jlpSevGoF+ZU+6WA7POdlKoiGYOOUhe5tcWMfDwDjNeMN
   bz6jksFcZM7W/YiI1uNkoMm3BVVVenbPYi1E5u10/trhjbtu/Rofo9c0R
   /ugXhUn9F+D24/d5yhKV570n8XecBEG+rEaeCcGx2c5gXZ0ctkydIYs+S
   756zmt6yTamMNZjMwXgNZnhvWjFk5H6tTpsf4tTi7tYV/5x5dpCHhWOXz
   fV4GM5xgv9v2GR+hu/YC+54yOhh5nlo0NA8NsMyHcZZdS5dvzGzcGrTGc
   i6ZDXVz7o1nMJJy+R25esFShe9bFXa8qWU/22Ltm1K+Z7OzFFh02Bx34Z
   A==;
IronPort-SDR: /6rC9fKFP/N28mIlf2A5U8Yf9Qkc520gdrxRYAXGVtCh3Ja0Gtn+NOiay/ynpC81L6qXHi5PYa
 beAwLo+1cz+2bBX8UOnGct1AS5Aung9AjH3pXlTJwEBgsh3jQOtTY6PZUs4CdMwlw5D8HKIicN
 eE0sjQEHQcEkXzDaYV4HwymhbxuYCsCZIVUJOT9WpDFfNa66/OKM+oAEDyPfJoRHq9UWiCdud+
 pHJ6A1aU4s5SKV7VmGPQ/ilCanu0JFSOE0d7q2azQiwEQeccJ/EgpniTiEcR8TiS+CtDcyHaST
 FXo=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="115878643"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:17:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:17:13 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:16:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 15/24] ARM: at91: pm: wait for ddr power mode off
Date:   Fri, 9 Apr 2021 14:13:36 +0300
Message-ID: <20210409111345.294472-16-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for DDR power mode off before shutting down the core.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 9c9e08fd8300..7396e18dd7e5 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -980,6 +980,11 @@ ulp_exit:
 	mov	tmp1, #0x1
 	str	tmp1, [r0, #0x10]
 
+	/* Wait for it. */
+1:	ldr	tmp1, [r0, #0x10]
+	tst	tmp1, #0x1
+	beq	1b
+
 	/* Shutdown */
 	ldr	r0, .shdwc
 	mov	tmp1, #0xA5000000
-- 
2.25.1

